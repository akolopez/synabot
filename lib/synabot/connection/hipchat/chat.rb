require 'blather/client/dsl'
require_relative '../../command/parser'

module Synabot
	module Connection
		module Hipchat
			class Chat
				extend Blather::DSL

				def initialize(args)
					$name = args[:name]
					$rooms = args[:rooms]
					@jid = args[:jid]
					@password = args[:password]
				end

				def connect
					@client = Chat.setup @jid, @password
					@client.run
				end

				when_ready do
					puts 'ready for 1 on 1 chat'
				end

				message :chat?, :body, proc { |m| m.from != jid.stripped }, delay: nil do |m|
					puts m
		      body = Command::Parser.parse m
		      to = m.from.stripped
					reply = Blather::Stanza::Message.new(to, body, :chat)
		      @client.write reply
				end
			end
		end
	end
end
