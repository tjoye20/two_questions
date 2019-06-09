class Profiles::CreateProcess
  include Interactor::Organizer

  before do 
    if context.profile_params.blank?
      context.fail!(error: "Bad context in Profiles::CreateProcess. Context: #{context}")
    end 
  end 

  organize Profiles::UploadImagesToS3,
           Profiles::Create

end 