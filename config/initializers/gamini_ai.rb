require 'net/http'
require 'json'
require 'uri'
require 'singleton'

module Gemini

  class Client
    include Singleton
    API_KEY = ENV['GEMINI_API_KEY']

    def self.send_message(messages)

      uri = URI("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=#{API_KEY}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request.body = {
        contents: [
          { parts: [{ text: messages.to_s }] }
        ]
      }.to_json

      response = http.request(request)

      parsed_response = if response.is_a?(Net::HTTPSuccess)
                          JSON.parse(response.body)
                        else
                          Rails.logger.error "Gemini API Error: #{response.status} - #{response.body.to_s}"
                          { 'error' => 'Request failed', 'code' => response.code, 'message' => response.message }
                        end
      return parsed_response
    end
  end

end
