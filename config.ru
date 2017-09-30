require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

require_relative './controllers/video_controller.rb'
require_relative '.models/Video.rb'

use Rack::MethodOverride

run VideoController