### define the residual function
residArray = function(model = "simple1to1"){
    residArray_ = function(par = par, dat= dat)
    {
        # take the data out
        datF     <- dat$datF;
        t2      <- dat$t2;
        concs   <- dat$concs;
        time    <- dat$xdata;
        len <- length(time);

        #
        resid = matrix(0, ncol = length(concs), nrow = length(time))
        resid = as.data.frame(resid)
        colnames(resid) = concs
        resid[] <- lapply (seq_along(concs), function(idx)
        {
            # set the concentration of the dissociation to zero.
            conc <- ifelse(time < t2, concs[idx], 0)
            ydata <- datF[[idx]]

            # choose the model between ysimple1to1 and ydimer
            simulate = switch(model,
                                simple1to1 = ysimple1to1,
                                dimer = ydimer)
            out <- simulate(par=par, conc, time, ydata) - ydata
        })

        #prepare for melt
        resid$Time = time;

        # melt the resid velue into a single column
        resid <- reshape2::melt(resid, id.vars="Time")
        as.numeric(resid$value)
    }
    return(residArray_)
}

