require 'digest'
require 'securerandom'

puts SecureRandom.random_number(10)
# nonce = 0
# seed = Time.now.to_i #"42"

# r = Digest::SHA256.hexdigest "#{seed}#{nonce}"

# k0 = r.to_i(16) % 100

# puts k0

# nonce = nonce + 1

# r = Digest::SHA256.hexdigest "#{seed}#{nonce}"

# k1 = r.to_i(16) % 100

# puts k1