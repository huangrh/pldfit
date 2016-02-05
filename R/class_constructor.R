#' provide a constructor function of S3 class "simple1to1"
#'
#' @params  kon   <- par$kon
#' @params koff  <- par$koff
#' @params rmax  <- par$rmax
#'
simple1to1 <- function(kon, koff, rmax) {

    structure(class = "simple1to1")
}




#' To construct a list with paramenters including     with a class
#'
#' @params  kon   <- par$kon
#' @params koff  <- par$koff
#' @params rmax  <- par$rmax
#'
dimer <- function(par = list(kon, koff, rmax)) {

    structure(class = "dimer")
}
