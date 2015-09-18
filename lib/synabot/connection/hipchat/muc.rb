require 'blather/client/dsl'
require_relative 'common/chat'

module Synabot
	module Connection
		module Hipchat
			class MUC < Chat

				def initialize(args)
					$name = args[:name]
					$rooms = args[:rooms]
					@jid = args[:jid]
					@password = args[:password]
				end

				def connect
					@client = MUC.setup @jid, @password
					@client.run
				end

				disconnected { @client.connect }	

				when_ready do
					$rooms.each do |r|
						puts 'JOINING ROOM ' + r
						join r, $name
					end
				end

				message :groupchat?, :body, proc { |m| m.from != jid.stripped }, delay: nil do |m|
					self.create_reply m, 'groupchat'
				end

			end
		end
	end
end
