module ApplicationHelper

  # 日本時間表記の0900を除外
  def japanese_time(time)
    time.strftime("%Y-%m-%d　%H:%M")
  end 
end
