#' pldfit: Fitting the Protein-Ligand Sensorgram Data
#'
#' Fitting the protein-ligand sensorgram data collected from a BLI biosensor or SPR
#' experiment.
#'
#' BLI Biosensor became a popular method to study protein-protein, and protein-ligand
#'  interactions recently.
#'  However, the data fitting is a challenge because the fitting program availabe
#'  has only a limited number of conventioanal models. The present package is the first time
#'  to use R to fit this kind of data. A novel model was developed in the package,
#'  which enable us to study the protein self-homodimerization using the biosensor
#'  method.
#'
#' @section model:
#' The pldfit provide two models:
#'
#'  1. The "simple1to1" model:  the protein immobilized on the pin has one binding
#'  site for the ligand, usally in a 96-well plate.
#'
#'  2. The dimer model: the protein dimerize itself. So it will binding itself
#'  in the solusion biside the interaction on the pin.
#'
#' @section kinfit:
#'  The function to fit the sensorgram data. there are two models: "simple1to1"
#'  and "dimer" model.
#'
#' @section kinsim:
#'  The function to simulate the sensorgram data. there are two models: "simple1to1"
#'  and "dimer" model.
#'
#' @docType package
#' @name pldfit
#' @seealso \code{\link{kinfit}}
#'
#' \code{\link{kinsim}}
NULL

