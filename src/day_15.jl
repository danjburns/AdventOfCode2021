module day15

using DataStructures

include("inputs.jl")
ex = inputs.ex_d15()
input = inputs.input_d15()

parse_input(input) = parse.(Int, mapreduce(collect, hcat, input)) |> permutedims

function find_min_risk(M::Matrix{Int})

    CI = CartesianIndex
    indxs = CartesianIndices(M)
    START = first(indxs)
    GOAL = last(indxs)
    Δs = [CI(i,j) for i ∈ -1:1 for j ∈ -1:1 if abs(i)!=abs(j)]  # [←, ↓, →, ↑]
    visited = Set{CI}()
    push!(visited, START)

    # tracks cost of path from START to any index visited
    cost_to_go = fill(99999, size(M)) 
    pq = PriorityQueue{CI, Int}()
    enqueue!(pq, START=>0)

    while true
        # get next index and ctg from priority queue
        here, cost_to_go_cand = peek(pq) # awkward to get key *and* val 
        _ = dequeue!(pq)                 # from priority queue

        # does this candidate result in a lower cost-to-go?
        if cost_to_go[here] <= cost_to_go_cand
            continue  
        else
            cost_to_go[here] = cost_to_go_cand
        end

        # reached the goal, exit
        here == GOAL && return cost_to_go[GOAL]

        # add adjacent indexes to the priority queue
        for next in filter(x->x ∈ indxs, Ref(here) .+ Δs)
            if next ∉ visited
                push!(pq, next => cost_to_go_cand + M[next])
                push!(visited, next)
            end
        end
    end
end

part1(input) = find_min_risk(parse_input(input))

@assert part1(ex) == 40
@info "Day 15, Part 1:  $(part1(input))"

function tile_map(M::Matrix{Int})
    return hvncat((5,5), false, [@. mod1(M+i+j, 9) for i=0:4, j=0:4]...)
end

part2(input) = find_min_risk(tile_map(parse_input(input)))

@assert part2(ex) == 315
@info "Day 15, Part 2:  $(part2(input))"

end # module