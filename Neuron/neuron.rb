module Neuron
  class Operate
    attr_reader :state

    def initialize
      @state = "off"
    end

    def on_activity
      require "naive_bayes"
      
      finput = File.read("_ainput/finput.txt").strip.to_i
      dinput = File.read("_ainput/dinput.txt").strip.to_i
    
      # Make sure that story elements are kept on seperate lines.
      character_fate = File.readlines("_narratives/outcomes/character_fates.txt")
      dating_outcome = File.readlines("_narratives/outcomes/dating_outcomes.txt")

      # Make the total imagined branch the size of the darkest path.
      # branch_size = branch_1.size.to_i

      # Imagined a compromise path that is neither ideal or tragic.
      open("_imaginedpath/outcomes/nuetral_outcome.txt", "a") { |f|
        segment_1 = character_fate[finput].strip
        segment_2 = dating_outcome[dinput].strip

        f.puts "#{segment_1} #{segment_2}"
      }

      outcome = NaiveBayes.new(:worst, :neutral, :best)

      # Never Dated Player
      outcome.train(:worst,   "[ charlotte dead ][ never dated player ]",   "worst")
      outcome.train(:nuetral,       "[ charlotte dead ][ dated player ]", "nuetral")

      # Dated Player
      outcome.train(:nuetral, "[ charlotte alive ][ never dated player ]", "nuetral")
      outcome.train(:best,          "[ charlotte alive ][ dated player ]",    "best")

      current_outcome = File.readlines("_imaginedpath/outcomes/nuetral_outcome.txt")
      row             = 0

      iter_lim = current_outcome.size.to_i

      iter_lim.times do
        chosen_outcome = current_outcome[row].to_s

        result = outcome.classify(*chosen_outcome)

        label       = result[0]
        probability = result[1]

        open("_memory/longterm/outcome.pl", "w") { |f|
          f.puts "outcome(player, #{label})."
        }

        row = row + 1
      end
    end

    def off_activity
      puts "Goodnight!"
    end

    def transition
      case state

      when "off"
        off_activity

        @state = "on"
      when "on"
        on_activity

        @state = "off"
      end
    end
  end
end
