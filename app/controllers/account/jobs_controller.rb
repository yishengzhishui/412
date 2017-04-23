class Account::JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout "admin"
  def index
    @jobs = current_user.jobs.recent.paginate(:page => params[:page], :per_page => 5)
  end
end
