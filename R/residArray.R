### define the residual function
residArray = function(par = params, env= env_test)
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

    #prepare for melt
    resid$Time = time;

    # melt the resid velue into a single column
    resid <- reshape2::melt(resid, id.vars="Time")
    as.numeric(resid$value)
}
