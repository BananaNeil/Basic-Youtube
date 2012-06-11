require 'spec_helper'

describe BasicYoutube::Channel do
  before do
    @channel = BasicYoutube::Channel.new("BananaNeil")
    @entry = {"entry"=>{"id"=>"http://gdata.youtube.com/feeds/api/users/YsmyStytOHPX9SaGBPda2Q", "published"=>"2008-11-18T06:51:28.000Z", "updated"=>"2012-06-10T13:04:18.000Z", "category"=>[{"scheme"=>"http://schemas.google.com/g/2005#kind", "term"=>"http://gdata.youtube.com/schemas/2007#userProfile"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/channeltypes.cat", "term"=>"DIRECTOR"}], "title"=>"I am a lion, rawr.", "content"=>"Email me = BananaNeil@gmail.com\n\nPage design = http://gemsemaj.deviantart.com/\n\nI am a lion.", "link"=>[{"rel"=>"alternate", "type"=>"text/html", "href"=>"https://www.youtube.com/channel/UCYsmyStytOHPX9SaGBPda2Q"}, {"rel"=>"self", "type"=>"application/atom+xml", "href"=>"https://gdata.youtube.com/feeds/api/users/YsmyStytOHPX9SaGBPda2Q"}], "author"=>{"name"=>"BananaNeil", "uri"=>"https://gdata.youtube.com/feeds/api/users/BananaNeil"}, "age"=>"21", "company"=>"Panthera leo.", "description"=>"Essentially, i am a lion. rawr.", "feedLink"=>[{"rel"=>"http://gdata.youtube.com/schemas/2007#user.favorites", "href"=>"https://gdata.youtube.com/feeds/api/users/banananeil/favorites", "countHint"=>"180"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#user.contacts", "href"=>"https://gdata.youtube.com/feeds/api/users/banananeil/contacts", "countHint"=>"2390"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#user.inbox", "href"=>"https://gdata.youtube.com/feeds/api/users/banananeil/inbox"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#user.playlists", "href"=>"https://gdata.youtube.com/feeds/api/users/banananeil/playlists"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#user.subscriptions", "href"=>"https://gdata.youtube.com/feeds/api/users/banananeil/subscriptions", "countHint"=>"318"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#user.uploads", "href"=>"https://gdata.youtube.com/feeds/api/users/banananeil/uploads", "countHint"=>"190"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#user.newsubscriptionvideos", "href"=>"https://gdata.youtube.com/feeds/api/users/banananeil/newsubscriptionvideos"}], "firstName"=>"Neil", "gender"=>"m", "hobbies"=>"you.", "hometown"=>"lots of places....", "lastName"=>"Johnson", "location"=>"Portland Oregon, US", "occupation"=>"Lion.", "statistics"=>{"lastWebAccess"=>"2012-05-14T21:15:09.000Z", "subscriberCount"=>"12236", "videoWatchCount"=>"0", "viewCount"=>"237276", "totalUploadViews"=>"1006317"}, "thumbnail"=>{"url"=>"https://i2.ytimg.com/i/YsmyStytOHPX9SaGBPda2Q/1.jpg?v=4f3e1533"}, "username"=>"banananeil"}}
    @channel.class.stub(:call_youtube).and_return(@entry)
    @videos = {"feed"=>{"entry"=>[{"id"=>"http://gdata.youtube.com/feeds/api/videos/h74fp_CiZTs", "published"=>"2012-04-26T22:30:07.000Z", "updated"=>"2012-06-10T10:40:37.000Z", "category"=>[{"scheme"=>"http://schemas.google.com/g/2005#kind", "term"=>"http://gdata.youtube.com/schemas/2007#video"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/categories.cat", "term"=>"People", "label"=>"People & Blogs"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"mythbusters"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"myth"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"busters"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"myth busters"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"big bang theory"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"big"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"bang"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"theory"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"Adam Savage"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"Jamie Hyneman"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"stupid"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"people"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"smart"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"shows"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"science"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"lion"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"rawr"}], "title"=>"Smart Shows For Dumb People", "content"=>"That girl = http://youtube.com/nerdzrl\nI tweet and tumblr sometimes:\nhttp://BananaNeil.tumblr.com\nhttp://twitter.com/BananaNeil\n\nThis is a video in which I rant about how myth busters doesn't follow proper methods for executing scientific experiments, and how big bang theory is just a show that makes stupid people feel smart", "link"=>[{"rel"=>"alternate", "type"=>"text/html", "href"=>"https://www.youtube.com/watch?v=h74fp_CiZTs&feature=youtube_gdata"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#video.responses", "type"=>"application/atom+xml", "href"=>"https://gdata.youtube.com/feeds/api/videos/h74fp_CiZTs/responses"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#video.related", "type"=>"application/atom+xml", "href"=>"https://gdata.youtube.com/feeds/api/videos/h74fp_CiZTs/related"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#mobile", "type"=>"text/html", "href"=>"https://m.youtube.com/details?v=h74fp_CiZTs"}, {"rel"=>"self", "type"=>"application/atom+xml", "href"=>"https://gdata.youtube.com/feeds/api/users/BananaNeil/uploads/h74fp_CiZTs"}], "author"=>{"name"=>"BananaNeil", "uri"=>"https://gdata.youtube.com/feeds/api/users/BananaNeil"}, "comments"=>{"feedLink"=>{"rel"=>"http://gdata.youtube.com/schemas/2007#comments", "href"=>"https://gdata.youtube.com/feeds/api/videos/h74fp_CiZTs/comments", "countHint"=>"183"}}, "where"=>{"Point"=>{"pos"=>"47.65387 -122.25517"}}, "hd"=>nil, "group"=>{"category"=>"People", "content"=>[{"url"=>"https://www.youtube.com/v/h74fp_CiZTs?version=3&f=user_uploads&app=youtube_gdata", "type"=>"application/x-shockwave-flash", "medium"=>"video", "isDefault"=>"true", "expression"=>"full", "duration"=>"84", "format"=>"5"}, {"url"=>"rtsp://v2.cache2.c.youtube.com/CigLENy73wIaHwk7ZaLwpx--hxMYDSANFEgGUgx1c2VyX3VwbG9hZHMM/0/0/0/video.3gp", "type"=>"video/3gpp", "medium"=>"video", "expression"=>"full", "duration"=>"84", "format"=>"1"}, {"url"=>"rtsp://v4.cache3.c.youtube.com/CigLENy73wIaHwk7ZaLwpx--hxMYESARFEgGUgx1c2VyX3VwbG9hZHMM/0/0/0/video.3gp", "type"=>"video/3gpp", "medium"=>"video", "expression"=>"full", "duration"=>"84", "format"=>"6"}], "description"=>"That girl = http://youtube.com/nerdzrl\nI tweet and tumblr sometimes:\nhttp://BananaNeil.tumblr.com\nhttp://twitter.com/BananaNeil\n\nThis is a video in which I rant about how myth busters doesn't follow proper methods for executing scientific experiments, and how big bang theory is just a show that makes stupid people feel smart", "keywords"=>"mythbusters, myth, busters, myth busters, big bang theory, big, bang, theory, Adam Savage, Jamie Hyneman, stupid, people, smart, shows, science, lion, rawr", "player"=>{"url"=>"https://www.youtube.com/watch?v=h74fp_CiZTs&feature=youtube_gdata_player"}, "thumbnail"=>[{"url"=>"http://i.ytimg.com/vi/h74fp_CiZTs/0.jpg", "height"=>"360", "width"=>"480", "time"=>"00:00:42"}, {"url"=>"http://i.ytimg.com/vi/h74fp_CiZTs/1.jpg", "height"=>"90", "width"=>"120", "time"=>"00:00:21"}, {"url"=>"http://i.ytimg.com/vi/h74fp_CiZTs/2.jpg", "height"=>"90", "width"=>"120", "time"=>"00:00:42"}, {"url"=>"http://i.ytimg.com/vi/h74fp_CiZTs/3.jpg", "height"=>"90", "width"=>"120", "time"=>"00:01:03"}], "title"=>"Smart Shows For Dumb People", "duration"=>{"seconds"=>"84"}}, "rating"=>{"average"=>"4.394958", "max"=>"5", "min"=>"1", "numRaters"=>"357", "rel"=>"http://schemas.google.com/g/2005#overall"}, "statistics"=>{"favoriteCount"=>"16", "viewCount"=>"8388"}}, {"id"=>"http://gdata.youtube.com/feeds/api/videos/rHVRKrL_WuI", "published"=>"2012-04-20T01:39:35.000Z", "updated"=>"2012-06-10T22:13:05.000Z", "category"=>[{"scheme"=>"http://schemas.google.com/g/2005#kind", "term"=>"http://gdata.youtube.com/schemas/2007#video"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/categories.cat", "term"=>"People", "label"=>"People & Blogs"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"BananaNeil"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"Confessions"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"Confession"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"dark"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"secret"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"secrets"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"Confessions (film)"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"love"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"life"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"lions"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"rawr"}, {"scheme"=>"http://gdata.youtube.com/schemas/2007/keywords.cat", "term"=>"Lion (Animal)"}], "title"=>"Confessions 4/19/12", "content"=>"Email confessions to = BananaNeilConfessions@gmail.com\nOther confession videos = http://bit.ly/confessionsBN\nThat kid in my video = http://youtube.com/thatzak (he makes better videos than me)\n\nThis is a video in which i read peoples confessions.", "link"=>[{"rel"=>"alternate", "type"=>"text/html", "href"=>"https://www.youtube.com/watch?v=rHVRKrL_WuI&feature=youtube_gdata"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#video.responses", "type"=>"application/atom+xml", "href"=>"https://gdata.youtube.com/feeds/api/videos/rHVRKrL_WuI/responses"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#video.related", "type"=>"application/atom+xml", "href"=>"https://gdata.youtube.com/feeds/api/videos/rHVRKrL_WuI/related"}, {"rel"=>"http://gdata.youtube.com/schemas/2007#mobile", "type"=>"text/html", "href"=>"https://m.youtube.com/details?v=rHVRKrL_WuI"}, {"rel"=>"self", "type"=>"application/atom+xml", "href"=>"https://gdata.youtube.com/feeds/api/users/BananaNeil/uploads/rHVRKrL_WuI"}], "author"=>{"name"=>"BananaNeil", "uri"=>"https://gdata.youtube.com/feeds/api/users/BananaNeil"}, "comments"=>{"feedLink"=>{"rel"=>"http://gdata.youtube.com/schemas/2007#comments", "href"=>"https://gdata.youtube.com/feeds/api/videos/rHVRKrL_WuI/comments", "countHint"=>"218"}}, "hd"=>nil, "group"=>{"category"=>"People", "content"=>[{"url"=>"https://www.youtube.com/v/rHVRKrL_WuI?version=3&f=user_uploads&app=youtube_gdata", "type"=>"application/x-shockwave-flash", "medium"=>"video", "isDefault"=>"true", "expression"=>"full", "duration"=>"334", "format"=>"5"}, {"url"=>"rtsp://v7.cache1.c.youtube.com/CigLENy73wIaHwniWv-yKlF1rBMYDSANFEgGUgx1c2VyX3VwbG9hZHMM/0/0/0/video.3gp", "type"=>"video/3gpp", "medium"=>"video", "expression"=>"full", "duration"=>"334", "format"=>"1"}, {"url"=>"rtsp://v1.cache6.c.youtube.com/CigLENy73wIaHwniWv-yKlF1rBMYESARFEgGUgx1c2VyX3VwbG9hZHMM/0/0/0/video.3gp", "type"=>"video/3gpp", "medium"=>"video", "expression"=>"full", "duration"=>"334", "format"=>"6"}], "description"=>"Email confessions to = BananaNeilConfessions@gmail.com\nOther confession videos = http://bit.ly/confessionsBN\nThat kid in my video = http://youtube.com/thatzak (he makes better videos than me)\n\nThis is a video in which i read peoples confessions.", "keywords"=>"BananaNeil, Confessions, Confession, dark, secret, secrets, Confessions (film), love, life, lions, rawr, Lion (Animal)", "player"=>{"url"=>"https://www.youtube.com/watch?v=rHVRKrL_WuI&feature=youtube_gdata_player"}, "thumbnail"=>[{"url"=>"http://i.ytimg.com/vi/rHVRKrL_WuI/0.jpg", "height"=>"360", "width"=>"480", "time"=>"00:02:47"}, {"url"=>"http://i.ytimg.com/vi/rHVRKrL_WuI/1.jpg", "height"=>"90", "width"=>"120", "time"=>"00:01:23.500"}, {"url"=>"http://i.ytimg.com/vi/rHVRKrL_WuI/2.jpg", "height"=>"90", "width"=>"120", "time"=>"00:02:47"}, {"url"=>"http://i.ytimg.com/vi/rHVRKrL_WuI/3.jpg", "height"=>"90", "width"=>"120", "time"=>"00:04:10.500"}], "title"=>"Confessions 4/19/12", "duration"=>{"seconds"=>"334"}}, "rating"=>{"average"=>"4.93617", "max"=>"5", "min"=>"1", "numRaters"=>"376", "rel"=>"http://schemas.google.com/g/2005#overall"}, "statistics"=>{"favoriteCount"=>"53", "viewCount"=>"6549"}}]}}
  end
  describe ".entry" do
    it "should return a hash equal to entry" do
      @channel.entry.should == @entry["entry"]
    end
  end
  
  describe ".pull_all_videos" do
    before do
      @channel.class.stub(:call_youtube).and_return(@entry,@videos)
    end
    it "should try to contact youtube once for the entry, and 4 times for the 190 videos" do
      @channel.class.should_receive(:call_youtube).exactly(5).times
      @channel.pull_all_videos
    end
    it "should return an array" do
      @channel.pull_all_videos.class.should == Array
    end
    it "should store the response and only call youtube the minimum number of times" do
      @channel.class.should_receive(:call_youtube).exactly(5).times
      3.times{@channel.pull_all_videos}
    end
  end
  
  describe ".pull_raw_videos" do
    before do
      @channel.class.stub(:call_youtube).and_return(@videos)
    end
    it "should contact youtube" do
      @channel.class.should_receive(:call_youtube)
      @channel.pull_raw_videos
    end
  end
   
 {Hash=>[:thumbnail, :author, :statistics, :favorites, :contacts, :inbox, :playlists, :subscriptions, :uploads, :new_subscription_videos],
  String=>[:id, :title, :content, :name, :uri, :company, :description, :first_name, :gender, :location, :occupation, :username],
  Date=>[:published, :updated, :last_web_access],
  Array=>[:category, :link, :feed_link, :pull_raw_videos],
  Fixnum=>[:age, :subscriber_count, :video_watch_count, :view_count, :total_upload_views, :favorite_count, :contact_count, :subscription_count, :upload_count],
  Float=>[:hours_uploaded]}.each do |type,methods|
    methods.each do |method|
      describe ".#{method}" do
        before do
          @channel.class.stub(:call_youtube).and_return([:pull_raw_videos,:hours_uploaded].include?(method) ? @videos : @entry)
          @channel.stub(:pull_all_videos).and_return(@videos["feed"]["entry"].map{|v| BasicYoutube::Video.new(v)}) if method==:hours_uploaded
        end
        it "should return a #{type}" do
          @channel.send(method).class.should == type
        end
      end
    end
  end
end