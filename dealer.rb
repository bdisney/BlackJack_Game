require_relative 'player.rb'

class Dealer < Player
  def initialize(name = 'Dealer')
    super
    @name = name
  end
end
