class Account::JobsController < ApplicationController
  before_action :authenticate_user!

  def index
    @jobs = current_user.participated_jobs.recent.paginate(:page => params[:page], :per_page => 5)
  end
end
