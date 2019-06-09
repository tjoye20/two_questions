class Profiles::Create
  include Interactor

  before do 
    if context.profile_params.blank? || context.images_s3_keys.blank?
      context.fail!(error: "Bad context in Profiles::Create. Context: #{context}")
    end 
    update_images_array
  end 

  def call
    context.profile = Profile.new(context.profile_params) 
    
    unless context.profile.save
      context.fail!(error: 'Bad context in Profiles::Create. Failed to create requests. Errors: ' + context.profile.errors.full_messages.join(', '))
    end
  end 

  def rollback
    context.profile.destroy
  end 

  private

  def update_images_array
    context.profile_params[:images] = context.images_s3_keys
  end 
end 