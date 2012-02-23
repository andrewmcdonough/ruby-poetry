#!/usr/bin/ruby

fh = open("headlines.txt")
headlines = fh.read.split("\n")

def couplet?(a,b)
  as = a.gsub /\W/,"" # Ignore punctuation
  bs = b.gsub /\W/,""
  as[-3,3] == bs[-3,3] &&
    !(as[-4,4] == bs[-4,4]) &&
    (as.length - bs.length).abs < 15 &&
    (as.length > 30 && as.length < 70) &&
    (bs.length > 30 && bs.length < 70)
end

headlines.reject! {|h| h.length < 10}
headlines.sort! {|a,b|  a[-3,3] <=> b[-3,3] }

i = 0
while (i < headlines.length-1) do
  a = headlines[i]
  b = headlines[i+1]
  if couplet?(a,b)
    i += 1
    puts "#{a}\n#{b}\n\n"
  end
  i += 1
end


