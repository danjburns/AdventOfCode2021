module day03

using Pipe

include("inputs.jl")

ex = inputs.ex_d3()
input = inputs.input_d3()

# Part 1
parse_input(input) = @pipe collect.(input) |>
                           hcat(_...) |>
                           permutedims |>
                           parse.(Int, _)  # 2D array of Ints

function calc_power(report)

    function most_common_bit(report)
        bin = zeros(Int, size(report, 2))
        for (i, col) in enumerate(eachcol(report))
            numones = count(col .== 1)
            numzeros = count(col .== 0)
            bin[i] = numones > numzeros ? 1 : 0
        end
        return bin
    end

    γ_bin = most_common_bit(report)
    ϵ_bin = 1 .- γ_bin

    γ = parse(Int, join(γ_bin), base = 2)
    ϵ = parse(Int, join(ϵ_bin), base = 2)

    return γ * ϵ
end

part1(input) = calc_power(parse_input(input))

@assert part1(ex) == 198
@info "Day 3, Part 1:  $(part1(input))"


function calc_rating(report; use_most_common_bit = true)
    inds = collect(1:size(report, 1))
    for col in eachcol(report)

        numones = count(col[inds] .== 1)
        numzeros = count(col[inds] .== 0)
        most_common_bit = numones >= numzeros ? 1 : 0
        least_common_bit = 1 - most_common_bit
        bit_to_use = use_most_common_bit ? most_common_bit : least_common_bit

        predicate(index) =
            index ∈ inds && col[index] == bit_to_use ? true : false

        if length(inds) > 1
            filter!(predicate, inds)
        end
    end
    
    return parse(Int, join(report[inds, :]), base = 2)
end

function part2(input_raw)

    input = parse_input(input_raw)
    O₂rating = calc_rating(input)
    CO₂rating = calc_rating(input, use_most_common_bit = false)

    return O₂rating * CO₂rating
end

@assert part2(ex) == 230
@info "Day 3, Part 2:  $(part2(input))"

end