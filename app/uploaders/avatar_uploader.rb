class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  process :set_content_type
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url  
    ActionController::Base.helpers.asset_path "placeholder.jpg" 
  end

  version :photo_resize do
    process :resize_to_fit => [100, 100]
  end

end