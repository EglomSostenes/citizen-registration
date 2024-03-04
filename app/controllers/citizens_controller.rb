class CitizensController < ApplicationController
  before_action :set_citizen, only: %i[show edit update]

  def index
    @q = Citizen.ransack(params[:q])
    @citizens = @q.result.includes(:address).paginate(page: params[:page], per_page:2)
  end

  def create
    @citizen = Citizen.new(citizen_params)

    if @citizen.save
      CitizenMailer.registration_notification(@citizen.full_name,
                                   @citizen.email).deliver_later
      redirect_to @citizen
    else
      render "new"
    end
  end

  def update
    if @citizen.update(citizen_params)
      redirect_to @citizen
    else
      render "edit"
    end
  end

  def new
    @citizen = Citizen.new
    @citizen.build_address
  end

  def show; end

  def edit; end

  private

  def citizen_params
    params.require(:citizen).permit(:full_name, :cpf, :cns, :email, :phone,
                                    :birthday, :status,
                                    address_attributes: %i[id zip_code street complement
                                                           neighborhood city uf ibge_code])
  end

  def set_citizen
    @citizen = Citizen.find(params[:id])
  end
end
