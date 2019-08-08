class HomeController < ApplicationController
	before_action :set_surveys, only: [:add, :show, :edit, :update, :destroy]

  def index
    @guides = Guide.where(status: true).order('id ASC')
    @surveys = Survey.where(status: true).order('id ASC')
  end

  def show
  	#render template: "home/survey/#{params[:survey]}"
  	@surveys = Survey.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf { render template: 'home/pdf', pdf: "Encuesta - #{@surveys.created_at.strftime("%d-%m-%Y")}" }
    end
  end

  def insert_data
    #Condition validate if user already has answered the survey
    if Answer.exists?(user_email: params['user_email'], survey: params['survey'])
      #Destroy all records
      Answer.where(user_email: params['user_email'], survey: params['survey']).destroy_all
      #Condition if email is empty
      if params['user_email'].nil? 
        redirect_to home_index_path, alert: "No se puedo ingresar los datos."      
      else
        params['answer_question'].each_with_index do |a, i|
          Answer.create!({answer_question: a, question_id: params['question_id'][i], user_email: params['user_email'], survey: params['survey']})
        end
        redirect_to results_home_path(survey: params['survey'], user_email: params['user_email']), notice: "Datos agregado con éxito."
      end 
    else
      if params['user_email'].nil? 
        redirect_to home_index_path, alert: "No se puedo ingresar los datos."      
      else
        params['answer_question'].each_with_index do |a, i|
          Answer.create!({answer_question: a, question_id: params['question_id'][i], user_email: params['user_email'], survey: params['survey']})
        end
        redirect_to results_home_path(survey: params['survey'], user_email: params['user_email']), notice: "Datos agregado con éxito."
      end 
    end
  end

  def results
    respond_to do |format|
      format.html
      format.js
      format.pdf { render pdf: Survey.where(id: params[:survey]).last.name, page_size: 'Letter', print_media_type: true, disable_javascript: false, javascript_delay: 3000, viewport_size: '1280x1024' }
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

  private
    def set_surveys
      @surveys = Survey.find(params[:id])
    end

    def surveys_params
      params.require(:survey).permit(:id, :name, :status)
    end

    def answers_params
      params.require(:answer).permit(:id, :answer_question, :question_id, :user_email, :survey)
    end

    def user_params
      params.require(:user).permit(:organization_name, :name, :phone_number, :zipcode)
    end

end
