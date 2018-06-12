module ApplicationHelper
  # applicationヘルパーの役割：ここで書いた変数(アクション)はどのviewでも適用される

# 参照↓
# https://www.udemy.com/ruby-on-rails-g/learn/v4/t/lecture/5843078?start=0

  # controllerという引数を持ち、その引数が現在のcontorollerに含まれていたらtrueを返す
  def controller?(controller)
      controller.include?(params[:controller])
  end

  # actionという引数を持ち、その引数が現在のactionに含まれていたらtrueを返す
  def action?(action)
      action.include?(params[:action])
  end

end
