require_relative 'base_utils'

$english_freq_order = [" ", "E", "T", "A", "O", "I", "N", "S", "H", "R", "D", "L", "C", "U", "M", "W", "F", "G", "Y", "P", "B", "V", "K", "J", "X", "Q", "Z"]

def letter_frequency string
  freq = {}
  string.upcase.chars.each { |l| freq[l] = freq[l].to_i + 1 }
  freq
end

def simple_score_histogram string
  freq = letter_frequency string.to_s
  mask = $english_freq_order.dup
  pos_mod = 10

  hist = freq_to_hist freq
  base_size = mask.size + 1

  mask.each { |m| mask.delete m if not hist.flatten.include? m }

  hist.each do |set|
    set.each do |l|
      if l.ord < 32 ||  l.ord > 127 then
        pos_mod -= (base_size / 2)
      elsif mask.include? l then
        pos_mod += (base_size - mask.index(l))
      end
    end

    set.each do |l|
      mask.delete l
    end
  end

  pos_mod
end

# def old_simple_score_histogram string
#   freq = letter_frequency string.to_s
#   mask = $english_freq_order.dup
#   pos_mod = 10

#   hist = freq_to_hist freq
#   base_size = mask.size + 1

#   mask.each { |m| mask.delete m if not hist.flatten.include? m }

#   hist.each do |set|
#     set.each do |l|
#       if mask.include? l then
#         pos_mod *= (((base_size - mask.index(l)) / 100.0) + 1)
#       end
#     end

#     set.each do |l|
#       mask.delete l
#     end
#   end

#   pos_mod
# end

def freq_to_hist freq_hash
  sorted = Hash[freq_hash.sort_by { |p| -1 * p.last }]
  result = []

  while sorted.size > 0
    f = sorted.values.first
    t = sorted.select { |k, v| v == f }.map { |k, v| k }
    t.each { |c| sorted.delete c }
    result << t.sort
  end

  result
end

def english_score input
  input.chars.reduce(0) do |r, c|
    r += 1 if (('A'..'Z').include?(c) || ('a'..'z').include?(c) || ('0'..'9').include?(c))
    r += 3 if ("ETAOIN SHRDLU".include? c)
    r
  end
end

def find_best_english_score input_string
  best = (0..255)
    .to_a
    .map do |c|
      output = Crypto.xor_with_key input_string, c.chr
      possibles = {key: c, score: simple_score_histogram(output), line: output}
    end
    .sort_by { |p| -1 * p[:score] }
    .first

    # .tap do |p|
    #   p.take(10).each do |c|
    #     printf "(%c) %d - %s\n", c[:key], c[:score], c[:line]
    #   end
    # end


  {score: best[:score], line: best[:line], key: best[:key] }
end





