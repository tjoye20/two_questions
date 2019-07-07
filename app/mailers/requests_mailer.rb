class RequestsMailer < ApplicationMailer

  def notification
    @requester      = User.find(params[:user_id])
    @profile_owner  = Profile.find(params[:profile_id]).user
    @response_url   = 'https://www.asktwoquestions.co/requests/' + @requester.uuid

    mail(to: @profile_owner.email, subject: "Two Questions: #{@requester.display_name.split(' ').first} responded to your profile!")
  end 
end
