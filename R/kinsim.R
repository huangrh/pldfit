#' Kinetic Simulation of Protein-Ligand Sensorgram Data
#'
#' kinsim generates a sensorgram data according to the input parameters, kon, koff,
#' rmax, concs, t2, time and the chosen model.
#'
#' @param par A list of parametes, including kon, koff, rmax, concs, t2, time
#'
#' @param model The binding model, "simple1to1" or dimerization model : "dimer"
#' @param noise The noise level added to the simulated data
#'
#' @return kinsim returns an data frame. The first column of the data frame is
#'   "Time", which is the same the input variable time, and it is followed by the
#'   calculated responses corresponding to each concentration of the concs variable
#'
#' @examples
#' # Simulation  ----------------------------------------------------------
#'
#' # Prepare the parameters for simulation
#' par = list(kon    = 2e2,
#'           koff   = 1e-2,
#'           rmax   = 1,
#'           concs  = 1e-5 * (2^(0:5)),
#'           time   = seq(0, 300, length.out = 1501),
#'           t2     = 150)
#'
#' # Simulating
#' model = "simple1to1"
#' xySimulated <- kinsim(par = par, model = model, noise = 0.01)
#'
#' @seealso \code{\link{kinfit}}
#' @export
kinsim <- function(par,
                   model = "simple1to1",
                   noise = 0.01)
{

    # reconstruct the par_fit from par
    par_fit = list()
    par_fit$kon = par$kon
    par_fit$koff = par$koff
    par_fit$rmax =par$rmax
    # additional parameter
    concs   = par$concs
    xdata   = par$time
    ydata   = NULL
    t2      = par$t2

    # choose a method
    ysim = switch(model,
                  simple1to1 = ysimple1to1,
                  dimer = ydimer)

    results = matrix(0, ncol = length(concs), nrow = length(xdata))
    results = as.data.frame(results)

    results[] <- lapply(concs, function(conc)
    {
        conc = ifelse(xdata < t2, conc, 0);
        ysim(par = par_fit, conc=conc, xdata = xdata, ydata = ydata);

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

#' Predict method for Kinetic Model Fits
#'
#' Predict the responses (nm) correponding to concentrations based on a kinfit object.
#'
#' @param object An kinfit object returned from \code{\link{kinfit}}.
#' @param newdata
#'
#' @export
#' @method predict kinfit
predict.kinfit <- function(object,
                   new_concs,
                   noise = c(0, 0.01)
                   )
{

    # additional parameter
    if (!missing(new_concs) ) {
        object$par$concs = as.vector(new_concs)
    }
    kinsim(par = object$par,
           model = object$model,
           noise = noise[1])


}


