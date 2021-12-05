module day01

include("inputs.jl")
ex = inputs.ex_d1()
input = inputs.input_d1()

part1(input) = sum(
    [curr > prev for (curr, prev) in zip(input[2:end], input)]
)

@assert part1(ex) == 7
@info "Day 1, Part 1:  $(part1(input))"


part2(input) = sum(
    [curr > prev for (curr, prev) in zip(input[4:end], input)]
)

@assert part2(ex) == 5
@info "Day 1, Part 2:  $(part2(input))"

end # module day01