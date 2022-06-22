
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

