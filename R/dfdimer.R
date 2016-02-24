##============================================================================##
## wrapper of ydimer, for concentration series.
## return a data frame including both xdata and calculated ydata.
dfdimer <-
    function(par = par, dat = dat, noise = 0.01)
    {
        # take the data out from the list
        concs   = dat$concs
        xdata   = dat$xdata
        ydata   = dat$ydata
        t2      = dat$t2

        results = matrix(0, ncol = length(concs), nrow = length(xdata))
        results = as.data.frame(results)

        results[] <- lapply(concs, function(conc)
        {
            conc = ifelse(xdata < t2, conc, 0);
            ydimer(par = par, conc=conc, xdata = xdata, ydata = ydata);

        })
        # add noise
        if (noise) {
            # default sd should set 0.01
            results = results + rnorm(ncol(results)*nrow(results), sd = noise);
        }

        colnames(results) = concs
        results$Time <- xdata
        return(results)
    }
