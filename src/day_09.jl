module day09

include("inputs.jl")

ex = inputs.ex_d9()
input = inputs.input_d9()

function parse_input(input::Vector{String})
    chars = [collect(line) for line in input]
    ints = [parse.(Int, c) for c in chars]
    permutedims(reduce(hcat, ints))
end

# part 1
neighbors_offset = [CartesianIndex(i,j) for i ∈ -1:1, j ∈ -1:1 if !(abs(i)==abs(j))]

function find_low_points(heightmap::Matrix{Int})
    low_point_vals = Vector{Int}()
    low_point_idxs = Vector{CartesianIndex}()
    for idx in CartesianIndices(heightmap)
        height = heightmap[idx]
        neighbors = [heightmap[n + idx] 
            for n in neighbors_offset 
            if checkbounds(Bool, heightmap, n+idx)]
        if all(height .< neighbors) 
            push!(low_point_vals, height)
            push!(low_point_idxs, idx)
        end
    end
    return low_point_vals, low_point_idxs
end

function part1(input)
    heightmap = parse_input(input)
    low_point_vals, _ = find_low_points(heightmap)
    return sum(1 .+ low_point_vals)
end

@assert part1(ex) == 15
@info "Day 9, Part 1:  $(part1(input))"

# part 2 - depth first search using recursion
function dfsearch!(visited, heightmap, idx)
    if !checkbounds(Bool, heightmap, idx)
        return
    elseif (idx ∈ visited || heightmap[idx] == 9)
        return
    else
        push!(visited, idx)
        for next_idx in neighbors_offset
            dfsearch!(visited, heightmap, idx + next_idx)
        end
    end
    return visited
end

function part2(input)
    heightmap = parse_input(input)
    _, low_point_indxs = find_low_points(heightmap)

    basin_sizes = Vector{Int}()
    for low_point_idx in low_point_indxs
        visited = Set{CartesianIndex}()
        basin = dfsearch!(visited, heightmap, low_point_idx)
        push!(basin_sizes, length(basin))
    end

    return reduce(*, (sort!(basin_sizes, rev=true)[1:3]))
end

@assert part2(ex) == 1134
@info "Day 9, Part 2:  $(part2(input))"

end # module