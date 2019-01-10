class Gallery < ApplicationRecord
  mount_uploader :image, CaseGalleryUploader
end
