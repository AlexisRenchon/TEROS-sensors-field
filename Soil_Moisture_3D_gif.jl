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

# Create a continuous half-hourly DateTime vector
using Dates
Dtime = collect(Dates.DateTime(DateTime(2019,11,19,00,00,00)):Dates.Minute(30):Dates.DateTime(DateTime(2019,11,28,00,00,00)))
m = length(Dtime)
# Initialize SWC matrice with 66 columns, m rows
SWC = Array{Union{Float64,Missing}}(missing,m,66)
nextit = collect(0:5:5*n-1)
for j = 1:11
    for i = 1:m
        k = nextit[j]
        t = findfirst(x -> x == Dtime[i],data[j].DateTime)
        if isnothing(t) == false
            SWC[i,j+k] = data[j].SWC_1[t]
            SWC[i,j+1+k] = data[j].SWC_2[t]
            SWC[i,j+2+k] = data[j].SWC_3[t]
            SWC[i,j+3+k] = data[j].SWC_4[t]
            SWC[i,j+4+k] = data[j].SWC_5[t]
            SWC[i,j+5+k] = data[j].SWC_6[t]
        end
    end
end
# could find something more elegent to do the loop below...
for j = 1:66
    for i = 1:m
        if SWC[i,j] < 0.35 || SWC[i,j] > 0.5
            SWC[i,j] = NaN
        end
    end
end

MD = CSV.read("Input\\Metadata.csv")
x = MD.x*12.5
y = MD.y*12.5
# altitude = rand(228:236,66)
# Replace missing by NaN, for plotting
x = replace(x, missing=>NaN)
y = replace(y, missing=>NaN)
SWC = replace(SWC, missing=>NaN)
SWC = replace(SWC, 0.0=>NaN)
# Initialize plot for gif
using Plots
scatter(x,y,color=:deep,markersize=10,zcolor=SWC[175,:])
xlabel!("x (m)")
ylabel!("y (m)")
title!(Dates.format(Dtime[175], "e, dd u yyyy HH:MM:SS"))
plot!(xticks = 0:12.5:87.5)
plot!(yticks = 0:12.5:87.5)
plot!(legend = nothing)
plot!(colorbar_title = "Soil Moisture")
plot!(dpi = 300)
# Make gif, fps = 2
anim = @animate for i = 175:m
    title!(Dates.format(Dtime[i], "e, dd u yyyy HH:MM:SS"))
    scatter!(x,y,color=:deep,markersize=10,zcolor=SWC[i,:])
end
gif(anim,"Output\\anim_5days.gif",fps=10)

# 3D scatter with altitude
# scatter3d(x,y,altitude,color=:deep,markersize=10,zcolor=SWC[:,1])
# this connect the dots to create a surface
# surface(x,y,altitude)

# to do, no dot if missing data
# to do, fix the colorbar range (from 0.35 to 0.5 for example)
