module day04

include("inputs.jl")

ex = inputs.ex_d4()
input = inputs.input_d4()

function parse_input(input)
    # unpack the input lines
    strnumbers, _, strgrids... = input
    
    # parse the numbers
    numbers = parse.(Int, split(strnumbers, ","))

    # parse the grids
    # 1. flatten each grid into 1-d array of strings
    flatgrids_str = split.(join.(split.(split(join(strgrids,"\n"),"\n\n"),"\n")," "))
    # 2. convert elems from string to ints
    flatgrids = [parse.(Int, el) for el in flatgrids_str]
    # 3. reshape into 5x5 arrays
    grids = [reshape(grd, (5, 5)) for grd in flatgrids]
    # 4. transpose boards to match description
    grids = [permutedims(brd) for brd in grids]

    return numbers, grids
end

mutable struct Board
    grid::Matrix{Int}
    nrow::Int
    ncol::Int
    row_sum::Vector{Int}
    col_sum::Vector{Int}
    marked::Matrix{Bool}
    function Board(grid)
        nr, nc = size(grid)
        new(grid, nr, nc, zeros(nr), zeros(nc), falses(nr,nc))
    end
end


function mark!(board::Board, number::Int)
    if number in board.grid
        idx = findall(x->x==number, board.grid) |> only
        board.marked[idx] = true
        board.row_sum[idx[1]] += 1
        board.col_sum[idx[2]] += 1
    end
    return nothing
end

function iswinner(board::Board)
    if any([rs == board.nrow for rs in board.row_sum])
        return true
    elseif any([cs == board.ncol for cs in board.col_sum])
        return true
    else
        return false
    end
end

score(board::Board, number::Int) = number * sum(board.grid .* .!board.marked)

# function play(numbers, boards)
#     for number in numbers
#         for board in boards
#             mark!(board, number)
#             iswinner(board) && return score(board, number)
#         end
#     end
# end


function part1(input)
    numbers, grids = parse_input(input)
    boards = [Board(grid) for grid in grids]
    for number in numbers
        for board in boards
            mark!(board, number)
            iswinner(board) && return score(board, number)
        end
    end
end

@assert part1(ex) == 4512
@info "Day 4, Part 1:  $(part1(input))"

function part2(input)
    numbers, grids = parse_input(input)
    boards = Set([Board(grid) for grid in grids])
    for number in numbers
        to_remove = Set()
        for (i, board) in enumerate(boards)
            mark!(board, number)
            if iswinner(board) && length(boards) == 1
                return score(board, number)
            elseif iswinner(board)
                push!(to_remove, board)
            end
        end
        setdiff!(boards, to_remove)
    end
    return to_remove
end

@assert part2(ex) == 1924
@info "Day 4, Part 2:  $(part2(input))"

end # module