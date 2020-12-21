# Read data
input_data = split(read("input.txt", String), "\n\n")

## Part 1
# Count the number of valid passports - those that have all required fields. Treat cid as optional. In your batch file, how many passports are valid?

function check_passport(pass)
    psplit = split(pass, ('\n', ' '))
    psplit = psplit[psplit .!= ""]
    pnames = hcat(split.(psplit, ':')...)
    sum(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"] .∈  Ref(pnames[1,:])) == 7
end
npassports  = [check_passport(pass) for pass in input_data] |> sum
println("Number of valid passports = $npassports")

## Part 2
# You can continue to ignore the cid field, but each other field has strict rules about what values are valid for automatic validation:

function test_fields(pdict)
    byr_test(pdict) =  1920 <= parse(Int, pdict["byr"]) <= 2002
    iyr_test(pdict) =  2010 <= parse(Int, pdict["iyr"]) <= 2020
    eyr_test(pdict) =  2020 <= parse(Int, pdict["eyr"]) <= 2030
    function hgt_test(pdict)
        hgt = match(r"([0-9]+)(in|cm|.*)(.*)$", pdict["hgt"]).captures
        if hgt[2] == "cm"
            return 150 <= parse(Int, hgt[1]) <= 193
        elseif hgt[2] == "in"
            return 59 <= parse(Int, hgt[1]) <= 76
        else
            return false
        end
    end
    hcl_test(pdict) = !(match(r"^#[0-9a-f]{6}$", pdict["hcl"]) |> isnothing)
    ecl_test(pdict) = pdict["ecl"] ∈ ["amb" "blu" "brn" "gry" "grn" "hzl" "oth"]
    pid_test(pdict) = !(match(r"^[0-9]{9}$", pdict["pid"]) |> isnothing)
    ([byr_test(pdict), iyr_test(pdict), eyr_test(pdict), hgt_test(pdict), hcl_test(pdict), ecl_test(pdict), pid_test(pdict)] |> sum) == 7
end

function check_passport_fields(pass)
    psplit = split(pass, ('\n', ' '))
    psplit = psplit[psplit .!= ""]
    pnames = hcat(split.(psplit, ':')...)
    pdict  = Dict(pnames[1,:] .=> pnames[2,:])
    if (sum(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"] .∈  Ref(keys(pdict))) != 7) 
        return false
    end
    return test_fields(pdict)
end


npassports  = [check_passport_fields(pass) for pass in input_data] |> sum
println("Number of valid passports with valild fields = $npassports")
