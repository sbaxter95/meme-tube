class VideoController < Sinatra::Base 

	configure :development do 
		register Sinatra::Reloader
	end

	set :root, File.join(File.dirname(__FILE__), "..")

	set :views, Proc.new  {File.join(root, 'views')}

	get '/videos' do
		@videos = Video.all
		erb :"videos/index"
	end

	get '/videos/:id' do
		@id = params[:id].to_i
		@video = Video.find(@id) 
	  	erb :"videos/show"
	end

end