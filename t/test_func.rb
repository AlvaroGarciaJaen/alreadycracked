require_relative '../lib/acapp.rb'
require 'sinatra'
require 'test/unit'
require 'rack/test'

class AlreadyCrackedFuncTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    ACApp
  end

  def test_root
    get '/'
    assert last_response.ok?
    assert_equal last_response.content_type, 'application/json'
    body = JSON last_response.body
    assert body['status'].include? '/status'
    assert body['get_hash'].include? '/hash/:type/:plain'
  end

  def test_status
    get '/status'
    assert last_response.ok?
    assert_equal last_response.content_type, 'application/json'
    body = JSON last_response.body
    assert_equal 'OK', body['status']
  end

  def test_hash
    get '/hash/md5/Alvaro'
    assert last_response.ok?
    assert_equal last_response.content_type, 'application/json'
    body = JSON last_response.body
    assert_equal 'md5', body['type']
    assert_equal 'Alvaro', body['plain']
    assert_equal 'f964ec386676ab3b4bae194d3fb7fd69', body['hash']
  end

  def test_crack
    get '/crack/2c65a48513a36d846e69232a88c404b4d44b99d846cd1fc598b08e95c0a75b9a'
    assert last_response.ok?
    assert_equal last_response.content_type, 'application/json'
    body = JSON last_response.body
    assert_equal '2c65a48513a36d846e69232a88c404b4d44b99d846cd1fc598b08e95c0a75b9a', body['hash']
    assert_equal 'IV', body['plain']
  end

  def test_not_found_hash
    get '/crack/9a618248b64db62d15b300a07b00580b'
    assert last_response.not_found?
    assert_equal last_response.content_type, 'application/json'
    body = JSON last_response.body
    assert_equal 'Hash not found', body['message']
  end

  def test_not_found_hash_type
    get '/hash/mdx/helloworld'
    assert last_response.not_found?
    assert_equal last_response.content_type, 'application/json'
    body = JSON last_response.body
    assert_equal 'Hash function not found', body['message']
    assert_equal 'https://alvaro.network/alreadycracked/', body['documentation_url']
  end

  def test_not_found_route
    get '/imagination'
    assert last_response.not_found?
    assert_equal last_response.content_type, 'application/json'
    body = JSON last_response.body
    assert_equal 'Not found', body['message']
    assert_equal 'https://alvaro.network/alreadycracked/', body['documentation_url']
  end
end
