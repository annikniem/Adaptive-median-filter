# Adaptive-median-filter

This MATLAB code filters an image with an adaptive median filter.
The edge pixels have been mirrored so that each of the original pixels
can be filtered and the output image retains its original size.

An adaptive median filter is an edge preserving low-pass filter
that can change its kernel size.

The main advantage of the adaptive median filter compared to a
regular median filter is that it uses the median of the kernel only,
when the value to-be-filtered is not an impulse. Otherwise, the original
pixel's grayscale value is retained. This makes it possible to effectively
filter out noise while also preserving edges and details.

parameters:

kuva = image to be filtered
Smax = maximum filter size

output:

[suodatettu] = filtered image

The output is rounded to 8-bits.


