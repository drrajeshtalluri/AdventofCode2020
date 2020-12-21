# Read Data
input_data  = readlines("input.txt")


# Part 1
# What is the highest seat ID on a boarding pass?

function seatid(bpass)
    rowid = parse(Int, reduce(replace, ["F" => "0", "B" => "1"], init = bpass[1:7]), base = 2)
    colid = parse(Int, reduce(replace, ["L" => "0", "R" => "1"], init = bpass[8:10]), base = 2)
    (rowid * 8) + colid
end

sids = [seatid(bpass) for bpass in input_data]
println("The maximum seat id is $(sids |> maximum)")


# Part 2
# What is the ID of your seat?

mids = setdiff(1:(8*128), sids) 
mids  = mids[minimum(sids) .< mids .< maximum(sids)]
check_neighbors(id,sids) = (id-1 ∈ sids) && (id+1 ∈ sids)
println("My seat number is $(mids[check_neighbors.(mids,Ref(sids))][1])")

