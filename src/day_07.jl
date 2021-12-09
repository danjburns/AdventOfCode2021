module day07

include("inputs.jl")

ex = inputs.ex_d7()
input = inputs.input_d7()

# part 1
# problem is to find the offset that minimizes an L1 norm. 
# spoiler: in 1-d, this is the median.

cost_p1(position, candidate) = sum(abs(position - candidate))

function find_min_cost(positions, cost_func)
    lo, hi = extrema(positions)
    costs  = []
    for candidate in lo:hi
        push!(costs, sum(p -> cost_func(p, candidate), positions))
    end
    (min_cost, _) = findmin(costs)
    return min_cost
end

part1(input) = find_min_cost(input, cost_p1)
@assert part1(ex) == 37
@info "Day 7, Part 1:  $(part1(input))"

# part 2
# find min cost with an L2-like norm (it's not quite L2)
# intuition says this should just be the mean, but since the domain is
# discrete, may have to check neighbors. Or brute force it by checking 
# all candidates in range. 

cost_p2(position, candidate) = sum(1:abs(position - candidate))

part2(input) = find_min_cost(input, cost_p2)
@assert part2(ex) == 168
@info "Day 7, Part 2:  $(part2(input))"

end # module