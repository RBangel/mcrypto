# Break repeating-key XOR
# It is officially on, now.
#
# This challenge isn't conceptually hard, but it involves actual error-prone coding. The other 
# challenges in this set are there to bring you up to speed. This one is there to qualify you. 
# If you can do this one, you're probably just fine up to Set 6.
# 
# There's a file here. It's been base64'd after being encrypted with repeating-key XOR.
# 
# Decrypt it.
# 
# Here's how:
# 
# 1. 
# Let KEYSIZE be the guessed length of the key; try values from 2 to (say) 40.
#
# 2.
# Write a function to compute the edit distance/Hamming distance between two strings. The Hamming 
# distance is just the number of differing bits. The distance between:
#
#     this is a test
#
# and
#
#     wokka wokka!!!
#
# is 37. Make sure your code agrees before you proceed.
#
# 3. 
# For each KEYSIZE, take the first KEYSIZE worth of bytes, and the second KEYSIZE worth of bytes, 
# and find the edit distance between them. Normalize this result by dividing by KEYSIZE.
#
# 4.
# The KEYSIZE with the smallest normalized edit distance is probably the key. You could proceed 
# perhaps with the smallest 2-3 KEYSIZE values. Or take 4 KEYSIZE blocks instead of 2 and average the distances.
#
# 5.
# Now that you probably know the KEYSIZE: break the ciphertext into blocks of KEYSIZE length.
#
# 6.
# Now transpose the blocks: make a block that is the first byte of every block, and a block that 
# is the second byte of every block, and so on.
#
# 7.
# Solve each block as if it was single-character XOR. You already have code to do this.
#
# 8.
# For each block, the single-byte XOR key that produces the best looking histogram is the 
# repeating-key XOR key byte for that block. Put them together and you have the key.
#
# This code is going to turn out to be surprisingly useful later on. Breaking repeating-key XOR 
# ("Vigenere") statistically is obviously an academic exercise, a "Crypto 101" thing. But more
# people "know how" to break it than can actually break it, and a similar technique breaks 
# something much more important.
# 
# No, that's not a mistake.
# We get more tech support questions for this challenge than any of the other ones. We promise, there aren't any blatant errors in this text. In particular: the "wokka wokka!!!" edit distance really is 37.

require_relative 'base_utils'
require_relative 'scores'

$DEBUG = ENV["DBG"]

def hamming_distance_for_sizes bstring, sizes_ary
  sizes_ary.map do |keysize|
    segments = 4.times.to_a.map do |segment|
      ByteString.new(bstring.bytes[segment*keysize, keysize])
    end

    hammdist1 = segments[0].hamming_distance segments[1]
    hammdist2 = segments[1].hamming_distance segments[2]
    hammdist3 = segments[2].hamming_distance segments[3]
    hammdistavg = (hammdist1 + hammdist2 + hammdist3) / 3.0

    {keysize: keysize, hammdist: hammdistavg/keysize}
  end.sort_by { |key| key[:hammdist] }
end

def best_hd_sizes hammdist_ary
  hammdist_ary[0..2].map { |m| m[:keysize] }
end

def challenge6 filename
  key_sizes = (2..40)
  file_lines = File.read(filename).lines
  file_lines.each { |l| l.chomp! }
  text = ByteString.from_b64(file_lines.join)

  sorted_diffs_map = hamming_distance_for_sizes(text, (2..40).to_a)
  potentials = best_hd_sizes sorted_diffs_map
  # puts "#{potentials}"

  toplist = []
  potentials.each do |ks|
    printf "." unless $DEBUG == "TRUE"
    puts "\nTrying size #{ks}\n#{"+"*50}" if $DEBUG == "TRUE"

    blocks = []
    index = 0
    while index < text.size
      blocks << text.bytes[index, ks]
      index += ks
    end

    puts "#{blocks}" if $DEBUG == "TRUE"

    tblocks = ks.times.to_a.map do |i|
      blocks.reduce([]) { |r, b| if b[i] then r << b[i] else r end }
    end.map { |tb| ByteString.new tb }

    puts "#{tblocks}" if $DEBUG == "TRUE"

    ks_key = ""
    tblocks.map do |tb|
      printf "." unless $DEBUG == "TRUE"
      printf("\n%s\n", tb) if $DEBUG == "TRUE"
      score = find_best_english_score tb
      printf("%s\nKey: %d  Score: %d\n", score[:line], score[:key], score[:score]) if $DEBUG == "TRUE"
      ks_key += score[:key].chr
    end
    toplist << {ks: ks, key: ks_key}
  end

  printf "\n"

  best = toplist.map do |t|
    ks = t[:ks]
    key = ByteString.new(t[:key].chars.map { |c| c.ord })
    result = Crypto.xor_with_key text, key
    score = simple_score_histogram result
    {key: key, score: score, text: result}
  end
  .sort_by { |s| s[:score] * -1 }
  .first

  if $DEBUG == "TRUE" then 
    puts "-" * 50
    puts " " * 22 + "RESULTS"
    puts "-" * 50
    puts ""
    printf "%s\n", "+" * 50
    printf "++   %40s   ++\n", best[:key]
    printf "%s\n", "+" * 50
    printf "%s\n", best[:text]
    printf "%s\n", "+" * 50
    printf "\n\n"
  end

  best[:key].to_s
end
