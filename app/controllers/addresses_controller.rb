class AddressesController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @address = current_user.addresses.build
    end
  
    def create
      @address = current_user.addresses.build(address_params)
      if @address.save
        redirect_to new_order_path, notice: 'Address was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      @address = current_user.addresses.find(params[:id])
    end
  
    def update
      @address = current_user.addresses.find(params[:id])
      if @address.update(address_params)
        redirect_to new_order_path, notice: 'Address was successfully updated.'
      else
        render :edit
      end
    end
  
    private
  
    def address_params
      params.require(:address).permit(:street, :city, :province_id, :postal_code, :country)
    end
  end
  