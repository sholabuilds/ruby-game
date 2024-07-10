require_relative "lib/studio_game/game"
require_relative "lib/studio_game/player"
require_relative "lib/studio_game/clumsy_player"
require_relative "lib/studio_game/crazy_player"

game = StudioGame::Game.new("Dinosaur kids")

# __dir__ - absolute path 
players_file = File.join(__dir__, "players.csv")

# shift and get the first command line arg or default to player_file
game.load_players(ARGV.shift || players_file)

clumsy_player_1 = StudioGame::ClumsyPlayer.new("Treezo", 100)
game.add_player(clumsy_player_1)

crazy_player_1 = StudioGame::CrazyPlayer.new("kurama", 50)
game.add_player(crazy_player_1)

loop do
    print "\nHow many game rounds? ('quit' to exit) "
    answer = gets.chomp.downcase

    case answer
    when /^\d+$/
        game.play(answer.to_i)
    when 'exit', 'quit'
        game.print_stats
        break
    else
        puts "Enter number of rounds or 'quit"
    end
end

game.save_high_scores