class Admin::SystemConfigsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @system_config = SystemConfig.first_or_create
  end

  def update
    @system_config = SystemConfig.first
    if @system_config.update_attributes(system_config_params)
      flash[:notice] = 'Configuration updated successfully.'
    else
      flash[:alert] = 'There was a problem updating the configuration.'
    end
    render action: :edit
  end

  private

  def system_config_params
    params.require(:system_config).permit(:library_name, :public_book_display)
  end
end
