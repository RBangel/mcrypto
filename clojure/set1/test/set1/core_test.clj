(ns set1.core-test
  (:require [clojure.test :refer :all]
            [set1.core :refer :all]))

(deftest test-char-value-low
  (testing "hex-char-value [low]"
    (is (= (hex-char-value \4) 4))))

(deftest test-char-value-high
  (testing "hex-char-value [high]"
    (is (= (hex-char-value \D) 13))))

(deftest test-hex-pair-to-val
  (testing "hex-pair-to-val"
    (is (= (hex-pair-to-val \3 \D) 61))))

(deftest test-hex-string-to-pairs
  (testing "hex-string-to-pairs"
    (is (= (hex-string-to-pairs "ABCD") [[\A \B][\C \D]]))))

(deftest test-hex-string-to-vals
  (testing 'hex-string-to-vals
    (is (= (hex-string-to-vals "ABCD1234") [171 205 18 52]))))

(deftest test-trip-to-b64vec
  (testing "trip-to-b64vec"
    (is (= (trip-to-b64vec [171 205 18]) [\q \8 \0 \S]))))

(deftest test-b64val-to-char-mid
  (testing "b64val-to-char [mid]"
    (is (= (b64val-to-char 42) \q))))

(deftest test-b64val-to-char-high
  (testing "b64val-to-char [high]"
    (is (= (b64val-to-char 60) \8))))

(deftest test-b64val-to-char-low
  (testing "b64val-to-char [low]"
    (is (= (b64val-to-char 18) \S))))

(deftest test-vals-to-b64
  (testing "vals-to-b64"
    (is (= (vals-to-b64 [171 205 18 171 205 18]) "q80Sq80S"))))
