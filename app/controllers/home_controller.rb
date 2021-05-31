class HomeController < ApplicationController
  before_action :set_surveys, only: [:add, :edit, :update, :destroy]

  def index
    @guides = Guide.where(status: true).order('id ASC')
    @surveys = Survey.where(status: true).order('id ASC')
    @surveys_count = @surveys.length
  end

  # this action renders the survey to be fill with the user data.
  def show
    survey_id = params[:id]
    diagnostic_id = params[:diagnostic]
    @survey = find_survey(survey_id)
    @diagnostic = find_diagnostic_secure(diagnostic_id)
    @answers = @diagnostic.nil? ? {} :
                 Answer.joins(:section)
                       .where(diagnostic_id: diagnostic_id, survey_id: survey_id)
                       .group_by { |ans| ans.question.section_id }

    @counter = @diagnostic.nil? ? Diagnostic.counter_next(current_user.id) : @diagnostic.counter
    respond_to do |format|
      format.html
      format.pdf { render template: 'home/pdf', pdf: "Encuesta - #{@survey.created_at.strftime("%d-%m-%Y")}" }
    end
  end

  def insert_data
    diagnostic_id = params[:diagnostic_id]
    values = params['answer_question']
    survey_id = params[:survey_id]

    answers_stored = {}
    diagnostic = find_diagnostic_secure(diagnostic_id)
    updated=0
    created=0

    if diagnostic.nil?
      counter = Diagnostic.counter_next(current_user.id)
      diagnostic = Diagnostic.create!({
                                        user_id: current_user.id,
                                        user_email: current_user.email,
                                        counter: counter
                                      })
    end

    if !diagnostic.nil?
      answers_stored = Answer.where(survey_id:survey_id, diagnostic_id: diagnostic.id).all.index_by{|a| a.question_id}
    end

    values.each do |question_id, answer_value|
      answer = answers_stored[question_id.to_i]
      if answer.nil?

        answer = Answer.create!({
                         answer_question: answer_value,
                         question_id: question_id,
                         user_email: diagnostic.user_email,
                         survey: survey_id,
                         survey_id: survey_id,
                         diagnostic_id: diagnostic.id,
                         counter: diagnostic.counter
                       })

        answers_stored[question_id] = answer
        created+=1
      else

        if answer.answer_question == answer_value
          next
        end

        answer.answer_question = answer_value

        if answer.save
          updated+=1
        end
      end
    end

    redirect_to home_historic_path(survey_id: survey_id, diagnostic_id: diagnostic.id), notice: "Datos agregados con éxito."
  end

  def delete
    if !current_user.is_admin
      exception_403_not_allowed("No tiene permitido realizar esta acción")
    end

    diagnostic_id = params[:diagnostic_id]
    @diagnostic = find_diagnostic_secure(diagnostic_id)

    ActiveRecord::Base.transaction do
      Answer.where(:diagnostic_id => @diagnostic.id).destroy_all
      @diagnostic.destroy
    end

    redirect_to root_path and return
  end

  def results
    @current_survey = params[:survey_id]
    @diagnostic_id = params[:diagnostic_id]
    @survey = find_diagnostic(@current_survey)
    @diagnostic = find_diagnostic_secure(@diagnostic_id)
    @user = @diagnostic.user
    @last_survey_id = Survey.where(status: true).last.id
    respond_to do |format|
      format.html
      format.js
      format.pdf {
        render pdf: "Resultados",
               page_size: 'Letter',
               print_media_type: true,
               disable_javascript: false,
               javascript_delay: 3000,
               viewport_size: '1280x1024'
      }
    end
  end

  def historic

    @user = current_user
    @survey = find_survey(params[:survey_id])
    @diagnostic = find_diagnostic(params[:diagnostic_id])

    @user_answers = UserAnswers.new(@user.email, @survey.id, @diagnostic.id)

    @sections = Section.where(survey_id: @survey.id).order('id ASC')

    @last_survey_id = Survey.where(status: true).last.id

    respond_to do |format|
      format.html
    end
  end

  def edit_user
    @user = current_user
  end

  def update_user
    user = User.find(params[:id])
    if user.update(user_params)
      sign_out(user)
      sign_in(user, :bypass => true)
      redirect_to root_path, notice: "Cambios actualizados"
    else
      redirect_to root_path, alert: "No se actualizo el registro"
    end
  end

  def records
    survey_id = params['id']
    email = current_user.email
    diagnostic_id = params['diagnostic_id']
    @survey = find_survey(survey_id)
    @answers = Answer.where(
                        survey: survey_id,
                        user_email: email,
                        diagnostic_id: diagnostic_id
                      )
                     .group_by(&:counter)
  end

  private

  def set_surveys
    @surveys = find_survey(params[:id])
  end

  def surveys_params
    params.require(:survey).permit(:id, :name, :status)
  end

  def answers_params
    params.require(:answer).permit(:id, :answer_question, :question_id, :user_email, :survey)
  end

  def user_params
    params.require(:user).permit(:organization_name, :name, :phone_number, :zipcode, :organization_type)
  end

end
