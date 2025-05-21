# Covid_mortality_analysis
COVID-19 Mortality Analysis Across Three Key Periods (Pre-Lockdown, During, Post-Lockdown)

This project aims to analyze and compare COVID-19 mortality rates per million people across world regions during three critical periods of the pandemic:
    March 2020 – the early global outbreak
    November 2020 – peak of lockdowns during the second wave
    Post-Lockdown Q2 2021 (April–June) – period when many restrictions were lifted and vaccinations ramped up

The goal is to determine whether the mortality significantly differed across these phases and between continents, using statistical analysis and data visualization.


Platform used: R (via RStudio)
Libraries: dplyr, ggplot2, readr, lubridate, broom
Data Source: Public dataset from Our World in Data (OWID), filtered to use:
    Date
    Region
    Total confirmed COVID-19 deaths per million people


Data Processing & Transformation:
    Cleaned data and converted types
    Selected three key periods by date filtering
    Grouped data by Region and Period
    Calculated daily mortality rates per million
    Visualized trends with line plots and summarized differences with boxplots

Statistical Testing:
Tests used:
    One-Way ANOVA per Region: For each region, I tested whether mean daily mortality differed significantly between the three periods. This is appropriate because we are comparing a quantitative outcome (deaths per million) across 3 independent groups (time periods)
    Tukey HSD Post-Hoc Test: Identified which specific pairs of periods had statistically significant differences


Results:
The ANOVA test showed extremely small p-values (p < 0.001) for all regions, confirming significant differences in mortality between the three periods in every region.
Tukey HSD test revealed that, in every region, Post-Lockdown Q2 2021 had significantly higher mortality than both March 2020 and November 2020. For example: 
    Europe - Post-Lockdown had a mean increase of 1423 deaths per million over March 2020 (p < 0.001)
    South America - November 2020 was already significantly higher than March (diff = 1094), but Post-Lockdown increased even further (diff = 1950)
    Africa: Differences were statistically significant but numerically smaller (Post-Lockdown vs March: +89 deaths per million)
These results confirm that while March 2020 marked the pandemic's start, the worst mortality impacts occurred well after lockdowns, especially in the Americas and Europe.

Boxplots confirmed that mortality was lowest in March 2020 and highest in the Post-Lockdown Q2 2021 period in many regions, especially Europe, North America, and South America.
Visual line plots showed clear upward trends over time, with substantial regional differences.

Europe, North America, and South America experienced the highest mortality rates post-lockdown, despite the availability of vaccines, possibly reflecting earlier under-reporting, variant effects, or overwhelmed health systems.
Africa, Asia, and Australia had much lower mortality across all periods.
This supports the importance of temporal and regional context in understanding public health outcomes.

Limitations:
    Data accuracy depends on each region’s reporting standards
    Differences in population age, healthcare systems, and policy were not adjusted for
    Time periods were based on global patterns and may not reflect each country’s local timeline