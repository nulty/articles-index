require 'test_helper'

class ArticleImporterTest < ActiveSupport::TestCase
  def setup
    @user = {
      'id' => 8039,
      'first_name' => 'Lloyd',
      'current_avatar' => {
        'original' => 'https://cdn.olioex.com/uploads/avatar/file/oZq8DF3dzLEi3Fnf4XxMrg/image.jpg',
        'large' => 'https://cdn.olioex.com/uploads/avatar/file/oZq8DF3dzLEi3Fnf4XxMrg/large_image.jpg',
        'small' => 'https://cdn.olioex.com/uploads/avatar/file/oZq8DF3dzLEi3Fnf4XxMrg/small_image.jpg'
      },
      'roles' => ['Consumer', 'Food Waste Hero', 'Volunteer', 'Administrator'],
      'location' => { 'latitude' => 51.7645, 'longitude' => -3.79133 },
      'rating' => { 'rating' => 10, 'number' => 15 },
      'verifications' => [{ 'method' => 'sms' }, { 'method' => 'facebook' }]
    }
  end

  test 'imports the json array of articles' do
    json = file_fixture('articles.json').read
    ArticleImporter.import(json)
    assert_equal 4, Article.count
  end
end

