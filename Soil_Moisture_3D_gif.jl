# Create a 3D gif of SWC moisture in space, over time

# First part of this code is similar to Plot_input.jl
Input_FN = readdir("Input\\TEROS\\")
permute!(Input_FN,[1,4,5,6,7,8,9,10,11,2,3]) # need to reorder from 1 to 11
n = length(Input_FN) # this is the number of input files, useful later
using DataFrames
data = DataFrame[]
using CSV
col_name = [:DateTime,:SWC_1,:Ts_1,:SWC_2,:Ts_2,:SWC_3,:Ts_3,:SWC_4,:Ts_4,:SWC_5,:Ts_5,:SWC_6,:Ts_6,:Battery_P,:Battery_V,:Pressure,:Log_T]
for i = 1:n
    df = CSV.read(string("Input\\TEROS\\",Input_FN[i]),header=col_name,datarow=2,dateformat="yyyy-mm-dd HH:MM:SS")
    push!(data, df) # push "Insert one or more items at the end of collection"
end
MD = CSV.read("Input\\Metadata.csv")
x = MD.x*12.5
y = MD.y*12.5
# altitude = rand(228:236,66)
using Dates
# Differs from here, calculate z for different dates
# Initialize array of Dates
D1 = Array{DateTime}(undef, 6)
#i = collect(1:6)
i = 1
for d = [23,24,25]
    for h = [0,8]
        D1[i] = DateTime(2019,11,d,h,00,00)
        global i += 1 # i = i + 1
    end
end
# Create 6 vector z
z = Array{Union{Float64,Missing}}(missing, 66, 6)
# z2 = Array{Array}(undef, 6)
# z2[1] = [1,2,3]
nextit = collect(0:5:5*n-1)
for dt = 1:6
    for i = 1:n
        j = nextit[i]
        t = findall(x -> x == D1[dt],data[i].DateTime)
        z[i+j,dt] = data[i].SWC_1[t][1]
        z[i+1+j,dt] = data[i].SWC_2[t][1]
        z[i+2+j,dt] = data[i].SWC_3[t][1]
        z[i+3+j,dt] = data[i].SWC_4[t][1]
        z[i+4+j,dt] = data[i].SWC_5[t][1]
        z[i+5+j,dt] = data[i].SWC_6[t][1]
    end
end

# Replace missing by NaN, for plotting
x = replace(x, missing=>NaN)
y = replace(y, missing=>NaN)
z = replace(z, missing=>NaN)
z = replace(z, 0.0=>NaN)
# Initialize plot for gif
using Plots
scatter(x,y,color=:deep,markersize=10,zcolor=z[:,1])
xlabel!("x (m)")
ylabel!("y (m)")
title!(Dates.format(D1[1], "e, dd u yyyy HH:MM:SS"))
plot!(xticks = 0:12.5:87.5)
plot!(yticks = 0:12.5:87.5)
plot!(legend = nothing)
plot!(colorbar_title = "Soil Moisture")
plot!(dpi = 300)
# Make gif, fps = 2
anim = @animate for i = 1:6
    title!(Dates.format(D1[i], "e, dd u yyyy HH:MM:SS"))
    scatter!(x,y,color=:deep,markersize=10,zcolor=z[:,i])
end
gif(anim,"Output\\anim_fps2.gif",fps=2)

# 3D scatter with altitude
# scatter3d(x,y,altitude,color=:deep,markersize=10,zcolor=z[:,1])
# this connect the dots to create a surface
# surface(x,y,altitude)
