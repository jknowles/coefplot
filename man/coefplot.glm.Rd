\name{coefplot.glm}
\alias{coefplot.glm}
\title{coefplot.glm}
\usage{
  \method{coefplot}{glm} (...)
}
\arguments{
  \item{\dots}{All arguments are passed on to
  \code{\link{coefplot.default}}.  Please see that function
  for argument information.}
}
\value{
  A ggplot object.  See \code{\link{coefplot.lm}} for more
  information.
}
\description{
  Dotplot for glm coefficients
}
\details{
  A graphical display of the coefficients and standard
  errors from a fitted glm model

  \code{\link{coefplot}} is the S3 generic method for
  plotting the coefficients from a fitted model.

  For more information on this function and it's arguments
  see \code{\link{coefplot.default}}
}
\examples{
model2 <- glm(price > 10000 ~ carat + cut*color, data=diamonds, family=binomial(link="logit"))
coefplot(model2)
}
\author{
  Jared P. Lander
}

