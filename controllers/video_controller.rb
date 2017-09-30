class VideoController < Sinatra::Base 

	configure :development do 
		register Sinatra::Reloader
	end

	set :root, File.join(File.dirname(__FILE__), "..")

	set :views, Proc.new  {File.join(root, 'views')}

	#index
	get '/videos' do
		@videos = Video.all
	  	erb :"videos/index"
	end

	#new
	get '/videos/new' do
	  erb :"videos/new"
	end

	#show
	get '/videos/:id' do
		@id = params[:id].to_i
		@video = Video.find(@id) 
	  	erb :"videos/show"
	end

	#create 
	post '/videos' do
		new_video = Video.new
		new_video.title = params[:title]
		new_video.description = params[:description]
		new_video.url = params[:url]
		new_video.genre = params[:genre]
		new_video.save		
		redirect '/videos'
	end

	#edit
	get '/videos/:id/edit' do
		@id = params[:id].to_i
		@video = Video.find(@id)
	  	erb :"videos/edit"
	end

	put '/videos/:id' do
		@id = params[:id].to_i
		@video = Video.find(@id)
		@video.title = params[:title]
		@video.description = params[:description]
		@video.url = params[:url]
		@video.genre = params[:genre]
		@video.save

		redirect "/videos/#{@id}"  
		#video.id instead of #{@id}
	end

	#delete
	delete '/videos/:id' do
		id = params[:id].to_i
		Video.destroy(id)
		redirect '/videos'
	end

end