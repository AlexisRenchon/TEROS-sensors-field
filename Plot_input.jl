# Plot inputs

# Load data
using CSV
Input1 = CSV.read("Input\\1(z6-04628).csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")
# Input2 = CSV.read("Input\\1(z6-04628)-Configuration 2-1574695017.61.csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")
Input3 = CSV.read("Input\\3(z6-04619).csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")
Input4 = CSV.read("Input\\4(z6-04629).csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")
Input5 = CSV.read("Input\\5(z6-04641).csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")
Input6 = CSV.read("Input\\6(z6-04638).csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")
Input7 = CSV.read("Input\\7(z6-04624).csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")
Input8 = CSV.read("Input\\8(z6-04627).csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")
Input9 = CSV.read("Input\\9(z6-04620).csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")
Input10 = CSV.read("Input\\10(z6-04621).csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")
Input11 = CSV.read("Input\\11(z6-04618).csv", header=1,normalizenames=true,dateformat="yyyy-mm-dd HH:MM:SS")

# rename columns
col_name = [:DateTime,:SWC_1,:Ts_1,:SWC_2,:Ts_2,:SWC_3,:Ts_3,:SWC_4,:Ts_4,:SWC_5,:Ts_5,:SWC_6,:Ts_6,:Battery_P,:Battery_V,:Pressure,:Log_T]
old_name1 = names(Input1)
#old_name2 = names(Input2)
old_name3 = names(Input3)
old_name4 = names(Input4)
old_name5 = names(Input5)
old_name6 = names(Input6)
old_name7 = names(Input7)
old_name8 = names(Input8)
old_name9 = names(Input9)
old_name10 = names(Input10)
old_name11 = names(Input11)
using DataFrames
rename!(Input1, f => t for (f, t) = zip(old_name1, col_name))
# rename!(Input2, f => t for (f, t) = zip(old_name2, col_name))
rename!(Input3, f => t for (f, t) = zip(old_name3, col_name))
rename!(Input4, f => t for (f, t) = zip(old_name4, col_name))
rename!(Input5, f => t for (f, t) = zip(old_name5, col_name))
rename!(Input6, f => t for (f, t) = zip(old_name6, col_name))
rename!(Input7, f => t for (f, t) = zip(old_name7, col_name))
rename!(Input8, f => t for (f, t) = zip(old_name8, col_name))
rename!(Input9, f => t for (f, t) = zip(old_name9, col_name))
rename!(Input10, f => t for (f, t) = zip(old_name10, col_name))
rename!(Input11, f => t for (f, t) = zip(old_name11, col_name))

# Plots space coordinate and SWC by color
using Plots

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
