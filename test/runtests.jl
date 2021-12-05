using Test

using AdventOfCode2021:day01
@testset "Day 1" begin
    @test day01.part1(day01.input) == 1154 
    @test day01.part2(day01.input) == 1127
end

using AdventOfCode2021:day02
@testset "Day 2" begin
    @test day02.part1(day02.input) == 1813801
    @test day02.part2(day02.input) == 1960569556
end

using AdventOfCode2021:day03
@testset "Day 3" begin
    @test day03.part1(day03.input) == 4147524
    @test day03.part2(day03.input) == 3570354
end

