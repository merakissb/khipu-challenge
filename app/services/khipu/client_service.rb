module Khipu
  class ClientService
    include HTTParty
    base_uri ENV.fetch("KHIPU_API_URL")

    CONTENT_TYPE = "Content-Type".freeze
    API_KEY = "x-api-key".freeze

    def self.default_headers
      {
        CONTENT_TYPE => "application/json",
        API_KEY => ENV.fetch("KHIPU_API_KEY")
      }
    end

    def self.get(path, options = {})
      handle_response(super(path, options))
    end

    def self.post(path, options = {})
      handle_response(super(path, options))
    end

    def self.delete(path, options = {})
      handle_response(super(path, options))
    end

    def self.handle_response(response)
      if response.success?
        JSON.parse(response.body)
      else
        Rails.logger.error "Khipu API Error: #{response.code} - #{response.body}"
        { "error" => "Error #{response.code}", "status" => "unknown" }
      end
    end
  end
end
