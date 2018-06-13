class ReservationsController < ApplicationController



  def create
    @sharing = Sharing.find(params[:sharing_id])

    # 自分で自分の部屋を予約する場合(カレンダーでの予約作成)
    if current_user == @sharing.user
      #選択されてた日付 ","で区切って配列化
      selectedDates = params[:reservation][:selectedDates].split(",")

      # 今まで、自分自身で予約した予約を取り出す
      reservationsByme = @sharing.reservations.where(user_id: current_user.id)

      # 以前、自分自身で選択した日付
      oldSelectedDates = []

      # 以前、自分自身で予約した"予約の日付"を配列に入れていく
      reservationsByme.each do |reservation|
        oldSelectedDates.push(reservation.start_date)
      end

      # 以前の自身で選択した日付の予約を全て消す
      if oldSelectedDates
        oldSelectedDates.each do |date|
          @reservation = current_user.reservations.where(start_date:date,end_date:date)
          @reservation.destroy_all
        end
      end

      #新しい日付の予約をクリエイトする
      if selectedDates
        selectedDates.each do |date|
          current_user.reservations.create(:sharing_id => @sharing.id,:start_date => date,:end_date => date )
        end
      end

      # redirect_back fallback_location: manage_sharing_calendar_path, notice:"更新しました"
      redirect_to manage_sharing_calendar_path(@sharing), notice: "更新しました。"

    else

  #     # Find the user to pay.
  #     user = @sharing.user
  #
  #     # Charge
  #     amount = params[:reservation][:total_price]
  #
  #     # fee 10％の手数料
  #     fee = (amount.to_i * 0.1).to_i
  #
  #     # Calculate the fee amount that goes to the application.
  #     # docs https://stripe.com/docs/connect/payments-fees
  #     begin
  #       charge_attrs = {
  #         amount: amount,
  #         currency: user.currency,
  #         source: params[:token],
  #         description: "Test Charge via Stripe Connect",
  #         application_fee: fee
  #       }
  #
  #       # Use the platform's access token, and specify the
  #       # connected account's user id as the destination so that
  #       # the charge is transferred to their account.
  # # ここでエラーになる
  #       charge_attrs[:destination] = user.stripe_user_id
  #       charge = Stripe::Charge.create( charge_attrs )
  #
  #       #have to edit view template to show html in flash
  #       flash[:notice] = "Charged successfully!"
  #
  #     rescue Stripe::CardError => e
  #       error = e.json_body[:error][:message]
  #       flash[:error] = "Charge failed! #{error}"
  #     end

      # 予約をパラメーター付与して作成
        @reservation = current_user.reservations.create(reservation_params)
        redirect_to @reservation.sharing, notice: "予約が完了しました。"

    end
  end


  def setdate
    # ajaxで送られてきたsharing_idを(sharingに代入)元にそのシェペットの予約をjsonで返す
    sharing = Sharing.find(params[:sharing_id])
    #今日の日付をtodayに代入
    today = Date.today
    # ↓今日以降の予約が入っている予約をreservationsに代入
    reservations = sharing.reservations.where("start_date >= ? OR end_date >= ?",today,today)

    render json: reservations
  end

  def duplicate
  # 送られてきたstart_dateとend_dateをそれぞれ代入
  start_date = Date.parse(params[:start_date])
  end_date = Date.parse(params[:end_date])
  # is_duplicateは自作関数(private)
  result = {
      duplicate: is_duplicate(start_date, end_date)
  }
  render json: result
  end


  private

    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :price, :total_price, :sharing_id )
    end

    def is_duplicate(start_date, end_date)
      sharing = Sharing.find(params[:sharing_id])
      # start_dateとend_dateの範囲内に予約があるかどうかをcheckに代入
      check = sharing.reservations.where("? < start_date AND end_date < ?",start_date,end_date)

      check.size > 0? true : false
    end

end
