require 'unirest'
require 'json'
require_relative '../../model/user'

module Synabot
	module Command
		module Type
			class Commend

				def self.do(person)
					user = Synabot::Model::User.get(person)
					user.points += 1
					user.save
					"Good job, #{person} (froiface)"
				end

				def self.do(person, giver, message)
					if person.include? '@' then person.delete! '@' end
					giver_response = Unirest.get "https://api.hipchat.com/v2/user/#{giver}?auth_token=mADiVreIffCP39lllErURnEL52zMvAuJ5ZFwx4cq"
					giver_user = Synabot::Model::User.get(giver_response.body['mention_name'])
					user = Synabot::Model::User.get(person)
					user.points += 1
					user.save
					if giver_user.access_token != nil
						response = Unirest.get "https://api.hipchat.com/v2/user/@#{person}?auth_token=mADiVreIffCP39lllErURnEL52zMvAuJ5ZFwx4cq"
						puts response.body['email']
						Unirest.post "https://bonus.ly/api/v1/bonuses?access_token=#{giver_user.access_token}",
													headers: { "Accept" => "application/json" },
													parameters:{ :receiver_email => response.body['email'], :reason => message, :amount => 1 }
					end
					"Good job, #{person} (froiface)"
				end

			end
		end
	end
end