##### Frequency Response Data

library(tidyverse)
library(ggthemes)
library(tuneR)

# 10hz - 20k hz
# 100hz - 6hz to 8k hz
# lows 10-300hz
# mid 300-2400hz
# high 2400hz - 20k hz


df <- read.delim("./data/Test FRD File.frd", header = FALSE) %>%
  select(frequency = V1, db = V2, V3)

df %>%
  head()

df %>%
  summary()


df %>%
  mutate(range = case_when(frequency >= 10 & frequency < 300 ~ "Low",
                           frequency >= 300 & frequency <2400 ~ "mid",
                           frequency >= 2400 ~ "high")) %>%
  ggplot(aes(x = frequency, y = db, size = V3, color = range)) +
  geom_line()

df %>%
  ggplot(aes(x = V2)) +
  geom_density()

df %>%
  ggplot(aes(x = V3)) +
  geom_density() 


###
audacity <- read.delim(file = "./data/test.txt") %>%
  select(Freq = `Frequency..Hz.`, levelDb = `Level..dB.`)
audacity %>%
  mutate(range = case_when(Freq >= 10 & Freq < 300 ~ "Low",
                           Freq >= 300 & Freq <2400 ~ "mid",
                           Freq >= 2400 ~ "high")) %>%
  ggplot(aes(x = Freq, y = levelDb, color = range)) +
  geom_point() +
  scale_x_continuous(trans = "log10") 
