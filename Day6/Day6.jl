# Read data

# remove last \n in the file
input_data = split.(read("input.txt", String)[1:(end - 1)], "\n\n")


# Part 1
# What is the sum of those counts?

function count_yes(yes_q)
    union(split.(split(yes_q, "\n"), "")...) |> length
end

println("Sum of the counts  = $([count_yes(x)  for x in input_data] |> sum)") 

# Part 2
# For each group, count the number of questions to which everyone answered "yes". What is the sum of those counts?

function count_all_yes(yes_q)
    intersect(split.(split(yes_q, "\n"), "")...) |> length
end

println("Sum of the counts  = $([count_all_yes(x)  for x in input_data] |> sum)") 
