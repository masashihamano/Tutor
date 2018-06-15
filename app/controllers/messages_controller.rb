class MessagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_conversation

  # redirect_to this action from conversation controller create action
  def index
    # check if this current_user are involved in conversation
    # 今のユーザーが送り手(sender)もしくは、受けて(recipient)のどちらかならば
    if current_user == @conversation.sender || current_user == @conversation.recipient
      # 今のユーザーが送りて(sender)ならば、受け手(recipient)を@otherに代入する、そうでないならば送りて(sender)に代入する
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      # メッセージを順番に入れる
      @messages = @conversation.messages.order("created_at DESC")
    else
      # 許可がない場合は一覧ページへ返す
      redirect_to conversations_path, alert: "他人のメッセージにアクセスできません"
    end

  end

  def create
    @message = @conversation.messages.new(message_params)
    @messages = @conversation.messages.order("created_at DESC")

    if @message.save
      #create.js.erb が実行される
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
