module day11

include("inputs.jl")

ex = inputs.ex_d11()
input = inputs.input_d11()

CI = CartesianIndex

function parse_input(input::Vector{String})
    chars = [collect(line) for line in input]
    ints = [parse.(Int, c) for c in chars]
    permutedims(reduce(hcat, ints))
end

neig_offset = [CI(i, j) for i ∈ -1:1, j ∈ -1:1 if !(i==j==0)]

grid = parse_input(ex)

function inc!(grid, idx)
    if checkbounds(Bool, grid, idx) 
        grid[idx] += 1
    end
end

function step!(grid::Matrix{Int})

    grid .+= 1
    flashed = Set{CI}()

    while true
        flash_queue = Set{CI}()
        for ind in CartesianIndices(grid) 
            if grid[ind] > 9 && ind ∉ flashed
                push!(flash_queue, ind) 
            end
        end

        isempty(flash_queue) && break

        while !isempty(flash_queue)
            ind = pop!(flash_queue)
            push!(flashed, ind)
            [inc!(grid, ind + no) for no in neig_offset]
        end
    end
    
    for ind in flashed
        grid[ind] = 0
    end
    
    return length(flashed)
end

function part1(input)
    grid = parse_input(input)
    flashes = [step!(grid) for _ in 1:100]
    return sum(flashes)
end

@assert part1(ex) == 1656
@info "Day 11, Part 1:  $(part1(input))"

function part2(input)
    grid = parse_input(input)
    iters = 0
    while sum(grid) != 0
        step!(grid)
        iters += 1
    end
    return iters
end

@assert part2(ex) == 195
@info "Day 11, Part 1:  $(part2(input))"

end # module