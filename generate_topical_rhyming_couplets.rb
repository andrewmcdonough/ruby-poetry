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

def couplet?(a,b)
  as = a.gsub /\W/,"" # Ignore punctuation
  bs = b.gsub /\W/,""
  as[-3,3] == bs[-3,3] &&
    !(as[-5,5] == bs[-5,5]) &&
    (as.length - bs.length).abs < 10 &&
    (as.length > 30 && as.length < 70) &&
    (bs.length > 30 && bs.length < 70)
end

headlines.sort! {|a,b|  a[-3,3] <=> b.reverse[-3,3] }

i = 0
while (i < headlines.length-2) do
  a = headlines[i]
  b = headlines[i+1]
  if couplet?(a,b)
    i += 1
    puts "#{a}\n#{b}\n\n"
  end
  i += 1
end
