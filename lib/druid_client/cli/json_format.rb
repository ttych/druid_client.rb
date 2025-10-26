# frozen_string_literal: true

require 'json'

require_relative 'output_format'

module DruidClient
  class CLi
    class JsonFormat
      include OutputFormat

      def format(data)
        JSON.pretty_generate(data)
      end
    end
  end
end
