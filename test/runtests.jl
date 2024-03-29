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

using AdventOfCode2021:day08
@testset "Day 8" begin
    @test_skip day08.part1(day08.input) == 0
    @test_skip day08.part2(day08.input) == 0
end

using AdventOfCode2021:day09
@testset "Day 9" begin
    @test day09.part1(day09.input) == 524
    @test day09.part2(day09.input) == 1235430
end

using AdventOfCode2021:day10
@testset "Day 10" begin
    @test day10.part1(day10.input) == 311895
    @test day10.part2(day10.input) == 2904180541
end

using AdventOfCode2021:day11
@testset "Day 11" begin
    @test day11.part1(day11.input) == 1719
    @test day11.part2(day11.input) == 232
end

using AdventOfCode2021:day12
@testset "Day 12" begin
    @test_broken day12.part1(day12.input) == 0
    @test_broken day12.part2(day12.input) == 0
end

using AdventOfCode2021:day13
@testset "Day 13" begin
    @test day13.part1(day13.input) == 759
end

using AdventOfCode2021:day14
@testset "Day 14" begin
    @test day14.part1(day14.input) == 3587
    @test day14.part2(day14.input) == 3906445077999
end

using AdventOfCode2021:day15
@testset "Day 15" begin
    @test day15.part1(day15.input) == 745
    @test day15.part2(day15.input) == 3002
end