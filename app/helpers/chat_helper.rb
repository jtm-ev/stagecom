module ChatHelper
  def own_message(message)
    return (cookies[:user] == message.user) ? "right floated" : "left floated"
  end
end
