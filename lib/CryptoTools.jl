module CryptoTools
using converters
using DataStructures
function hex_xor(a,b)
    c = converters.hex_parse(a) $ converters.hex_parse(b)
    c = join(map(hex, c),"")
    return c
  end
  function ChiSqTest(obs, expt)
    if length(obs) == length(expt)
      chi2 = sum(((obs - expt).^2)./expt)
    else
      throw("Test vectors are not of same length")
    end
    return chi2
end

#function scorestring(str)
    english_freq= Dict('a' => 0.0651738, 'b' => 0.0124248, 'c' => 0.0217339,
                    'd' => 0.0349835, 'e' => 0.1041442, 'f' => 0.0197881,
                    'g' => 0.0158610, 'h' => 0.0492888, 'i' => 0.0558094,
                    'j' => 0.0009033, 'k' => 0.0050529, 'l' => 0.0331490,
                    'm' => 0.0202124, 'n' => 0.0564513, 'o' => 0.0596302,
                    'p' => 0.0137645, 'q' => 0.0008606, 'r' => 0.0497563,
                    's' => 0.0515760, 't' => 0.0729357, 'u' => 0.0225134,
                    'v' => 0.0082903, 'w' => 0.0171272, 'x' => 0.0013692,
                    'y' => 0.0145984, 'z' => 0.0007836, ' ' => 0.1918182)

#end
function xor_key(string, key)
  a = Int[]
  string = converters.hex_parse_bytes(string)
    for i = 1:length(string)
      push!(a,key $ string[i])
    end
    return a
end

function breakxor(string)
  fkey = 'a'
  chi2min = 1e10
  fin = String[]

   for key = 65:122
    v = xor_key(string, key)
    #convert vector to ASCII representation
    v = map(Char, v)
    v = map(lowercase, v)
    n = length(v) #Determine length of input string
    t = n #duplicate length for loop
    #loop below scans backwards and deletes values from the string that aren't in our alphabet of interest
    while t > 0
      if !haskey(english_freq, v[t])
        deleteat!(v,t)
      end
      t = t - 1
    end
    #make a vector of expected observations
    dind = [map(Char,collect((97:122))); ' ']
    expv = map(x->english_freq[x], dind)
    #count the number of occurences of acceptable characters
    cdict = counter(v)
    #predclare observation vector and normalise the entries from the cdict
    obsv = Float32[]
    for i = 1:27
      if haskey(cdict, dind[i])
        push!(obsv, cdict[dind[i]]/n)
      else
        push!(obsv, 0.0)
      end
    end

    if ChiSqTest(obsv, expv) < chi2min
      print("potential better key found \n")
      fkey = Char(key)
      chi2min = ChiSqTest(obsv, expv)
      print(chi2min)
      fin = join(map(Char,xor_key(string, key)),"")
      #convert vector to ASCII representation
    end
  end
  #return fkey, fin
  return fkey, fin
end
breakxor("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736")
end















end
