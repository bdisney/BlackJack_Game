class GameController
  attr_reader :deck

  def initialize
    @bank = Bank.new(:game, 0)
  end

  def start_game
    create_player
    create_dealer
    create_deck
    game
  end

  def create_player
    print 'Введите Ваше имя: '
    name = gets.strip.downcase.capitalize

    @user = User.new(name)

    @user ? (puts "Hello, #{@user.name}! Let the fun begins!") : (raise "You should enter your name first")
  end

  def create_dealer
    @dealer = Dealer.new
  end

  def create_deck
    @deck = CardDeck.new
    puts @deck.inspect
  end

  def game
    first_move
    @user.display_cards
  end

  def first_move
    bet
    2.times do
      [@user, @dealer].each { |player| player.take_card(@deck.give_out_card) }
    end
  end

  def bet(value = 10)
    [@user.account, @dealer.account].each { |player| player.money_transfer(@bank, value) }
    puts "Счет игрока: #{@user.account.sum}, счет дилера: #{@dealer.account.sum}. В банке: #{@bank.sum}"
  end
end
