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

# Plots space coordinate and SWC by color
using Plots
# coordinates of TEROS11 sensors, from sensor 1 to sensor 64
x = [0,0,0,12.5,12.5,12.5,25,25,25,37.5,37.5,37.5,50,50,50,62.5,62.5,62.5,75,75,75,87.5,87.5,87.5,0,0,12.5,12.5,25,25,37.5,37.5,50,50,62.5,62.5,75,75,87.5,87.5,0,0,0,12.5,12.5,12.5,25,25,25,37.5,37.5,37.5,50,50,50,62.5,62.5,62.5,75,75,75,87.5,87.5,87.5];
y = [0,12.5,25,25,12.5,0,0,12.5,25,25,12.5,0,0,12.5,25,25,12.5,0,0,12.5,25,25,12.5,0,37.5,50,50,37.5,50,37.5,37.5,50,50,37.5,37.5,50,50,37.5,50,37.5,62.5,75,87.5,87.5,75,62.5,62.5,75,87.5,87.5,75,62.5,62.5,75,87.5,87.5,75,62.5,62.5,75,87.5,87.5,75,62.5];
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



scatter([0,0,0,12.5,12.5,12.5],[0,12.5,25,25,12.5,0], color = :deep,markersize=10,zcolor=[Input1.SWC_1[229],Input1.SWC_2[229],Input1.SWC_3[229],Input1.SWC_4[229],Input1.SWC_5[229],Input1.SWC_6[229]])
# dummy 2
scatter!([25,25,25,37.5,37.5,37.5],[0,12.5,25,25,12.5,0], color = :deep,markersize=10,zcolor=[Input1.SWC_1[229],Input3.SWC_2[234],Input1.SWC_3[229],Input8.SWC_4[229],Input8.SWC_5[229],Input1.SWC_6[229]])
scatter!([50,50,50,62.5,62.5,62.5],[0,12.5,25,25,12.5,0], color = :deep,markersize=10,zcolor=[Input3.SWC_1[234],Input3.SWC_2[234],Input3.SWC_3[234],Input3.SWC_4[234],Input3.SWC_5[234],Input3.SWC_6[234]])
scatter!([75,75,75,87.5,87.5,87.5],[0,12.5,25,25,12.5,0], color = :deep,markersize=10,zcolor=[Input4.SWC_1[235],Input4.SWC_2[235],Input4.SWC_3[235],Input4.SWC_4[235],Input4.SWC_5[235],Input4.SWC_6[235]])
scatter!([0,0,12.5,12.5,25,25],[37.5,50,50,37.5,50,37.5], color = :deep,markersize=10,zcolor=[Input5.SWC_1[234],Input5.SWC_2[234],Input5.SWC_3[234],Input5.SWC_4[234],Input5.SWC_5[234],Input5.SWC_6[234]])
scatter!([37.5,37.5,50,50],[37.5,50,50,37.5], color = :deep,markersize=10,zcolor=[Input6.SWC_1[231],Input6.SWC_2[231],Input6.SWC_3[231],Input6.SWC_4[231]])
# dummy port 6
scatter!([62.5,62.5,75,75,87.5,87.5],[37.5,50,50,37.5,50,37.5], color = :deep,markersize=10,zcolor=[Input7.SWC_1[141],Input7.SWC_2[141],Input7.SWC_3[141],Input7.SWC_4[141],Input7.SWC_5[141],Input7.SWC_5[141]])
scatter!([0,0,0,12.5,12.5,12.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input8.SWC_1[229],Input8.SWC_2[229],Input8.SWC_3[229],Input8.SWC_4[229],Input8.SWC_5[229],Input8.SWC_6[229]])
scatter!([25,25,25,37.5,37.5,37.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input9.SWC_1[230],Input9.SWC_2[230],Input9.SWC_3[230],Input9.SWC_4[230],Input9.SWC_5[230],Input9.SWC_6[230]])
scatter!([50,50,50,62.5,62.5,62.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input10.SWC_1[232],Input10.SWC_2[232],Input10.SWC_3[232],Input10.SWC_4[232],Input10.SWC_5[232],Input10.SWC_6[232]])
scatter!([75,75,75,87.5,87.5,87.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input11.SWC_1[231],Input11.SWC_2[231],Input11.SWC_3[231],Input11.SWC_4[231],Input11.SWC_5[231],Input11.SWC_6[231]])
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
scatter([0,0,0,12.5,12.5,12.5],[0,12.5,25,25,12.5,0], color = :deep,markersize=10,zcolor=[Input1.SWC_1[229-100],Input1.SWC_2[229-100],Input1.SWC_3[229-100],Input1.SWC_4[229-100],Input1.SWC_5[229-100],Input1.SWC_6[229-100]])
scatter!([25,25,25,37.5,37.5,37.5],[0,12.5,25,25,12.5,0], color = :deep,markersize=10,zcolor=[Input1.SWC_1[229-100],Input3.SWC_2[234-100],Input1.SWC_3[229-100],Input8.SWC_4[229-100],Input8.SWC_5[229-100],Input1.SWC_6[229-100]])
scatter!([50,50,50,62.5,62.5,62.5],[0,12.5,25,25,12.5,0], color = :deep,markersize=10,zcolor=[Input3.SWC_1[234-100],Input3.SWC_2[234-100],Input3.SWC_3[234-100],Input3.SWC_4[234-100],Input3.SWC_5[234-100],Input3.SWC_6[234-100]])
scatter!([75,75,75,87.5,87.5,87.5],[0,12.5,25,25,12.5,0], color = :deep,markersize=10,zcolor=[Input4.SWC_1[235-100],Input4.SWC_2[235-100],Input4.SWC_3[235-100],Input4.SWC_4[235-100],Input4.SWC_5[235-100],Input4.SWC_6[235-100]])
scatter!([0,0,12.5,12.5,25,25],[37.5,50,50,37.5,50,37.5], color = :deep,markersize=10,zcolor=[Input5.SWC_1[234-100],Input5.SWC_2[234-100],Input5.SWC_3[234-100],Input5.SWC_4[234-100],Input5.SWC_5[234-100],Input5.SWC_6[234-100]])
scatter!([37.5,37.5,50,50],[37.5,50,50,37.5], color = :deep,markersize=10,zcolor=[Input6.SWC_1[231-100],Input6.SWC_2[231-100],Input6.SWC_3[231-100],Input6.SWC_4[231-100]])
# dummy port 6
scatter!([62.5,62.5,75,75,87.5,87.5],[37.5,50,50,37.5,50,37.5], color = :deep,markersize=10,zcolor=[Input7.SWC_1[141-100],Input7.SWC_2[141-100],Input7.SWC_3[141-100],Input7.SWC_4[141-100],Input7.SWC_5[141-100],Input7.SWC_5[141-100]])
scatter!([0,0,0,12.5,12.5,12.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input8.SWC_1[229-100],Input8.SWC_2[229-100],Input8.SWC_3[229-100],Input8.SWC_4[229-100],Input8.SWC_5[229-100],Input8.SWC_6[229-100]])
scatter!([25,25,25,37.5,37.5,37.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input9.SWC_1[230-100],Input9.SWC_2[230-100],Input9.SWC_3[230-100],Input9.SWC_4[230-100],Input9.SWC_5[230-100],Input9.SWC_6[230-100]])
scatter!([50,50,50,62.5,62.5,62.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input10.SWC_1[232-100],Input10.SWC_2[232-100],Input10.SWC_3[232-100],Input10.SWC_4[232-100],Input10.SWC_5[232-100],Input10.SWC_6[232-100]])
scatter!([75,75,75,87.5,87.5,87.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input11.SWC_1[231-100],Input11.SWC_2[231-100],Input11.SWC_3[231-100],Input11.SWC_4[231-100],Input11.SWC_5[231-100],Input11.SWC_6[231-100]])
xlabel!("x (m)")
ylabel!("y (m)")
using Dates
title!(Dates.format(Input1.DateTime[129], "e, dd u yyyy HH:MM:SS"))
plot!(xticks = 0:12.5:87.5)
plot!(yticks = 0:12.5:87.5)
plot!(legend = nothing)
# using LaTeXStrings
plot!(colorbar_title = "Soil Moisture")
plot!(dpi = 300)


@gif for i=1:100
    title!(Dates.format(Input1.DateTime[229-100+i], "e, dd u yyyy HH:MM:SS"))
    scatter!([25,25,25,37.5,37.5,37.5],[0,12.5,25,25,12.5,0], color = :deep,markersize=10,zcolor=[Input1.SWC_1[229-100+i],Input3.SWC_2[234-100+i],Input1.SWC_3[229-100+i],Input8.SWC_4[229-100+i],Input8.SWC_5[229-100+i],Input1.SWC_6[229-100+i]])
    scatter!([50,50,50,62.5,62.5,62.5],[0,12.5,25,25,12.5,0], color = :deep,markersize=10,zcolor=[Input3.SWC_1[234-100+i],Input3.SWC_2[234-100+i],Input3.SWC_3[234-100+i],Input3.SWC_4[234-100+i],Input3.SWC_5[234-100+i],Input3.SWC_6[234-100+i]])
    scatter!([75,75,75,87.5,87.5,87.5],[0,12.5,25,25,12.5,0], color = :deep,markersize=10,zcolor=[Input4.SWC_1[235-100+i],Input4.SWC_2[235-100+i],Input4.SWC_3[235-100+i],Input4.SWC_4[235-100+i],Input4.SWC_5[235-100+i],Input4.SWC_6[235-100+i]])
    scatter!([0,0,12.5,12.5,25,25],[37.5,50,50,37.5,50,37.5], color = :deep,markersize=10,zcolor=[Input5.SWC_1[234-100+i],Input5.SWC_2[234-100+i],Input5.SWC_3[234-100+i],Input5.SWC_4[234-100+i],Input5.SWC_5[234-100+i],Input5.SWC_6[234-100+i]])
    scatter!([37.5,37.5,50,50],[37.5,50,50,37.5], color = :deep,markersize=10,zcolor=[Input6.SWC_1[231-100+i],Input6.SWC_2[231-100+i],Input6.SWC_3[231-100+i],Input6.SWC_4[231-100+i]])
    # dummy port 6
    scatter!([62.5,62.5,75,75,87.5,87.5],[37.5,50,50,37.5,50,37.5], color = :deep,markersize=10,zcolor=[Input7.SWC_1[141-100+i],Input7.SWC_2[141-100+i],Input7.SWC_3[141-100+i],Input7.SWC_4[141-100+i],Input7.SWC_5[141-100+i],Input7.SWC_5[141-100+i]])
    scatter!([0,0,0,12.5,12.5,12.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input8.SWC_1[229-100+i],Input8.SWC_2[229-100+i],Input8.SWC_3[229-100+i],Input8.SWC_4[229-100+i],Input8.SWC_5[229-100+i],Input8.SWC_6[229-100+i]])
    scatter!([25,25,25,37.5,37.5,37.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input9.SWC_1[230-100+i],Input9.SWC_2[230-100+i],Input9.SWC_3[230-100+i],Input9.SWC_4[230-100+i],Input9.SWC_5[230-100+i],Input9.SWC_6[230-100+i]])
    scatter!([50,50,50,62.5,62.5,62.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input10.SWC_1[232-100+i],Input10.SWC_2[232-100+i],Input10.SWC_3[232-100+i],Input10.SWC_4[232-100+i],Input10.SWC_5[232-100+i],Input10.SWC_6[232-100+i]])
    scatter!([75,75,75,87.5,87.5,87.5],[62.5,75,87.5,87.5,75,62.5], color = :deep,markersize=10,zcolor=[Input11.SWC_1[231-100+i],Input11.SWC_2[231-100+i],Input11.SWC_3[231-100+i],Input11.SWC_4[231-100+i],Input11.SWC_5[231-100+i],Input11.SWC_6[231-100+i]])
end every 10
