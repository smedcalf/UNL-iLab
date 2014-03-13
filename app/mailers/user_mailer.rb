class UserMailer < ActionMailer::Base
  default from: "InnovationLab@cse.unl.edu"

  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Registration Confirmation")
  end

  def user_type_confirmation(user)
    mail(:to => user.email, :subject => "Your User Type was set: #{user.utype}")
  end
end
