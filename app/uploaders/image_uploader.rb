class ImageUploader < CarrierWave::Uploader::Base

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

  version :thumb do
    process :resize_to_fit => [200, 200]
  end

  version :photo_resize do
    process :resize_to_fit => [800, 800]
  end

  version :avatar_resize do
    process :resize_to_fill => [80, 80]
  end
end
