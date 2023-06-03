# frozen_string_literal: true

class Jha
  class << self
    def digest(str, vector = 76)
      message_for(str).inject(vector) do |next_vector, num|
        (
          next_vector + swap(
            (
              (next_vector + num) * 7
            ) % 100
          )
        ) % 100
      end
    end

    private

    def message_for(str)
      str
        .upcase
        .chars
        .map { |c| c == ' ' ? 26 : c.ord - 65 }
        .push(str.length)
    end

    def swap(number)
      number.divmod(10).reverse.join.to_i
    end
  end
end

# puts Jha.digest('Thisisatest')#('Hello my name is Alice')
# puts Jha.digest('Hello my name is Bob')