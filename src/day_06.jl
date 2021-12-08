module day06

using OffsetArrays

include("inputs.jl")

ex = inputs.ex_d6()
input = inputs.input_d6()


"""
Part 1 approach works but doesn't scale to Part 2. 
Leaving this code for posterity, but it's not good.
"""

function step!(input)

    # decrement each element
    input .-= 1

    # test if any are minus one 
    indexes = findall(x->x==-1, input)

    # if so, reset countdown and spawn new fish
    if !isempty(indexes)
        for ind in indexes
            input[ind] = 6 
            push!(input, 8)
        end
    end
    return input
end

function part1_old(input)
    state = copy(input)
    for _ in 1:80
        step!(state)
    end
    return length(state)
end


# attempt #2: using array and slicing
function model_growth(input; num_steps=80)

    # state index is time-to-spawn 
    # and val is num fish with that time
    state = OffsetArray(zeros(Int, 9), -1)

    # initialize state
    for time in input
        state[time] += 1
    end

    function step(state)
        next_state = OffsetArray(zeros(Int, 9), -1)

        # shift counts down w/ array slicing
        next_state[0:7] = state[1:8]

        # spawn new fish
        num_spawnning = state[0]
        if num_spawnning != 0
            next_state[6] += num_spawnning
            next_state[8] += num_spawnning
        end
        return next_state
    end

    for _ in 1:num_steps
        state = step(state)
    end

    return sum(state)
end

part1(input) = model_growth(input)
part2(input) = model_growth(input, num_steps=256)

@assert part1(ex) == 5934
@info "Day 6, Part 1:  $(part1(input))"

@assert part2(ex) == 26984457539 
@info "Day 6, Part 1:  $(part2(input))"

end  # module