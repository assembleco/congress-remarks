class BillsController < ApplicationController
  def show
    key = params[:id]
    render json: { key: key }
  end
end
