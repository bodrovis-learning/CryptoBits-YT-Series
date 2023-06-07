require 'prime'
require 'base64'
require_relative 'jha'

class SimpleRSA
  attr_reader :pub_key, :priv_key

  def initialize(limit = 30)
    pn = random_prime(limit)
    qn = random_prime(limit)

    @max = pn * qn

    totient = (pn - 1) * (qn - 1)

    @pub_key = { max: @max, key: pub_key_from(totient) }

    @priv_key = priv_key_from totient
  end

  def sign(message)
    Base64.strict_encode64(
      encrypt(
        Jha.digest(message), @priv_key, @max
      ).join('-')
    )
  end

  def valid?(message, signature, pub_key)
    regenarated_sig = Base64.strict_decode64(signature).split('-')

    decrypted = decrypt(regenarated_sig, pub_key[:key], pub_key[:max])

    decrypted == Jha.digest(message)
  end

  def encrypt(arr, key, local_max)
    arr.map do |char_code|
      (char_code.to_i ** key) % local_max
    end
  end

  def decrypt(arr, key, local_max)
    arr.map do |s_char|
      (s_char.to_i ** key) % local_max
    end
  end

  private

  def pub_key_from(totient, generator = Prime::EratosthenesGenerator.new)
    # co-prime number
    next_prime = generator.next

    return if next_prime >= totient # exception!

    return next_prime if gcd_extended(next_prime, totient)[0] == 1

    pub_key_from totient, generator
  end

  def priv_key_from(totient)
    d = gcd_extended(totient, @pub_key[:key])[2]

    d.positive? ? d : (totient - d.abs)
  end

  def gcd_extended(a, b)
    return b, 0, 1 if a.zero?

    gcd, x1, y1 = gcd_extended(b % a, a)

    x = y1 - (b / a) * x1
    y = x1

    [gcd, x, y]
  end

  def random_prime(limit)
    Prime.take(rand(1..limit)).last
  end
end

