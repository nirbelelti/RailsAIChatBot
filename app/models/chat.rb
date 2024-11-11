class Chat < ApplicationRecord
  after_create_commit { broadcast_prepend_to 'chats' }
  after_update_commit { broadcast_replace_to 'chats' }
  after_destroy_commit { broadcast_remove_to 'chats' }

  belongs_to :user
  validates :history, presence: true, on: :update

  before_update :request_answer

  attr_accessor :question

  private

  def request_answer

    return if self.question.blank?

    response = Gemini::Client.send_message(self.question)
    reply = response.dig('candidates', 0, 'content', 'parts', 0, 'text') || response['error'] || "Sorry, I don't understand"
    self.history['massages'] << { "role": 'bot', "content": reply }
    enqueue_add_question_job
  end

  def enqueue_add_question_job
    return if self.question.blank?

    AddQuestionJob.perform_async(id, history.deep_stringify_keys)
  end

end
