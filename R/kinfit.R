### minimize the residFun using nls.lm

kinfit <- function(par= par, env = env) {
    #
    lowerBound  <- as.numeric(env$lowerBound);
    upperBound  <- as.numeric(env$upperBound);
    #env_test$concs      = concs;
    #env_test$datF       = ySimulated;
    minpack.lm::nls.lm(par = par,
                       lower=lowerBound,
                       upper=upperBound,
                       fn= residArray,
                       jac = NULL,
                       control = minpack.lm::nls.lm.control(),
                       env = env)
}
