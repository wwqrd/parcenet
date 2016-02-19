require 'digest'

puts Digest::SHA256.hexdigest(ARGV[0] + ARGV[1])
