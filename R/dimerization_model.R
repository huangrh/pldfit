# setwd("~/Documents/My_Exp/2012BLI_Sadler/model/Rmd")
# source("~/Documents/My_Exp/2012BLI_Sadler/model/Rmd/dimerization.R")

### define the model:
# yPred only work on one concentration at a time
# for multiple concentration, using ySimulate_df
# params = list(kon =1, koff = 1, rmax = 1)
yPred = function(par = params, conc, time, y_data = NULL) {
    # fiting params
    kon   <- par$kon 
    koff  <- par$koff 
    rmax  <- par$rmax 
    
    # derived paramenters
     kd2 <- koff/kon
     conc <- ifelse(conc == 0, 0, (sqrt( kd2 * kd2 + 4 * kd2 * conc) - kd2)/2)
    
    # cat(kon, koff, rmax, "; Kd = ", koff/kon*1e6); 
    # other input dat: conc, time, y_data. 
    
    # dt: time intervals
    len <- length(time); 
    dt  <- time[2:len] - time[1:(len-1)] # time intarvals, length is (len -1)
    
    # define the simple1to1 model here. 
    # measured responses with baseline corrected. 
    # y_data = y - baseline
    if (is.null(y_data)){
        predict_y = rep(0, length.out=len);
        for (i in 2:len) {
            y_data <- predict_y[i-1];
            
            dy <- conc[i] * kon * (rmax - y_data) - koff * y_data;
            
            predict_y[i] = y_data + dy*dt[i-1];
            # cat(predict_y[i], "\n")
        }
        y_data <- predict_y; # copy the predict_y to y_data
    }
    
    # If yData is not null. 
    {
        dy <- conc * kon * (rmax - y_data) - koff * y_data # the model
        dy <- (dy[1:(len-1)] + dy[2:len]) / 2; # vector length is (len -1)
        # numerical integration that predict the responses(y_data).  
        predict_y = cumsum(dy * dt); # length of data points = len -1
    }
    predict_y <- c(0, predict_y); # add the first point back to keep the length consistently 
}



##===========================================##
## wrapper of yPred, for concentration series. 
yPred_df <- function(par = par, concs = concs, time = time, t2 = t2, y_data = NULL) {
    example = matrix(0, ncol = length(concs), nrow = length(time))
    example = as.data.frame(example)
    
    example[] <- lapply(concs, function(conc) {
        conc = ifelse(time < t2, conc, 0);
        predict_y <- yPred(par = par, conc=conc, time=time, y_data = y_data); 
    })
    example;
}

yPred_dft <- function(par = par, concs = concs, time = time, t2 = t2, y_data = NULL) {
    example <- yPred_df(par = par, concs = concs, time = time, t2 = t2, y_data = NULL)
    example$Time <- time
    return(example)
}
##residFun

##kinFit



