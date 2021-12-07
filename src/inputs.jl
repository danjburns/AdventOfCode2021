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
@assert typeof(ex_d3()) == typeof(input_d4())

end