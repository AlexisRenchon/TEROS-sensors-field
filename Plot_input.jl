# Plot soil moisture (color) on coordinate (x,y), Alexis 11/25/2019

# This will get all input File Name
Input_FN = readdir("Input\\")
n = length(Input_FN) # this is the number of input files, useful later

# Initialize array of dataframes
using DataFrames
data = DataFrame[]

# Load data
using CSV
col_name = [:DateTime,:SWC_1,:Ts_1,:SWC_2,:Ts_2,:SWC_3,:Ts_3,:SWC_4,:Ts_4,:SWC_5,:Ts_5,:SWC_6,:Ts_6,:Battery_P,:Battery_V,:Pressure,:Log_T]
for i = 1:n
    df = CSV.read(string("Input\\",Input_FN[i]),header=col_name,datarow=2,dateformat="yyyy-mm-dd HH:MM:SS")
    push!(data, df) # push "Insert one or more items at the end of collection"
end

# coordinates of TEROS11 sensors, from sensor 1 to sensor 64
x = [0,0,0,12.5,12.5,12.5,25,25,25,37.5,37.5,37.5,50,50,50,62.5,62.5,62.5,75,75,75,87.5,87.5,87.5,0,0,12.5,12.5,25,25,37.5,37.5,50,50,62.5,62.5,75,75,87.5,87.5,0,0,0,12.5,12.5,12.5,missing,missing,25,25,25,37.5,37.5,37.5,50,50,50,62.5,62.5,62.5,75,75,75,87.5,87.5,87.5];
y = [0,12.5,25,25,12.5,0,0,12.5,25,25,12.5,0,0,12.5,25,25,12.5,0,0,12.5,25,25,12.5,0,37.5,50,50,37.5,50,37.5,37.5,50,50,37.5,37.5,50,50,37.5,50,37.5,62.5,75,87.5,87.5,75,62.5,missing,missing,62.5,75,87.5,87.5,75,62.5,62.5,75,87.5,87.5,75,62.5,62.5,75,87.5,87.5,75,62.5];
using Dates
D = Dates.DateTime("20191125 080000", "yyyymmdd HHMMSS")
z = Array{Union{Float64,Missing}}(missing, 66) # initialize z, which will contain both Float64 and missing type. 2 missing (logger 6 has 4 port only), so 64+2 = 66
nextit = collect(0:5:5*n-1)
for i = 1:n
    j = nextit[i]
    t = findall(x -> x == D,data[i].DateTime)
    z[i+j] = data[i].SWC_1[t][1]
    z[i+1+j] = data[i].SWC_2[t][1]
    z[i+2+j] = data[i].SWC_3[t][1]
    z[i+3+j] = data[i].SWC_4[t][1]
    z[i+4+j] = data[i].SWC_5[t][1]
    z[i+5+j] = data[i].SWC_6[t][1]
end

# Replace missing by NaN, for plotting
x = replace(x, missing=>NaN)
y = replace(y, missing=>NaN)
z = replace(z, missing=>NaN)
# Replace value 54 which was 0 because of sensor error
z[54] = 0.4

# Plots space coordinate and SWC by color
using Plots
scatter(x,y,color=:deep,markersize=10,zcolor=z)
xlabel!("x (m)")
ylabel!("y (m)")
title!("11/25/2019 08:00 am")
plot!(xticks = 0:12.5:87.5)
plot!(yticks = 0:12.5:87.5)
plot!(legend = nothing)
# using LaTeXStrings
plot!(colorbar_title = "Soil Moisture")
plot!(dpi = 300)

savefig("Output\\Output.png")


# Make a gif
# Initialize
#= D = Dates.DateTime("20191123 080000", "yyyymmdd HHMMSS") # Note this is 2 days earlier
z = Array{Union{Float64,Missing}}(missing, 66) # initialize z, which will contain both Float64 and missing type. 2 missing (logger 6 has 4 port only), so 64+2 = 66
nextit = collect(0:5:5*n-1)
for i = 1:n
    j = nextit[i]
    t = findall(x -> x == D,data[i].DateTime)
    z[i+j] = data[i].SWC_1[t][1]
    z[i+1+j] = data[i].SWC_2[t][1]
    z[i+2+j] = data[i].SWC_3[t][1]
    z[i+3+j] = data[i].SWC_4[t][1]
    z[i+4+j] = data[i].SWC_5[t][1]
    z[i+5+j] = data[i].SWC_6[t][1]
end
# Replace missing by NaN, for plotting
x = replace(x, missing=>NaN)
y = replace(y, missing=>NaN)
z = replace(z, missing=>NaN)
# Replace value 54 which was 0 because of sensor error
z[54] = 0.4
scatter(x,y,color=:deep,markersize=10,zcolor=z)
xlabel!("x (m)")
ylabel!("y (m)")
plot!(xticks = 0:12.5:87.5)
plot!(yticks = 0:12.5:87.5)
plot!(legend = nothing)
# using LaTeXStrings
plot!(colorbar_title = "Soil Moisture")
plot!(dpi = 300)
title!(Dates.format(D, "e, dd u yyyy HH:MM:SS"))



@gif for i=1:100
    title!(Dates.format(Input1.DateTime[229-100+i], "e, dd u yyyy HH:MM:SS"))

end every 10
=#
