require "minitest/autorun"

require_relative "../../lib/studio_game/game"
require_relative "../../lib/studio_game/player"

module StudioGame
    class GameTest < Minitest::Test

        def setup
            @game = Game.new("Test game")
            @player_1 = Player.new("Bowie", 88)
            @player_2 = Player.new("Fede", 72)

            # Turns off classes output
            $stdout = StringIO.new
        end

        # init players arr is empty
        def test_has_no_players_initially
            assert_empty @game.players
        end

        def test_players_can_be_added_to_the_game
            @game.add_player(@player_1)
            @game.add_player(@player_2)

            players = [@player_1, @player_2]

            refute_empty @game.players
            assert_equal players, @game.players
        end

        def test_boosts_health_if_no_rolled_is_greater_or_equals_to_5
            @game.add_player(@player_1)
            
            @game.stub(:roll_dice, 6) do
                player_1_boosted_health = @player_1.health + 20
        
                @game.play(1)
        
                assert_equal player_1_boosted_health, @player_1.health
            end
        end

        def test_drains_health_if_no_rolled_is_lesser_than_3
            @game.add_player(@player_1)
            
            @game.stub(:roll_dice, 1) do
                player_1_drained_health = @player_1.health - 10
        
                @game.play(1)
        
                assert_equal player_1_drained_health, @player_1.health
            end
        end

        def test_skips_player_if_no_rolled_is_mid
            @game.add_player(@player_2)
            
            @game.stub(:roll_dice, 3) do
                @game.play
        
                assert_equal 72, @player_2.health
            end
        end
    end
end