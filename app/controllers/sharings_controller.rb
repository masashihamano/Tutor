class SharingsController < ApplicationController

  # ログイン済ユーザーのみにアクセスを許可する→ログインしていないuserが「シッターになるボタン(sharing)」を押したときにログインページへ飛ばす
  before_action :authenticate_user!

  # onlyで制限しないとindexやshowなど他のアクションにも適用されてしまう
  before_action :set_sharing, only: [:show, :update, :basics, :description, :address, :price, :photos, :calendar, :bankaccount, :publish]

  # 他人の管理ページへのアクセス制限
  before_action :access_deny, only: [:basics, :description, :address, :price, :photos, :calendar, :bankaccount, :publish]


  def index
    @sharings = current_user.sharings
  end

  def show
    @photos = @sharing.photos

    # 予約をした人でないとreviewはかけないという処理
    # sharing_id = ?に@sharing.id が入り AND user_id = ?にcurrent_user.idが入る
    # 今のユーザー(current_user)かつ、このsharing(@sharing_id)を予約しているかどうか
    # if current_user はcurrnt_userがいる場合に実行する
    @currentUserBooking = Reservation.where("sharing_id = ? AND user_id = ?",@sharing.id,current_user.id).present? if current_user

    @reviews = @sharing.reviews
    @currentUserReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    # 現在のユーザーのsharing情報の作成
    @sharing = current_user.sharings.build
  end

  def create
    # パラメーターとともに現在のユーザーのシェアリング情報を作成
    @sharing = current_user.sharings.build(sharing_params)

    if @sharing.save
      redirect_to manage_sharing_basics_path(@sharing), notice:"シェアリング情報を作成しました"
    else
      redirect_to new_sharing_path, notice: "シェアリング情報を作成・保存できませんでした"
    end

  end

  def edit
  end

  def update
    if @sharing.update(sharing_params)

      # redirect_to sharings_path(@sharing), notice: "更新しました"
      # redirect_to :back, notice: "更新しました"
      redirect_back fallback_location: manage_sharing_price_path, notice:"更新しました"
      # Rails 5.1からbackは使えない
    end
  end

  def basics
    # Sharingモデルのidナンバーを探して@sharingに代入
    # @sharing = Sharing.find(params[:id])
  end

  def description
  end

  def address
  end

  def price
  end

  def photos
    @photo = Photo.new
  end

  def calendar
  end

  def bankaccount
    @user = @sharing.user
    session[:sharing_id] = @sharing.id
  end

  def publish
  end

  # def back_url
  #   request.referer
  # end


  private

  # Sharingモデルのidナンバーを探して@sharingに代入
  def sharing_params
    params.require(:sharing).permit(:home_type, :pet_type, :breeding_years, :pet_size, :price, :address, :sharing_title, :sharing_content, :active)
  end

  def set_sharing
    @sharing = Sharing.find(params[:id])
  end

  def access_deny
    if !(current_user == @sharing.user)
      redirect_to root_path, notice: "他人の編集ページにはアクセスできません"
    end
  end

end
