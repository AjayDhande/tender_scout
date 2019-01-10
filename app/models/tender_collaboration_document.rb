class TenderCollaborationDocument < ApplicationRecord
  belongs_to :tender, class_name: 'Core::Tender'
  mount_uploader :file, TenderCollaborationDocumentUploader
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
