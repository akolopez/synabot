require 'rest-client'
require 'json'

module Synabot
	module Command
		module Type
			class Giphy

				def self.do(search_term)
					resp = RestClient.get 'http://api.giphy.com/v1/gifs/random',
															{:params => {:api_key => 'dc6zaTOxFJmzC', :tag => search_term}, :accept => :json}
					gif = JSON.parse resp.body
					gif['data']['image_url']
				end
				
			end
		end
	end
end
