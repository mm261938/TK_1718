class StaticPagesController < ApplicationController
  def index
    @news = Api::V1::Digest.geta
    p @news
  end
end
