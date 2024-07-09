require_relative "treasure_trove"
require_relative "player"

class Game
    attr_reader :game_title, :players

    def initialize(game_title)
        @game_title = game_title
        @players = []
    end

    # load player
    def load_players(file_name)
        players = File.readlines(file_name, chomp: true)

        players.each do |player|
            name, health = player.split(",")
            new_player = Player.new(name, health.to_i)
            
            add_player(new_player)
        end
    end

    # save player 

    # add player
    def add_player(player)
        @players.push(player)
    end

    # roll dice
    def roll_dice
        rand(1..6)
    end

    # print stats
    def print_stats
        puts "\n#{@game_title} Stats:"
        puts "-" * 20
        total_points_per_player
        high_scores
    end

    # sort players
    def sorted_players_by_score
        @players.sort_by { |player| player.score}.reverse
    end

    # total points
    def total_points_per_player
        @players.each do |player| 
            puts "\n#{player.name}'s treasure point totals:"

            player.treasures_collected.each do |treasure, value| 
                puts "#{treasure}: #{value}"
            end

            puts "total: £#{player.treasures_collected.values.sum}"
        end
    end

    # high scores
    def high_scores
        puts "\nHigh Scores:"
        
        sorted_players_by_score.each do |player| 
            name = player.name.ljust(20, ".")
            points = player.score.round.to_s.rjust(5)
            puts "#{name}#{points}"
        end
    end

    # play
    def play(rounds=2)
        puts TreasureTrove.treasure_items

        puts "\nBefore playing:"
        puts players

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
        puts sorted_players_by_score
    end
end