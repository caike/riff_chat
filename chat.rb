require 'sinatra/base'
require 'pusher'
require 'json'

class RiffChat < Sinatra::Base
  
  @@counter = 0

  post '/message' do

    return 'bad' unless params[:secret_token] == ENV['SECRET_TOKEN']

    Pusher.app_id = ENV['PUSHER_APP_ID']
    Pusher.key = ENV['PUSHER_KEY']
    Pusher.secret = ENV['PUSHER_SECRET']
    
    message = params[:message_out]

    @@counter += 1
    
    output =  { :body => message, :counter => @@counter }.to_json

    Pusher['riffit_chat'].trigger('message',
      "{\"body\": \" #{message} \", \"counter\": #{@@counter}}".to_json)

    return message
  end

end