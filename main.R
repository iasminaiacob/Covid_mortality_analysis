library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)
library(broom)

#cleaning data
data <- read_csv("covid.csv")
colnames(data) <- c("Region", "Date", "DeathsPerMillion")
data$Date <- as.Date(data$Date)
data$DeathsPerMillion <- as.numeric(data$DeathsPerMillion)
data <- data %>% filter(!is.na(DeathsPerMillion))

#defining 3 periods
periods_data <- data %>%
  mutate(Period = case_when(
    Date >= as.Date("2020-03-01") & Date <= as.Date("2020-03-31") ~ "March 2020",
    Date >= as.Date("2020-11-01") & Date <= as.Date("2020-11-30") ~ "November 2020",
    Date >= as.Date("2021-04-01") & Date <= as.Date("2021-06-30") ~ "Post-Lockdown Q2 2021",
    TRUE ~ NA_character_
  )) %>%
  filter(!is.na(Period))

#custom color palette for visualization
period_colors <- c("March 2020" = "#E76F51", "November 2020" = "#457B9D", "Post-Lockdown Q2 2021" = "#2A9D8F")

#line plotting
ggplot(periods_data, aes(x = Date, y = DeathsPerMillion, color = Period)) +
  geom_line(size = 1.1) +
  facet_wrap(~Region, scales = "free_y") +
  scale_color_manual(values = period_colors) +
  labs(
    title = "COVID-19 Mortality per Million by Region",
    subtitle = "Comparing March 2020, November 2020, and Post-Lockdown Q2 2021",
    x = NULL,
    y = "Deaths per Million",
    color = "Period"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "top",
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", size = 18),
    plot.subtitle = element_text(size = 13, color = "gray40"),
    strip.text = element_text(face = "bold", size = 12)
  )


#boxplot
ggplot(periods_data, aes(x = Period, y = DeathsPerMillion, fill = Period)) +
  geom_boxplot(width = 0.6, outlier.shape = 21, outlier.fill = "white", outlier.color = "black") +
  facet_wrap(~Region, scales = "free_y") +
  scale_fill_manual(values = period_colors) +
  labs(
    title = "Distribution of Daily COVID-19 Deaths per Million",
    subtitle = "Grouped by Continent and Period",
    x = "",
    y = "Daily Deaths per Million"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 18),
    plot.subtitle = element_text(size = 13, color = "gray40"),
    strip.text = element_text(face = "bold", size = 12),
    axis.text.x = element_text(angle = 20, hjust = 1),
    panel.grid.minor = element_blank()
  )

#Anova results
anova_results <- periods_data %>%
  group_by(Region) %>%
  do(tidy(aov(DeathsPerMillion ~ Period, data = .)))

#Tukey HSD Post-Hoc Test by Region
tukey_results <- periods_data %>%
  group_by(Region) %>%
  group_modify(~ {
    model <- aov(DeathsPerMillion ~ Period, data = .x)
    tukey_tbl <- as.data.frame(TukeyHSD(model)$Period)
    tukey_tbl$Comparison <- rownames(tukey_tbl)
    return(tukey_tbl)
  }) %>%
  ungroup() %>%
  select(Region, Comparison, diff, lwr, upr, `p adj`)

print(anova_results)
print(tukey_results)