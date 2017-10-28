# ChannelsController
# require 'utils/error.rb'
require 'net/https'
module Api
  module V1
    class Digest < ApiController
      API_URL = "http://www.47news.jp/cgi-bin/ra/meta_ex.cgi"

      def self.geta
        return "OK"
      end

      def self.fetchAllChannels
      request_url = API_URL
      params = URI.encode_www_form(
          { 'title' => '早大３連覇　斎藤が１５奪三振、初完封　東京六大学野球',
            'body' => '東京六大学野球秋季リーグは３０日、神宮球場で最終週の早大—慶大３回戦があり、早大が斎藤（１年、早稲田実）の活躍で慶大に７—０で大勝し、３季連続４０度目の優勝を果たした。勝ち点４で明大と並んだが、勝率で上回った。早大は１１月１０日開幕の明治神宮大会への出場も決めた。斎藤はスライダーやツーシームなどの変化球がさえ、リーグ戦初完封。被安打４で１５奪三振の力投で今季４勝目を挙げた。打線は１回、松本（３年、千葉経大付）の適時打と本田（４年、智弁和歌山）の３点二塁打で４点を先取し、その後も加点した。慶大は３連投のエース加藤幹（４年、川和）が力尽きた。',
            'enc'  => 'utf-8', # 入出力文字コードがUTF-8
            'debug' => '1', # 0:false 1:true
            'permax' => '50' #要約圧縮率
      })
      uri = URI.parse("#{request_url}")

      begin
        http = Net::HTTP.new(uri.host, uri.port)
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        req = Net::HTTP::Post.new(uri.path)
        req.set_form_data({ 'title' => '早大３連覇　斎藤が１５奪三振、初完封　東京六大学野球',
                            'body' => '東京六大学野球秋季リーグは３０日、神宮球場で最終週の早大—慶大３回戦があり、早大が斎藤（１年、早稲田実）の活躍で慶大に７—０で大勝し、３季連続４０度目の優勝を果たした。勝ち点４で明大と並んだが、勝率で上回った。早大は１１月１０日開幕の明治神宮大会への出場も決めた。斎藤はスライダーやツーシームなどの変化球がさえ、リーグ戦初完封。被安打４で１５奪三振の力投で今季４勝目を挙げた。打線は１回、松本（３年、千葉経大付）の適時打と本田（４年、智弁和歌山）の３点二塁打で４点を先取し、その後も加点した。慶大は３連投のエース加藤幹（４年、川和）が力尽きた。',
                            'enc'  => 'utf-8', # 入出力文字コードがUTF-8
                            'debug' => '1', # 0:false 1:true
                            'permax' => '50' #要約圧縮率
                          })

        response = http.request(req)

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
