class Player
    attr_reader :name
    attr_accessor :health

    # init
    def initialize(name, init_health = 100)
        @name = name
        @health = init_health
    end

    # boost
    def boost
        @health += 15
    end

    # drain
    def drain
        @health -= 10
    end

    # score
    def score
        @health + @name.length
    end

    # to_s
    def to_s
        "I'm #{@name} with a health of #{@health} and a score of #{score}"
    end
end


class Game
    attr_reader :title, :players
    # init
    def initialize(title)
        @title = title
        @players = []
    end

    # add player
    def add_player(*player)
        @players.concat(player)
    end

    # roll dice
    def roll_dice
        rand(1..6)
    end

    # play
    def play
        puts self.inspect 

        puts "Before the game:"
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

        puts "\nAfter the game:"
        puts players
    end

end

player_1 = Player.new("Jackie", 55)
player_2 = Player.new("Mo", 65)
player_3 = Player.new("Sunny")

game = Game.new("Reconstructed Mario")
game.add_player(player_1, player_2, player_3)
game.play
