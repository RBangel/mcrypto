/// Convert hex to base64
/// The string:
///
///     49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d
///
/// Should produce:
///
///     SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t
///
/// So go ahead and make that happen. You'll need to use this code for the rest of the exercises.
///
/// Cryptopals Rule
/// Always operate on raw bytes, never on encoded strings. Only use hex and base64 for pretty-printing.

use std::os;
use std::fmt;

static HEXMAP: &'static str = "0123456789ABCDEF";
static BASE64MAP: &'static str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

#[deriving(PartialEq)]
struct Byte {
  value: int,
}

impl Byte {
  fn to_hex(&self) -> (char, char) {
    let lv = self.value >> 4;
    let rv = self.value & 0b00001111;
    let hmap = HEXMAP.as_slice();
    let lc = hmap.char_at(lv as uint);
    let rc = hmap.char_at(rv as uint);
    (lc, rc)
  }

  fn from_hex(inchar: (char, char)) -> Byte {
    let lc = inchar.val0();
    let rc = inchar.val1();
    let hmap = HEXMAP.as_slice();
    let lv = hmap.find(lc);
    let rv = hmap.find(rc);
    let result = (lv.unwrap() << 4) + (rv.unwrap());
    Byte { value: result as int }
  }
}

impl fmt::Show for Byte {
  fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
    self.value.fmt(f)
  }
}

#[deriving(PartialEq)]
struct ByteString {
  bytes: Vec<Byte>,
}

impl ByteString {
  fn to_hex(&self) -> String {
    let mut hex_string = String::new();
    for b in self.bytes.iter() {
      let (l, r) = b.to_hex();
      hex_string.push(l);
      hex_string.push(r);
    }

    hex_string
  }

  fn from_hex(hexstr: &str) -> ByteString {
    let mut result = vec!();

    for pair in hexstr.as_bytes().chunks(2) {
      let val1:char = pair[0] as char;
      let val2:char = pair[1] as char;
      let val = Byte::from_hex((val1, val2));
      result.push(val)
    }

    ByteString { bytes: result }
  }

  fn to_b64(&self) -> String {
    String::from_str("ABC")
  }
}

// impl TotalEq for ByteString {
//   fn equals(&self, other: &Self) -> bool {
//     self.bytes == other.bytes
//   }
// }

// fn hex_to_bytestring(hexstr: &str) {
//   let res: Vec<uint> = hexstr.as_slice().chars().map(|x| x.to_uppercase()
//   ).map(|x| x.to_digit(16)).collect(); // .collect::<Vec<uint>>();
// 
//   // res = res.iter().map(|x| x.to_digit(16));
// 
//   println!("{}", res);
// }
// 
// fn main() {
//   let inp = os::args();
//   let r = inp[1].as_slice();
//   // println!("{}", hex_to_bytestring(inp))
//   hex_to_bytestring(r)
// }
// 

#[test]
fn test_hexmap_size() {
  if HEXMAP.len() != 16 {
    fail!("HEXMAP is the wrong size!");
  }
}

#[test]
fn test_b64map_size() {
  if BASE64MAP.len() != 64 {
    fail!("BASE64MAP is the wrong size!");
  }
}

#[test]
fn test_to_hex_low() {
  let test_val = Byte { value: 9 };
  if test_val.to_hex() != ('0','9') {
    fail!("Byte{9}.to_hex() Should be ('0', '9')");
  }
}

#[test]
fn test_to_hex_high() {
  let test_val = Byte { value: 123 };
  if test_val.to_hex() != ('7','B') {
    fail!("Byte{123}.to_hex() Should be ('7', 'B')");
  }
}

#[test]
fn test_bs_to_hex() {
  let a = Byte { value: 171 };
  let b = Byte { value: 205 };
  let c = Byte { value: 239 };
  let test_bstring = ByteString {bytes: vec!(a, b, c)};
  let results = test_bstring.to_hex();
  if results != String::from_str("ABCDEF") {
    fail!("ByteString(171, 205, 239).to_hex() should be \"ABCDEF\", not {}",
    results);

  }
}

#[test]
fn test_bs_from_hex() {
  let teststr = "ABC123";
  let a = Byte { value: 171 };
  let b = Byte { value: 193 };
  let c = Byte { value: 35 };
  let expected = ByteString {bytes: vec!(a, b, c)};
  let results = ByteString::from_hex(teststr); 
  if results != expected {
    fail!("hex 'ABC123' should result in ByteString(171, 193, 35)");
  }
}

fn main() {
  let a = Byte { value: 19 };
  println!("Result:  {}", a.to_hex())
}
