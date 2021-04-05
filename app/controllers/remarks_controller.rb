class RemarksController < ApplicationController
  def index
    remarks = Remark.all.includes(:person).map do |r|
      r.slice(:place, :body).
        merge(person: r.person.slice(:handle).merge(badges: []))
    end

    render json: remarks
  end
end
