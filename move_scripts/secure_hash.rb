require 'digest'
def secure_hash(secret_hex, hand = nil)
  data = [secret_hex].pack('H*') + [hand].pack('Q')
  Digest::SHA2.new(256).hexdigest data
end

if __FILE__ == $0
  puts secure_hash(ARGV[0], ARGV[1].to_i)
end
