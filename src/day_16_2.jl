module day16

# include("inputs.jl")
# ex = inputs.ex_d16()
# input = inputs.input_d16()
using Parameters


function h2b(input::String)
    """Hex string to binary string according to Day 16 rules"""
    hex_8s = [parse(UInt8, input[i:i+1], base=16) for i in 1:2:length(input)]
    bin_strs = bitstring.(hex_8s)
    bin_str = reduce(*, bin_strs)
    return bin_str
end

HS = "D2FE28"
@assert h2b("D2FE28") == "110100101111111000101000"

@with_kw mutable struct BitStream
    bits::String
    index::Int = 1
end

function read(bs::BitStream, num_bits::Int)
    result = bs.bits[bs.index:bs.index+num_bits-1]
    bs.index += num_bits
    return result
end

s = h2b(HS)
bs = BitStream(bits=s)


@with_kw mutable struct Packet
    version::Int
    type_id::Int
    subpackets::Vector{Packet} = []
    literal::Union{Int,Nothing} = nothing
end


function parse_bitstream(bs::BitStream)
    """parse a bit stream into a packet"""

    # header
    version = parse(Int, read(bs, 3), base=2)
    type_id = parse(Int, read(bs, 3), base=2)

    if type_id == 4  # literal
        keep = ""
        while read(bs, 1) == "1"
            keep *= read(bs, 4)
        end
        keep *= read(bs, 4) # read last nibble, starts w '0'
        literal = parse(Int, keep, base=2)
        packet = Packet(
            version=version,
            type_id=type_id,
            literal=literal,
        )

        return packet
    else  # operator
        lenTypeID = read(bs, 1)

        if lenTypeID == "0"
            # process subpackets as string-to-bs_end
            len = parse(Int, read(bs, 15), base=2)
            bs_end = bs.index + len
            subpackets = Vector{Packet}()
            while true
                subpacket = parse_bitstream(bs)
                push!(subpackets, subpacket)
                if bs.index >= bs_end
                    break
                end
            end
            packet = Packet(
                version=version,
                type_id=type_id,
                subpackets=subpackets,
            )
            return packet
        else
            # process number of indicated subpackets
            num_subpackets = parse(Int, read(bs, 11), base=2)

            subpackets = []
            while length(subpackets) < num_subpackets
                subpacket = parse_bitstream(bs)
                push!(subpackets, subpacket)
            end
            packet = Packet(
                version=version,
                type_id=type_id,
                subpackets=subpackets,
            )
            return packet
        end
    end
end

# contains two subpackets (with lenTypeID="0")
bs2 = BitStream(bits=h2b("38006F45291200"))
p2 = parse_bitstream(bs2)
# write an accessor to pull out literals of subpackets for unit tests

# contains three subpackets (with lenTypeID="1")
bs3 = BitStream(bits=h2b("EE00D40C823060"))
p3 = parse_bitstream(bs3)



end  # module


