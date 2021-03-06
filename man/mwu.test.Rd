% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mwu.R
\name{mwu.test}
\alias{mwu.test}
\title{Mann-Whitney U test}
\usage{
mwu.test(prep, alternative = c("two.sided", "less", "greater"), correct = TRUE)
}
\arguments{
\item{prep}{A \code{rkt_prep} object.}

\item{alternative}{The alternative hypothesis type. One of: "two.sided", "less", "greater".}

\item{correct}{Logical. Whether to apply continuity correction.}
}
\value{
A list of the class "htest".
}
\description{
Performs the Mann-Whitney U test with a normal approximation.
}
