require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "increment_likes" do
    article = Article.first
    original_likes = article.reactions['likes'].to_i

    article.increment_likes
    updated_likes = article.reactions['likes'].to_i
    article.reload
    assert_equal updated_likes, original_likes + 1
  end
end
