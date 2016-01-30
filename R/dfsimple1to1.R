##============================================================================##
## wrapper of ysimple1to1, for concentration series.
## return a data frame including both xdata and calculated ydata.
dfsimple1to1 <-
    function(par = par, concs = concs, xdata = time, ydata = NULL, t2 = t2)
    {
        example = matrix(0, ncol = length(concs), nrow = length(time))
        example = as.data.frame(example)

        example[] <- lapply(concs, function(conc)
        {
            conc = ifelse(time < t2, conc, 0);
            predict_y <-
                ysimple1to1(par = par, conc=conc, xdata = time, ydata = ydata);
        })
        example;
        example$Time <- time
        return(example)
    }




