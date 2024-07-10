class Player
    attr_reader :name, :treasures_collected
    attr_accessor :health

    def initialize(name, init_health = 100)
        @name = name.capitalize
        @health = init_health
        @treasures_collected = Hash.new(0)
    end

    # add treasure
    def add_treasure(name, points)
        @treasures_collected[name] += points
    end

    # boost
    def boost
        @health += 20
    end

    # drain
    def drain
        @health -= 10
    end 

    # score
    def score
        player_points = points
        @health + player_points
    end 

    # points
    def points 
        @treasures_collected.values.sum
    end

    # from csv
    def self.from_csv(line)
        name, health = line.split(",")
        Player.new(name, health.to_i)
    end

    # to_s
    def to_s
        "I'm #{@name} with health = #{@health}, points = #{points} and score = #{score}"
    end
end