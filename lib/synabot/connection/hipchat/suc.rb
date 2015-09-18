require 'blather/client/dsl'
require_relative 'common/chat'

module Synabot
	module Connection
		module Hipchat
			class SUC < Chat

				def initialize(args)
					$name = args[:name]
					@jid = args[:jid]
					@password = args[:password]
				end

				def connect
					@client = SUC.setup @jid, @password
					@client.run
				end

				disconnected { @client.connect }	

				when_ready do
					puts 'ready for 1 on 1 chat'
				end

				message :chat?, :body, proc { |m| m.from != jid.stripped }, delay: nil do |m|
					self.create_reply m, 'chat'
				end

			end
		end
	end
end
