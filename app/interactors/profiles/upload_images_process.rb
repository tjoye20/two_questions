class Profiles::UploadImagesProcess
  include Interactor::Organizer

  before do 
    if context.profile_id.blank? || context.image_file_paths.blank?
      context.fail!(error: "Bad context in Profiles::UploadImagesProcess. Context: #{context}")
    end 
  end 

  organize Profiles::UploadImagesToS3,
           Profiles::UpdateImages,
           Profiles::DeleteImages

end 