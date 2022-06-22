source("scripts/package_list.R")

lapply(bookwide_packages, function(x)
  if (!require(x, character.only = TRUE)) {
    pak::pkg_install(x)
    library(x, character.only = TRUE)
  })

set.seed(42)

source("scripts/ggplot_dd_theme.R")
source("scripts/custom_scripts.R")
source("scripts/make_dag_df.R")

options(knitr.kable.NA = '')
options(knitr.kable.NaN = '')

theme_set(theme_dd())

