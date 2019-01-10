class Attachment < ApplicationRecord
  mount_uploader :file, AttachmentUploader
  validates_presence_of :file
  before_save :update_file_attributes

  private

  def update_file_attributes
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end
end
