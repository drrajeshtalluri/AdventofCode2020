# Read data
using DelimitedFiles
input_data = readdlm("input.txt", ' ', String)

## Part 1

# How many passwords are valid according to their policies?

function testpass(prange, pchar, ppass)
    pmin, pmax =  parse.(Int, match(r"(.*)-(.*)", prange).captures)
    pachar = match(r"(.*):", pchar).captures[1]
    pmin <= length(collect(eachmatch(Regex(pachar), ppass))) <= pmax
end

println("Number of valid passwords = $(sum([ testpass(inp[1], inp[2], inp[3]) for inp in eachrow(input_data)]))")

## Part 2
# How many passwords are valid according to their updated policies?

function testpass_updated(prange, pchar, ppass)
    pindex =  match(r"(.*)-(.*)", prange).captures
    pachar = match(r"(.*):", pchar).captures[1]
    noffset = [x.offset for x in eachmatch(Regex(pachar), ppass)]
    length(intersect(parse.(Int, pindex), noffset)) == 1
end

println("Number of valid passwords = $(sum([ testpass_updated(inp[1], inp[2], inp[3]) for inp in eachrow(input_data)]))")
