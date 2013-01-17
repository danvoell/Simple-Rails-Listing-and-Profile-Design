# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

 version :supermini do
    process :resize_to_limit => [20, 20]
  end

  version :mini do
    process :resize_to_limit => [60, 60]
  end

  version :thumb do
    process :resize_to_limit => [120, 120]
  end

version :medium do
    process :resize_to_limit => [400, 400]
  end

end
