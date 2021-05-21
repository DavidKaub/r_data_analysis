#my_data <- read_csv("./r_data_analysis/test.csv")


library(dplyr)
library(ggplot2)
library(Hmisc)



my_data <- test

colnames(my_data) <- c("day", "group", "myValue")


my_data <- my_data %>% 
  group_by(day, group) %>% 
  summarise(
    myValue = myValue,
    myValue.max = max(myValue),
    myValue.min = min(myValue),
    myValue.mean = mean(myValue),
    myValue.median = median(myValue),
    myValue.quantile95 = quantile(myValue, 0.95),
    myValue.quantile05 = quantile(myValue, 0.05),
    q = list(quantile(myValue))) %>% 
    unnest_wider(q)## this is needed since the quantile function will return 5 values which can not be set into a single column
    #)
#?quantile

#my_data

my_data$group <- as.factor(my_data$group)

head(my_data)

colors <- c("#00AFBB", "#08eb7a", "#EB3008", "#E7B800")

plot <- ggplot(my_data, aes(x = day, y = myValue.mean, group=group)) + 
  #stat_summary(geom = "ribbon", fun.data = mean_cl_normal, alpha = 0.3) + 
  geom_ribbon(aes(ymin=myValue.min, ymax=myValue.max, fill = group), alpha = 0.15) +  
  geom_ribbon(aes(ymin=myValue.quantile05, ymax=myValue.quantile95, fill = group), alpha = 0.35) +  
  scale_fill_manual(values=colors)+
  scale_color_manual(values = colors) +
  geom_line(aes(color = group), size = 1) +
  xlab("Day") + ylab("myValue") + 
  theme_minimal()

plot

