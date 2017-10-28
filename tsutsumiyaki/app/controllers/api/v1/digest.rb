# ChannelsController
# require 'utils/error.rb'
module Api
  module V1
    class Digest < ApiController
      API_URL = ""

      def self.geta
        return "OK"
      end

      def self.fetchAllChannels
      request_url = API_URL + "v4/home.php"
      params = URI.encode_www_form({ param1: '111', param2: '222' })
      uri = URI.parse("#{request_url}?#{params}")

      begin
        response = Net::HTTP.start(uri.host, uri.port) do |http|
          http.open_timeout = 5
          http.read_timeout = 10
          http.get(uri.request_uri)
        end

        # [レスポンス処理]
        # 1xx系 => Net::HTTPInformation
        # 2xx系 => Net::HTTPSuccess
        # 3xx系 => Net::HTTPRedirection
        # 4xx系 => Net::HTTPClientError
        # 5xx系 => Net::HTTPServerError
        case response
          # 2xx系
          when Net::HTTPSuccess
            return JSON.parse(response.body)
          # 3xx系
          when Net::HTTPRedirection
            p("Redirection: code=#{response.code} message=#{response.message}")
          else
            p("HTTP ERROR: code=#{response.code} message=#{response.message}")
        end

      rescue IOError => e
        p(e.message)
      rescue TimeoutError => e
        p(e.message)
      rescue JSON::ParserError => e
        p(e.message)
      rescue => e
        p(e.message)
      end
      end
    end
  end
end
