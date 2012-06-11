require 'rubygems'
require "basic_youtube/youtube_object"
require "basic_youtube/version"
require "basic_youtube/channel"
require "basic_youtube/video"
require 'httparty'


module BasicYoutube
  
  
  #youtube errors
  class YoutubeError < StandardError; end
  #invalid accounts
  class InvalidAccount < YoutubeError; end
  #invalid videos
  class InvalidVideo < YoutubeError; end
  
end

class String
	def number?
	  true if Float(self) rescue false
	end
end