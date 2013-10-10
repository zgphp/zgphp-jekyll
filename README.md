ZgPHP Meetup Web Site
=====================

This is the operating manual. Work in progress.

## Setup

Install the latest version of Ruby 1.9 and RubyGems package manager.

Install prerequisites
```
gem install jekyll i18n
```

Checkout this project, and build the web site by running:
```
jekyll build
```

This will produce the HTML in _site subfolder.

## How to get a Vimeo video thumbnail

Visit:
```
http://vimeo.com/api/oembed.json?url=http://player.vimeo.com/video/VIDEO_ID
```

For example:
```
http://vimeo.com/api/oembed.json?url=http://player.vimeo.com/video/66249603
```
