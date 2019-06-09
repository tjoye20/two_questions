class Profiles::UploadImagesToS3
  include Interactor

  before do 
    if context.profile_params.blank?
      context.fail!(error:"Bad context in Profiles::UploadImagesToS3. Context: #{context}")
    end 
  end 

  def call
    context.images_s3_keys = []
    context.profile_params[:images].each do |image_file|
      s3_key = (Rails.env == 'development') ? "development/#{SecureRandom.uuid}" : "production/#{SecureRandom.uuid}"
      file = open(image_file.tempfile.path) { |f| f.read }

      unless S3_BUCKET.put_object({ body: file, key: s3_key })
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