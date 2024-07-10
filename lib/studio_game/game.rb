require_relative "treasure_trove"
require_relative "player"
require_relative "auditable"

class Game
    include Auditable

    attr_reader :game_title, :players

    def initialize(game_title)
        @game_title = game_title
        @players = []
    end

    # load player
    def load_players(file_name)
        if File.exist?(file_name)
            player_list = File.readlines(file_name, chomp: true)

            player_list.each do |line|
                new_player = Player.from_csv(line)
                
                add_player(new_player)
            end
        else
            puts "Oh no, #{file_name} not found"
            # exit if error
            exit 1
        end
    end

    # save player (take a file and write to it)
    def save_high_scores(to_file = "high_scores.txt")
        File.open(to_file, "w") do |file|
            file.puts "#{@game_title} High Scores:"
            sorted_players_by_score.each do |player|
                file.puts high_score_entry(player)
            end
        end
    end

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
       
        puts "\nHigh Scores:"
        sorted_players_by_score.each do |player|
            puts high_score_entry(player)
        end
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

    def high_score_entry(player)
        name = player.name.ljust(20, ".")
        points = player.score.round.to_s.rjust(5)
        "#{name}#{points}"
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

                audit(number_rolled)
            end
        end
        
        puts "\nAfter playing:"
        puts sorted_players_by_score
    end
end