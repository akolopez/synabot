require 'redis'
require_relative 'type/commands'

module Synabot
	module Command
		class Parser

			def self.parse(message)
				command, arg1, arg2 = message.split
				if command == 'summon'
					Synabot::Command::Type::Summon.do(arg1)
				elsif command == '!points' || command == '!pt'
					Synabot::Command::Type::Points.do(arg1)
				elsif command == '!commend' || command == '!cm'
					if arg2
						giver = message.from.node.split('_')[1]
						Synabot::Command::Type::Commend.do(arg1, giver, message.body.split()[2..-1].join(' '))
					else 
						Synabot::Command::Type::Commend.do(arg1)
					end
				elsif command == '!register' || command == '!reg'
					Synabot::Command::Type::Register.do(arg1, arg2)
				end
			end

		end
	end
end