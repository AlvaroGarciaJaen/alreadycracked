require 'sinatra'
require 'sinatra/json'
require_relative 'alreadycracked.rb'

class ACApp < Sinatra::Base
  def initialize
    super
    @alreadycracked = AlreadyCracked.new
  end

  get '/' do
    options = {
      :status => url + 'status',
      :get_hash => url + 'hash/:type/:plain',
      :crack => url + 'crack/:hash'
    }
    json options
  end

  get '/status' do
    json :status => 'OK',
      :ejemplo => { :ruta => '/crack/fc5e038d38a57032085441e7fe7010b0',
                   :valor => { :hash => 'fc5e038d38a57032085441e7fe7010b0',
                              :plain => 'helloworld'}}
  end

  get '/hash/:type/:plain' do
    options = @alreadycracked.get_hash_types
    type = params[:type]
    plain = params[:plain]

    if options.include? type
      hash = @alreadycracked.compute_digest(type, plain)
      json :type => type, :plain => plain, :hash => hash
    else
      status 404
      json :message => 'Hash function not found',
        :documentation_url => 'https://alvaro.network/alreadycracked/#obtener-hash-a-partir-de-un-texto-plano'
    end
  end

  put '/hash/:type/:plain' do
    options = @alreadycracked.get_hash_types
    type = params[:type]
    plain = params[:plain]

    if options.include? type
      hash = @alreadycracked.compute_digest(type, plain, true)
      json :type => type, :plain => plain, :hash => hash
    else
      status 404
      json :message => 'Hash function not found',
        :documentation_url => 'https://alvaro.network/alreadycracked/#obtener-hash-a-partir-de-un-texto-plano'
    end
  end

  get '/crack/:hash' do
    hash = params[:hash]
    plain = @alreadycracked.get_plain(hash)
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
      :documentation_url => 'https://alvaro.network/alreadycracked/#api-rest'
  end
end
