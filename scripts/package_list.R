# this is a list of packages we will load for every chapter
# let's try to keep this to a minimum
# for many chapters, you will load special packages for them -- like if there's a section on matching it will do library(Matching) in the code
#   don't add those chapter-specific packages here

bookwide_packages <-
  c(
    # bookdown and knitr related packages
    "knitr",
    "kableExtra",
    "gridExtra",
    "texreg",

    # DeclareDesign packages
    "estimatr",
    "fabricatr",
    "randomizr",
    "DeclareDesign",
    "DesignLibrary",
    "rdss",

    # tidyverse packages
    "ggplot2",
    "patchwork",
    "dplyr",
    "tidyr",
    "readr",
    "purrr",
    "tibble",
    "stringr",
    "forcats",
    "haven",
    "sf",
    # DAGs packages
    "dagitty",
    "ggdag",
    "ggraph",
    # ggplot packages
    "ggforce",
    "ggtext",
    "ggrepel",
    "ragg",
    # extras
    "dddag",
    "latex2exp"
  )


# These are all the chapters you might need; install manually if needed
if(FALSE){
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")
pacman::p_load(
  pak, ggcorrplot, modelr, ICC, gt, ggspatial, GGally, psych, rdrobust,
  DIDmultiplegt, car, checkpoint, dagitty, downlit, dplyr, estimatr,
  fabricatr, forcats, ggdag, ggforce, ggplot2, ggraph, ggrepel,
  ggridges, ggtext, glmnet, glue, gridExtra, haven, jsonlite,
  kableExtra, knitr, latex2exp, lme4, magrittr, MASS, metafor,
  patchwork, prediction, purrr, randomizr, Rcpp, readr, remotes,
  reshape2, rmarkdown, rprojroot, rr, sf, shiny, stringr, texreg,
  tibble, tidyr, tidyverse, xml2, broom.mixed, parsermd, rstanarm,
  CausalQueries, DeclareDesign, DesignLibrary, ragg, margins, MatchIt,
  cjoint, spdep, grf, bbmle, rdss, vayr, dddag, randnet, interference
)

remotes::install_github(c(
  "acoppock/vayr",
  "DeclareDesign/dddag",
  "cran/randnet",
  "szonszein/interference",
  "cran/checkpoint"
), upgrade = "never")
}

