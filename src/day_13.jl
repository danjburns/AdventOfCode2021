module day13

# using OffsetArrays didn't work because folding changes size of arrays
using SparseArrays
using Colors
using UnicodePlots

include("inputs.jl")

ex = inputs.ex_d13()
input = inputs.input_d13()

function parse_input(input)
    # add one to each index, can't use OffsetArrays for this problem
    dots_raw, insts_raw = split(input, "\n\n")
    dots = [parse.(Int,d) .+ 1 for d in split.(split(dots_raw, "\n"), ",")]
    paper = sparse(last.(dots), first.(dots), true)

    # parse folding instructions as namedtuple: (axis, offset)
    insts_raw = String.(split(insts_raw, "\n"))
    insts = [(axis = i[12], line=parse(Int, i[14:end])+1) for i in insts_raw]

    return paper, insts
end

function fold(paper, inst) 
    if inst.axis == 'y'
        if iseven(size(paper, 1))
            vcat(paper[1:1,:], paper[2:inst.line-1,:] .| reverse(paper[inst.line+1:end, :], dims=1))
        else
            paper[1:inst.line-1,:] .| reverse(paper[inst.line+1:end, :], dims=1)
        end
    else
        if iseven(size(paper, 2))
            paper[:,1:inst.line-1] .| reverse(paper[:, inst.line+1:end], dims=2)
        else
            paper[:,1:inst.line-1] .| reverse(paper[:, inst.line+1:end], dims=2)
        end
    end
end

function part1(input)
    paper, insts = parse_input(input)
    paper = fold(paper, insts[1])
    return sum(paper)
end

@assert part1(ex) == 17
@info "Day 13, Part 1:  $(part1(input))"

function part2(input)
    paper, insts = parse_input(input)
    for inst in insts
        paper = fold(paper, inst)
    end
    return paper
end

@info "Day 13, Part 2:"
display(heatmap(reverse(part2(input), dims=1)))

# alt vis.
# using Colors 
# [g ? RGB(1, 0, 0) : RGB(0, 0, 0) for g in day13.out]

end # module