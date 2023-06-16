require 'digest'
require_relative '../../xor/cipher'

# seed = Time.now.to_i

puts "Enter seed:"
seed = gets.strip.unpack('U*')

puts "Enter words:"

words = gets.strip.split(',')

words.each_with_index do |word, nonce|
  puts word
  puts nonce

  r = Digest::SHA256.hexdigest "#{seed}#{nonce}"

  key = (r.to_i(16) % 1000).to_s

  puts "Let's cipher it:"

  cipherer = XorCipher::Cipher.new word, key
  secret = cipherer.cipher

  puts secret

  puts '=' * 50

  puts "Let's decipher it:"

  decipherer = XorCipher::Decipher.new secret, key

  puts decipherer.decipher

  puts '=' * 50
end