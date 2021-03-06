\name{matchCoefs}
\alias{matchCoefs}
\title{matchCoefs}
\usage{
  matchCoefs(model, ...)
}
\arguments{
  \item{model}{Fitted model}

  \item{\dots}{Further arguments}
}
\value{
  a data.frame matching predictors to coefficients
}
\description{
  Match coefficients to predictors
}
\details{
  Matches coefficients to predictors using information from
  model matrices
}
\examples{
require(reshape2)
require(plyr)
data("tips", package="reshape2")
mod1 <- lm(tip ~ total_bill * sex + day, tips)
mod2 <- lm(tip ~ total_bill * sex + day - 1, tips)
mod3 <- glm(tip ~ total_bill * sex + day, tips, family=gaussian(link="identity"))
mod4 <- lm(tip ~ (total_bill + sex + day)^3, tips)
mod5 <- lm(tip ~ total_bill * sex + day + I(total_bill^2), tips)
coefplot:::matchCoefs(mod1)
coefplot:::matchCoefs(mod2)
coefplot:::matchCoefs(mod3)
coefplot:::matchCoefs(mod4)
coefplot:::matchCoefs(mod5)
}
\author{
  Jared P. Lander
}

