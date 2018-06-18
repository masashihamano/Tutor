class PagesController < ApplicationController

  def index
    @users = User.all
  end

  def search
    if params[:search].present?
    # 検索欄が空欄でない(入力されている)場合
      session[:address] = params[:search]

      if params["lat"].present? & params["lng"].present?
        @latitude = params["lat"].to_f
        @longitude = params["lng"].to_f

        geolocation = [@latitude,@longitude]

      else
        geolocation = Geocoder.coordinates(params[:search])
        @latitude = geolocation[0]
        @longitude = geolocation[1]
      end

      @sharings = Sharing.where(active: true).near(geolocation, 1, order: 'distance')

    else
    # 検索欄が空欄の場合
      @sharings = Sharing.where(active: true).all
      @latitude = @sharings.to_a[0].latitude
      @longitude = @sharings.to_a[0].longitude

    end


    # Ransack q のチェックボックス一覧
      if params[:q].present?

        if params[:q][:price_gteq].present?
          session[:price_gteq] = params[:q][:price_gteq]
        else
          session[:price_gteq] = nil
        end


        if params[:q][:price_lteq].present?
          session[:price_lteq] = params[:q][:price_lteq]
        else
          session[:price_lteq] = nil
        end

        if params[:q][:home_type_eq_any].present?
          session[:home_type_eq_any] = params[:q][:home_type_eq_any]
          session[:House] = session[:home_type_eq_any].include?("一軒家")
          session[:Mansion] = session[:home_type_eq_any].include?("マンション")
          session[:Apartment] = session[:home_type_eq_any].include?("アパート")
        else
          session[:home_type_eq_any] = ""
          session[:House] = false
          session[:Mansion] = false
          session[:Apartment] = false
        end

        if params[:q][:pet_type_eq].present?
          session[:pet_type_eq] = params[:q][:pet_type_eq]
        else
          session[:pet_type_eq] = nil
        end


        if params[:q][:breeding_years_gteq].present?
          session[:breeding_years_gteq] = params[:q][:breeding_years_gteq]
        else
          session[:breeding_years_gteq] = nil
        end

      end

      # Q条件をまとめたものをセッションQに入れる
      session[:q] = {"price_gteq"=>session[:price_gteq], "price_lteq"=>session[:price_lteq],  "home_type_eq_any"=>session[:home_type_eq_any], "pet_type_eq"=>session[:pet_type_eq], "breeding_years_gteq"=>session[:breeding_years_gteq]}


      # ransack検索
      @search = @sharings.ransack(session[:q])
      @result = @search.result(distinct: true)


    #リスティングデータを配列にしてまとめる
    @arrsharings = @sharings.to_a

    # start_date end_dateの間に予約がないことを確認.あれば削除
    if ( !params[:start_date].blank? && !params[:end_date].blank? )

      session[:start_date] = params[:start_date]
      session[:end_date] = params[:end_date]

      start_date = Date.parse(session[:start_date])
      end_date = Date.parse(session[:end_date])

      @sharings.each do |sharing|

        # check the sharing is availble between start_date to end_date
        unavailable = sharing.reservations.where(
          "(? <= start_date AND start_date <= ?)
          OR (? <= end_date AND end_date <= ?)
          OR (start_date < ? AND ? < end_date)",
          start_date, end_date,
          start_date, end_date,
          start_date, end_date
        ).limit(1)

        # delete unavailable room from @sharings
        if unavailable.length > 0
          @arrsharings.delete(sharing)
        end
      end
    end
  end


  def ajaxsearch
    # まずajaxで送られてきた緯度経度をセッションに入れる
    if !params[:geolocation].blank?
      geolocation = params[:geolocation]
    end

    # まずajaxで送られてきた緯度経度をセッションに入れる
    if !params[:location].blank?
      session[:address] = params[:location]
    end

    @sharings = Sharing.where(active: true).near(geolocation, 1, order: 'distance')

# searchメソッドとここから同じ
    #リスティングデータを配列にしてまとめる
    @arrsharings = @sharings.to_a

    # start_date end_dateの間に予約がないことを確認.あれば削除
    if ( !session[:start_date].blank? && !session[:end_date].blank? )

      start_date = Date.parse(session[:start_date])
      end_date = Date.parse(session[:end_date])

      @sharings.each do |sharing|

        # check the sharing is availble between start_date to end_date
        unavailable = sharing.reservations.where(
            "(? <= start_date AND start_date <= ?)
              OR (? <= end_date AND end_date <= ?)
              OR (start_date < ? AND ? < end_date)",
            start_date, end_date,
            start_date, end_date,
            start_date, end_date
        ).limit(1)

        # delete unavailable room from @sharings
        if unavailable.length > 0
          @arrsharings.delete(sharing)
        end
      end
    end
# ここまでsearchメソッドと同じ

    respond_to :js
  end

end
