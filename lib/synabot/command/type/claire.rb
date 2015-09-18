module Synabot
	module Command
		module Type
			class Claire

				def self.do()
					value = Random.rand(1..15) 
					if value == 1 || value == 2
						'Stand up na tayo guys.'
					elsif value == 3 || value == 4
						'So what are our action items for this sprint?'
					elsif value == 5 || value == 6
						'Team retro in the chill out room.'
					elsif value == 7 || value == 8
						'Remember the prime directive.'
					elsif value == 9 || value == 10 
						'What went well in your life recently?'
					elsif value == 11 || value == 12
						'What can be improved?'
					elsif value == 13 || value == 14 
						'Great job on the demo guys. (thumbsup)'
					elsif value == 15
						'hi jc (heart) (aww)'
					end
				end
				
			end
		end
	end
end
