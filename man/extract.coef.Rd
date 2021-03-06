\name{extract.coef}
\alias{extract.coef}
\title{extract.coef}
\usage{
  extract.coef(model, ...)
}
\arguments{
  \item{model}{Model object to extract information from.}

  \item{\dots}{Further arguments}
}
\value{
  A \code{\link{data.frame}} containing the coefficient,
  the standard error and the variable name.
}
\description{
  Extract Coefficient Information from glm Models
}
\details{
  Gets the coefficient values and standard errors, and
  variable names from a glm model.
}
\examples{
require(ggplot2)
data(diamonds)
mod1 <- lm(price ~ carat + cut + x, data=diamonds)
mod2 <- glm(price > 10000 ~ carat + cut + x, data=diamonds, family=binomial(link="logit"))
mod3 <- lm(price ~ carat*cut + x, data=diamonds)
extract.coef(mod1)
extract.coef(mod2)
extract.coef(mod3)
\dontrun{
mod4 <- rxLinMod(price ~ carat*cut + x, diamonds)
}
}
\author{
  Jared P. Lander
}

