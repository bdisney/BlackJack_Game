class CardDeck
  SUITS = ["\u{2664}", "\u{2661}", "\u{2667}", "\u{2662}"].freeze
  CARD_VALUES = {
    '2' => 2, '3'  => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8,
    '9' => 9, '10' => 10, 'K' => 10, 'J' => 10, 'Q' => 10, 'A' => 1
  }.freeze

  attr_reader :deck

  def initialize
    create
  end

  def create
    @deck = []

    SUITS.each do |suit|
      CARD_VALUES.each do |card, value|
        @deck << [card + suit, value]
      end
    end
    @deck.shuffle!
  end
end
