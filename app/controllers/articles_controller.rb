require 'net/http'

class ArticlesController < ApplicationController
  before_action :fetch_remote_articles, only: :index

  def index
    @articles = Article.all
  end

  def like
    article = Article.find(like_params[:id])
    article.increment_likes
    article.save
    render json: { 'likes' => article.reactions['likes'] }
  end

  private

  def like_params
    params.permit(:id)
  end

  def fetch_remote_articles
    articles_json = ::Net::HTTP.get(URI('https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'))
    ArticleImporter.import(articles_json)
  end
end
