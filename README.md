# lichtemberg_figures
##  Description
In this repo you will find a recreation of the lichtenberg figures as a result of a dielectric breakdown model of lightning strike between two electrodes.
##  Features
  - Code's syntax is made for Matlab or GNU-Octave
  - It solves the laplace equation by SOR method with relaxation coefficient 'w = 1.6' over potential in a lattice with continous boundary conditions on oposite borders and generalized boundary conditins on the two oposite border left, like a parallel plate capacitor.
  - Probability function takes the whole neighbor points around the current node, not only the closer points according to each direction (left, right, up, down).
  - Probability function is proportional to a power 'e' of the elctric field between two nodes and a power of a random n such that 0 < n < 1. this is made for giving a non-uniform potential or field which causes the lichtemberg figure like discharge pattern. .
##  Images
Look for any image of simmulation in Images folder located in main.
