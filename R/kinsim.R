#' kinetic simulation
#'
#' @param par parametes in a list, including kon, koff, rmax, cocns, t2, time
#'
#' @param model the binding model, "simple1to1" or dimerization model : "dimer"
#' @param noise the noise level added to the simulated data
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


#' @export
#' @method predict kinfit
predict.kinfit <- function(object,
                   newdata
                   )
{
    # reconstruct the par_fit from par
    par_fit = list()
    par_fit$kon = par$kon
    par_fit$koff = par$koff
    par_fit$rmax =par$rmax
    # additional parameter
    concs   = object$par$concs
    xdata   = object$par$time
    ydata   = NULL
    t2      = object$par$t2

    kinsim(par = par,
           model = "simple1to1",
           noise = 0)


}


