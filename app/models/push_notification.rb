class PushNotification < ActiveRecord::Base
  attr_accessible :device_token_id, :message, :push_notification_type, :status
end
