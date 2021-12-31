module day14

include("inputs.jl")

ex = inputs.ex_d14()
input = inputs.input_d14()

function parse_input(input)
    template, rules_raw = split(input, "\n\n")
    rules_raw = String.(split(rules_raw, "\n"))
    rules = Dict{Tuple{Char, Char}, Char}()
    for rule in rules_raw
        pair, elem = split(rule, " -> ")
        rules[first(pair), last(pair)] = only(elem)
    end
    return template, rules
end

function part1(input)
    
    function insert(template, rules)
        """This function grows the template. Does not scale to part 2"""
    
        pairs = [template[i:i+1] for i in range(1, length(template)-1)]
        insertions = join([rules[(first(p), last(p))] for p in pairs])
    
        result = Vector{Char}()
        [append!(result, c) for c in zip(template, insertions)]
        append!(result, last(template))
        return join(result)
    end

    # insert elem and update template
    template, rules = parse_input(input)
    for _ in 1:10
        template = insert(template, rules)
    end

    # count most and least freq chars
    counts = Vector{Int}()
    for char in Set(template)
        append!(counts, count(i->i==char, template))
    end
    return abs(reduce(-, extrema(counts)))
end

@assert part1(ex) == 1588
@info "Day 14, Part 1:  $(part1(input))"


function part2(input, num_iters=40)
    
    function insert(pair_counts, rules)
        """This function updates pair counts. Better scaling."""
        next_pair_counts = Dict{Tuple{Char,Char}, Int}()
        for ((c1, c2), num) in pair_counts
            elem = rules[(c1, c2)]
            next_pair_counts[(c1, elem)] = get(next_pair_counts, (c1, elem), 0) + num
            next_pair_counts[(elem, c2)] = get(next_pair_counts, (elem, c2), 0) + num
        end
        return next_pair_counts
    end
    
    template, rules = parse_input(input)
    
    # initialize pair_counts from template
    pair_counts = Dict{Tuple{Char,Char}, Int}()
    for i in range(1, length(template)-1)
        pair = (template[i], template[i+1])
        pair_counts[pair] = get(pair_counts, pair, 0) + 1
    end

    # count the pairs after num_iters insertions
    for _ in 1:num_iters
        pair_counts = insert(pair_counts, rules)
    end

    counts = Dict{Char, Int}()
    # don't forget start and end chars
    counts[first(template)] = 1
    counts[last(template)] = 1
    # count most and least frequent chars 
    for ((c1, c2), num) in pair_counts
        counts[c1] = get(counts, c1, 0) + num
        counts[c2] = get(counts, c2, 0) + num
    end
    # pairs mean each char was double counted
    for (c, num) in counts
        counts[c] = num/2 
    end

    return reduce(-, reverse(extrema(values(counts))))
end


@assert part1(ex) == part2(ex, 10)
@assert part2(ex) == 2188189693529
@info "Day 14, Part 2:  $(part2(input))"


end  # module

