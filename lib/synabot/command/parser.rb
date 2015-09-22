require 'redis'
require_relative 'type/commands'

module Synabot
	module Command
		class Parser

			def self.parse(message)
				command = message.split.first
				args = message[command.length..-1]
				if command == 'gif'
					Synabot::Command::Type::Giphy.do(args)
				elsif command == 'claire'
					Synabot::Command::Type::Claire.do()
				end
			end

		end
	end
end
