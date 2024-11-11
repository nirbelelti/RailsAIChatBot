class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show edit update destroy set_current_chat]

  # GET /chats or /chats.json
  def index
    @chats = Chat.where(user_id: current_user.id).order(updated_at: :desc)
    @chat = Chat.new
  end

  # GET /chats/1 or /chats/1.json
  def show
  end

  # GET /chats/new
  def new
    @chat = Chat.new
  end

  # GET /chats/1/edit
  def edit
  end

  # POST /chats or /chats.json
  def create
    @chat = Chat.new(chat_params)
    @chat.user_id = current_user.id

    if @chat.save
      session[:current_chat_id] = @chat.id
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend('chats', partial: 'chat', locals: { chat: @chat }),
            turbo_stream.replace('chat_content', partial: 'current_chat', locals: { chat: @chat }),
            turbo_stream.replace('question_input', partial: 'add_question', locals: { chat: @chat })
          ]
        end
        format.html { redirect_to chats_path, notice: 'Tt was successfully created.' }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace('new_chat', partial: 'form', locals: { chat: @chat }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
    payload = if @chat.history.nil?
                puts 'history not present'
                { massages: [{ "role": 'user', "content": chat_params[:question] }] }

              else
                puts 'history present'
                { massages: @chat.history['massages'] << { "role": 'user', "content": chat_params[:question] }}

              end
    @chat.question = chat_params[:question]

    respond_to do |format|
      if @chat.update(history: JSON.parse(payload.to_json))
        puts 'updated chat in controller'
        format.html { redirect_to @chat, notice: 'Chat was successfully updated.' }
        format.json { render :show, status: :ok, location: @chat }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('chat_content', partial: 'current_chat', locals: { chat: @chat }),
          ]
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1 or /chats/1.json
  def destroy
    @chat.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@chat) }
      format.html { redirect_to chats_url, notice: 'Chat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_current_chat
    session[:current_chat_id] = @chat.id
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('chat_content', partial: 'current_chat', locals: { chat: @chat }),
          turbo_stream.replace('question_input', partial: 'add_question', locals: { chat: @chat })]
      end
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chat
    @chat = Chat.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def chat_params
    params.require(:chat).permit(:user_id, :history, :question)
  end
end
