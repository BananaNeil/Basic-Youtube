require 'rubygems'
require "basic_youtube/version"
require 'httparty'


module BasicYoutube
  
  module YoutubeObject
    ############################################
    # Recursively assigns methods to the instance
    # allowing for access to nested attributes of the
    # entry hash, (eg, c.statistics => c.entry['statistics']
    # and c.view_count => c.entry["statistics"]["viewCount"])
  
    def recursive_hash_access dynamic_methods, base, key
      if key.respond_to? :keys
        key.each do |k,v|
          recursive_hash_access(dynamic_methods, base, k)
          v=[v] unless v.kind_of?(Array)
          v.each do |v1|
            recursive_hash_access(dynamic_methods, base[k.to_s.camelcase(:lower)], v1)
          end
        end
      else
        value = base[key.to_s.camelcase(:lower)]
        begin
          value = value.number? ? value.to_i : Date.parse(value)
        rescue
        end
        dynamic_methods[key] = value
      end
    end
    ############################################
  end
  
  
  class Channel
    include YoutubeObject
    include HTTParty
    format :xml
    
    VALID_METHODS = [:thumbnail, :id, :published, :updated, :category, :title, :content,
                     :link, {:author=>[:name, :uri]}, :age, :company, :description, :feed_link,
                     :first_name, :gender, :location, :occupation, {:statistics=> [:last_web_access,
                     :subscriber_count, :video_watch_count, :view_count, :total_upload_views]}, :username]
    
    def initialize username
      @dynamic_methods = {}
      @username = username
      @entry = nil
    end
    
    def dynamic_methods
      h={};@dynamic_methods.each {|k,v| h[v.class].nil? ? h[v.class]=[k] : h[v.class] << k}
      return h
    end
  
    def entry
      @entry ||= self.class.call_youtube(@username)["entry"]
      VALID_METHODS.each {|key| recursive_hash_access @dynamic_methods, @entry, key} if @dynamic_methods.blank?
      define_feeds
      return @entry
    rescue MultiXml::ParseError
      raise InvalidAccount
    end
    
    def pull_videos start=1, max_results=25
      pull_raw_videos(start,max_results).map{|v| BasicYoutube::Video.new(v)}
    end
    
    def pull_all_videos
    end
    
    def pull_raw_videos start=1, max_results=25
      self.class.call_youtube(@username,"/uploads?start-index=#{start}&max-results=#{max_results}")["feed"]["entry"]
    end
    
    def respond_to?(method)
      entry if @dynamic_methods.blank?
      return true if @dynamic_methods.keys.include? method 
      super
    end
    
    private
    
    def self.call_youtube username, nested_route=nil
    	base_uri "https://gdata.youtube.com"
      data = get "/feeds/api/users/#{username}#{nested_route}"
    end
    
    def method_missing method
      entry if @dynamic_methods.blank?
      @dynamic_methods[method] || super
    end
    
    
    def define_feeds
      (feeds = [:favorites,:contacts,:inbox,:playlists,:subscriptions,:uploads,:new_subscription_videos]).each do |key|
        single_count = "#{key.to_s.singularize}_count".to_sym
        @dynamic_methods[key] = feed_link[feeds.index(key)]
        @dynamic_methods[single_count] = feed_link[feeds.index(key)]["countHint"].to_i if (send(key)["countHint"].present?)
      end
    end
    
  end
  
  
  class Video
    include YoutubeObject
    include HTTParty
    format :xml
    
    VALID_METHODS = [:comments, :id, :published, :updated, :category, :title, :content, :link,
                     :author, :where, {:group => [:category, :content, :description, :keywords,
                     :player, :thumbnail, :title, :duration]}, :rating, {:statistics =>
                     [:favorite_count, :view_count]}]
    
    def initialize video
      @dynamic_methods = {}
      @id = video.respond_to?(:keys) ? video["id"].split("/").last : video
      @entry = (video if video.respond_to?(:keys))
    end
    
    def dynamic_methods
      h={};@dynamic_methods.each {|k,v| h[v.class].nil? ? h[v.class]=[k] : h[v.class] << k}
      return h
    end
    
    def entry
      @entry ||= self.class.call_youtube(@id)["entry"]

      VALID_METHODS.each {|key| recursive_hash_access @dynamic_methods, @entry, key} if @dynamic_methods.blank?
      return @entry
    rescue MultiXml::ParseError
      raise InvalidVideo
    end
    
    def author
      BasicYoutube::Channel.new(entry["author"]["name"])
    end
    
    def likes
      average = rating["average"].to_f
      total = rating["numRaters"].to_i
      return (total*(average-1)/4).round
    end
    
    def dislikes
      total = rating["numRaters"].to_i
      return total-likes
    end
    
    def average_rating
      average = rating["average"].to_f
    end

    private
    
    def self.call_youtube id, nested_route=nil
      base_uri "https://gdata.youtube.com"
      data = get "/feeds/api/videos/#{id}"
    end
    
    def method_missing method
      (entry;@dynamic_methods[method]) if @dynamic_methods.blank?
      @dynamic_methods[method] || super
    end
    
  end
  
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