class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_isnot_admin

  def index
    @job = Job.find(params[:job_id])
    @resumes = @job.resumes
  end
  def new
    @job = Job.find(params[:job_id])
    @resume = Resume.new
  end

  def create
    @job = Job.find(params[:job_id])
    @resume =Resume.new(resume_params)
    @resume.job = @job
    @resume.user = current_user

    if @resume.save
      current_user.join_post!(@job)
      current_user.join!(@job)
      flash[:notice] = "成功提交简历"
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def edit
    @job = Job.find(params[:job_id])
    @resume = Resume.find(params[:id])
  end

  def update
    @job = Job.find(params[:job_id])
    @resume = Resume.find(params[:id])

    if @resume.update(resume_params)
      redirect_to job_path(@job) , notice: "更新简历成功！"
    else
      redirect_to :edit
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    @resume = Resume.find(params[:id])
    @resume.destroy
    current_user.quit_post!(@job)

    redirect_to job_path(@job)
  end

  private

  def resume_params
    params.require(:resume).permit(:content,:attachment)
  end

end
