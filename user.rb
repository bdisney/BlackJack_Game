require_relative 'player.rb'

class User < Player
  AVATAR = "🍀".freeze
  def initialize(name)
    super
    @name = name
  end
end
