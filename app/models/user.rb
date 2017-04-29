class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :resumes
  has_many :jobs

#------收藏功能-------
  has_many :job_relationships
  has_many :participated_jobs, :through => :job_relationships, :source => :job



  def admin?
    is_admin
  end

  def is_member_of?(job)
    participated_jobs.include?(job)
  end

  def join!(job)
    participated_jobs << job
  end

  def quit!(job)
    participated_jobs.delete(job)
  end

end
