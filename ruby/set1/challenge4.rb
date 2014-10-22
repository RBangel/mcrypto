# Detect single-character XOR
# One of the 60-character strings in 4.txt has been encrypted by single-character XOR.

# Find it.

# (Your code from #3 should help.)

require_relative 'base_utils'
require_relative 'scores'

def challenge4(filename)
  ln = 0
  possibles = []

  f = File.open(filename).each_line do |line|
    line.chomp!
    break if line == nil || line.size == 0

    line = ByteString.from_hex line
    ln += 1

    printf "."

    score = find_best_english_score(line)
    possibles << {ln: ln, info: score}
  end

  printf "\n"

  possibles
    .sort_by { |p| -1 * p[:info][:score] }
    .first[:info][:line].to_s
end