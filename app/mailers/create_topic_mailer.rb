class CreateTopicMailer < ApplicationMailer


  def create_topic(user)
    @user = user
    mail to: @user.email, subject: "Topic Notification"
  end
end
