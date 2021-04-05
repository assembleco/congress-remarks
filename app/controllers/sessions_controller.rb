class SessionsController < ApplicationController
  def create
    person_params = params.require(:person).permit(:email, :handle)
    person = Person.find_by(person_params)

    person ||=
      begin
        if person_params[:email] &&\
            person_params[:handle] &&\
            !Person.find_by(email: person_params[:email]) &&\
            !Person.find_by(handle: person_params[:handle])

          person = Person.create(person_params)
        end
      rescue
        nil
      end

    unless person
      render json: { success: "no" }
      return nil
    end

    session = Session.create(
      person: person,
      expires: 3.days.from_now,
      code: SecureRandom.uuid,
    )
    SessionMailer.with(session: session).claim.deliver_later

    render json: { success: 'yes' }
  end

  def index
    render json: {
      code: session_hash.code,
      person: session_hash.person.slice(:email, :handle),
    }
  end

  def claim
    session = Session.find_by(code: params[:code])

    if session
      if session.claimed
        @error = "Your session has already been claimed."
      else
        Session.update(claimed: Time.current)
        @code = session.code
      end
    else
      @error = "Your session link is unrecognized."
    end
  end
end
