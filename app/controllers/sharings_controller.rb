class SharingsController < ApplicationController

  # ログイン済ユーザーのみにアクセスを許可する→ログインしていないuserが「シッターになるボタン(listing)」を押したときにログインページへ飛ばす
  before_action :authenticate_user!

  before_action :set_sharing, only: [:show, :update, :basics, :description, :address, :price, :photos, :calendar, :bankaccount, :publish]



  def index
    @sharings = current_user.sharings
  end

  def show
    @photos = @sharing.photos
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

      # redirect_to listings_path(@listing), notice: "更新しました"
      # redirect_to :back, notice: "更新しました"
      redirect_back fallback_location: manage_sharing_price_path, notice:"更新しました"
      # Rails 5.1からbackは使えない
    end
  end

  def basics
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
    @user = @listing.user
    session[:listing_id] = @listing.id
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

end
