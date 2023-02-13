# Takes article_hash data from external source and
# removes properties that are not desired
# and rename specified properties
class ArticleMapping
  def initialize(article_hash)
    @article_hash = article_hash
  end

  def call
    filter
    rename
  end

  RENAME = {
    'id' => 'original_id',
    'created_at' => 'original_created_at',
    'updated_at' => 'original_updated_at'
  }

  PROPERTIES = %w[
    id
    title
    description
    location
    value
    status
    expiry
    reactions
    photos
    user
    created_at
    updated_at
  ]

  private

  # rename the json properties that conflict with Rails model attributes
  def rename
    RENAME.each do |k, v|
      @article_hash[v] = @article_hash.delete(k)
    end
    @article_hash
  end

  # select only the properties we expect from the article_hash
  def filter
    @article_hash.slice!(*PROPERTIES)
  end
end
