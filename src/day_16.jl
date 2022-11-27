module day16

# include("inputs.jl")
# ex = inputs.ex_d16()
# input = inputs.input_d16()



function h2b(input::String)
    """Hex string to binary string according to Day 16 rules"""
    hex_8s = [parse(UInt8, input[i:i+1], base=16) for i in 1:2:length(input)]
    bin_strs = bitstring.(hex_8s)
    bin_str = reduce(*, bin_strs)
    return bin_str
end

HS = "D2FE28"
@assert h2b(HS) == "110100101111111000101000"

get_ver(p::String) = parse(Int, p[1:3], base=2)
get_typeID(p::String) = parse(Int, p[4:6], base=2)

function get_literal(p::String)
    """Decode literal value from packet"""
    @assert get_typeID(p) == 4 "Incorrect packet type!"
    
    pointer = 7
    payload = p[pointer:end]
    parts = [payload[i:i+4] for i in 1:5:5fld(length(payload), 5)]

    # build literal as bitstring, stop when nibble leads w/ a '0'
    keep = ""
    for part in parts
        keep *= part[2:end]
        pointer += 5
        part[1] == '0' && break
    end

    rest = all([c=='0' for c in p[pointer:end]]) ? nothing : p[pointer:end]

    # return literal and any unparsed string (may be another subpacket)
    return (parse(Int, keep, base=2), rest)
end

get_literal("110100101111111000101000")
@assert first(get_literal("110100101111111000101000")) == 2021

function parse_operator(p::String)
    @assert get_typeID(p) != 4 "Incorrect packet type!"
    lenTypeID = p[7]

    pointer = 8
    if lenTypeID == '0'
        # process subpackets until string is exhausted
        len = parse(Int, p[8:22], base=2)
        
        pointer += 15
        subpackets_str = p[pointer:pointer+len-1] # string of subpackets
        subpackets = []
        while !isempty(subpackets_str)
            val, subpackets_str = get_literal(subpackets_str)
            push!(subpackets, val)
        end
    else
        # process number of indicated subpackets
        num_subpackets = parse(Int, p[8:18], base=2)
        
        pointer += 11
        subpackets_str = p[pointer:end] # string of subpackets
        subpackets = []
        for _ in 1:num_subpackets
            val, subpackets_str = get_literal(subpackets_str)
            push!(subpackets, val)
        end
    end
    return subpackets
end


@assert parse_operator(h2b("38006F45291200")) == [10, 20]
@assert parse_operator(h2b("EE00D40C823060")) == [1, 2, 3]

function dispatch(p::String)
    type = get_typeID(p)

    if type == 4
        println("Dispatching to get_literal")
        literal, rest = get_literal(p)
        println(literal)
        if !isnothing(rest)
            dispatch(rest)
        end
    else
        println("Not implemented yet")
        # subpackets = parse_operators(p)
    end
end





end  # module





"""
     v
11101110000000001101010000001100100000100011000001100000
VVVTTTILLLLLLLLLLLAAAAAAAAAAABBBBBBBBBBBCCCCCCCCCCC
"""

"""
literals = Vector{Int}()
while !isempty(subpackets)
    val, subpackets = get_literal(subpackets)
    push!(literals, val)
end
@assert literals == [10, 20]


subpackets = parse_operator(h2b("EE00D40C823060"))
literals = Vector{Int}()
while !isempty(subpackets)
    val, subpackets = get_literal(subpackets)
    push!(literals, val)
end
@assert literals == [1, 2, 3]
"""




"""



110100010100101001000100100
1101000101001010010001001000000000
AAAAAAAAAAABBBBBBBBBBBBBBBB

101111111000101000
101111111000101000
AAAAABBBBBCCCCC


00111000000000000110111101000101001010010001001000000000
00111000000000000110111101000101001010010001001000000000
VVVTTTILLLLLLLLLLLLLLLAAAAAAAAAAABBBBBBBBBBBBBBBB

"""