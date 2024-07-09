require_relative "lib/studio_game/game"
require_relative "lib/studio_game/player"

game = Game.new("Dinosaur kids")

game.load_players("players.csv")


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


# game.total_points_per_player
# game.high_scores

# puts "... #{player_4.treasures_collected.values.sum}"

# player_1 = Player.new("finn", 60)
# player_2 = Player.new("lucy", 90)
# player_3 = Player.new("jase")
# player_4 = Player.new("alex", 125)

# game_2 = Game.new("Winner Takes All")
# game_2.add_player(player_1)
# game_2.add_player(player_2)
# game_2.add_player(player_3)
# game_2.add_player(player_4)
# game_2.play




# puts "Champ!" unless player_1.health <= 50

