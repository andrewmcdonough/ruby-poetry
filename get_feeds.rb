#!/usr/bin/env ruby

require 'open-uri'
require 'yaml'
require 'rss'

data = YAML.load(open("./feeds.yaml"))
feeds = data.collect {|source| source["feeds"] && source["feeds"].collect {|f| f["url"] } }.flatten

open("feeds.txt", "w") do |fh|
  feeds.each do |feed|
    fh.write "#{feed}\n"
  end
end




