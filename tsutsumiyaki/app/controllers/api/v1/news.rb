# ChannelsController
# require 'utils/error.rb'
require 'net/https'
require 'open-uri'
require 'kconv'
require 'rss'
module Api
  module V1
    class News < ApiController
      API_URL = "https://news.google.com/news"

      def self.fetchNews
        request_url = API_URL
        params = URI.encode_www_form(
            { 'hl' => 'ja',
              'ned' => 'us',
              'ie'  => 'utf-8',
              'output' => 'rss',
              'topic' => 'p',
              'num' => '100'
            })
        uri = URI.parse("#{request_url}?#{params}")
        # uri = URI.parse("#{request_url}")

        begin
          # sleep 1 if Time.now - @last_accessed < ACCESS_INTERVAL

          # url = URI.parse(url) if url.is_a?(String)
          html = open(uri) do |f|
            # @status_code = f.status[0].try(:to_i)
            @current_url = f.base_uri.to_s
            f.read
          end
          @html = html.toutf8
          @document = RSS::Parser.parse(@html, false)
          # p fetch @html
          return @document.items
        rescue OpenURI::HTTPError => e
          p e.message.split(' ')
        end
        return
      end

      def self.fetch(rss_body)
        # Rails.logger.debug "accessing: #{url}"
        # @client.access(url)

        unless rss_body.xml =~ %r{<(channel|feed).*?>.*?</(channel|feed)>}mi
          return RssEntity.new(url, error: "RSSリンクではありません")
        end

        if rss_body.success?
          rss = RssEntity.new(url, {
              final_url: rss_body.current_url,
              body: rss_body.xml,
              code: rss_body.status_code
          })
          if rss.success?
            if rss.items.empty?
              rss.error = "RSSの items 要素が空です"
            elsif rss.items.none?{|i| URI::regexp(%w( http https )) =~ i.link }
              rss.error = "RSSのLinkが不正です"
            elsif rss.items.all?{|i| i.title.blank? }
              rss.error = "RSSのTitleが不正です"
            end
          end
          rss
        else
          RssEntity.new(url, error: "取得に失敗しました")
        end
      end
    end
  end
end
