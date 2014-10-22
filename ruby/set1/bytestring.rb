class ByteString
  attr_reader :bytes

  def initialize byte_array
    if byte_array.respond_to? :bytes then
      @bytes = byte_array.bytes
    else
      @bytes = byte_array
    end
  end

  def self.from_text string
    self.new(string.bytes)
  end

  def to_text
    bytes
    .map { |b| b.chr }
    .join
  end

  def to_ascii
    to_text
  end

  def to_s
    to_text
  end

  def self.from_hex string
    vals = string.chars.map do |nib|
      ByteString.hex_map.index nib
    end

    results = []

    while vals.size > 0
      n1, n2 = vals.shift(2)
      results << ((n1 << 4) + n2)
    end

    self.new(results)
  end

  def to_hex
    bytes.map do |b|
      f = ByteString.hex_map[(b >> 4)]
      s = ByteString.hex_map[(b & 0b00001111)]
      "#{f}#{s}"
    end.flatten.join
  end

  def self.from_b64 text
    vals = text.chars.map do |c|
      ByteString.b64_map.index c
    end

    results = []

    while vals.size > 0
      c1, c2, c3, c4 = vals.shift(4)
      r1 = (c1.to_i << 2) + (c2.to_i >> 4)
      r2 = ((c2.to_i & 0b00001111) << 4) + (c3.to_i >> 2)
      r3 = ((c3.to_i & 0b00000011) << 6) + c4.to_i
      results << r1 << r2 << r3
    end

    self.new(results)
  end

  def to_b64
    to64 = []
    valmap = bytes.dup

    while valmap.size > 0
      set = valmap.shift(3)
      first  = set[0] >> 2
      second = ((set[0] & 0b00000011) << 4) + (set[1] >> 4)
      third  = ((set[1] & 0b00001111) << 2) + (set[2] >>6)
      fourth = set[2] & 0b00111111
      to64 << first << second << third << fourth
    end

    results = ""
    to64.each do |c|
      results += ByteString.b64_map[c]
    end

    results
  end

  def self.hex_map
    "0123456789abcdef"
  end

  def self.b64_map
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  end

  def size
    bytes.size
  end

  def hamming_distance other
    return :NotEqualSize if size != other.size

    xr = bytes.zip(other.bytes).map { |f, s| f ^ s }
    hamming_weight(xr)
  end

  private

  def hamming_weight zipped_bytes
    zipped_bytes.map do |b|
      b = (((b >> 0) & 0b01010101) + ((b >> 1) & 0b01010101))
      b = (((b >> 0) & 0b00110011) + ((b >> 2) & 0b00110011))
      (((b >> 0) & 0b00001111) + ((b >> 4) & 0b00001111))
    end.reduce(:+)
  end
end
