class GameController
  USER_ACTIONS = ['1-Пропустить ход', '2-Взять карту', '3-Открыть карты.'].freeze

  #attr_reader :deck

  def initialize
    @bank   = Bank.new(:game, 0)
    @deck   = create_deck
    @dealer = create_dealer
    @user   = create_user
  end

  def new_game
    clear_screen
    first_move # по 2 карты у обоих игроков
    second_move
    third_move
  end

  def first_move
    bet
    2.times do
      [@user, @dealer].each { |player| player.take_card(@deck.give_out_card) }
    end
    show_players_cards
  end

  def second_move
    user_actions
    execute_action(@user_choice)
  end

  def third_move
    clear_screen
    info
    if @user.cards.count < 3
      show_players_cards
      user_actions
      execute_action(@user_choice)
    else
      open_cards
    end
  end

  def open_cards
    clear_screen
    info
    @dealer.display_cards
    @user.display_cards
    choose_winner
    reset_options
  end

  def bet(value = 10)
    [@user.account, @dealer.account].each { |player| player.money_transfer(@bank, value) }
    info
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
      open_cards
      new_game
    else
      puts "Неизвестная команда!"
    end
  end

  def dealer_move
    @dealer.take_card(@deck.give_out_card) if @dealer.pre_results < 18
  end

  def choose_winner
    @winner =
      if @user.results > @dealer.results
        @user
      elsif @user.results < @dealer.results
        @dealer
      end
    @winner ? (puts "Выиграл - #{@winner.name}!") : (puts 'Ничья!')
    @bank.money_transfer(@winner.account, @bank.sum) if @winner
  end

  def game_over
    print 'Enter - Продолжить. Exit - выход : '
    user_choice = gets.strip.downcase

    exit if user_choice == 'exit'
    reset_options
  end

  def reset_options
    @deck = create_deck
    @available_actions, @winner = nil

    [@user.cards, @dealer.cards].each(&:clear)
  end

  def info
    puts "#{@user.name}: #{@user.account.sum} $. \tДилер: #{@dealer.account.sum} $. \tБанк: #{@bank.sum} $."
  end

  protected

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

  def clear_screen
    gets
    system 'clear'
  end
end
