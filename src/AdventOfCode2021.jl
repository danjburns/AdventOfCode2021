module AdventOfCode2021
using Printf: @sprintf

@info "Advent of Code 2021, Dan Burns"
@info ""

for day in 25:-1:1
    filename = @sprintf("day_%02d.jl", day)
    path = joinpath(@__DIR__, filename)
    isfile(path) && println("Loading file: ", filename)
    isfile(path) && include(path)
end

end
