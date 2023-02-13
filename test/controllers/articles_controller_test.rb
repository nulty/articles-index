require 'test_helper'
require 'minitest/mock'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @stubbed_json = file_fixture('articles.json').read
  end

  test 'render index' do
    Net::HTTP.stub :get, @stubbed_json do
      get articles_url
      assert_response :success
    end
  end

  test 'like' do
    article = Article.first
    original_likes_count = article.reactions['likes'].to_i
    patch like_article_url(article.id)
    article.reload
    updated_likes_count = article.reactions['likes'].to_i
    assert_equal original_likes_count + 1, updated_likes_count
    assert_response :success
    assert_equal JSON.parse(response.body),{ 'likes' => updated_likes_count }
  end
end
