require 'rspec'
require_relative './challenge1'
require_relative './challenge2'
require_relative './challenge3'
require_relative './challenge4'
require_relative './challenge5'
require_relative './challenge6'

describe "Challenge 1" do
  it 'returns the correct response' do
    orig = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    result = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

    expect(challenge1(orig)).to eq result
  end
end

describe "Challenge 2" do
  it 'returns the correct response' do
    input_string = "1c0111001f010100061a024b53535009181c"
    xor_string = "686974207468652062756c6c277320657965"
    result_string = "746865206b696420646f6e277420706c6179"

    expect(challenge2(input_string, xor_string)).to eq result_string
  end
end

describe "Challenge 3" do
  it 'returns the correct response' do
    input_string = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    result_string = "Cooking MC's like a pound of bacon"

    expect(challenge3(input_string)).to eq result_string
  end
end

describe "Challenge 4" do
  it 'returns the correct response' do
    filename = "4.txt"
    result_string = "Now that the party is jumping\n"

    expect(challenge4(filename)).to eq result_string
  end
end

describe "Challenge 5" do
  it 'returns the correct response' do
    input_string = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"
    result_string = "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f"

    expect(challenge5(input_string)).to eq result_string
  end
end

describe "Challenge 6" do
  it 'returns the correct key' do
    filename = "6.txt"
    key = "Terminator X: Bring the noise"

    expect(challenge6(filename)).to eq key
  end
end



