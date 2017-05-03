class Job < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :city , presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: {greater_than: 0}


  scope :recent, -> { order("created_at DESC")}
  scope :published, -> { where(is_hidden: false)}

  has_many :resumes

  has_many :job_relationships
  has_many :members, through: :job_relationships, source: :user

  has_many :resume_relationship
  has_many :postmens, through: :resume_relationship, source: :user

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end
end
