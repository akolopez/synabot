module Synabot
	module Command
		module Type
			class Register

				def self.do(name, access_token)
					user = Synabot::Model::User.get name
					puts user
					user.access_token = access_token
					user.save
					"#{name} successfully registered to the auto-bonusly service."
				end
				
			end
		end
	end
end