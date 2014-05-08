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
    @author = @user.profile.full_name

    @url = event_path(@event.id)
    @team = Team.find(@event.team_id)

    if @event.created_at != @event.updated_at
      @subject = "From iLab: Team task was updated"
    else
      @subject = "From iLab: New team task was created"
    end

    #mail(:to => @emails, :subject => @subject)
    mail(:to => "wangzhen614@gmail.com", :subject => @subject)

  end

  def personal_task_confirmation(event)
    @event = event
    @email = @event.user.email

    @url = event_path(@event.id)

    if @event.created_at != @event.updated_at
      @subject = "From iLab: Personal task was updated"
    else
      @subject = "From iLab: Personal task was created"
    end

    #mail(:to => @email, :subject => "From ilab: New team task was created")
    mail(:to => "wangzhen614@gmail.com", :subject => @subject)

  end

end
