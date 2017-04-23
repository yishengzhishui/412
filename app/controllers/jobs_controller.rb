class JobsController < ApplicationController
  before_action :authenticate_user! ,only: [:new,:edit,:create,:update,:destroy]
  before_action :validate_search_key, only: [:search]

  def index
    @jobs = case params[:order]

    when 'by_lower_bound'
      Job.published.order('wage_lower_bound DESC').paginate(:page => params[:page], :per_page => 8)
    when 'by_upper_bound'
      Job.published.order('wage_upper_bound DESC').paginate(:page => params[:page], :per_page => 8)
    else
      Job.published.recent.paginate(:page => params[:page], :per_page => 8)
    end



  end

  def show
    @job = Job.find(params[:id])

    if @job.is_hidden
      flash[:warning] = "This Job already archieved"
      redirec_to root_path
    end
  end

  def search
    if @query_string.present?
      search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 5 )
    end
  end


  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_cont => query_string }
  end



  private

  def job_params
    params.require(:job).permit(:title,:description,:wage_upper_bound, :wage_lower_bound,:contact_email,:is_hidden)
  end


end
