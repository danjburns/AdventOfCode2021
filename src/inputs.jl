# Loads the puzzle inputs as function calls
module inputs

cd(dirname(@__DIR__))

################
#    Day 1
################
ex_d1() = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
input_d1() = readlines("inputs/day_01.txt") .|> x->parse(Int, x)


end