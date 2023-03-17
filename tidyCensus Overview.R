install.packages("tidyverse","tidycensus")
library(tidyverse)
library(tidycensus)

#geojsonsf - special package to extend SF package ability convert GeoJSON

#start by looking at what variables are available

#see https://walker-data.com/tidycensus/reference/load_variables.html
#PL is the Redistricting Data File, it is not a complete decennial data set
#but is is all we have for 2020 currently (Covid delayed release)
#Only 301 entries
c2020 <- load_variables(2020, "pl")
View(c2020)

#2010 version - only 301 entries
c2010 <- load_variables(2020, "pl")
View(c2010)

#2010 also has the SF files - 8959 entries!!
dec2010 <- load_variables(2010, "sf1")
View(dec2010)

# this get the list of Variables in the 2021 ACS profile - which is more detailed
v21p <- load_variables(2021, "acs5/profile", cache = TRUE)
View(v21p)

# use this get the list of Variables in the 2021 ACS subject
v21s <- load_variables(2021, "acs5/subject", cache = TRUE)
View(v21s)

# use this get the Variables in the 2021 ACS  detail tables - I most commopnly use this
v21s <- load_variables(2021, "acs5", cache = TRUE)
View(v21s)

#Get the total population, by listing a state it limits it to that state.
pop10 <- get_decennial(
  geography = "state",
  state = "IA",
  variables = "P001001",
  year = 2010 # remember not all data is available for 2020 so this won't work yet for 2020
)

#by contrast for the ACS data
popACS <- get_acs(
  geography = "state", #no state specified so all states collected
  variables = "B01001_001", # this is the total pop in the detail tables.
  survey = "acs5", #tell it acs1 or acs5
  year = 2021
)