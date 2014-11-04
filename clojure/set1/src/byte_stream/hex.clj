(in-ns 'byte-stream.core)

(defn hex-char-value
  "Returns the value for the hex character passed in"
  [hexchar]
  (.indexOf (seq "0123456789ABCDEF") (Character/toUpperCase hexchar)))

(defn hex-pair-to-val
  "Convert both chars in a hex pair to their Base10 value"
  ([l r]
   (+ (bit-shift-left (hex-char-value l) 4) (hex-char-value r)))
  ([[l r]]
   (hex-pair-to-val l r)))

(defn hex-string-to-pairs
  "Split a string of hex values into pairs"
  [hexstring]
  (partition 2 (seq (char-array hexstring))))

(defn hex-string-to-vals
  "Convert all characters in the hex string to their corresponding values"
  [hexstring]
  (map hex-pair-to-val (hex-string-to-pairs hexstring)))

