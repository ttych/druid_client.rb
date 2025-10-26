# frozen_string_literal: true

require_relative 'table_format'
require_relative 'json_format'

module DruidClient
  class CLi
    class OutputFormatFactory
      puts self
      FORMATS = {
        table: TableFormat,
        json: JsonFormat,
      }.freeze

      def self.create(format_name)
        format_class = FORMATS[format_name.to_sym]
        raise "Unknown format: #{format_name}" unless format_class
        format_class.new
      end
    end
  end
end
