require_relative 'player.rb'

class User < Player
  def initialize(name)
    super
    @name = name
  end
end
