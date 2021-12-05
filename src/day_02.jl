module day02

include("inputs.jl")

ex_raw = inputs.ex_d2()
inputs_raw = inputs.input_d2()


function parse_input(input)
    parse_line(line) =
        let parts = split(line, " ")
            return Symbol(parts[1]), parse(Int, parts[2])
        end
    return parse_line.(input)
end
ex = parse_input(ex_raw)

abstract type Submarine end


# Part 1
mutable struct SimpleSub <: Submarine
    horiz::Int
    depth::Int
end

function forward!(sub::SimpleSub, x::Int)
    sub.horiz += x
end

function down!(sub::SimpleSub, x::Int)
    sub.depth += x
end

function up!(sub::SimpleSub, x::Int)
    sub.depth -= x
end

function follow_commands(sub::Submarine, commands)

    dispatch_map = Dict(
        :forward => forward!,
        :down => down!,
        :up => up!,
    )

    for (dirn, amount) in commands
        dispatch_map[dirn](sub, amount)
    end

    return sub.horiz * sub.depth
end

function part1(input)
    sub = SimpleSub(0, 0)
    return follow_commands(sub, input)
end

@assert part1(ex) == 150
input = parse_input(inputs_raw)
@info "Day 2, Part 1:  $(part1(input))"


# Part 2
mutable struct AimableSub <: Submarine
    horiz::Int
    depth::Int
    aim::Int
end

function forward!(sub::AimableSub, x::Int)
    sub.horiz += x
    sub.depth += sub.aim * x
end

function down!(sub::AimableSub, x::Int)
    sub.aim += x
end

function up!(sub::AimableSub, x::Int)
    sub.aim -= x
end

function part2(input)
    sub = AimableSub(0, 0, 0)
    return follow_commands(sub, input)
end

@assert part2(ex) == 900
@info "Day 2, Part 2:  $(part2(input))"

end # module day02