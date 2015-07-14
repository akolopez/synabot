require 'json'
require 'redis'

module Synabot
	module Model
		class User

			attr_accessor :points, :access_token
			attr_reader :name

			def name=(name)
				if name.include? '@' then name.delete! '@' end
				@name = name.downcase!
			end

			def initialize(args)
				@name = args[:name]
				@points = args[:points]
				@access_token = args[:access_token]
			end

			def save
				redis = Redis.new
				redis.set @name, self.to_json
			end

			def to_json
				user = {name: @name, points: @points, access_token: @access_token}
				JSON.generate user
			end

			def self.get(name)
				if name.include? '@' then name.delete! '@' end
				redis = Redis.new
				values = redis.get name.downcase!
				values ||= JSON.generate({name: name, points: 0, access_token: nil})
				values = JSON.parse(values)
				User.new(name: values['name'], points: values['points'], access_token: values['access_token'])
			end

		end
	end
end