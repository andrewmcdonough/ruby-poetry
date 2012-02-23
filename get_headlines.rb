#!/usr/bin/env ruby

require 'open-uri'
require 'rss'

fh = open("feeds.txt")
feeds = fh.read.split "\n"

headlines = []
feeds.each do |feed|
  begin
    file = open(feed)
    rss = RSS::Parser.parse(file.read)
    feed_headlines = rss.items.map {|i| i.title}
    headlines += feed_headlines
  rescue
    puts "Error with #{feed}"
  end
end

# Remove duplicates and strip some prefixes
headlines = headlines.uniq!
headlines = headlines.map {|h| h.gsub /^(AUDIO|VIDEO): /,""}

open("headlines.txt", "w") do |fh|
  headlines.each do |h|
    fh.write "#{h}\n"
  end
end
