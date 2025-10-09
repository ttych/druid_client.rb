# frozen_string_literal: true

module DruidClient
  module Api
    class Response
      attr_reader :status_code, :body, :headers, :elapsed_time, :retry_count

      def initialize(status_code:, body:, headers: {}, elapsed_time: nil, retry_count: nil)
        @status_code = status_code
        @body = body
        @headers = headers
        @elapsed_time = elapsed_time
        @retry_count = retry_count
      end

      def success?
        return false unless status_code

        200.299.include?(status_code)
      end

      def error?
        !success?
      end

      def raise_on_error; end

      def to_s
        "#<Response status_code=#{status_code} retry_count=#{retry_count} elapsed_time=#{elapsed_time}s>"
      end
    end
  end
end
