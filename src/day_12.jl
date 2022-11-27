module day12


include("inputs.jl")

ex = inputs.ex_d12()
input = inputs.input_d12()

function parse_input(input)
    function add_edge!(caves, cave1, cave2)
        if !haskey(caves, cave1)
            caves[cave1] = Vector{String}()
        end
        push!(caves[cave1], cave2)
    end

    caves = Dict{String, Vector{String}}()
    for line in input
        cave1, cave2 = String.(split(line, "-"))
        add_edge!(caves, cave1, cave2)
        add_edge!(caves, cave2, cave1)    
    end
    return caves
end

function find_paths(caves)
    paths = Vector{String}()
    frontier = [["start"]]

    while !isempty(frontier)
        path = pop!(frontier)
        cave = last(path)

        if cave == "end"
            append!(paths, path)
        else
            for next_cave in caves[cave]
                if next_cave ∉ path || isuppercase(first(next_cave))
                    push!(path, next_cave)
                    append!(frontier, path)
                end
            end
        end
    end
    return paths
end

caves = parse_input(ex)
# paths = find_paths(caves) broken

end # module