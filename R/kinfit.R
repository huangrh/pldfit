#' Kinetic Data Fitting of Protein-Ligand Sensorgram
#'
#'
#' kinfit is for fitting a biosensor kinetic data.
#'
#'
#' @param par The initial parameters to be fitted.
#' @param dat A data frame. The first column in the data frame is "Time" followed
#'  by the response (nm) recorded from a biosensor experiment or from a simulation
#'  at the corresponding concentration of the ligand.
#' @param concs The oncentrations. It is usally a series of two-times dilution
#'  of the ligand concentration.
#' @param t2 The beggining of dissociation.
#' @param model The model. Choose the model from "simple1to1" or "dimer".
#' @param bound The upper and lower limits of the parameters used in fitting.
#' It should match with the corresponding parameters of par.
#' @param jac A function to return the Jacobian for the fn function.
#'  see \code{\link[minpack.lm]{nls.lm}} for detail.
#' @param control An optional list of control settings.
#' See \code{\link[minpack.lm]{nls.lm}} and \code{\link[minpack.lm]{nls.lm.control}}
#' for the names of the settable control values and their effect.
#'
#' @return A list with components returned from minpack.lm::nls.lm, including par,
#' hessian, fvec, info, message, diag, niter, rsstrace and deviance.
#' see \code{\link[minpack.lm]{nls.lm}}.
#'
#' The par component also includes "concs", "t2", and "time", which is taken from
#' the input variables.
#'
#' @examples
#' # Simulation  ----------------------------------------------------------
#' Do a simulation first before the perform the following fitting.
#' \code{\link{kinsim}}
#'
#'
#' # Fit the simulated data into the corresponding model--------------------
#'
#' # Prepare fitting parameters
#' initPar_test = list(kon =1, koff = 1, rmax = 1)
#' t2  = par$t2 # t2 is the beginning of the diassociation.
#' concs        = par$concs
#' dat          = xySimulated
#'
# # Fitting
#' fit <- kinfit(par = initPar_test, dat = dat, concs = concs, t2 = t2, model = "simple1to1")
#' names(fit)
#'
#' cbind(simulation= par, init = initPar_test, fitting = fit$par)
#'
#' # Predict  -------------------------------------------------------------
#' predFit <- kinsim(par = fit$par, model = model, noise = 0)
#'
#'
#' # Plot -----------------------------------------------------------------
#'
#' # Plotting the simulation
#' xy <-reshape2::melt(data = xySimulated,
#' id.vars = "Time",
#' measure.vars = rev(1:6),
#' variable.name = "Conc")
#'
#' g <- ggplot()  + xlab("Time (sec)") + ylab("Response (nm)") +
#'     labs(linetype= 'title') +
#'    ylim(-0.025,1) +
#'    theme_classic() +
#'    theme(legend.position=c(0.9, 0.65),
#'          legend.text=element_text(size = rel(1)),
#'          legend.key.size=unit(0.9,"line"));
#' g <- g + geom_line(data = xy, aes(x = Time, y = value, color = Conc));
#' print(g)
#'
#' # Plotting the prediction from the fitted parameters
#' predFit <- reshape2::melt(predFit, id.vars = "Time")
#' g + geom_line(data=predFit, aes(x = Time, y = value, group = variable) )
#'
#' @seealso \code{\link{kinsim}}
#'
#' @export
kinfit <- function(par,
                   dat,
                   concs,
                   t2,
                   model = c("simple1to1","dimer"),
                   lower = NULL,
                   upper = NULL,
                   jac = NULL,
                   control = minpack.lm::nls.lm.control())
{
    if (missing(par))    stop("par is missing when calling kinfit")
    if (missing(dat))    stop("dat is missing when calling kinfit")
    if (missing(t2))     stop("t2 is missing when calling kinfit")
    if (missing(concs))  stop("concs is missing when calling kinfit")

    #
    if (is.null(lower)) lower = list(kon =1e-05, koff=1e-05, rmax = 0.001)
    if (is.null(upper)) upper = list(kon =1e05,  koff=1e05,  rmax = 100)

    # Reconstruct a list "dat_fit"  that required by fn residArray.R,
    dat_fit = list()
    dat_fit$concs = concs
    dat_fit$xdata  = dat$Time
    dat_fit$t2 <- t2 # t2 is the beginning of the diassociation.
    dat_fit$datF       = within(dat, rm("Time"));

    #
    fit <- minpack.lm::nls.lm(par = par,
                              lower = as.numeric(lower),
                              upper = as.numeric(upper),
                              fn= residArray(model = model[1]),
                              jac = jac,
                              control = minpack.lm::nls.lm.control(),
                              dat = dat_fit)
    fit$model     = model
    fit$par$concs = concs
    fit$par$time  = dat$Time
    fit$par$t2    = t2
    fit$dat       = dat
    out <- structure(fit, class = c(class(fit), "kinfit"))
    return(out)
}
