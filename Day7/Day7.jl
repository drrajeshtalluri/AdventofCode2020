# Read data

input_data  = readlines("input.txt")
function parse_data(bline)
    bcolor = match(r"(.*) bags contain (.*).$", bline).captures
    bcolor_inside =  split.(bcolor[2], ", ") 
    bcolor_inside = match.(r"^(\d) (.*) (bag|bags)$", bcolor_inside)
    if isnothing(bcolor_inside[1])
        return Dict(bcolor[1] => [(n = 0, color = "nothing")])
    end
    return Dict(bcolor[1] => [(n = parse(Int, x.captures[1]), color = x.captures[2]) for x in bcolor_inside])
end

# create a dict by parsing the data
cdict = reduce(merge, parse_data.(input_data))

## Part 1
# find all bags that can contain bag_color using all rules

function out_color(bag_color, cdict)
    res = []
    for bdict in cdict
        if bag_color ∈ [x.color for x in bdict[2]] 
            push!(res, bdict[1])
        end
    end
    return res
end


# repeat this for each level and each of the outer bags in each level untill the outer bags become zero
function all_colors(fcolor, cdict)
    fcolor = "shiny gold"
    start_colors =  out_color(fcolor, cdict)
    ucolor = start_colors
    old_colors = start_colors
    new_colors = old_colors
    while true
        new_colors = vcat(out_color.(old_colors, Ref(cdict))...)
        ucolor = union(ucolor, new_colors)
        old_colors = new_colors
        if length(new_colors) == 0
            break
        end
    end
    return ucolor
end

println("The number of different bag colors that can contain a shiny gold bag is $(all_colors("shiny gold", cdict) |> length)")

## Part 2
# How many individual bags are required inside your single shiny gold bag?

# recursive function to count bags
function inside_bags_count(bcolor, cdict)
    isum = 1
    ibags = cdict[bcolor]
    if ibags[1].n == 0
        return isum
    end 
    for bag in ibags
        isum = isum + bag.n * inside_bags_count(bag.color, cdict)
    end
    return isum
end

println("Number of bags inside shiny gold bag is $(inside_bags_count("shiny gold", cdict) - 1)")