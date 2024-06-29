class CreateApplicationJob < ApplicationJob
  queue_as :default

  def perform(name)
    application = Application.new(name: name)
    application.save
    # Additional processing can be added here, such as sending notifications, etc.
  end
end
