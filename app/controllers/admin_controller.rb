class AdminController < ApplicationController
  before_filter :authenticate
  def show
    authorize Admin.new
  end
end
