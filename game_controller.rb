class GameController

  def create_player
    print 'Введите Ваше имя: '
    name = gets.strip.downcase.capitalize
    player = Player.new(name)
  end

  def create_dealer
    dealer = Dealer.new
  end

  def create_deck
    deck = CardDeck.new
  end
  # Let's the Game begin
  # create banks
  # create card deck


end
