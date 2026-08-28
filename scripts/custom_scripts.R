
get_dropbox_path <- function(section){
  if(.Platform$OS.type == "unix"){
    path <- file.path("~", "Dropbox", "DeclareDesign_book_rfiles", section)
  } else if (.Platform$OS.type == "windows") {
    
    if (file.exists("C:/Dropbox")) 
      path <- file.path("C:", "Dropbox", "DeclareDesign_book_rfiles", section)
    
    if (file.exists("C:/Dropbox (WZB)"))
      path <- file.path("C:", "Dropbox (WZB)", "DeclareDesign_book_rfiles", section)
  
  }
  dir.create(path, showWarnings = FALSE)
  return(path)
}

get_rdddr_file_local <- function(name) {
  path <- get_dropbox_path("dataverse")
  read_rds(paste0(path, "/", name, ".rds"))
}

bookreg <- function(...) {
  if(knitr:::kable_format() == "html") {
    do.call(htmlreg, args = list(...))
  } else if(knitr:::kable_format() == "latex") {
    do.call(texreg, args = list(...))
  } else {
    stop(paste0("bookreg only supports html and tex", knitr:::kable_format()))
  }
}


# estimatr 1.0.6 lh_robust() shim ----
# lh_robust() in estimatr 1.0.6 fails on single-coefficient models. Its
# degrees-of-freedom check reads var(fit$df > 0) where var(fit$df) > 0 was
# meant, so it takes the variance of a logical vector. The length guard is also
# wrong: var() of a length-one vector is NA either way, and && cannot take NA,
# so both halves of the condition need correcting. Declaration 9.2 tests age ~ 1,
# which has exactly one coefficient, so chapter 9 has failed to render since
# 1.0.6 reached CRAN on 2025-02-28. estimatr 1.0.4 had no such check and
# estimatr 2.0 rewrote the function, so this masks lh_robust only for the
# versions that carry the bug, and only if the buggy text is actually found.
# Delete this block once estimatr 2.0 is on CRAN.
if (packageVersion("estimatr") < "2.0.0") {
  .lh_src <- paste(deparse(estimatr::lh_robust, width.cutoff = 500L), collapse = "\n")
  .lh_fix <- sub("length\\(lm_robust_fit\\$df\\)\\s*>\\s*0\\s*&&\\s*var\\(lm_robust_fit\\$df\\s*>\\s*0\\)",
                 "length(lm_robust_fit$df) > 1 && var(lm_robust_fit$df) > 0", .lh_src)
  if (!identical(.lh_src, .lh_fix)) {
    lh_robust <- eval(parse(text = .lh_fix), envir = asNamespace("estimatr"))
  }
  rm(.lh_src, .lh_fix)
}
