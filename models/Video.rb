class Video 

	attr_accessor :id, :title, :description, :url, :genre

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

	def self.find id
		conn = self.open_connection
		sql = "SELECT * FROM videos WHERE id =#{id}"
		videos = conn.exec(sql)

		@video = self.hydrate videos[0]

		@video
	end

	def save 
		conn = Video.open_connection
		if !self.id 
			sql = "INSERT INTO videos (title, description, url, genre) VALUES ('#{self.title}', '#{self.description}', '#{self.url}', '#{self.genre}')"
		else
			sql = "UPDATE videos SET title = '#{self.title}', description = '#{self.description}', url = '#{self.url}', genre = '#{self.genre}' WHERE id = #{self.id}"
		end

		conn.exec(sql)
	end

end

