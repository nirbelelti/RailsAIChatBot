class AddQuestionJob
  include Sidekiq::Job

  def perform(*args)
    chat = Chat.find(args[0])
    chat.update(history: args[1])
  end
end
