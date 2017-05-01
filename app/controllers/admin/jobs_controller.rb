class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create, :edit,:update,:destroy]
  before_action :require_is_admin
  layout "admin"
  before_action :find_job_and_check_permission, only: [:edit,:update,:destroy,:hide,:publish]
  def index
    @jobs =current_user.jobs.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user

    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to admin_jobs_path, notice: "Job updated!"
    else
      render :edit
    end
  end

  def destroy

    @job.destroy
    redirect_to admin_jobs_path,  alert: "Job Deleted!"
  end

  def publish
    @job.publish!
    redirect_to admin_jobs_path
  end

  def hide
    @job.hide!
    redirect_to admin_jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title,:description,:wage_upper_bound,:wage_lower_bound,:contact_email,:is_hidden, :city, :category,:company)
  end

  def find_job_and_check_permission
    @job = Job.find(params[:id])

    if current_user != @job.user
      redirect_to root_path, alert: "You have no permission"
    end
  end
end
