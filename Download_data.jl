# Download data from ZENTRA
# Note: working directory must be set to TEROS-sensors-field
# Check with the command pwd()

url = "http://i3.ytimg.com/vi/J---aiyznGQ/mqdefault.jpg" # test for now
download(url,"Input\\Data.jpg") # test for now

# I will change this for ZENTRA cloud data.
# Ideally, I want 1 csv file per ZL6 loggers, or 1 csv file with all ZL6 loggers.
# I also want this script to NOT redownload existing data (or redownload but then erase old data).
# The idea is, each time the script runs, it update the Input with complete dataset.
