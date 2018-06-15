class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  def message_time_day
    created_at.strftime('%m月%d日')
  end

  def message_time
    created_at.strftime('%H時%M分')
  end

end
