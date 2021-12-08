module day05

using OffsetArrays

include("inputs.jl")

ex = inputs.ex_d5()
input = inputs.input_d5()

function parse_input(input)
    # regex101.com is my friend
    rx = r"(\d+),(\d+) -> (\d+),(\d+)"
    return [parse.(Int, match(rx, line).captures) for line in input]
end


function count_overlap(input, diagonal = false)
    lines = parse_input(input)

    # compute largest "ocean floor" needed to map lines
    maxdim = maximum(maximum.(lines)) + 1
    size = (maxdim, maxdim)
    floor = OffsetArray(zeros(Int, size), -1, -1) # Python indexing

    function reorder_hv(x1, x2, y1, y2)
        if x2 < x1
            x1, x2 = x2, x1
        elseif y2 < y1
            y1, y2 = y2, y1
        end
        return x1, x2, y1, y2
    end

    for line in lines
        (x1, y1, x2, y2) = line
        # part 1 check horiz or vert lines 
        if x1 == x2 || y1 == y2
            x1, x2, y1, y2 = reorder_hv(x1, x2, y1, y2)
            floor[x1:x2, y1:y2] .+= 1
        # part 2 also consider diagonals
        elseif diagonal
            xrange = x1 > x2 ? (x1:-1:x2) : (x1:x2)
            yrange = y1 > y2 ? (y1:-1:y2) : (y1:y2)
            for (x, y) in zip(xrange, yrange)
                floor[x, y] += 1
            end
        end
    end
    return sum(length(findall(x -> x > 1, floor)))
end

part1(input) = count_overlap(input)

@assert part1(ex) == 5
@info "Day 5, Part 1:  $(part1(input))"

part2(input) = count_overlap(input, true)
@assert part2(ex) == 12
@info "Day 5, Part 2:  $(part2(input))"

end # module