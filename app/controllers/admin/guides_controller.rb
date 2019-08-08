class Admin::GuidesController < Admin::ApplicationController
  before_action :set_guides, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @guides = Guide.all.order('id ASC')
  end

  def show
  end

  def new
    @guides = Guide.new
  end  

  def edit
    @guides = Guide.find(params[:id])
  end

  def create
    @guides = Guide.new(guides_params)
    if @guides.save
      redirect_to admin_guides_path, notice: "Guía creada con éxito."
    else
      redirect_to new_admin_guide_path
    end    
  end

  def update
    if @guides.update(guides_params)
      redirect_to admin_guides_path, notice: "Guía actualizada con éxito."
    else
      if @guides.errors.any?
        render :edit
        flash[:alert] = "Error! Por favor verifique la información."
      end
    end
  end

  def destroy
    @guide.destroy
    respond_to do |format|
      format.html { redirect_to guides_url, notice: 'Guide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guides
      @guides = Guide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guides_params
      params.require(:guide).permit(:id, :title, :file, :status)
    end

end
