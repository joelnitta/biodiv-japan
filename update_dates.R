# Update dates in slides

library(tidyverse)
library(fs)

date_df <- tribble(
  ~day_num, ~old_date, ~new_date,
  1, "2023-06-13", "2024-06-11",
  2, "2023-06-20", "2024-06-18",
  3, "2023-06-27", "2024-06-25",
  # 4 is media day
  5, "2023-07-04", "2024-07-02",
  6, "2023-07-11", "2024-07-09",
  7, "2023-07-18", "2024-07-16",
  8, "2023-07-25", "2024-07-18"
)

replace_vec <- date_df$new_date |>
  set_names(date_df$old_date)

replace_date_single <- function(file, replace_vec) {
  read_lines(file) |>
  str_replace_all(replace_vec) |>
  write_lines(file)
}

replace_date <- function(file, replace_vec) {
  purrr::walk(file, ~replace_date_single(., replace_vec))
}

fs::dir_ls(glob = "*.qmd", recurse = TRUE) |>
  replace_date(replace_vec)
