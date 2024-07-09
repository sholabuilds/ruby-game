require_relative "lib/studio_game/game"
require_relative "lib/studio_game/player"

class Game
    attr_reader :game_title, :players

    def initialize(game_title)
        @game_title = game_title
        @players = []
    end

    # Add player
    def add_player(player)
        @players.push(player)
    end

    # Roll dice
    def roll_dice
        rand(1..6)
    end

    # Print stats
    def print_stats
        puts "\n#{@game_title} Stats:"
        puts "-" * 20
        total_points_per_player
        high_scores
    end

    # Sort players
    def sorted_players_by_score
        @players.sort_by { |player| player.score }.reverse
    end

    # Total points
    def total_points_per_player
        @players.each do |player| 
            puts "\n#{player.name}'s treasure point totals:"

            player.treasures_collected.each do |treasure, value| 
                puts "#{treasure}: #{value}"
            end

            puts "Total: £#{player.treasures_collected.values.sum}"
        end
    end

    # High scores
    def high_scores
        puts "\nHigh Scores:"
        
        sorted_players_by_score.each do |player| 
            name = player.name.ljust(20, ".")
            points = player.score.round.to_s.rjust(5)
            puts "#{name}#{points}"
        end
    end

    # Play
    def play(rounds=2)
        puts TreasureTrove.treasure_items

        puts "\nBefore playing:"
        @players.each { |player| puts player }

        1.upto(rounds) do |round| 
            puts "\nRound #{round}:"

            @players.each do |player|
                number_rolled = roll_dice
    
                case number_rolled
                when 1..2
                    player.drain
                    puts "#{player.name} got drained 😢"
                when 3..4
                    puts "#{player.name} got skipped"
                else 
                    player.boost
                    puts "#{player.name} got boosted 🥳"
                end

                treasure = TreasureTrove.random_treasure
                player.add_treasure(treasure.name, treasure.points)
                puts "#{player.name} found a #{treasure.name} worth #{treasure.points} points"
            end
        end
        
        puts "\nAfter playing:"
        @players.each { |player| puts player }
    end
end


player_4 = Player.new("aaliyah", 60)
player_5 = Player.new("mya", 90)
player_6 = Player.new("dela")

game = Game.new("Dinosaur kids")
game.add_player(player_4)
game.add_player(player_5)
game.add_player(player_6)

game.play(3)
game.print_stats
