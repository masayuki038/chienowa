module StarsHelper
  def starred?(stars)
    stars.each do |star|
      return true if current_user?(star.user)
    end
    false
  end
end
