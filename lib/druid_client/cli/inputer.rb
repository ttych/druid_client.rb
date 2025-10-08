# frozen_string_literal: true

require 'readline'

module DruidClient
  class Cli
    class Inputer
      def read(prompt)
        puts prompt

        lines = []
        while (line = Readline.readline('> ', true))
          break if line.nil?

          lines << line
        end

        lines.join("\n")
      end
    end
  end
end
