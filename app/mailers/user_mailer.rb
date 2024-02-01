class UserMailer < ApplicationMailer
  default from: 'notifications@localhost:3000'

  def welcome_email
    @user = params[:user]
    @url = 'http://localhost:3000/sign_in'
    mail(
      to: @user.email,
      subject: 'Welcome to Bookface!'
    )
  end
end
