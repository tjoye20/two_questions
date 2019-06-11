class UploadImagesToS3Job < ApplicationJob
  queue_as :default

  def perform(profile_id, image_file_paths)
    Profiles::UploadImagesProcess.call(profile_id: profile_id, image_file_paths: image_file_paths)
  end
end
