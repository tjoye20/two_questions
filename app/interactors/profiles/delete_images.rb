class Profiles::DeleteImages
  include Interactor

  before do 
    if context.image_file_paths.blank?
      context.fail!(error: "Bad context in Profiles::DeleteImages. Context: #{context}")
    end 
  end 

  def call
    context.image_file_paths.each do |file_name|
      File.delete(file_name)
    end 
  end 
end 