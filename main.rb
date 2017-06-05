require_relative 'game_controller.rb'
require_relative 'bank.rb'
require_relative 'card_deck.rb'

require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'user.rb'


puts 'Добро пожаловать в ЛуноПарк'

controller = GameController.new
controller.start_game


# loop do
#   # controller.display_actions
#   # user_choice = gets.strip
#   # break if user_choice == '0'
#   # controller.render_action(user_choice)
# end
