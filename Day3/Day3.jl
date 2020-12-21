# Read data
input_data = hcat(split.(readlines("input.txt"), "")...) |> permutedims

## Part 1
# Starting at the top-left corner of your map and following a slope of right 3 and down 1, how many trees would you encounter?

function ntrees(nright, ndown, data)
    [data[1 + ((i - 1) * ndown),1 + mod((i - 1) * nright, size(data, 2))] == "#" for i in 1:(size(data, 1) ÷ ndown)] |> sum
end

println("Number of trees encountered  = $(ntrees(3, 1, input_data))")

## Part 2
# Determine the number of trees you would encounter if, for each of the following slopes, you start at the top-left corner and traverse the map all the way to the bottom:
nright = [1 3 5 7 1]
ndown = [1 1 1 1 2]
println("Product of trees encountered  = $([ntrees(nright[i], ndown[i], input_data) for i in 1:5] |> prod)")
