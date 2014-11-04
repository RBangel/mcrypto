(in-ns 'byte-stream.core)

(require '[clojure.string :as str])

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

