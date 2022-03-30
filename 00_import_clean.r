#### IMPORT ####
raw <- read.csv("https://www.phoenixopendata.com/
dataset/598be280-a5ce-4c77-b802-321756332dfb/
resource/d49c88c7-93b4-4c83-9032-31e4fd620f61/
download/20210519_opendata-1.csv")

d <- raw

#### CLEAN ####
## Rename the columns. ##
colnames(d) <- tolower(gsub(".", "_", colnames(raw), fixed = TRUE))
d$building_type <- tolower(d$building_type)

## Remove unneeded data. ##
d$year <- NULL  # Year is 2020 for all rows.
d$electric_utility <- NULL  # Uninterested in electric co.

## Format the data. ##
# Latitude and longitude columns
d[
    d$latitude == "" | d$latitude == "N/A",
    c("latitude", "longitude")
] <- NA

d$latitude <- as.numeric(d$latitude)
d$longitude <- as.numeric(d$longitude)

## Format d$building_type.
d[
        d$building_type == "N/A" | d$building_type == " N/A ",
        c("building_type")
] <- NA

## NA values
# For any sites with an address, we will fill in the latitude and longitude.
d[
        d["address"] == "1658 S Litchfield Rd",
        c("latitude", "longitude")
] <- c(33.42719273452142, -112.35756158572785)

d [
        d["address"] == "333 S 42nd St",
        c("latitude", "longitude")
] <- c(33.44477620868195, -111.99011796985566)