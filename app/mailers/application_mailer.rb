class ApplicationMailer < ActionMailer::Base
  default from: 'library@bibliotheca.com'
  layout 'mailer'
  def confirmation_email(user)
    @user = user

    mail(to: @user.email, subject: 'Order Confirmed')
  end
end
