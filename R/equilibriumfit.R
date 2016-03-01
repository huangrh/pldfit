#' Equilibrium Data Fitting of Protein-Ligand Sensorgram
#'
#' @export
ssgfit <- function(dat,
                   concs,
                   start = list(Rmax = 0.5, Kd=1),
                   width =5,
                   t2 = 149.5,
                   model = c("simple1to1", "dimer")
                   )
{

    # data transform

    dat2 <- data.frame(t(dplyr::filter(dat, Time > t2 - width, Time <t2 - 0.5)))

    dat2 <- dplyr::mutate(
        dat2,
        mean = apply(dat2, 1, FUN = mean),
        sd = apply(dat2, 1, FUN=sd)
    )

    # data
    yData <- dat2$mean
    xData <- concs
    list(xData, yData, model)
}

#' Choose A Equilibrium Model.
#'
#' Choose a model between "simple1to1" and "dimer" to fit the equilibrium data
#'
#' @param model The model symbol. Choose the model bewteen "simple1to1", and "dimer"
#'
#' @export
equilibrium_model <- function(model = c("simple1to1", "dimer")) {
    #simple1to1 model
    simple1to1_model <- formula(yData ~ (Rmax * xData)/(Kd + xData))

    # dimer
    dimer_model <- formula( yData ~
                                (Rmax * (-Kd + sqrt(Kd^2+8*Kd*xData)))/(3*Kd +sqrt(Kd^2+8*Kd*xData)))

    # cho
    chosenModel = switch(model[1],
                         simple1to1 = simple1to1_model,
                         dimer = dimer_model)
    return(chosenModel)
}
