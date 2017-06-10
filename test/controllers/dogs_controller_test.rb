require 'test_helper'

class DogsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get dogs_url
    assert_response :success
  end

  test "should get breeds" do
    get '/dogs/breeds'
    assert_response :success

    parsedResponse = ActiveSupport::JSON.decode(@response.body)
    assert_equal parsedResponse, BREEDS
    assert_equal parsedResponse.length, BREEDS.length
  end

  test "should populate dogs" do
    get '/populate/dogs'
    assert_response :success

    parsedResponse = ActiveSupport::JSON.decode(@response.body)
    assert_equal parsedResponse.length, NUMBER_DOGS
    assert_equal Dog.count, NUMBER_DOGS
  end

  test "should drop table and populate dogs" do
    get '/populate/dogs'

    get '/populate/dogs'
    assert_response :success

    parsedResponse = ActiveSupport::JSON.decode(@response.body)
    assert_equal parsedResponse.length, NUMBER_DOGS
    assert_equal Dog.count, NUMBER_DOGS
  end

  test "should list dogs when database hasn't records" do
    get '/dogs'
    assert_response :success

    parsedResponse = ActiveSupport::JSON.decode(@response.body)
    assert_equal parsedResponse['items'].length, 0
    assert_equal parsedResponse['total'], 0
    assert_equal parsedResponse['pages'], 0
  end

  test "should list all dogs when database has records" do
    get '/populate/dogs'
    get '/dogs'
    assert_response :success

    countPages = (NUMBER_DOGS / RECORDS_PER_PAGE)

    if (NUMBER_DOGS % RECORDS_PER_PAGE) != 0
      countPages += 1
    end

    parsedResponse = ActiveSupport::JSON.decode(@response.body)
    assert_equal parsedResponse['items'].length, RECORDS_PER_PAGE
    assert_equal parsedResponse['total'], NUMBER_DOGS
    assert_equal parsedResponse['pages'], countPages
  end

  test "should list dogs with filters" do
    get '/populate/dogs'
    get '/dogs?page=1&genre=male'
    assert_response :success

    countPages = (NUMBER_DOGS / RECORDS_PER_PAGE)

    if (NUMBER_DOGS % RECORDS_PER_PAGE) != 0
      countPages += 1
    end

    parsedResponse = ActiveSupport::JSON.decode(@response.body)
    assert_equal parsedResponse.keys, ['items', 'total', 'pages']
  end

end
