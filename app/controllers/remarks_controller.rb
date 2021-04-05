class RemarksController < ApplicationController
  def index
    remarks = Remark.all.includes(:person).map do |r|
      r.slice(:place, :body).
        merge(person: r.person.slice(:handle).merge(badges: []))
    end

    render json: remarks
  end

  def create
    unless session_hash
      return render json: { success: :no }
    end

    remark_params = params.require(:remark).permit(:place, :body)

    person = session_hash.person
    remark = person.remarks.create(remark_params)

    render json: { success: :yes }
  end
end
