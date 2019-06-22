class ApprovedViewNotificationJob < ApplicationJob
  queue_as :default

  def perform(profile_id, user_id)
    ApprovedViewMailer.with(profile_id: profile_id, user_id: user_id).notification.deliver_now
  end
end
