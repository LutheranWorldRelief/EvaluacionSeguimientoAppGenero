class Admin::SurveysController < Admin::ApplicationController
  before_action :set_surveys, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @surveys = Survey.all.order('id ASC')
  end

  def show
    render template: "admin/surveys/survey/#{params[:survey]}"
    @surveys = Survey.find(params[:id])
  end

  def new
    @surveys = Survey.new
  end  

  def edit
    @surveys = Survey.find(params[:id])
  end

  def create
    @surveys = Survey.new(surveys_params)
    if @surveys.save
      redirect_to admin_surveys_path, notice: "Encuesta creada con éxito."
    else
      redirect_to new_admin_survey_path
    end    
  end

  def update
    if @surveys.update(surveys_params)
      redirect_to admin_surveys_path, notice: "Encuesta actualizada con éxito."
    else
      if @surveys.errors.any?
        render :edit
        flash[:alert] = "Error! Por favor verifique la información."
      end
    end
  end

  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_surveys
      @surveys = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def surveys_params
      params.require(:survey).permit(:id, :name, :status, :indications, :code, :recommendation_one, :recommendation_two, :advice_message)
    end

end
