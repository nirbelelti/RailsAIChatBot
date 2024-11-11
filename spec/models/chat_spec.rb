require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Chat, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
  end
  describe 'Validations' do
    it { should validate_presence_of(:history).on(:update) }
  end

  describe 'Callbacks' do
    let(:user) { create(:user) }
    let(:chat) { create(:chat, :with_history, user: user, question: 'What is the weather today?') }

    before do
      Sidekiq::Testing.fake!
    end

    context 'before_update :request_answer' do
      it 'calls request_answer before update' do
        expect(chat).to receive(:request_answer)
        chat.update(question: 'What is the weather today?')
      end
      it 'enqueues AddQuestionJob when question is present' do
        allow(Gemini::Client).to receive(:send_message).and_return({
                                                                     'candidates' => [
                                                                       { 'content' => {
                                                                         'parts' => [
                                                                           { 'text' => 'It is sunny today.' }
                                                                         ]
                                                                       } }
                                                                     ]
                                                                   })

        expect {
          chat.send(:request_answer)
        }.to change(AddQuestionJob.jobs, :size).by(1)

        expect(chat.history['massages'].last).to eq({ role: 'bot', content: 'It is sunny today.' })
      end
    end

    context "enqueue_add_question_job" do

      it 'enqueues AddQuestionJob when question is present' do
        expect {
          chat.send(:enqueue_add_question_job)
        }.to change(AddQuestionJob.jobs, :size).by(1)
      end

      it 'does not enqueue AddQuestionJob when question is blank' do
        chat.question = ''
        expect {
          chat.send(:enqueue_add_question_job)
        }.not_to change(AddQuestionJob.jobs, :size)
      end

    end
  end

end
