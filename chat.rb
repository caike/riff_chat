require 'sinatra'
require 'pusher'

post '/message' do

  Pusher.app_id = ENV['APP_ID']
  Pusher.key = ENV['KEY']
  Pusher.secret = ENV['SECRET']

  params[:message_out]
  # TODO: add delayed_job
  Pusher['riffit_chat'].trigger('message', { :body => params[:message_out] } )
end
