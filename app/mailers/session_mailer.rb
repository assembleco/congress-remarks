class SessionMailer < ApplicationMailer
  default from: "grace.c.youngblood@gmail.com"

  def claim
    @session = params[:session]
    @url = "https://#{ENV["APPLICATION_HOST"]}/session/#{@session.code}"

    mail(to: @session.person.email, subject: 'Assembled: sign in.')
  end
end
