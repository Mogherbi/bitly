require_relative '../../config/environment'

get '/' do
  redirect to "/urls"
end

get '/urls' do
  erb :create_url
end

post '/urls' do
  @url = Url.new(long_url: params[:url_input])

  if @url.save #it will trigger model/url.rb/before save:method to do checking and generating short_url
    redirect to "/urls/#{@url.id}" #so that the new_url id can be passed in to the below GET to find respective result(short_url)
  else
    erb :create_url
  end

end

get '/urls/:id' do
  @url = Url.find(params[:id])
  erb :show_url
end

get '/:mini_url' do
  @short_url = "http://localhost:9393" + "/#{params[:mini_url]}" #http:// is the domain
  @url = Url.find_by(short_url: @short_url) #USE FIND_BY instead of FIND
  @url.click_count += 1
  @url.save
  redirect to "#{@url.long_url}" #remember dont put a slash so that it goes straight to the link instead of localhost:9393/long_url
end
