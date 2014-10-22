# Fixed XOR
# Write a function that takes two equal-length buffers and produces their XOR combination.
# 
# If your function works properly, then when you feed it the string:
# 
# 1c0111001f010100061a024b53535009181c
# ... after hex decoding, and when XOR'd against:
# 
# 686974207468652062756c6c277320657965
# ... should produce:
# 
# 746865206b696420646f6e277420706c6179

require_relative './base_utils'

def challenge2(input_str, xor_str)
  sin = ByteString.from_hex input_str
  xin = ByteString.from_hex xor_str
  Crypto.xor_with_key(sin, xin).to_hex
end
