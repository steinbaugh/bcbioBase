% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sampleDirs.R
\name{sampleDirs}
\alias{sampleDirs}
\title{Sample directories}
\usage{
sampleDirs(uploadDir)
}
\arguments{
\item{uploadDir}{\code{character(1)}.
Final upload directory path.}
}
\value{
Named \code{character}. Sample directory paths.
}
\description{
Sample directories
}
\note{
Updated 2020-01-17.

Function will \code{\link[base:stop]{stop()}} if no sample directories match.
}
\examples{
uploadDir <- system.file("extdata/bcbio", package = "bcbioBase")
x <- sampleDirs(uploadDir)
basename(x)
}
\author{
Michael Steinbaugh
}
