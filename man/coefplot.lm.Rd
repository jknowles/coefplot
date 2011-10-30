\name{coefplot.lm}
\alias{coefplot.lm}
\alias{coefplot.rxLinMod}
\title{Dotplot for model coefficients}
\usage{
  coefplot.lm(model, title="Coefficient Plot",
  xlab="Value", ylab="Coefficient", innerCI=1, outerCI=2,
  lwdInner=1, lwdOuter=0, color="blue", cex=.8,
  textAngle=0, numberAngle=0, zeroColor="grey", zeroLWD=1,
  zeroType=2, facet=FALSE, scales="free", sort="natural",
  decreasing=FALSE, numeric=FALSE, fillColor="grey",
  alpha=1/2, horizontal=FALSE, intercept=TRUE, plot=TRUE,
  ...)
}
\arguments{
  \item{model}{The model we are graphing}

  \item{title}{The name of the plot, if NULL then no name
  is given}

  \item{xlab}{The x label}

  \item{ylab}{The y label}

  \item{innerCI}{How wide the inner confidence interval
  should be, normally 1 standard deviation.  If 0, then
  there will be no inner confidence interval.}

  \item{outerCI}{How wide the outer confidence interval
  should be, normally 2 standard deviations.  If 0, then
  there will be no outer confidence interval.}

  \item{lwdInner}{The thickness of the inner confidence
  interval}

  \item{lwdOuter}{The thickness of the outer confidence
  interval}

  \item{color}{The color of the points and lines}

  \item{cex}{The text size multiplier, currently not used}

  \item{textAngle}{The angle for the coefficient labels, 0
  is horizontal}

  \item{numberAngle}{The angle for the value labels, 0 is
  horizontal}

  \item{zeroColor}{The color of the line indicating 0}

  \item{zeroLWD}{The thickness of the 0 line}

  \item{zeroType}{The type of 0 line, 0 will mean no line}

  \item{facet}{logical; If the coefficients should be
  faceted by the variables, numeric coefficients (including
  the intercept) will be one facet}

  \item{scales}{The way the axes should be treated in a
  faceted plot.  Can be c("fixed", "free", "free_x",
  "free_y")}

  \item{sort}{Determines the sort order of the
  coefficients.  Possible values are c("natural", "normal",
  "magnitude", "size", "alphabetical")}

  \item{decreasing}{logical; Whether the coefficients
  should be ascending or descending}

  \item{numeric}{logical; If true and factors has exactly
  one value, then it is displayed in a horizontal graph
  with constinuous confidence bounds.}

  \item{fillColor}{The color of the confidence bounds for a
  numeric factor}

  \item{alpha}{The transparency level of the numeric
  factor's confidence bound}

  \item{horizontal}{logical; If the plot should be
  displayed horizontally}

  \item{intercept}{logical; Whether the Intercept
  coefficient should be plotted}

  \item{plot}{logical; If the plot should be drawn, if
  false then a data.frame of the values will be returned}

  \item{\dots}{See Details for information on
  \code{factors}, \code{only} and \code{shorten}}
}
\value{
  If \code{plot} is \code{TRUE} then a \code{\link{ggplot}}
  object is returned.  Otherwise a \code{\link{data.frame}}
  listing coeffcients and confidence bands is returned.
}
\description{
  A graphical display of the coefficients and standard
  errors from a fitted model
}
\details{
  \code{coefplot} is the S3 generic method for plotting the
  coefficients from a fitted model.

  \code{factors} Vector of factor variables that will be
  the only ones shown

  \code{only} logical; If factors has a value this
  determines how interactions are treated.  True means just
  that variable will be shown and not its interactions.
  False means interactions will be included.

  \code{shorten} logical or character; If \code{FALSE} then
  coefficients for factor levels will include their
  variable name.  If \code{TRUE} coefficients for factor
  levels will be stripped of their variable names.  If a
  character vector of variables only coefficients for
  factor levels associated with those variables will the
  variable names stripped.
}
\examples{
data(diamonds)
corner(diamonds)
model1 <- lm(price ~ carat + cut*color, data=diamonds)
model2 <- lm(price ~ carat*color, data=diamonds)
coefplot(model1)
coefplot(model1, shorten=FALSE)
coefplot(model1, shorten=c("cut"))
coefplot(model1, shorten=c("cut"), intercept=FALSE)
coefplot(model1, factors="cut")
coefplot(model1, factors="cut", only=TRUE)
coefplot(model1, facet=TRUE)
coefplot(model2)
}
\author{
  Jared P. Lander www.jaredlander.com
}
\seealso{
  \code{\link{lm}} \code{\link{glm}} \code{\link{ggplot}}
  \code{\link{coefplot}} \code{\link{plotcoef}}
}
