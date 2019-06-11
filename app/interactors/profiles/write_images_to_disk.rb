class Profiles::WriteImagesToDisk
  include Interactor

  before do 
    if context.profile_params_images.blank?
      context.fail!(error:"Bad context in Profiles::WriteImagesToDisk. Context: #{context}")
    end 
  end 

  def call
    context.image_file_paths = []

    context.profile_params_images[:images].each do |image_file|
      file_name = image_file.original_filename
      out_file = File.write(file_name, image_file.tempfile)
      context.image_file_paths << file_name
    end 
  end 

  def rollback
    context.image_file_paths.each do |file_name|
      File.delete(file_name)
    end 
  end 
end 