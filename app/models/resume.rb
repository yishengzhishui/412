class Resume < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :job
  belongs_to :resume_relationship
  
  mount_uploader :attachment, AttachmentUploader
end
