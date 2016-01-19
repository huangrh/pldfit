# source("~/Documents/My_Exp/2012BLI_Sadler/model/Rmd/helper.R")


### define the residual function
residFun = function(par = params, env= env_test)
{
    # take the data out
    dat     <- env$datF;
    t2      <- env$t2;
    concs   <- env$concs;
    time    <- env$Time;
    len <- length(time);

    #
    resid = matrix(0, ncol = length(concs), nrow = length(time))
    resid = as.data.frame(resid)
    colnames(resid) = concs
    resid[] <- lapply (seq_along(concs), function(idx)
    {
        # set the concentration of the dissociation to zero.
        conc <- ifelse(time < t2, concs[idx], 0)
        y_data <- dat[[idx]]
        out <- yPred(par=par, conc, time, y_data) - y_data
    })

    #as.vector(as.matrix(resid))
    resid$Time = time;

    resid
}

residArray = function(par = par, env= env) {
    resid <- residFun(par = par, env = env)
    resid <- reshape2::melt(resid, id.vars="Time")
    as.numeric(resid$value)
}

### minimize the residFun using nls.lm
require(minpack.lm)
kinFit <- function(par= par, env= env) {
    #
    lowerBound  <- as.numeric(env$lowerBound);
    upperBound  <- as.numeric(env$upperBound);
    #env_test$concs      = concs;
    #env_test$datF       = ySimulated;
    minpack.lm::nls.lm(par = par, lower=lowerBound, upper=upperBound, fn= residArray, jac = NULL, control = minpack.lm::nls.lm.control(), env = env)
}
