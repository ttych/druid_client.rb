# frozen_string_literal: true

require 'terminal-table'

require_relative 'output_format'

module DruidClient
  class CLi
    class TableFormat
      include OutputFormat

      def format(data)
        table = Terminal::Table.new do |t|
          headings = data.first.keys
          t.headings = headings
          data[1..-1].each do |row|
            t << headings.map { |heading| row[heading] }
          end
        end
        table.to_s
      end
    end
  end
end
