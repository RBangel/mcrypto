require 'rspec'
require_relative './bytestring'

describe "ByteString" do
  it 'can convert b64 to hex' do
    orig = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    result = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
  
    response = ByteString.from_b64(orig).to_hex
    expect(response).to eq result
  end
end
