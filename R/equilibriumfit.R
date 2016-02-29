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
