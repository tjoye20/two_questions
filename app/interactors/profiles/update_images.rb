class Profiles::UpdateImages
  include Interactor

  before do 
    if context.profile_id.blank? || context.images_s3_keys.blank?
      context.fail!(error: "Bad context in Profiles::UploadImagesProcess. Context: #{context}")
    end 
  end 

  def call
    Profile.find(context.profile_id).update(images: context.images_s3_keys)
  end 
end 