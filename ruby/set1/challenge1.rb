require_relative 'base_utils'

def challenge1(orig)
  ByteString.from_hex(orig).to_b64
end
