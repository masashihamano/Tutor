class UsersController < ApplicationController

  #show.html.erbを表示するアクション
  def show
    @user = User.find(params[:id])
  #Userモデルから、userのパラメーターを探す
  end

end
