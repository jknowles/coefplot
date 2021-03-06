\name{extract.coef.rxGlm}
\alias{extract.coef.rxGlm}
\title{extract.coef.rxGlm}
\usage{
  \method{extract.coef}{rxGlm} (model, ...)
}
\arguments{
  \item{\dots}{Further arguments}

  \item{model}{Model object to extract information from.}
}
\value{
  A \code{\link{data.frame}} containing the coefficient,
  the standard error and the variable name.
}
\description{
  Extract Coefficient Information from rxGlm Models
}
\details{
  Gets the coefficient values and standard errors, and
  variable names from an rxGlm model.
}
\examples{
\dontrun{
require(ggplot2)
data(diamonds)
mod4 <- rxGlm(price ~ carat + cut + x, data=diamonds)
mod5 <- rxGlm(price > 10000 ~ carat + cut + x, data=diamonds, fmaily="binomial")
extract.coef(mod4)
extract.coef(mod5)
}
}
\author{
  Jared P. Lander
}

