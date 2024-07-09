require "minitest/autorun"

require_relative "../../lib/studio_game/player"

class PlayerTest < Minitest::Test
    # set up
    def setup
        @player = Player.new("inarra", 62)

        # Turns off classes output
        $stdout = StringIO.new
    end

    def test_player_name_is_capitalized
        assert_equal "Inarra", @player.name
    end

    def test_player_has_init_health_when_no_health_arg_is_given
        player = Player.new("Dara")
        assert_equal 100, player.health
    end

    def test_score_is_computed
        computed_score = @player.health + @player.name.length

        assert_equal computed_score, @player.score
    end

    def test_health_increases_by_20_when_boosted
        health_increase = @player.health + 20

        @player.boost

        assert_equal health_increase, @player.health
    end

    def test_health_decreases_by_10_when_drained
        health_decrease = @player.health - 10

        @player.drain

        assert_equal health_decrease, @player.health
    end

    def test_has_string_representation
        string_rep = "I'm Inarra with a health of 62 and a score of 68"

        assert_equal string_rep, @player.to_s
    end
    # tests
    # computes score
    # boosts
    # drains
    # to_s
end