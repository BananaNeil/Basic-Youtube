require 'httparty'
module BasicYoutube
  class Channel < YoutubeObject
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
      @all_videos=nil
    end
  
    def dynamic_methods
      h={};@dynamic_methods.each {|k,v| h[v.class].nil? ? h[v.class]=[k] : h[v.class] << k}
      return h
    end

    def entry
      @entry ||= self.class.call_youtube(@username)["entry"]
      if @dynamic_methods.blank?
        VALID_METHODS.each {|key| recursive_hash_access @dynamic_methods, @entry, key} 
        define_feeds
      end
      return @entry
    rescue MultiXml::ParseError
      raise InvalidAccount
    end
  
    def pull_videos start=1, max_results=25
      return @all_videos[start-1..start+max_results-1] if @all_videos.present?
      pull_raw_videos(start,max_results).map{|v| BasicYoutube::Video.new(v)}
    end
  
    def pull_all_videos
      calls = (upload_count+1)/50
      i = 0
      videos = []
      while i<=calls
        videos << pull_videos(i*50+1, 50)
        i+=1
      end
      @all_videos = videos
      return videos
    end
  
    def pull_raw_videos start=1, max_results=25
      max_results=50 if max_results-start>50
      videos = self.class.call_youtube(@username,"/uploads?start-index=#{start}&max-results=#{max_results}")["feed"]["entry"]
      return max_results==1 ? [videos] : videos
    end
  
    def respond_to?(method)
      entry if @dynamic_methods.blank?
      return true if @dynamic_methods.keys.include? method 
      super
    end
  
    def hours_uploaded
      pull_all_videos.map(&:hours).sum
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
end