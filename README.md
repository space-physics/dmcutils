# DMC Utils

[![Zenodo](https://zenodo.org/badge/DOI/10.5281/zenodo.241127.svg)](https://zenodo.org/record/241127)

Programs used to help with the Dual-Multi-sCale (DMC) experiment.
Example of dealing with 100000 - 1 million Andor Neo spool files in a fast way.

## Installation

```
git clone https://github.com/space-physics/dmcutils

python -m pip install -e ./dmcutils
```

## Functions

* `angledist` computes angular distance between points (in degrees)
    for a pair of points with RA,decl. or az,el.

## Notes

[Matlab Engine for Python](https://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html)
is optional.
It's only used for corrupted 2010-era Solis files.

---

The Andor Solis Neo spool file format has changed at least three times.
This spool reader is known to work for the 2011-2012 versions (I don't have exact version numbers, but could find out if you need).

For 2008-Spring 2011 spool files, see the `andor_neo_spool` directory in this repo.
