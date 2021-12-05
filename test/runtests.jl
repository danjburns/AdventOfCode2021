using Test

using AdventOfCode2021:day01
@testset "Day 1" begin
    @test day01.part1(day01.input) == 1154 
    @test day01.part2(day01.input) == 1127
end
