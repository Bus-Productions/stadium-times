class PushNotification < ActiveRecord::Base
  attr_accessible :device_token_id, :message, :push_notification_type, :status

  belongs_to :device_token

  def send_notification
    #determine what type of notification, and send
    if self.device_token.ios_device_token && self.device_token.ios_device_token.length > 0
      #send ios
      send_ios_notification
    end
    if self.device_token.android_device_token && self.device_token.android_device_token.length > 0
        #send android
        send_android_notification
    end
  end


  def send_ios_notification
    n = Rapns::Apns::Notification.new
    n.app = Rapns::Apns::App.find_by_name(ENV['IOS_RAPNS_ENVIRONMENT'])
    n.device_token = self.device_token.ios_device_token
    n.alert = self.message
    n.attributes_for_device = {}
    n.save!
  end


  def send_android_notification
    n = Rapns::Gcm::Notification.new
    n.app = Rapns::Gcm::App.find_by_name(ENV['ANDROID_RAPNS_ENVIRONMENT'])
    n.registration_ids = [self.device_token.android_device_token]
    n.data = {:message => self.message}
    n.save!
  end

end
