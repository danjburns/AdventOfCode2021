"""
Loads the puzzle inputs as function calls.

    Call the associated day's example data and input data in the
    solution scripts. E.g., ex_d1() loads the example data for day 1, and input_d1() loads the input data.

    Lightwieight parsing is done in this script to convert to arrays
    of strings or integers where appropriate. More significant parsing 
    is considered puzzle logic and should be done in the solution scripts.

"""

module inputs

using Pipe

cd(dirname(@__DIR__))

################
#    Day 1
################
ex_d1() = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
input_d1() = readlines("inputs/day_01.txt") .|> x->parse(Int, x)
@assert typeof(ex_d1()) == typeof(input_d1())

################
#    Day 2
################
ex_d2() = @pipe """forward 5
down 5
forward 8
up 3
down 8
forward 2""" |> String.(split(_, "\n"))
input_d2() = readlines("inputs/day_02.txt")
@assert typeof(ex_d2()) == typeof(input_d2())

################
#    Day 3
################
ex_d3() = @pipe """00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010""" |> String.(split(_, "\n"))
input_d3() = readlines("inputs/day_03.txt")
@assert typeof(ex_d3()) == typeof(input_d3())

################
#    Day 4
################
ex_d4() = @pipe """7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7""" |> String.(split(_, "\n"))
input_d4() = readlines("inputs/day_04.txt")
@assert typeof(ex_d4()) == typeof(input_d4())

################
#    Day 5
################
ex_d5() = @pipe """0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2""" |> String.(split(_, "\n"))
input_d5() = readlines("inputs/day_05.txt")
@assert typeof(ex_d5()) == typeof(input_d5())

################
#    Day 6
################
ex_d6() = @pipe """3,4,3,1,2""" |> parse.(Int, split(_, ","))
input_d6() = @pipe readlines("inputs/day_06.txt") |>
                only |>
                split(_, ",") |>
                parse.(Int, _)
@assert typeof(ex_d6()) == typeof(input_d6())

################
#    Day 7
################
ex_d7() = parse.(Int, split("16,1,2,0,4,2,7,1,2,14", ","))
input_d7() = @pipe readlines("inputs/day_07.txt")  |>
                only |>
                split(_, ",") |>
                parse.(Int, _)
@assert typeof(ex_d7()) == typeof(input_d7())

################
#    Day 8
################
ex_d8() = @pipe """be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb |
fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec |
fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef |
cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega |
efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga |
gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf |
gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf |
cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd |
ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg |
gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc |
fgae cfgab fg bagce""" |> String.(split(_, "\n"))
input_d8() = @pipe readlines("inputs/day_08.txt")
@assert typeof(ex_d8()) == typeof(input_d8())

################
#    Day 9
################
ex_d9() = @pipe """2199943210
3987894921
9856789892
8767896789
9899965678""" |> String.(split(_, "\n"))
input_d9() = readlines("inputs/day_09.txt")
@assert typeof(ex_d9()) == typeof(input_d9())

################
#    Day 10
################
ex_d10() = @pipe """[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]""" |> String.(split(_, "\n"))
input_d10() = readlines("inputs/day_10.txt")
@assert typeof(ex_d10()) == typeof(input_d10())

################
#    Day 11
################
ex_d11() = @pipe """5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526""" |> String.(split(_, "\n"))
input_d11() = readlines("inputs/day_11.txt")
@assert typeof(ex_d11()) == typeof(input_d11())

################
#    Day 12
################
ex_d12() = @pipe """start-A
start-b
A-c
A-b
b-d
A-end
b-end""" |> String.(split(_,"\n"))
input_d12() = readlines("inputs/day_12.txt")
@assert typeof(ex_d12()) == typeof(input_d12())

################
#    Day 13
################
ex_d13() = """6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5"""
input_d13() = read("inputs/day_13.txt", String)
@assert typeof(ex_d13()) == typeof(input_d13())




end