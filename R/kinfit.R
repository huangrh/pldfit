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
kinfit <- function(init = NULL,
                   dat = NULL,
                   concs = concs,
                   t2 = t2,
                   model = "simple1to1",
                   bound = NULL)
{
    if (is.null(init)) stop("init is required when calling kinfit")
    if (is.null(dat))  stop("dat is required when calling kinfit")
    #
    if (is.null(bound)) {
        lowerBound = list(kon =1e-04, koff=1e-04, rmax = 0.01);
        upperBound = list(kon =1e04, koff=1e04, rmax = 10);
    } else {
        lowerBound  <- as.numeric(bound$lowerBound);
        upperBound  <- as.numeric(bound$upperBound);
    }

    # Reconstruct a list dat_fit  that required by residArray.R,
    dat_fit = list()
    dat_fit$concs = concs
    dat_fit$xdata  = dat$Time
    dat_fit$t2 <- t2 # t2 is the beginning of the diassociation.
    dat_fit$lowerBound = list(kon =1e-04, koff=1e-04, rmax = 0.01);
    dat_fit$upperBound = list(kon =1e04, koff=1e04, rmax = 10);
    dat_fit$datF       = within(dat, rm("Time"));

    # fitting
    kinfit_(par = init, dat = dat_fit, model = model)
}


#' @export
kinfit_ <- function(par= par, dat = dat, model = "simple1to1") {
    #

    lowerBound  <- as.numeric(dat$lowerBound);
    upperBound  <- as.numeric(dat$upperBound);
    #env_test$concs      = concs;
    #env_test$datF       = ySimulated;
    fit <- minpack.lm::nls.lm(par = par,
                       lower=lowerBound,
                       upper=upperBound,
                       fn= residArray(model = model),
                       jac = NULL,
                       control = minpack.lm::nls.lm.control(),
                       dat = dat)
    fit$model = model
    fit$par$concs = dat$concs
    fit$par$time  = dat$xdata
    fit$par$t2    = dat$t2
    out <- structure(fit, class = "kinfit")
    return(out)
}
