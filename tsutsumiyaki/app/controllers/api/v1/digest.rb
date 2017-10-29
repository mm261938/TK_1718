# ChannelsController
# require 'utils/error.rb'
require 'net/https'
require 'active_support'
require 'active_support/core_ext'
module Api
  module V1
    class Digest < ApiController
      API_URL = "http://www.47news.jp/cgi-bin/ra/meta_ex.cgi"

      def self.geta
        return "OK"
      end

      def self.getDigest(params)
        uri = URI.parse("#{API_URL}")
        begin
          # http = Net::HTTP.new(uri.host, uri.port)
          # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          # req = Net::HTTP::Post.new(uri.path)
          # req.set_form_data({'enc'  => 'utf-8', 'debug' => '0'}.merge(params))
          # response = http.request(req)

          # response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          #   http.open_timeout = 5
          #   http.read_timeout = 10
          #   http.post(uri.request_uri)
          # end

          req = Net::HTTP::Post.new(uri.path)
          req.set_form_data({ 'debug' => '0'}.merge(params))
          # req.set_form_data({'enc'  => 'utf-8', 'debug' => '0'}.merge(params))
          response = Net::HTTP.new(uri.host, uri.port).start do |http|
            http.open_timeout = 100
            http.read_timeout = 100
            http.request(req)
          end

          # response = Net::HTTP.post_form(uri, {'enc'  => 'utf-8', 'debug' => '0'}.merge(params))

          # p "response====-=="
          # p response.body.to_s
          # return response.body.to_s
          # p Hash.from_xml(response.body)

          # [レスポンス処理]
          case response
            # 2xx系
            when Net::HTTPSuccess
              # body = JSON.parse response.body
              # body = Hash.from_xml(response.body)
              body = response.body
              p "body====-=="
              # p body
              result = {}
              result["description"] = body.to_s.match(/<DESCRIPTION>(.+?)<\/DESCRIPTION>/)
              geo = body.to_s.match(/<CANDIDATE num=\"1\">(.+?)<\/CANDIDATE>/)[1].split("\t")
              result["place"]      = geo[0]
              result["latitude"]   = geo[1]
              result["longitude"]  = geo[2]
              p result
              return result
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
          p "error==="
          p(e.message)
        end
      end
    end
  end
end
