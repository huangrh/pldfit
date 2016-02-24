### minimize the residFun using nls.lm

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
