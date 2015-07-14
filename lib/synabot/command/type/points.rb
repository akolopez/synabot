require_relative '../../model/user'

module Synabot
	module Command
		module Type
			class Points

				def self.do(person)
					user = Synabot::Model::User.get person
					"#{person} has accumulated #{user.points} points!"
				end
				
			end
		end
	end
end