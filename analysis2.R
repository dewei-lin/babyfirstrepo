setwd("../BIOS611-A3")
unique_case <- read.csv("data/unique_case.csv")
source("utils.R");

num_dogs_year <- unique_case %>%
  group_by(birth_year) %>%
  summarise(total_count = n()) 
dogs_name_year <- unique_case %>%
  group_by(birth_year, name) %>%
  summarise(count = n()) 
joined_data <- num_dogs_year %>%
  left_join(dogs_name_year, by = "birth_year") %>% 
  mutate(rate = count/total_count) %>% 
  arrange(desc(rate))
most_popular_1999 <- joined_data %>%
  filter(birth_year== 1999) %>%
  slice(1)

most_popular_2023 <- joined_data %>%
  filter(birth_year== 2023) %>%
  slice(1)


name_1 <- most_popular_1999$name
name_2 <- most_popular_2023$name
name_rate <- joined_data %>% 
  filter(name == most_popular_1999$name | name == most_popular_2023$name)

plot3 <- ggplot(name_rate, aes(x = birth_year, y = rate, color = name)) +
  geom_line() +
  scale_x_continuous(breaks = seq(1999, 2023, by = 1)) +
  labs(title = "Popularity Trends of Most Popular Dog Names (1999 vs 2023)",
       x = "Year", y = "Popularity Rate") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
ggsave(filename = "figures/plot3.png", plot = plot2, width = 6, height = 4)