(ns set1.core)

;; (require [clojure.string :as str])

(defn hex-char-value
  "Returns the value for the hex character passed in"
  [hexchar]
  (.indexOf (seq "0123456789ABCDEF") hexchar))

(defn hex-string-to-vals
  "Convert all characters in the hex string to their corresponding values"
  [hexstring]
  (map hex-char-value (seq (clojure.string/upper-case hexstring))))

(defn rhex
  [s]
  (map #(apply println %) (partition 2 s)))

(defn challenge1
  "Crypto Challenge 1-1"
  [hex-inp]
  (rhex hex-inp))

(defn -main
  [& args]
  ;; (printf "** %s **\n" (challenge1 "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"))
  (println (hex-string-to-vals "Abc")))

(challenge1 "ABCD")
(println (Character/digit \E 16))
