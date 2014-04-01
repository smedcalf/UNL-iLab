class UserMailer < ActionMailer::Base
  default from: "InnovationLab@cse.unl.edu"

  def registration_confirmation(user)
    mail(:to => user.email, :subject => "From iLab: Registration Confirmation")
  end

  def user_type_confirmation(user)
    mail(:to => user.email, :subject => "From iLab: Your User Type was set as #{user.utype.upcase}")
  end

  def reset_password_confirmation(user, password)
    @password = password
    @user = user
    mail(:to => user.email, :subject => "From iLab: Reset Password to #{@password}")
  end
end
