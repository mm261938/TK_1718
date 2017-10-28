class StaticPagesController < ApplicationController
  def index
    @list = Api::V1::News.fetchNews
    p @list
    return

    @news = Api::V1::Digest.fetchAllChannels
    # p @news
    @news_list = [
        {latitude: 35.1814464, longitude: 136.906398, address: "名古屋", title: "名古屋の場所"},
        {latitude: 35.1814, longitude: 137.916398, address: "神戸", title: "あああ"},
        {latitude: 35.4464, longitude: 135.906398, address: "名古屋3", title: "ニュースの中身"},
        {latitude: 35.1864, longitude: 134.906398, address: "名古屋4", title: "名古屋の場所"},
    ]
    @hash = Gmaps4rails.build_markers(@news_list) do |news, marker|
      marker.lat news[:latitude]
      marker.lng news[:longitude]
      marker.infowindow news[:title]
      marker.json({title: news[:address]})
    end
  end
end
