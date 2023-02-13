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
end
