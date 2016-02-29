
ydimer <- function(par = par, conc=conc, xdata=time, ydata = NULL) {

    # fiting params
    kon   <- par$kon
    koff  <- par$koff
    rmax  <- par$rmax

    # conc correction for dimerization
    kd2 <- koff/kon
    conc <- ifelse(conc == 0, 0, (sqrt( kd2 * kd2 + 4 * kd2 * conc) - kd2)/2)

    # dt: time intervals
    len <- length(xdata);
    dt  <- xdata[2:len] - xdata[1:(len-1)] # time intarvals, length is (len -1)

    # define the simple1to1 model here.
    # measured responses with baseline corrected.
    # ydata = y - baseline
    if (is.null(ydata)){
        predict_y = rep(0, length.out=len);
        for (i in 2:len) {
            ydata <- predict_y[i-1];

            dy <- conc[i] * kon * (rmax - ydata) - koff * ydata;

            predict_y[i] = ydata + dy*dt[i-1];
            # cat(predict_y[i], "\n")
        }
        ydata <- predict_y; # copy the predict_y to ydata
    }

    # If yData is not null.
    {
    dy <- conc * kon * (rmax - ydata) - koff * ydata # the model
    dy <- (dy[1:(len-1)] + dy[2:len]) / 2; # vector length is (len -1)
    # numerical integration that predict the responses(ydata).
    predict_y = cumsum(dy * dt); # length of data points = len -1
    }

    # add the first point back to keep the length consistently
    predict_y <- c(0, predict_y);
}



