class Admin::SectionsController < Admin::ApplicationController
	before_action :set_section, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @sections = Section.all.order('id ASC')
  end

  def show
  end

  def new
    @section = Section.new
  end

  def edit
    @sections = Section.find(params[:id])
  end

  def create
    @section = Section.new(sections_params)
    if @section.save
      redirect_to admin_survey_path(@section.survey_id), notice: "Encuesta creada con éxito."
    else
      if @section.errors.any?
        render :edit
        flash[:alert] = "Error! Por favor verifique la información."
      end
    end
  end

  def update
    if @section.update(sections_params)
      redirect_to admin_survey_path(@section.survey_id), notice: "Sección actualizada con éxito."
    else
      if @section.errors.any?
        render :edit
        flash[:alert] = "Error! Por favor verifique la información."
      end
    end
  end

  def destroy
    @section.destroy
    respond_to do |format|
      format.html { redirect_to sections_url, notice: 'Section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_section
    @section = Section.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sections_params
      params.require(:section).permit(:id, :name, :status, :gap_porcent, :recommendation, :survey_id, :gap_max, :recommendation_negative, :recommendation_gap_max, :recommendation_no_data)
    end
end
