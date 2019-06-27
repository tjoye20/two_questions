class RequestsMailer < ApplicationMailer

  def notification
    @requester      = User.find(params[:user_id])
    @profile_owner  = Profile.find(params[:profile_id]).user
    @response_url   = Rails.application.routes.url_helpers.request_url(@user.uuid)

    mail(to: @profile_owner.email, subject: "Two Questions: #{@requester.display_name.split(' ').first} responded to your profile!")
  end 
end
