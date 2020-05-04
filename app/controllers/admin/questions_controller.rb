class Admin::QuestionsController < Admin::ApplicationController
	before_action :set_question, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @questions = Question.all.order('id ASC')
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
    @questions = Question.find(params[:id])
  end

  def create
    @question = Question.new(questions_params)
    if @question.save
      redirect_to admin_survey_path(Section.where(id: @question.section_id).last.survey_id), notice: "Pregunta creada con éxito."
    else
      if @question.errors.any?
        render :edit
        flash[:alert] = "Error! Por favor verifique la información."
      end
    end
  end

  def update
    if @question.update(questions_params)
      redirect_to admin_survey_path(Section.where(id: @question.section_id).last.survey_id), notice: "Pregunta actualizada con éxito."
    else
      if @question.errors.any?
        render :edit
        flash[:alert] = "Error! Por favor verifique la información."
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_question
    @question = Question.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def questions_params
      params.require(:question).permit(:id, :question, :question_type, :status, :section_id, :recommendation, :discard_question)
    end
end
