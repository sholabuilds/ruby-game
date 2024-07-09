# words = %w[dog zebra elephant chimpanzee]

# words.each do |word|
#     puts word.length
# end

Treasure = Data.define(:treasure, :points)

treasures = [
    Treasure.new("pie", 10),
    Treasure.new("coin", 25),
    Treasure.new("flute", 50),
    Treasure.new("compass", 65),
    Treasure.new("key", 80),
    Treasure.new("crown", 90),
    Treasure.new("star", 10),
]

puts treasures.sample