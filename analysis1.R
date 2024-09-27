#### Load data ####
#setwd("../BIOS611-A3")
source("utils.R")
if (!dir.exists("logs")) {
  dir.create("logs")
}
ensure_directory("logs");
data <- read.csv("data/source_data.csv")

#### complete case ####
log <- make_logger("logs/logs_output1.txt")
n_data = nrow(data)
complete_case <- data %>%
  mutate(across(everything(), ~str_replace_all(., "#VALUE!", NA_character_))) %>%
  rename(
    name = AnimalName, 
    gender = AnimalGender, 
    birth_year = AnimalBirthYear, 
    breed = BreedName, 
    zipcode = ZipCode, 
    issue_date = LicenseIssuedDate, 
    expiration_date = LicenseExpiredDate, 
    extract_year = Extract.Year
  ) %>% drop_na() %>%
  filter(
    name != "UNKNOWN" & name != "." & name != "NAME NOT PROVIDED"
    & name != "NONE" & name != "NAME"
  )
n_complete = nrow(complete_case)
log("Before filtering NA cases: %d, after %d (%0.2f%% decrease)",
    n_data,
    n_complete,
    100 - 100 * n_complete / n_data)

#### deduplicate ####

distinct_case <- complete_case %>%
  distinct()
n_distinct = nrow(distinct_case)

log("Before filtering duplicate cases: %d, after %d (%0.2f%% decrease)",
    n_complete,
    n_distinct,
    100 - 100 * n_distinct / n_complete)

write.csv(distinct_case, "data/distinct_case.csv", row.names = FALSE)

#### plots ####

plot1 <- distinct_case %>%
  group_by(birth_year) %>%
  summarize(count = n()) %>%
  arrange(birth_year) %>% 
  ggplot(aes(x = birth_year, y = count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Number of Dogs Born Each Year", x = "Year of Birth", y = "Number of Dogs") +
  theme_minimal() +
  #scale_x_continuous(limits = c(min_yr,max_yr)) +  
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 

threshold <- 1000
plot2 <- distinct_case %>%
  group_by(birth_year) %>%
  summarize(count = n()) %>%
  filter(count > threshold) %>%
  arrange(birth_year) %>% 
  ggplot(aes(x = birth_year, y = count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Number of Dogs Born Each Year: Count > 1000", x = "Year of Birth", y = "Number of Dogs") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 

ggsave(filename = "figures/plot1.png", plot = plot1, width = 6, height = 4)
ggsave(filename = "figures/plot2.png", plot = plot2, width = 6, height = 4)

#### apply new rule ####

unique_case <- distinct_case %>% 
  group_by(name, gender, birth_year, breed, zipcode) %>%
  slice(1) %>%
  ungroup()
n_unique <- nrow(unique_case)

log("Before applying the new rule: %d, after %d (%0.2f%% decrease)",
    n_distinct,
    n_unique,
    100 - 100 * n_unique / n_distinct)

write.csv(unique_case, "data/unique_case.csv", row.names = FALSE)
