class Profiles::UploadImagesToS3
  include Interactor

  before do 
    if context.image_file_paths.blank?
      context.fail!(error:"Bad context in Profiles::UploadImagesToS3. Context: #{context}")
    end 
  end 

  def call
    context.images_s3_keys = []
    context.image_file_paths.each do |image_file_path|
      s3_key = (Rails.env == 'development') ? "development/#{SecureRandom.uuid}" : "production/#{SecureRandom.uuid}"

      unless S3_BUCKET.put_object({ body: File.open(image_file_path), key: s3_key })
        context.fail!(error: "Profiles::UploadImagesToS3 did not create public url. Context: #{context}")
      else 
        context.images_s3_keys << s3_key.split('/').last
      end  
    end
  end

  def rollback
    context.images_s3_keys.each do |s3_key|
      S3_CLIENT.delete_object(key: s3_key, bucket: ENV['AMAZON_BUCKET'])
    end 
  end  
end 