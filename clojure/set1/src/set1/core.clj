(ns set1.core)

(require '[clojure.string :as str])

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

(defn b64val-to-char
  "Returns the character for an index value"
  [b64val]
  (nth (seq "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/") b64val))

(defn trip-to-b64vec
  ([[a b c]]
   (vector
     (b64val-to-char (bit-shift-right a 2))
     (b64val-to-char (+ (bit-shift-left (bit-and a 2r00000011) 4) (bit-shift-right b 4)))
     (b64val-to-char (+ (bit-shift-left (bit-and b 2r00001111) 2) (bit-shift-right c 6)))
     (b64val-to-char (bit-and c 2r00111111))
    )))

(defn vals-to-b64
  [vecvals]
  (str/join (flatten (map trip-to-b64vec (partition 3 vecvals)))))

(defn challenge1
  "Crypto Challenge 1-1"
  [hex-inp]
  (vals-to-b64 (hex-string-to-vals hex-inp)))

(defn -main
  [& args]
  (printf "** %s **\n" (challenge1 "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"))
  ;;(println (hex-string-to-vals "Abc"))
  )

