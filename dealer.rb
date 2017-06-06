require_relative 'player.rb'

class Dealer < Player
  AVATAR = "\u{1f4a9}".freeze

  def initialize(name = 'Dealer')
    super
    @name = name
  end

  def display_card_shirt
    secret = "📱"
    cards.each_key { print "#{secret}   " }
    puts "\nРука #{name}."
    puts DIVIDER
  end
end
