[![Travis-CI Build Status](https://travis-ci.org/huangrenhuai/pldfit.svg?branch=master)](https://travis-ci.org/huangrenhuai/pldfit)

# Protein-Ligand Biosensor Data Fitting in R
-----
### Introduction    
[R](https://cran.r-project.org/) is widely used in statistics analysis. A data frame is the most common way of storing data in [R](https://cran.r-project.org/). It is easy to convert biosensor data into a data frame. 
The purpose of this package is to use [R](https://cran.r-project.org/) to develop novel models and fit the protein-ligand interaction data obtained from biosensor (both BLI and SPR). In this packages, we first developed a dimerization model and successfully applied it to determined the dimerization constant and kinetic parameters of von Willebrand factor propeptide [( for background ) ](http://www.pnas.org/content/105/2/482.full). 

-----
There are two main biosensor techniques to study protein-ligand insteraction:  
* Bio-layer interferometry (BLI) 
* Surface plasmon resonance (SPR).  

Model in the package:  
* Simple one to one binding
  + steady state 
  + kinetic 
* Dimerization model:  
  + steady state 
  + kinetic 
* Multiple binding sites (to be developed)
  + steady state 
  + kinetic 
  
Other models: to request additional model, you may contact me by <a href="mailto:huangrenhuai@gmail.com?Subject=New%20model" target="_top">EMail</a>


-----
### Installation

pldfit is developed running in [R (following the link to download and install if you need)](https://cran.r-project.org/).   
To get the currect development version from github:    
  \# require devtools  
  \> require(devtools)  
  \> devtools::install_github("huangrenhuai/pldfit")

-----
### Model equation & simulation examples:   

[Equation & algotithm](https://huangrenhuai.github.io/pldfit/vignettes/Protein-Ligand%20Biosensor%20Data%20Fitting.html)

[Simple one to one model: simulation & fitting](https://huangrenhuai.github.io/pldfit/vignettes/Simple%20One%20to%20One%20Binding_%20Simulation.html)

[Dimerization model: simulation & fitting](https://huangrenhuai.github.io/pldfit/vignettes/Dimerization%20Model_%20Simulation%20%26%20Fitting.html)

