class StacksController < ApplicationController
  before_action :public_access_enabled?

  def public_access_enabled?
    SystemConfig.first.public_book_display
  end
end