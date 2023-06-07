# frozen_string_literal: true

class Jha
  class << self
    def digest(str, vector = [4, 8, 15, 16, 23])
      message_for(str).each_slice(vector.length).inject(vector) do |next_vector, next_block|
        next_vector.zip(next_block).map do |pair|
          (
            pair[0] + swap(
              (
                (pair[0] + pair[1].to_i) * 7
              ) % 100
            )
          ) % 100
        end
      end
    end

    private

    def swap(number)
      number.digits.join.to_i
    end

    def message_for(str)
      str
        .bytes
        .push(str.length)
    end
  end
end
