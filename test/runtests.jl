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

using AdventOfCode2021:day04
@testset "Day 4" begin
    @test day04.part1(day04.input) == 35670
    @test day04.part2(day04.input) == 22704
end

using AdventOfCode2021:day05
@testset "Day 5" begin
    @test day05.part1(day05.input) == 7674
    @test day05.part2(day05.input) == 20898
end

using AdventOfCode2021:day06
@testset "Day 6" begin
    @test day06.part1(day06.input) == 350917
    @test day06.part2(day06.input) == 1592918715629
end

using AdventOfCode2021:day07
@testset "Day 7" begin
    @test day07.part1(day07.input) == 348664
    @test day07.part2(day07.input) == 100220525
end

