#' Static State SensorGram Data Fitting
#'
#' Equilibrium Data Fitting of Protein-Ligand Sensorgram
#'
#' @export
ssgfit <- function(datF,
                   concs,
                   start = list(Rmax = 0.5, Kd=1),
                   width = 5,
                   t2    = 149.5,
                   model = c("simple1to1", "dimer")
                   )
{

    # data transform
    dat <- dplyr::filter(datF, Time > t2 - width, Time <t2 - 0.5)
    dat <- data.frame(t(dat[!grepl("time", tolower(colnames(dat)))]))
    #
    dat <- dplyr::mutate(
        dat,
        mean = apply(dat, 1, FUN = mean),
        sd   = apply(dat, 1, FUN=sd)
    )

    # data
    yData <- as.numeric(dat$mean)
    xData <- as.numeric(concs)

    # Model dispatch
    #  simple1to1 model in equilibrium
    simple1to1_model <- formula(yData ~ (Rmax * xData)/(Kd + xData))
    #  dimerization in equilibrium
    dimer_model <-
        formula( yData ~ (Rmax * (-Kd + sqrt(Kd^2+8*Kd*xData)))/(3*Kd +sqrt(Kd^2+8*Kd*xData)))
    #  choose a model
    chosenFormula = switch(model[1],
                         simple1to1 = simple1to1_model,
                         dimer = dimer_model)

    ## Fitting
    fit <- stats::nls(formula = chosenFormula,
                      start = list(Rmax = 0.5, Kd=1))
    fit$datF  = data.frame(Conc = xData,
                           Response = yData,
                           sd = as.numeric(dat$sd))
    fit$predict <- data.frame(xData = seq(min(xData), max(xData), len=100 ))
    fit$predict$yData <- predict(fit, newdata=fit$predict)
    class(fit) <- c(class(fit), "ssgfit")
    return(fit)
}

#' Plot Average Response (nm) vs Concentration ()
#'
#' @export
plot.ssgfit <- function(obj) {
    plot(obj$datF[1:2])
    lines(obj$predict, lty = 2, col = "blue")
    title(main = "Equilibrium Fitting", xlab = "Concs (mM)", ylab = "Response (nm)")
}


