require 'net/http'

class ArticlesController < ApplicationController
  before_action :fetch_remote_articles

  def index
    @articles = Article.all
  end

  private

  def fetch_remote_articles
    articles_json = ::Net::HTTP.get(URI('https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'))
    ArticleImporter.import(articles_json)
  end
end
