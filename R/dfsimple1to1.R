##============================================================================##
## wrapper of ysimple1to1, for concentration series.
## return a data frame including both xdata and calculated ydata.
dfsimple1to1 <-
    function(par = par, dat = dat, noise = 0.01)
    {
        # take the data out from the list
        concs   = dat$concs
        xdata   = dat$xdata
        ydata   = dat$ydata
        t2      = dat$t2

        example = matrix(0, ncol = length(concs), nrow = length(xdata))
        example = as.data.frame(example)

        example[] <- lapply(concs, function(conc)
        {
            conc = ifelse(xdata < t2, conc, 0);
            ysimple1to1(par = par, conc=conc, xdata = xdata, ydata = ydata);

        })
        # add noise
        if (noise) {
            # default sd should set 0.01
            example = example + rnorm(ncol(example)*nrow(example), sd = noise);
        }

        colnames(example) = concs
        example$Time <- xdata
        return(example)
    }




