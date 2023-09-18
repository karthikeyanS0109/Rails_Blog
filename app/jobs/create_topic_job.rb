class CreateTopicJob < ApplicationJob
  queue_as :default

  def perform(user)
    CreateTopicMailer.create_topic(user).deliver_now
  end
end
