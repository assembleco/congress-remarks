class RemarksController < ApplicationController
  def index
    render json: Remark.all.includes(:person).map do |r|
      r.slice(:place, :body).merge(person: r.person.slice(:handle))
    end
  end
end
