alias Move = Tuple(Int32, Int32, Int32, Int32)
class Game
    property answer : Move, moves : Array(Move)

    def initialize()
        @answer = Game.generate_random_answer()

        @moves = [] of Move
    end

    def initialize(answer : Move)
        @answer = answer

        @moves = [] of Move
    end

    def move(move : Move)
        moves << move
        self
    end

    def red_count(move)
        answer
            .zip(move)
            .select { |x, y| x == y}
            .size
    end

    def misses(move)
        (answer.to_a - move.to_a).size
    end

    def white_count(move)
        total_possible_pegs - red_count(move) - misses(move)
    end

    def total_possible_pegs
        answer.size
    end

    def print_board
        moves.each do |move|
            print_row(move)
        end
        print_status
    end

    def print_row(move)
        puts "#{pretty_move(move)} #{pretty_score(move)}"
    end

    def pretty_move(move)
        "#{move[0]} #{move[1]} #{move[2]} #{move[3]}"
    end

    def pretty_score(move)
        reds = "R" * red_count(move)
        whites = "W" * white_count(move)

        "#{reds} #{whites}"
    end

    def print_status
        if won?
            puts "You won"
        elsif lost?
            puts "You lost"
        else
            puts ""
        end
    end

    def won?
        return false if moves.size == 0
        red_count(moves.last) == 4
    end

    def lost?
        !won? && moves.size == 10
    end

    def self.generate_random_answer()
        r = Random.new

        {r.rand(1..6), r.rand(1..6), r.rand(1..6), r.rand(1..6)}
    end
end

