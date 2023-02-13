# Persist an array of json articles to the database
module ArticleImporter
  class << self
    # Normalize the json to match our expected format
    # If the record doesn't exist then create it
    # If the record is out of date then update it
    def import(json)
      parsed_json = JSON.parse(json)

      parsed_json.map do |article|
        normalized_article = ArticleMapping.new(article).call

        record = Article.find_by(original_id: normalized_article['original_id'])

        if record
          next if record.original_updated_at == normalized_article['original_updated_at']

          record.update(normalized_article)
        else
          Article.create(normalized_article) unless record
        end
      end
    end
  end
end
