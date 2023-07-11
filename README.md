# Cormas OpenMole Bridge

[![CI](https://github.com/cormas/cormas-openmole/actions/workflows/test.yml/badge.svg)](https://github.com/cormas/cormas-openmole/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/cormas/cormas-openmole/badge.svg?branch=main)](https://coveralls.io/github/cormas/cormas-openmole?branch=main)
[![Pharo version](https://img.shields.io/badge/Pharo-v11.0-%23aac9ff.svg)](https://pharo.org/download)
[![Cormas version](https://img.shields.io/badge/Cormas-v0.5-green?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAPCAMAAAAMCGV4AAABSlBMVEUAAAAOp0PDL3IGo0EDo0Int1XABWwAokAao0YVo0bNA3EFokIAoT8Lo0QOpEXALXAJqkYVo0c6tFsQpkYIqUiFHVhIs2AVoUhR8nkpmEQnj0LIAG9BeUeYRF27HWoDkUEPnkGJSFoFo0Ijo0gRmUIEokIdm0EHokFGckbDIW/FK3EMmEMApEJ+TFhqYFAWo0UAo0ExgkMNokO4GWsDo0ErpEwQpkLMDHQxdkUgikIopErKAHEIo0ICoUIAp0SrLGYCkUJlW04ra0MLo0U/p1ieLV7DPHUAq1QEgFC6AG0oWEBeAEwuuVHMAGYCuUoOsUjZI3rNDnPHA28Pv04MuUsBr0UBqUPaHnrZGHnPGXW6SXDIIXDAL2+0QGu4NGuhTWR2ZlZ4XlVjdlJocFJoaVAaukxHjUwXs0oFs0kbrEg6jEgUqUcYnUYUpEI1naPBAAAATnRSTlMABFZwUwf85dfFtY2HcmZcPDAuKCMiIB4J+vbx7evn49/d3dvY1tTTx8PAvr68ubm0sK+snpSSkZGOhoOAgHxzbWJfWVFPSEZAPyAbFgqRz/lQAAAAxUlEQVQI1zXOw5IDYQBF4fM3Ynts27bVHc9MbOf9t6l0Kl/VXZzdxaA4HLKfscCKpncTh6ijVBdbl6GI7xsEw8naCTyeXygCw3Y7EJzJFEuNecXotcngbOxsyrTT0Z0Aq9NHf27cv1fvEykPgq1afJMfNrK8NfeB+2pcAqToC0tmnHtiPW+TXiVb7gGLGXvCx24h+h8zlT9D+jHhtBW+Pu4WKgcRS9oP15r12XM711vmSXMB2FPJZL1/qiK8GLzyjSs8es8AWmUcev/cGYQAAAAASUVORK5CYII=)](https://github.com/cormas/cormas)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/cormas/cormas-openmole/master/LICENSE)

## How to install it?

In your [Pharo image](https://pharo.org/download), open the Playground (Ctrl+OW) and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
    onConflictUseLoaded;
    baseline: 'CormasOpenMole';
    repository: 'github://cormas/cormas-openmole:main';
    load.
```

To check if installation is correct, go to the `Cormas-OpenMole-Tests` package and run all the tests.
