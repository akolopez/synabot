require 'blather/client/dsl'
require_relative '../../command/parser'

module Synabot
	module Connection
		module Hipchat
			class MUC
				extend Blather::DSL

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

				when_ready do
					$rooms.each do |r|
						puts 'JOINING ROOM ' + r
						join r, $name
					end
				end

				message :groupchat?, :body, proc { |m| m.from != jid.stripped }, delay: nil do |m|
					message = m.body
					if message.start_with?('[[') && message.end_with?(']]')
						message = message[2..-3]
			      body = Command::Parser.parse message
			      to = m.from.stripped
						reply = Blather::Stanza::Message.new(m.from, body, :groupchat)
			      @client.write reply
			    end
				end
			end
		end
	end
end
