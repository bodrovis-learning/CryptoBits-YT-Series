# frozen_string_literal: true

require_relative 'simple_rsa'

sender = SimpleRSA.new
receiver = SimpleRSA.new

message = 'Hello my name is Bob!'

signature = sender.sign(message)

puts signature.inspect

puts receiver.valid?(message, signature, sender.pub_key).inspect
# puts u1.pub_key, u1.priv_key

# message = [1,2,3]

# secret = u1.encrypt(message, u2.pub_key[:key], u2.pub_key[:max])

# puts secret.inspect

# puts u2.decrypt(secret, u2.priv_key, u2.pub_key[:max]).inspect
