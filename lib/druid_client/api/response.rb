# frozen_string_literal: true

module DruidClient
  module Api
    class Response
      attr_reader :status_code, :body, :headers, :duration

      def initialize(status_code:, body:, headers: {}, duration: nil)
        @status_code = status_code
        @body = body
        @headers = headers
        @duration = duration
      end

      def success?
        return false unless status_code

        (200..299).include?(status_code)
      end

      def error?
        !success?
      end

      def to_s
        "#<Response status_code=#{status_code} duration=#{duration}s>"
      end
    end
  end
end
