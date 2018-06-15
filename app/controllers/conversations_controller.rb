class ConversationsController < ApplicationController
    before_action :authenticate_user!

    def index
      @users = User.all

      # get all conversations involving current_user
      @conversations = Conversation.involving(current_user)
    end


    def create
      # sender_idとrecipient_idの二人の間に会話が存在するならば
      if Conversation.between(params[:sender_id],params[:recipient_id]).present?
        # Conversationテーブルの先頭のレコードを取得する
        @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
      else
        # そうでないならば、新しくConversationを作る
        @conversation = Conversation.create(conversation_params)
      end
        # messagesコントローラーのindexアクションへ飛ぶ
      redirect_to conversation_messages_path(@conversation)
    end

    private
    def conversation_params
        params.permit(:sender_id, :recipient_id)
    end
end
