#my_data <- read_csv("./r_data_analysis/test.csv")


my_data$variable.min <- ""
my_data$variable.max <- ""

ggplot(my_data, aes(x=day ,y=variable, group=group, colour=group)) + 
  geom_ribbon(aes(ymin=min(variable), ymax=max(variable)), alpha=0.2) +
  geom_line()



