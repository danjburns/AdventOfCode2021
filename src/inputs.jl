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
input_d2() = @pipe readlines("inputs/day_02.txt")
@assert typeof(ex_d2()) == typeof(input_d2())

end