\name{getCoefsFromPredictors.rxLinMod}
\alias{getCoefsFromPredictors.rxLinMod}
\title{getCoefsFromPredictors.rxLinMod}
\usage{
  getCoefsFromPredictors.rxLinMod(model, predictors = NULL,
    strict = FALSE, ...)
}
\arguments{
  \item{model}{A fitted model}

  \item{predictors}{A character vector of predictors to
  match against}

  \item{strict}{Logical specifying if interactions terms
  should be included (\code{FALSE}) or just the main terms
  (\code{TRUE}).}

  \item{\dots}{further arguments}
}
\value{
  A character vector of coefficients listing the
  coefficients that match the predictor
}
\description{
  Function for matching coefficients with predictors for
  rxLinMod
}
\details{
  The user specifies predictors whose coefficients should
  be included in the coefplot.
}
\author{
  Jared P. Lander
}

