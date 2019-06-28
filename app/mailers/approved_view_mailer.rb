class ApprovedViewMailer < ApplicationMailer

  def notification
    @profile  = Profile.includes(:user).find(params[:profile_id])
    @user     = User.includes(:profile).find(params[:user_id])
    @profile_url = 'https://www.asktwoquestions.co/profiles/' + @user.profile.uuid

    mail(to: @profile.user.email, subject: "Two Questions: #{@user.display_name.split(' ').first} liked your profile!")
  end 
end
