(ns set1.core
  (:require [byte-stream.core :as bs]))

(defn challenge1
  "Crypto Challenge 1-1"
  [hex-inp]
  (bs/vals-to-b64 (bs/hex-string-to-vals hex-inp)))

(defn -main
  [& args]
  (printf "** %s **\n" (challenge1 "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"))
  ;;(println (hex-string-to-vals "Abc"))
  )

