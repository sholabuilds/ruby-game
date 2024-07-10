require_relative "player"

class CrazyPlayer < Player
    def initialize(name, health = 100)
        super(name, health)
        @boost_count = 0
    end

    def is_player_crazy?
        @boost_count > 5
    end

    def boost
        super
        @boost_count += 1
        puts "#{@name} is crazy!" if is_player_crazy?
    end

    def drain
        is_player_crazy? ? boost : super
    end
end

if __FILE__ == $0
    crazy_player = CrazyPlayer.new("kurama", 50)
    6.times { crazy_player.boost }
    2.times { crazy_player.drain }
    puts crazy_player.health
end