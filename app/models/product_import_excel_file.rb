class ProductImportExcelFile < ActiveRecord::Base
  include Gator::AttachmentAccessToken
  before_create :generate_access_token
  has_attached_file :file,
    :path => ":rails_root/public:url",
    :url => "/system/upload_files/:attachment_access_token/file.:extension"

  # validates_attachment_content_type :file, :content_type => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  do_not_validate_attachment_file_type :file
  validates_attachment_presence :file
end
