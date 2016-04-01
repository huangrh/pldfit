[![Travis-CI Build Status](https://travis-ci.org/huangrh/pldfit.svg?branch=master)](https://travis-ci.org/huangrh/pldfit)

# Protein-Ligand Biosensor Data Process in R
-----
### Introduction    
The purpose of this package is to use [R](https://cran.r-project.org/) to develop novel statistic models and to fit the protein-ligand interaction data obtained from biosensor (both BLI and SPR). [R](https://cran.r-project.org/) is widely used in statistic analysis. [R] also has advantage in large data process. For example, it often takes a lot of work to read biosensor data into certain program to analysis. However, it is easy to read biosensor data into a data frame, the most common method to store data in [R](https://cran.r-project.org/).  
In this packages, we first developed a dimerization model and applied it to fit the BLI data of von Willebrand factor propeptide. We  successfully determined the dimerization constant and kinetic parameters of von Willebrand factor propeptide [( for background ) ](http://www.pnas.org/content/105/2/482.full). 

-----
There are two major biosensor techniques in studying protein-ligand insteraction:  
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

[Equation & algotithm](https://huangrh.github.io/pldfit/vignettes/Protein-Ligand%20Biosensor%20Data%20Fitting.html)

[Simple one to one model: simulation & fitting](https://huangrh.github.io/pldfit/vignettes/Simple%20One%20to%20One%20Binding_%20Simulation.html)

[Dimerization model: simulation & fitting](https://huangrh.github.io/pldfit/vignettes/Dimerization%20Model_%20Simulation%20%26%20Fitting.html)

