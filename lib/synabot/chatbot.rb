require 'yaml'
require 'blather/client/dsl'
require_relative 'connection/hipchat/muc'
require_relative 'connection/hipchat/suc'

module Synabot

	ROOT_FOLDER = File.expand_path(File.join(File.dirname(__FILE__), '../..'))

	class Chatbot

		def initialize
			load_config
			@jid = @config['jid']
			@password = @config['password']
			@rooms = @config['rooms']
			@name = @config['name']
		end

		def run_muc_bot
			client = Synabot::Connection::Hipchat::MUC.new(name: @name, rooms: @rooms, jid: @jid, password: @password)
			client.connect
		end

		def run_private_bot
			client = Synabot::Connection::Hipchat::SUC.new(name: @name, jid: @jid, password: @password)
			client.connect
		end

		def load_config
      config_file = File.join(ROOT_FOLDER, 'config.yml')
      raise 'Synabot config.yml file not found' unless File.exists?(config_file)
      @config = YAML.load(File.read(config_file))
    end
	end
end
