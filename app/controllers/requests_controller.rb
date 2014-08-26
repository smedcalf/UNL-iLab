class RequestsController < ApplicationController

  def index
    request_manage_options
    if current_user.instructor?
      @requests = Request.all
    else
      @requests = Request.where(student_id: current_user.student.id)
      if !@requests.empty?
        redirect_to request_path(@requests.first.id)
      else
        redirect_to new_request_path
      end
    end
  end

  def new
    @request = Request.new
    if current_user.instructor?
      @students = Student.all
    else
      @students = Student.where(id: current_user.student.id)
    end

    @url = "create"
  end

  def create
    @request = Request.new(request_params)

    if @request.valid?
      @request.save
      flash[:success] = "Your request has been saved."
      redirect_to requests_path
    else
      flash[:error] = @request.errors.full_messages.join(", ").html_safe
      render "new"
    end
  end


  def show
    set_request
  end

  def edit
    set_request
    if current_user.instructor?
      @students = Student.all
    else
      @students = Student.where(id: current_user.student.id)
    end
    @url = "update"
  end

  def update
    set_request
    @url = "update"
    if @request.update_attributes(request_params)
      flash[:success] = "Request was successfully updated."
      redirect_to request_path(@request.id)
    else
      flash[:error] = @request.errors.full_messages.join(", ").html_safe
      render 'edit'
    end
  end

  def manage_requests
    if params[:request].nil?
      flash[:error] = 'No request was selected!'
      redirect_to requests_path
    else
      case params[:options]
        when 'delete'
          Request.destroy(params[:request])
        when 'activate'
          Request.where(:id => params[:request]).update_all(:active => true)
        when 'deactivate'
          Request.where(:id => params[:request]).update_all(:active => false)
        when 'approve'
          Request.where(:id => params[:request]).update_all(:approved => true)
        when 'disapprove'
          Request.where(:id => params[:request]).update_all(:approved => false)
        when 'show'
          redirect_to request_path(:id => params[:request]) and return
      end
      redirect_to requests_path
    end
  end

  private

  def request_params
    params.require(:request).permit(:student_id, :start_date, :end_date)
  end

  def set_request
    @request = Request.find_by_id(params[:id])
  end
  def request_manage_options
    if current_user.utype == "admin" || current_user.utype == "instructor"
      @request_manage_options = [{"value" => "", "label" => "Please select..."},
                                 {"value" => "activate", "label" => "Activate"},
                                 {"value" => "deactivate", "label" => "Deactivate"},
                                 {"value" => "approve", "label" => "Approve"},
                                 {"value" => "disapprove", "label" => "Disapprove"},
                                 {"value" => "delete", "label" => "Delete"}]
    else
      @request_manage_options = [{"value" => "", "label" => "You don't have authority to manage requests"}]
    end
  end
end
