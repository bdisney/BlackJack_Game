require_relative 'player.rb'

class Dealer < Player
  def initialize(name = 'Dealer')
    super
    @name = name
  end

  def display_card_shirt
    secret = "\u{2B1C}"
    cards.each_key { print "#{secret}   " }
    puts "\nРука #{name}."
    puts DIVIDER
  end
end
