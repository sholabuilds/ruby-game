require_relative "player"

module StudioGame
    class ClumsyPlayer < Player
        def add_treasure(name, points)
            points = points / 2
            # call the default method from parent class
            super(name, points)
        end
    end

    if __FILE__ == $0
        clumsy = ClumsyPlayer.new("Bosco", 45)
    
        clumsy.add_treasure("flute", 50)
        clumsy.add_treasure("flute", 50)
        clumsy.add_treasure("flute", 50)
        clumsy.add_treasure("star", 100)
    
        clumsy.treasures_collected.each do |name, points|
            puts "#{clumsy.name} #{name} has #{points} pointssss"
        end
    end
end
