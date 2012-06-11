require 'httparty'
module BasicYoutube
  class Video < YoutubeObject
    include HTTParty
    format :xml
  
    VALID_METHODS = [:comments, :id, :published, :updated, :category, :title, :content, :link,
                     :author, :where, {:group => [:category, :content, :description, :keywords,
                     :player, :thumbnail, :title, {:duration=>:seconds}]}, :rating, {:statistics =>
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
      if @dynamic_methods.blank?
        VALID_METHODS.each {|key| recursive_hash_access @dynamic_methods, @entry, key}
        define_links
      end
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
  
    def minutes
      seconds.to_f/60
    end
  
    def hours
      minutes/60
    end
  

    private
  
    def self.call_youtube top_route, nested_route=nil
      base_uri "https://gdata.youtube.com"
      data = get "/feeds/api/videos/#{top_route}"
    end
  
    def method_missing method
      (entry;@dynamic_methods[method]) if @dynamic_methods.blank?
    
      return self.class.call_youtube(@dynamic_methods[method].split("videos/").last)["feed"]["entry"] if [:raw_video_responses,:raw_related_videos].include? method
      return send("raw_#{method}").map{|v| BasicYoutube::Video.new(v)} if [:video_responses,:related_videos].include? method
    
      @dynamic_methods[method] || super
    end
  
    def define_links
      puts "in define links"
      (links = [:direct_link,:video_responses,:related_videos,:mobile_link,:api_link]).each do |key|
        single_count = "#{key.to_s.singularize}_count".to_sym
        current_link = link[links.index(key)]["href"]
        @dynamic_methods[key] = current_link
        @dynamic_methods["raw_#{key}".to_sym] = current_link
      end
    end
  
  end
end