class Player
    attr_reader :name
    attr_accessor :health
    # init player - name and health
    def initialize(name, health=100)
        @name = name.capitalize
        @health = health
    end

    def boost
        @health += 20
    end

    def drain
        @health -= 10
    end

    def score
        @health + @name.length
    end

    def to_s
        "I'm #{@name} with a health of #{@health} and a score of #{score}"
    end
end

player_1 = Player.new("max")
player_2 = Player.new("jalinka", 60)
player_3 = Player.new("elmer", 85)


class Game
    attr_reader :players, :title
    # init with game name and empty players arr
    def initialize(title)
        @title = title
        @players = []
    end

    # add players
    def add_players(*players)
        @players.concat(players)
    end

    # dice roll
    def roll_dice
        rand(1..6)
    end

    # play
    def play
        puts "\nWelcome to #{title}"
        puts "\nBefore play: "
        puts players

        @players.each do |player|
            number_rolled = roll_dice

            case number_rolled
            when 1..2
                player.drain
                puts "#{player.name} got drained"
            when 3..4
                puts "#{player.name} got skipped"
            else 
                player.boost
                puts "#{player.name} got boosted"
            end
        end

        puts "\nAfter play:"
        puts players
    end
end

game = Game.new("Green Link")
game.add_players(player_1, player_2, player_3)
# game.play
