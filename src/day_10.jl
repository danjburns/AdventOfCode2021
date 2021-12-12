module day10

using Statistics: median

include("inputs.jl")

ex = inputs.ex_d10()
input = inputs.input_d10()

# part 1 - find valid chuncks with FILO buffer (stack)

tokens = Dict(  # maps opening token to corresponding closing token
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>',
)

function check_line(line, complete_line=false)
    stack = Vector{Char}()
    is_valid = true
    for ch in line
        if ch ∈ keys(tokens)
            push!(stack, ch)
        else
            expected = tokens[pop!(stack)]
            if ch == expected
                continue
            elseif !complete_line
                return ch
            elseif complete_line
                is_valid = false
            end
        end
    end
    if complete_line && is_valid
        return [tokens[c] for c in reverse(stack)]
    end
end

illegal_char_points = Dict(
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137,
)

function part1(input)
    illegal_chars = filter(!isnothing, [check_line(l) for l in input])
    reduce(+, [illegal_char_points[ic] for ic in illegal_chars])
end

@assert part1(ex) == 26397
@info "Day 10, Part 1:  $(part1(input))"


# part 2 - complete the missing chars
incomplete_char_points = Dict(
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4,
)

function score_incomplete(chars)
    total_score = 0
    for c in chars
        total_score *= 5
        total_score += incomplete_char_points[c]
    end
    return total_score
end


function part2(input)
    incomplete_chars = filter(!isnothing, [check_line(l, true) for l in input])
    scores = [score_incomplete(chars) for chars in incomplete_chars]
    sort!(scores)
    return Int(median(scores))
end 

@assert part2(ex) == 288957
@info "Day 10, Part 2:  $(part2(input))"

end # module