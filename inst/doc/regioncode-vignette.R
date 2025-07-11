## -----------------------------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

if(!require(regioncode)) install.packages("regioncode")
library(regioncode)
library(dplyr)

load("../R/sysdata.rda")
vec_yearRange <- names(region_data) |>
  grep("^\\d{4}_code$", x = _, value = TRUE) |>
  substr(start = 1, stop = 4) |> 
  as.numeric()

## -----------------------------------------------------------------------------
library(regioncode)

data("corruption")

# Conversion to the 1989 version
regioncode(
  data_input = corruption$prefecture_id,
  convert_to = "code", # default setting
  year_from = 2019,
  year_to = 1989
)

# Comparison
tibble(
  code2019 = corruption$prefecture_id,
  code1989 = regioncode(
    data_input = corruption$prefecture_id,
    convert_to = "code", # default setting
    year_from = 2019,
    year_to = 1989
  ),
  name2019 = regioncode(
    data_input = corruption$prefecture_id,
    convert_to = "name", # default setting
    year_from = 2019,
    year_to = 2019
  ),
  name1989 = regioncode(
    data_input = corruption$prefecture_id,
    convert_to = "name", # default setting
    year_from = 2019,
    year_to = 1989
  )
)

## -----------------------------------------------------------------------------
# Original name
tibble(
  id = corruption$prefecture_id,
  name = corruption$prefecture
)

# Codes to name
regioncode(
  data_input = corruption$prefecture_id,
  convert_to = "name",
  year_from = 2019,
  year_to = 1989
)

# Name to codes of the same year
regioncode(
  data_input = corruption$prefecture,
  convert_to = "code",
  year_from = 2019,
  year_to = 2019
)

# Name to name of a different year
regioncode(
  data_input = corruption$prefecture,
  convert_to = "name",
  year_from = 2019,
  year_to = 1989)

## -----------------------------------------------------------------------------
# Original full names
corruption$prefecture

fake_incomplete <- corruption$prefecture

index_incomplete <- sample(seq(length(corruption$prefecture)), 7)

fake_incomplete[index_incomplete] <- fake_incomplete[index_incomplete] |>
  substr(start = 1, stop = 2)

fake_incomplete

# Conversion to full names in 2008
regioncode(
  data_input = fake_incomplete,
  convert_to = "name",
  year_from = 2019,
  year_to = 2008,
  incomplete_name = TRUE
)


## -----------------------------------------------------------------------------
names_municipality <- c(
  "北京市", # Beijing, a municipality
  "海淀区", # A district of Beijing
  "上海市", # Shanghai, a municipality
  "静安区", # A district of Shanghai
  "济南市"
) # A prefecture of Shandong

# When `zhixiashi` is FALSE, only the districts are recognized
regioncode(
  data_input = names_municipality,
  year_from = 2019,
  year_to = 2019,
  convert_to = "code",
  zhixiashi = FALSE
)

# When `zhixiashi` is TRUE, municipalities are recognized
regioncode(
  data_input = names_municipality,
  year_from = 2019,
  year_to = 2019,
  convert_to = "code",
  zhixiashi = TRUE
)

## -----------------------------------------------------------------------------
tibble(
  city = corruption$prefecture,
  rank1989 = regioncode(
    data_input = corruption$prefecture,
    year_from = 2019,
    year_to = 1989,
    convert_to = "rank"
  ),
  rank2014 = regioncode(
    data_input = corruption$prefecture,
    year_from = 2019,
    year_to = 2014,
    convert_to = "rank"
  ))

## -----------------------------------------------------------------------------
tibble(
  city = corruption$prefecture,
  cityPY = regioncode(
    data_input = corruption$prefecture,
    year_from = 2019,
    year_to = 1989,
    convert_to = "name",
    to_pinyin = TRUE
  ),
  areaPY = regioncode(
    data_input = corruption$prefecture,
    year_from = 2019,
    year_to = 1989,
    convert_to = "area",
    to_pinyin = TRUE
  )
)

# Regions with special spelling
regioncode(
  data_input = c("山西", "陕西", "内蒙古", "香港", "澳门"),
  year_from = 2019,
  year_to = 2008,
  convert_to = "name",
  incomplete_name = TRUE,
  province = TRUE,
  to_pinyin = TRUE
)

## -----------------------------------------------------------------------------
tibble(
  province = corruption$province_id,
  prov_name = regioncode(
    data_input = corruption$province_id,
    convert_to = "name",
    year_from = 2019,
    year_to = 1989,
    province = TRUE
  ),
  prov_abbre = regioncode(
    data_input = corruption$province_id,
    convert_to = "codeToabbre",
    year_from = 2019,
    year_to = 1989,
    province = TRUE
  )
)

## -----------------------------------------------------------------------------
regioncode(
  data_input = corruption$prefecture,
  year_from = 2019,
  year_to = 1989,
  convert_to = "area")

## -----------------------------------------------------------------------------
tibble(
  city = corruption$prefecture,
  dialectGroup = regioncode(
    data_input = corruption$prefecture,
    year_from = 2019,
    year_to = 1989,
    to_dialect = "dia_group"
  ),
  dialectSubGroup = regioncode(
    data_input = corruption$prefecture,
    year_from = 2019,
    year_to = 1989,
    to_dialect = "dia_sub_group"
  )
)

