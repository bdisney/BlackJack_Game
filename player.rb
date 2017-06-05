class Player
  BORDER = "-" * 15

  attr_reader :name, :account, :cards

  def initialize(name)
    @name = name
    @account = Bank.new(self, 100)
    @cards = {}
  end

  def take_card(card)
    cards[card[0]] = card[1]
  end

  def results
    results = cards.values.reduce(:+)
    results <= 21 ? results : results = 0
  end

  def display_cards
    cards.each_key { |card| print "#{card} " }
    puts "\nРука #{name}: #{cards.values.reduce(:+)}"
    puts BORDER
  end
end
