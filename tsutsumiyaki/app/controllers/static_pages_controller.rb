# encoding utf-8
class StaticPagesController < ApplicationController
  def index
    # news_list = Api::V1::News.fetchNews[0..3].map do |rss|
    #   digest = Api::V1::Digest.getDigest ({title: rss.title, body: rss.description, permax: '50' })
    #   # geos = digest.match(/<CANDIDATE num="1>(.+?)<\/CANDIDATE>/)[1].split("\t")
    #   p "digest----"
    #   p rss.title
    #   p digest["place"].force_encoding("UTF-8") if digest["place"]
    #
    #   OpenStruct.new(
    #     title: rss.title,
    #     description: rss.description,
    #     date: rss.pubDate,
    #     link: rss.link,
    #     place: digest["place"],
    #     latitude: digest["latitude"],
    #     longitude: digest["longitude"])
    #
    #   Article.create({ title: rss.title,
    #                    description: rss.description,
    #                    published_at: rss.pubDate,
    #                    link: rss.link,
    #                    place: (digest["place"] ? digest["place"] : ""),
    #                    latitude: digest["latitude"],
    #                    longitude: digest["longitude"] })
    # end

    # p "====-=-=-="
    # p news_list

    # news = Api::V1::Digest.getDigest ({'title' => '早大３連覇　斎藤が１５奪三振、初完封　東京六大学野球',
    #                                     'body' => '東京六大学野球秋季リーグは３０日、神宮球場で最終週の早大—慶大３回戦があり、早大が斎藤（１年、早稲田実）の活躍で慶大に７—０で大勝し、３季連続４０度目の優勝を果たした。勝ち点４で明大と並んだが、勝率で上回った。早大は１１月１０日開幕の明治神宮大会への出場も決めた。斎藤はスライダーやツーシームなどの変化球がさえ、リーグ戦初完封。被安打４で１５奪三振の力投で今季４勝目を挙げた。打線は１回、松本（３年、千葉経大付）の適時打と本田（４年、智弁和歌山）の３点二塁打で４点を先取し、その後も加点した。慶大は３連投のエース加藤幹（４年、川和）が力尽きた。',
    #                                     'permax' => '50' })

    # @news = JSON.parse(@news)
    # p news
    # p news.to_s.match(/<DESCRIPTION>(.+?)<\/DESCRIPTION>/)[1]
    # p news.to_s.match(/<CANDIDATE num="1">(.+?)<\/CANDIDATE>/)[1]
    # geo = news.match(/<CANDIDATE num=\"1\">(.+?)<\/CANDIDATE>/)[1].split("\t")
    # # p news.to_s.match(/<DESCRIPTION>(.+?)<\/DESCRIPTION>/)[1]
    # p geo
    # p "========"

    news_list = Article.all

    @news_list = [
        {latitude: 35.1814464, longitude: 136.906398, address: "名古屋", title: "名古屋の場所"},
        {latitude: 35.1814, longitude: 137.916398, address: "神戸", title: "あああ"},
        {latitude: 35.4464, longitude: 135.906398, address: "名古屋3", title: "ニュースの中身"},
        {latitude: 35.1864, longitude: 134.906398, address: "名古屋4", title: "名古屋の場所"},
    ]
    @hash = Gmaps4rails.build_markers(news_list) do |news, marker|
      p "news----~"
      p news
      marker.lat news.latitude
      marker.lng news.longitude
      marker.infowindow "(#{news.place})#{news.title}\n#{news.description}"
      marker.json({title: news.title})
    end
  end

  def ten_index
    news_list = Article.all.order(id: "ASC").limit(10)
    @hash = Gmaps4rails.build_markers(news_list) do |news, marker|
      p "news----~"
      p news
      marker.lat news.latitude
      marker.lng news.longitude
      marker.infowindow "(#{news.place})#{news.title}\n#{news.description}"
      marker.json({title: news.title})
    end
  end

  def get_articles
    news_list = Api::V1::News.fetchNews[0..10].map do |rss|
      digest = Api::V1::Digest.getDigest ({title: rss.title, body: rss.description, permax: '50' })
      # geos = digest.match(/<CANDIDATE num="1>(.+?)<\/CANDIDATE>/)[1].split("\t")
      # p "digest----"
      # p rss.title
      # p digest["place"].force_encoding("UTF-8") if digest["place"]

      # OpenStruct.new(
      #     title: rss.title,
      #     description: rss.description,
      #     date: rss.pubDate,
      #     link: rss.link,
      #     place: digest["place"],
      #     latitude: digest["latitude"],
      #     longitude: digest["longitude"])

      v = Article.create({ title: rss.title,
                       description: rss.description,
                       published_at: rss.pubDate,
                       link: rss.link,
                       place: (digest["place"] ? digest["place"].force_encoding("UTF-8") : ""),
                       latitude: digest["latitude"],
                       longitude: digest["longitude"],
                       category: rss.category.content
                     })
      v.id.nil? ? nil : v
    end.compact
    render json: news_list
    # render json: Api::V1::News.fetchNews[0].category.content
  end
end
