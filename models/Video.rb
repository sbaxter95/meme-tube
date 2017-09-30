class Video 

	attr_accessor :id, :title, :description, :url, :genre

	def self.open_connection
		PGconn.connect(dbname: "memetube")
	end

	#index
	def self.all
		conn = self.open_connection
		sql = "SELECT * FROM videos"
		results = conn.exec(sql) 

		videos = results.map do |video| 
			self.hydrate video
		end
		videos
	end

	#video will now equal an array of hydrated records
	def self.hydrate video_data
		video = Video.new
		video.id = video_data['id']
		video.title = video_data['title']
		video.description = video_data['description']
		video.url = video_data['url']
		video.genre = video_data['genre']

		video
	end

	#show
	def self.find id
		conn = self.open_connection #Establishing connection to SQL server
		sql = "SELECT * FROM videos WHERE id =#{id}"
		videos = conn.exec(sql)

		video = self.hydrate videos[0] #Like jQuery

		video
	end

	#Instead of create and update
	def save #save is acting on the instance - instance method
		conn = Video.open_connection,
		if !self.id
			sql = "INSERT INTO videos (description, title, url, genre) VALUES ('#{self.description}', '#{self.title}', '#{self.url}, '#{self.genre}')"
		else
			sql = "UPDATE videos SET title = '#{self.title}', description = '#{self.description}', url = '#{self.url}', genre = '#{self.genre}' WHERE id = #{self.id}"
		end

		conn.exec(sql)
	end

	#delete
	def self.destroy id
		conn = self.open_connection
		sql = "DELETE FROM video WHERE id =#{id}"
		conn.exec(sql) #run the sql
		#Doesn't need to be in a variable and return anything - not being used - only one 
	end

end