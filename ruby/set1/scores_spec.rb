require 'rspec'
require_relative 'scores'

describe "find_best_english_score" do
  it 'finds best key' do
    result = find_best_english_score ByteString.from_hex("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736")
    expect(result[:key]).to eq(88)
  end
end

describe "score" do
  # it 'calcualtes score correctly' do
  #   test_string = "                           EEEEEEEEEEEEEEEEEEEEEEEEEETTTTTTTTTTTTTTTTTTTTTTTTTAAAAAAAAAAAAAAAAAAAAAAAAOOOOOOOOOOOOOOOOOOOOOOOIIIIIIIIIIIIIIIIIIIIIINNNNNNNNNNNNNNNNNNNNNSSSSSSSSSSSSSSSSSSSSHHHHHHHHHHHHHHHHHHHRRRRRRRRRRRRRRRRRRDDDDDDDDDDDDDDDDDLLLLLLLLLLLLLLLLCCCCCCCCCCCCCCCUUUUUUUUUUUUUUMMMMMMMMMMMMMWWWWWWWWWWWWFFFFFFFFFFFGGGGGGGGGGYYYYYYYYYPPPPPPPPBBBBBBBVVVVVVKKKKKJJJJXXXQQZ"
  #   result = simple_score_histogram test_string
  #   expect(result.to_i).to eq(7846)
  # end

  it 'credits longer text better' do
    test_string1 = "TEA"
    test_string2 = "TEAS"

    result1 = simple_score_histogram test_string1
    result2 = simple_score_histogram test_string2

    expect(result1).to be < result2
  end

  it 'creates frequency hash' do
    test_freq = {"E"=>3, "N"=>4, "C"=>3, "Y"=>2, " "=>1, "O"=>3, "B"=>2}
    result = freq_to_hist test_freq
    expect(result).to eq([["N"], ["C","E","O"], ["B","Y"], [" "]])
  end
end
