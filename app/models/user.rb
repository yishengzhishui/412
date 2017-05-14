class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :resumes
  has_many :jobs

  def admin?
    is_admin
  end
mount_uploader :image, ImageUploader
validates :name, presence: true
#------收藏功能-------
  has_many :job_relationships
  has_many :participated_jobs, :through => :job_relationships, :source => :job

  def is_member_of?(job)
    participated_jobs.include?(job)
  end

  def join!(job)
    participated_jobs << job
  end

  def quit!(job)
    participated_jobs.delete(job)
  end
 # ---已投功能---
  has_many :resume_relationship
  has_many :post_jobs, :through => :resume_relationship, :source => :job

  def has_postmen_of?(job)
    post_jobs.include?(job)
  end

  def join_post!(job)
    post_jobs << job
  end

  def quit_post!(job)
    post_jobs.delete(job)
  end

end
