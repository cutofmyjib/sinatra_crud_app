require 'rubygems'
require 'sinatra'

require_relative 'config/application'

puts "Put your application code in #{File.expand_path(__FILE__)}"


get '/' do
  @notes = Note.all
  @title = 'All Notes'
  erb :home
end

helpers do
    include Rack::Utils
    alias_method :h, :escape_html
end

post '/' do
  n = Note.new
  n.content = params[:content]
  n.created_at = Time.now
  n.updated_at = Time.now
  n.save
  redirect '/'
end


get '/:id' do
  @note = Note.find(params[:id])
  @title = "Edit note ##{params[:id]}"
  erb :edit
end

put '/:id' do
  n = Note.find(params[:id])
  n.content = params[:content]
  n.complete = params[:complete] ? 1 : 0
  n.updated_at = Time.now
  n.save
  redirect '/'
end

get '/:id/complete' do
  n = Note.find(params[:id])
  n.complete = n.complete ? 0 : 1 # flip it
  n.updated_at = Time.now
  n.save
  redirect '/'
end

get '/:id/delete' do
  @note = Note.find(params[:id])
  @title = "Confirm deletion of note #{params[:id]}"
  erb :delete
end

delete '/:id' do
  n = Note.find(params[:id])
  n.destroy
  redirect '/'
end