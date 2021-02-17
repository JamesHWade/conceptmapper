library(ggraph)
library(tidygraph)

highschool


tibble(from = c("A", "B", "C"),
       to = c("D", "E", "B")) -> test


a <- as_tbl_graph(test)

as_tibble(a %>%  activate(edges))

test <- as_tbl_graph(highschool)


test %>% activate(edges) %>% as_tibble()


str(test)

as_tibble(test)

write_csv()