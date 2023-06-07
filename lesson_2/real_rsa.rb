require 'openssl'

class Exchanger
  attr_reader :private_key, :public_key, :symm_key

  def initialize
    rsa_key = OpenSSL::PKey::RSA.new(2048)

    @private_key = OpenSSL::PKey::RSA.new(rsa_key.to_pem)

    @public_key = OpenSSL::PKey::RSA.new(rsa_key.public_key.to_pem)
  end

  def sign(message)
    private_key.sign OpenSSL::Digest::SHA256.new, message
  end

  def valid?(message, pub_key_pem)
    pub_key = OpenSSL::PKey::RSA.new pub_key_pem

    pub_key.verify(OpenSSL::Digest::SHA256.new, message[:signature], message[:initial])
  end
end

ex1 = Exchanger.new
ex2 = Exchanger.new

string = 'test'

message = {
  initial: string,
  signature: ex1.sign(string)
}

puts ex2.valid?(message, ex1.public_key.to_pem)