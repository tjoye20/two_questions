class Profiles::SendImagesToJob
  include Interactor

  before do 
    if context.profile.blank? || context.image_file_paths.blank?
      context.fail!(error:"Bad context in Profiles::SendImagesToJob. Context: #{context}")
    end 
  end 

  def call
    UploadImagesToS3Job.perform_later(context.profile.id, context.image_file_paths)
  end 
end 