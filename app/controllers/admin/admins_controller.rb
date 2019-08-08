class Admin::AdminsController < Admin::ApplicationController

	before_action :set_admin, only: [:edit, :update, :destroy]

	def index
		@admins = Admin.all
	end

	def new
		@admin = Admin.new
	end

	def edit
	end

	def create
		admin = Admin.new(admin_params)
		if admin.save
			redirect_to admin_admins_path, notice: "Registro agregado"
		else
			redirect_to admin_admins_path, alert: "Ocurrio un error"
		end
	end

	def update
		if @admin.update(admin_params)
			redirect_to admin_admins_path, notice: "Registro actulizado"
		else
			redirect_to admin_admins_path, alert: "Ocurrio un error"
		end
	end

	def destroy
		if Admin.all.size > 1
			if @admin.destroy
				redirect_to admin_admins_path, notice: "Registro eliminado"
			else
				redirect_to admin_admins_path, alert: "Ocurrio un error"
			end
		else
			redirect_to admin_admins_path, alert: "No se puede eliminar el administrador"
		end
	end

	private

		def set_admin
			@admin = Admin.find(params[:id]) rescue nil
		end

		def admin_params
			params.require(:admin).permit(:email, :password, :password_confirmation)
		end
end