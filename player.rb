class Player
  DIVIDER = "-" * 15

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
    results = pre_results
    results <= 21 ? results : results = 0
  end

  def display_cards
    cards.each_key { |card| print "#{card} " }
    puts "\nРука #{name}: #{pre_results}"
    puts DIVIDER
  end

  def pre_results
    results = cards.values.reduce(:+)
    @pre_results = results

    cards.each do |card|
      if card[1] == 1
        @pre_results = results + 10
        @pre_results < 22 ? @pre_results : @pre_results = results
      end
    end
    @pre_results
  end
end
