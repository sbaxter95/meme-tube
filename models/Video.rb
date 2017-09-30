class Video 

	attr_accessor :title, :description, :url, :genre

	def self.open_connection
		PGconn.connect(dbname: "memetube")
	end

	def self.all 
		conn = self.open_connection
		sql = "SELECT * FROM videos"
		results = conn.exec(sql)

		videos = results.map do |video|
			self.hydrate video
		end
		videos 
	end

	def self.hydrate video_data
		video = Video.new
		video.title = video_data['title']
		video.description = video_data['description']
		video.url = video_data['url']
		video.genre = video_data['genre']

		video
	end

end

