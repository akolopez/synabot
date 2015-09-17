require 'blather/client/dsl'
require_relative '../../../command/parser'

module Synabot
	module Connection
		module Hipchat
			class Chat
				extend Blather::DSL

				def self.create_reply m, type
					message = m.body
					if message.start_with?('/')
						message = message[1..-1]
			      body = Command::Parser.parse message
			      reply = Blather::Stanza::Message.new
			      reply.to = m.from.stripped
			      reply.body = body
			      reply.type = type
			      @client.write reply 
			    end
				end
			end
		end
	end
end
