# frozen_string_literal: true

module DruidClient
  class CLi
    module OutputFormat
      def format(data)
        raise NotImplementedError, "Subclasses must implement #format method"
      end
    end
  end
end
