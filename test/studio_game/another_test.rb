require "minitest/autorun"
require_relative "../../another.rb"

module StudioGame
    class AnotherTest < Minitest::Test
        
        # Player
        def setup
            @player_1 = Player.new("korry")
            @player_2 = Player.new("ajasco", 80)
            @game = Game.new("Elm Street")
            
            # Turns off classes output
            $stdout = StringIO.new
        end
        # capitalizes
        def test_player_name_is_capitalized
            assert_equal "Korry", @player_1.name
        end

        # init health
        def test_player_has_init_health_when_no_health_arg_is_given
            assert_equal 100, @player_1.health
        end

        # boosts
        def test_health_increases_by_20_when_boosted
            assert_equal 100, @player_2.boost
        end

        # drains
        def test_health_decreases_by_10_when_drained
            assert_equal 70, @player_2.drain
        end

        # scores
        def test_score_is_computed
            assert_equal 86, @player_2.score
        end

        # to_s
        def test_has_string_representation
            assert_equal "I'm Ajasco with a health of 80 and a score of 86", @player_2.to_s
        end

        # Game
        # no init players
        def test_has_no_players_initially
            assert_empty @game.players
        end

        # players are added 
        def test_players_can_be_added_to_the_game
            @game.add_players(@player_1, @player_2)

            added_players = [@player_1, @player_2]

            refute_empty @game.players
            assert_equal added_players, @game.players 
        end

        # skip
        def test_skips_player_if_no_rolled_is_mid
            @game.add_players(@player_1)

            @game.stub(:roll_dice, 3) do
                @game.play

                assert_equal 100, @player_1.health
            end
        end

        # boosts
        def test_boosts_health_if_no_rolled_is_greater_or_equals_to_5
            @game.add_players(@player_1)

            @game.stub(:roll_dice, 6) do
                player_1_boosted_health = @player_1.health + 20

                @game.play

                assert_equal player_1_boosted_health, @player_1.health
            end
        end

        # decreases
        def test_drains_health_if_no_rolled_is_lesser_than_3
            @game.add_players(@player_1)

            @game.stub(:roll_dice, 1) do
                player_1_drained_health = @player_1.health - 10

                @game.play

                assert_equal player_1_drained_health, @player_1.health
            end
        end

    end
end