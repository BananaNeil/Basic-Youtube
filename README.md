# BasicYoutube

A basic youtube rails library created to provide access to public data.

## Installation

Add this line to your application's Gemfile:

    gem 'basic_youtube'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install basic_youtube

## Usage

    > channel = BasicYoutube::Channel.new("BananaNeil")
    

    > video = BasicYoutube::Video.new("VzWnMh-roJE")
    

## Channel Responds to the following methods:
    
    > channel.age
    > channel.author
    > channel.category
    > channel.company
    > channel.contact_count
    > channel.contacts
    > channel.content
    > channel.description
    > channel.entry
    > channel.favorite_count
    > channel.favorites
    > channel.feed_link
    > channel.first_name
    > channel.gender
    > channel.hours_uploaded
    > channel.id
    > channel.inbox
    > channel.last_web_access
    > channel.link
    > channel.location
    > channel.name
    > channel.new_subscription_videos
    > channel.occupation
    > channel.playlists
    > channel.published
    > channel.pull_videos
    > channel.pull_all_videos
    > channel.pull_raw_videos
    > channel.statistics
    > channel.subscriber_count
    > channel.subscription_count
    > channel.subscriptions
    > channel.thumbnail
    > channel.title
    > channel.total_upload_views
    > channel.updated
    > channel.upload_count
    > channel.uploads
    > channel.uri
    > channel.username
    > channel.video_watch_count
    > channel.view_count
    

    ## Video Responds to the following methods:
    
    > video.api_link
    > video.author
    > average_rating
    > video.category
    > video.comments
    > video.content
    > video.description
    > video.direct_link
    > video.dislikes
    > video.duration
    > video.entry
    > video.favorite_count
    > video.group
    > video.hours
    > video.id
    > video.keywords
    > video.likes
    > video.link
    > video.minutes
    > video.mobile_link
    > video.player
    > video.published
    > video.rating
    > video.raw_api_link
    > video.raw_direct_link
    > video.raw_mobile_link
    > video.raw_related_videos
    > video.raw_video_responses
    > video.related_videos
    > video.seconds
    > video.statistics
    > video.thumbnail
    > video.title
    > video.updated
    > video.video_responses
    > video.view_count
    > video.where


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
