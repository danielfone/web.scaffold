class RequestsController < ApplicationController

  def new
    @request = Request.new
  end

  def show
    @request = Request.find params[:id]
  end

  def create
    @request = Request.new params[:request]

    if @request.save
      redirect_to @request
    else
      render :new
    end
  end

  alias_method :update, :create

end