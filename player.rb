class Player
  attr_reader :name, :account, :cards

  def initialize(name)
    @name = name
    @account = Bank.new(self, 100)
    @cards = {}
  end

  def take_card(card)
    cards[card[0]] = card[1]
  end

  def display_cards
    cards.each_key { |card| print "#{card} " }
    puts "\nУ вас: #{cards.values.reduce(:+)}"
  end
end
