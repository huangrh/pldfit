#' minimize the residFun using nls.lm
#'
#' @param par the initial parameters to be fitted
#' @param dat the data in a list, which include a
#' @param model the model
#'
#' @return the fitting results returned by minpack.lm::nls.lm
#' @examples
#' # simulation
#' par = list(kon  = 2e2, koff = 1e-2, rmax = 1)
#' datsim = list()
#' datsim$concs <- 1e-5 * (2^(0:5));
#' datsim$xdata = seq(0, 300, length.out = 1501); # time
#' datsim$t2   = 150
#' datsim$ydata = NULL
#'
#' @export
kinfit <- function(par= par, dat = dat, model = "simple1to1") {
    #

    lowerBound  <- as.numeric(dat$lowerBound);
    upperBound  <- as.numeric(dat$upperBound);
    #env_test$concs      = concs;
    #env_test$datF       = ySimulated;
    minpack.lm::nls.lm(par = par,
                       lower=lowerBound,
                       upper=upperBound,
                       fn= residArray(model = model),
                       jac = NULL,
                       control = minpack.lm::nls.lm.control(),
                       dat = dat)
}
