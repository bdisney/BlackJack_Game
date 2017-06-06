class GameController
  USER_ACTIONS = ['1-Пропустить ход', '2-Взять карту', '3-Открыть карты', '0-Выход'].freeze

  def initialize
    @bank   = Bank.new(:game, 0)
    @deck   = create_deck
    @dealer = create_dealer
    @user   = create_user
  end

  def user_actions
    @available_actions ||= USER_ACTIONS.dup

    @available_actions.each { |action| print "#{action} " }
    @user_choice = gets.to_i
    @available_actions.delete_at(@user_choice - 1)
  end

  def execute_action(action)
    case action
    when 1
      dealer_move
    when 2
      @user.take_card(@deck.give_out_card)
      dealer_move
    when 3
      clear_screen
      score_bar
      open_cards
    when 0
      puts 'Всего хорошего!'
      exit
    else
      puts "Неизвестная команда!"
    end
  end

  def new_game
    clear_screen
    first_move
    next_move
  end

  def first_move
    bet
    2.times do
      [@user, @dealer].each { |player| player.take_card(@deck.give_out_card) }
    end
    show_players_cards
    user_actions
    execute_action(@user_choice)
  end

  def next_move
    clear_screen
    score_bar
    if @user.cards.count < 3
      show_players_cards
      user_actions
      execute_action(@user_choice)
    else
      open_cards
    end
  end

  def open_cards
    @dealer.display_cards
    @user.display_cards
    choose_winner
    reset_options
  end

  def choose_winner
    winner =
      if @user.results > @dealer.results
        @user
      elsif @user.results < @dealer.results
        @dealer
      end
      winner ? money_transfer(winner) : draw
    gets
  end

  def money_transfer(winner)
    puts "Выиграл - #{winner.name}!"
    @bank.money_transfer(winner.account, @bank.sum)
  end

  def draw
    puts 'Ничья!'
    cash_back = @bank.sum / 2
    [@user, @dealer].each { |player| @bank.money_transfer(player.account, cash_back) }
  end

  # def game_over
  #   print 'Enter - Продолжить. Exit - выход : '
  #   user_choice = gets.strip.downcase

  #   exit if user_choice == 'exit'
  #   reset_options
  # end

  def reset_options
    @deck = create_deck
    @available_actions, @winner = nil

    [@user.cards, @dealer.cards].each(&:clear)
    new_game
  end

  protected

  def bet(value = 10)
    [@user.account, @dealer.account].each { |player| player.money_transfer(@bank, value) }
    score_bar
  end

  def dealer_move
    @dealer.take_card(@deck.give_out_card) if @dealer.pre_results < 18
  end

  def show_players_cards
    @dealer.display_card_shirt
    @user.display_cards
  end

  def create_dealer
    @dealer = Dealer.new
  end

  def create_deck
    @deck = CardDeck.new
  end

  def create_user
    print 'Введите Ваше имя: '
    name = gets.strip.downcase.capitalize
    @user = User.new(name)
  end

  def score_bar
    print "#{User::AVATAR}  #{@user.name}: #{@user.account.sum} $. ",
          "#{Dealer::AVATAR}  Дилер: #{@dealer.account.sum} $. ",
          "#{Bank::AVATAR}  Банк: #{@bank.sum} $.\n"
  end

  def clear_screen
    gets
    system 'clear'
  end
end
