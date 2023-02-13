class Article < ApplicationRecord
  def increment_likes
    reactions['likes'] += 1
  end
end
