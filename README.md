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
##  version
  1.  This version consider the whole corners around the current probability point at the calculation, you can look that the pattern ussually goes to the lower side of the lattice and appear at the other side and goes down again until it reaches the u_anode border. This will be corrected at the next version.
  2.  Now simmulation doe not include corners in the current probability node which is being computed, so just uses the "cross" nodes around the poiny. It was detected a mistake which describes de preference of going lower by the discharge pattern because when scanning the neighbor nodes in the probability function and the "adding to pattern" function, it was neglecting the main diagonal points of the 3x3 scan grid; thus in this version it is neglected the secondary diagonal of the scanning matrix.
  if you want to add the whole corners just uncomment that calculations in probability function and "add to pattern" function.
