# Question 1

## Method

1. The filter it calculated by convolving a Laplacian **onto** a Gaussian.
2. The filter is convolved onto the image
3. The edges are cleaned with zero crossing


## Gaussian

### To Test

1. gaussian where *pdf* is calculated by the *sd*
2. sd is *fixed* and spread of pdf is manually defined


## Laplacian

### To Test

1. different sizes of laplacian


## Zero Crossing

This currently takes a long time but short of pooling the loops, i don't know how to deal with this