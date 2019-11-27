# Create a 3D gif of SWC moisture in space, over time

# First part of this code is similar to Plot_input.jl
Input_FN = readdir("Input\\")
n = length(Input_FN) # this is the number of input files, useful later
using DataFrames
data = DataFrame[]
using CSV
col_name = [:DateTime,:SWC_1,:Ts_1,:SWC_2,:Ts_2,:SWC_3,:Ts_3,:SWC_4,:Ts_4,:SWC_5,:Ts_5,:SWC_6,:Ts_6,:Battery_P,:Battery_V,:Pressure,:Log_T]
for i = 1:n
    df = CSV.read(string("Input\\",Input_FN[i]),header=col_name,datarow=2,dateformat="yyyy-mm-dd HH:MM:SS")
    push!(data, df) # push "Insert one or more items at the end of collection"
end
x = [0,0,0,12.5,12.5,12.5,25,25,25,37.5,37.5,37.5,50,50,50,62.5,62.5,62.5,75,75,75,87.5,87.5,87.5,0,0,12.5,12.5,25,25,37.5,37.5,50,50,62.5,62.5,75,75,87.5,87.5,0,0,0,12.5,12.5,12.5,missing,missing,25,25,25,37.5,37.5,37.5,50,50,50,62.5,62.5,62.5,75,75,75,87.5,87.5,87.5];
y = [0,12.5,25,25,12.5,0,0,12.5,25,25,12.5,0,0,12.5,25,25,12.5,0,0,12.5,25,25,12.5,0,37.5,50,50,37.5,50,37.5,37.5,50,50,37.5,37.5,50,50,37.5,50,37.5,62.5,75,87.5,87.5,75,62.5,missing,missing,62.5,75,87.5,87.5,75,62.5,62.5,75,87.5,87.5,75,62.5,62.5,75,87.5,87.5,75,62.5];
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
