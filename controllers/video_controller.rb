class VideoController < Sinatra::Base 

	configure :development do 
		register Sinatra::Reloader
	end

	set :root, File.join(File.dirname(__FILE__), "..")

	set :views, Proc.new  {File.join(root, 'views')}

	get '/videos' do
		@videos = Video.all
		erb :"players/index"
	end

end