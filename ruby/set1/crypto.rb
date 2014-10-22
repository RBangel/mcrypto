require_relative 'bytestring.rb'

class Crypto
  def self.xor_with_key string, key
    str_bs = string
    key_bs = key

    str_index = 0
    key_index = 0
    results = []

    while str_index < str_bs.size
      results << (str_bs.bytes[str_index] ^ key_bs.bytes[key_index])
      str_index += 1
      key_index += 1
      key_index = 0 if key_index >= key_bs.size
    end

    ByteString.new(results)
  end
end