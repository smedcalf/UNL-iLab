class UserMailer < ActionMailer::Base
  default from: "InnovationLab@cse.unl.edu"
  default to: "wangzhen614@gmail.com"

  def registration_confirmation(user)
    #mail(:to => user.email, :subject => "From iLab: Registration Confirmation")
    mail(:to => "wangzhen614@gmail.com", :subject => "From iLab: Registration Confirmation")
  end

  def user_type_confirmation(user)
    #mail(:to => user.email, :subject => "From iLab: Your User Type was set as #{user.utype.upcase}")
    mail(:to => "wangzhen614@gmail.com", :subject => "From iLab: Your User Type was set as #{user.utype.upcase}")
  end

  def reset_password_confirmation(user, password)
    @password = password
    @user = user
    #mail(:to => user.email, :subject => "From iLab: Reset Password to #{@password}")
    mail(:to => "wangzhen614@gmail.com", :subject => "From iLab: Reset Password to #{@password}")
  end

  def user_account_confirmation(user, password)
    @password = password
    @user = user
    #mail(:to => user.email, :subject => "From iLab: Your user account was created")
    mail(:to => "wangzhen614@gmail.com", :subject => "From iLab: Your user account was created")
  end

  def team_task_confirmation(event)
    @event = event
    @emails = ""
    @students = Student.where(team_id: @event.team_id)
    @students.each do |s|
      @emails = @emails + ', ' + s.email
    end
    @user = User.find(@event.user_id)
    case @user.utype
      when "instructor"
        @author = @user.instructor.full_name
      when "student"
        @author = @user.student.full_name
      when "sponsor"
        @author = @user.sponsor.full_name
    end

    @url = event_path(@event.id)
    @team = Team.find(@event.team_id)

    #mail(:to => @emails, :subject => "From ilab: New team task was created")
    mail(:to => "wangzhen614@gmail.com", :subject => "From ilab: New team task was created")

  end

end
