class Admin::SeasonsController < ApplicationController
  def index
    @seasons = Season.all
  end

  def show
    @season = Season.find(params[:id])
    @dates = @season.fish_dates
  end

  def new
  end

  def create
    season = Season.create!(year: params[:date][:year].to_i,
                            start_month: params[:date][:start_month].to_i,
                            end_month: params[:date][:end_month].to_i,
                            slot_limit: params[:slot_limit].to_i)
    redirect_to admin_seasons_path
  end
end
