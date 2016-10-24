module challenge1
  using converters
  if converters.hexto64("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")== "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    print("PASS")
  else
    print("fail")
  end
end


module challenge2
  using CryptoTools
  using converters
  x = "1c0111001f010100061a024b53535009181c"
  y = "686974207468652062756c6c277320657965"
  if  CryptoTools.hex_xor(x,y) == "746865206b696420646f6e277420706c6179"
    print("PASS")
  else
    print("FAIL")
  end
end

module challenge3
  using CryptoTools
  using converters
  print(CryptoTools.breakxor("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"))
end
