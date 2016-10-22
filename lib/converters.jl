module converters

  function hex_parse(s::String)
    if ismatch(r"/[^0-9A-Fa-f]/",s)
      throw("input is not a hex string!")
    else
      p = [parse(Int, s[i], 16) for i in collect(1:(length(s)))]
      return p
    end
  end

  function hex_parse_bytes(s::String)
    if ismatch(r"/[^0-9A-Fa-f]/",s)
      throw("input is not a hex string!")
    else
      p = [parse(Int, s[i:i+1], 16) for i in collect(1:2:(length(s)-1))]
      return p
    end
  end

  function hex_to_bytes(s)
    if ismatch(r"/[^0-9A-Fa-f]/",s)
      throw("input is not a hex string!")
    else
        p = [parse(Int, s[i:i+1], 16) for i in collect(1:2:(length(s)-1))]
      return p
    end
  end

  function hexto64(t)
    value = split(t,"")
    l = [parse(Int,value[i],16) for i in collect(1:length(value))]
    l = map(x->(bin(x,4)), l)
    l =join(l,"")

    if length(l)/8 % 3 !=0
      padl = 3- length(l)/8 % 3
      padl = Int(padl*8)
      l = join(l*repeat("0",padl),"")
    end

    l = [l[i:i+5] for i in collect(1:6:length(l)-5)]
    l=  map(x->parse(Int,x,2),l)
    digsyms = [collect('A':'Z') ; collect('a':'z') ; '0':'9'; '+';'/';'=']
  #to encode the padding
    for c = 1:length(l)
      if l[c] == 0
        l[c] = 64
      end
    end

    l=[l[i] = digsyms[l[i]+1] for i = 1:length(l)]
    l=join(l,"")

    return l
  end

end
