require 'sinatra'
require 'sinatra/json'
require_relative 'alreadycracked.rb'

class ACApp < Sinatra::Base
  get '/' do
    options = {
      :status => url + 'status',
      :get_hash => url + 'hash/:type/:plain'
    }
    json options
  end

  get '/status' do
    json :status => 'OK'
  end

  get '/hash/:type/:plain' do
    options = AlreadyCracked.new.get_hash_types
    type = params[:type]
    plain = params[:plain]

    if options.include? type
      hash = AlreadyCracked.new.compute_digest(type, plain)
      json :type => type, :plain => plain, :hash => hash
    else
      status 404
      json :message => 'Hash function not found',
        :documentation_url => 'https://alvaro.network/alreadycracked/'
    end
  end

  get '/crack/:hash' do
    hash = params[:hash]
    plain = AlreadyCracked.new.get_plain(hash)
    if plain.nil?
      status 404
      json :message => 'Hash not found'
    else
      json :hash => hash, :plain => plain
    end
  end

  error Sinatra::NotFound do
    status 404
    body json :message => 'Not found',
      :documentation_url => 'https://alvaro.network/alreadycracked/'
  end
end
