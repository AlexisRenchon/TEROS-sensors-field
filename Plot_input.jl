# Plot inputs

# Load data
using CSV
Input = CSV.read("Input\\1(z6-04628)-Configuration 2-1574695017.61.csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")

# rename columns
col_name = [:DateTime,:SWC_1,:Ts_1,:SWC_2,:Ts_2,:SWC_3,:Ts_3,:SWC_4,:Ts_4,:SWC_5,:Ts_5,:SWC_6,:Ts_6,:Battery_P,:Battery_V,:Pressure,:Log_T]
old_name = names(Input)
using DataFrames
rename!(Input, f => t for (f, t) = zip(old_name, col_name))

# Do some basic plots
using Plots

# Time series
plot(Input.DateTime[100:end],Input.Ts_1[100:end])

# Coordinate
scatter([0,0,0,1,1,1],[0,1,2,2,1,0],markersize=[5,5,5,5,5,5],markercolor=[Input.SWC_1[229],Input.SWC_2[229],Input.SWC_3[229],Input.SWC_4[229],Input.SWC_5[229],Input.SWC_6[229]])
