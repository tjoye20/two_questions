Aws.config.update({
  region: ENV["AMAZON_REGION"],
  credentials: Aws::Credentials.new(ENV['AMAZON_KEY_ID'], ENV['AMAZON_SECRET_ACCESS_KEY'])
})

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['AMAZON_BUCKET']).freeze

S3_CLIENT = Aws::S3::Client.new.freeze