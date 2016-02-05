#'
#'
#'
ydimer <- function(par = par, conc=conc, xdata=time, ydata = NULL) {
    # derived paramenters
    kd2 <- koff/kon
    conc <- ifelse(conc == 0, 0, (sqrt( kd2 * kd2 + 4 * kd2 * conc) - kd2)/2)
    results <- ysimple1to1(par = par, conc=conc, xdata=time, ydata = NULL)
    return(results)
}
