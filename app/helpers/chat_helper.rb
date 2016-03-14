module ChatHelper
  def own_message(message)
    return (cookies[:user] == message.user)
  end
end
