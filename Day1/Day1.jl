# Read Data
input_data  = parse.(Int, readlines("input.txt"))

## Part 1
# Find the first pair of numbers that add up to 2020

for num_1 in input_data, num_2 in setdiff(input_data, num_1)
    if (num_1 + num_2) == 2020
        println("Number 1 = $num_1, Number 2 = $num_2 \nProduct = $(num_1 * num_2)")
        break
    end
end

## Part 2
# Find the first triplet of numbers that add up to 2020

for num_1 in input_data, num_2 in setdiff(input_data, num_1), num_3 in setdiff(input_data, [num_1, num_2])
    if (num_1 + num_2 + num_3) == 2020
        println("Number 1 = $num_1, Number 2 = $num_2, Number 3 = $num_3 \nProduct = $(num_1 * num_2 * num_3)")
        break
    end
end
