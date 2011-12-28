## Plotting Functions
#buildPlotting <-function()

#' Coefplot plotting
#'
#' Build ggplot object for coefplot
#'
#' This function builds up the ggplot layer by layer for \code{\link{coefplot.lm}}
#'
#' @author Jared P. Lander www.jaredlander.com
#' @seealso \code{\link{coefplot.lm}} \code{\link{coefplot}} \code{\link{multiplot}}
#' @aliases buildPlotting.lm
#' @param modelCI An object created by \code{\link{buildModelCI}}
#' @param modelMeltInner The inner SE part of the object built by \code{\link{meltModelCI}}
#' @param modelMeltOuter The outer SE part of the object built by \code{\link{meltModelCI}}
#' @param title The name of the plot, if NULL then no name is given
#' @param xlab The x label
#' @param ylab The y label
#' @param innerCI How wide the inner confidence interval should be, normally 1 standard deviation.  If 0, then there will be no inner confidence interval.
#' @param outerCI How wide the outer confidence interval should be, normally 2 standard deviations.  If 0, then there will be no outer confidence interval.
#' @param multi logical; If this is for \code{\link{multiplot}} then dodge the geoms
#' @param lwdInner The thickness of the inner confidence interval
#' @param lwdOuter The thickness of the outer confidence interval
#' @param color The color of the points and lines
#' @param cex The text size multiplier, currently not used
#' @param textAngle The angle for the coefficient labels, 0 is horizontal
#' @param numberAngle The angle for the value labels, 0 is horizontal
#' @param zeroColor The color of the line indicating 0
#' @param zeroLWD The thickness of the 0 line
#' @param zeroType The type of 0 line, 0 will mean no line
#' @param facet logical; If the coefficients should be faceted by the variables, numeric coefficients (including the intercept) will be one facet
#' @param scales The way the axes should be treated in a faceted plot.  Can be c("fixed", "free", "free_x", "free_y")
#' @param numeric logical; If true and factors has exactly one value, then it is displayed in a horizontal graph with constinuous confidence bounds.
#' @param fillColor The color of the confidence bounds for a numeric factor
#' @param alpha The transparency level of the numeric factor's confidence bound
#' @param horizontal logical; If the plot should be displayed horizontally
#' @return a ggplot graph object
#' @examples
#'
#' data(diamonds)
#' model1 <- lm(price ~ carat + cut, data=diamonds)
#' theCI <- coefplot:::buildModelCI(model1)
#' theCIMelt <- coefplot:::meltModelCI(theCI)
#' coefplot:::buildPlotting.lm(theCI, theCIMelt$modelMeltInner, theCIMelt$modelMeltInner)
#'
buildPlotting.lm <- function(modelCI, 
                        modelMeltInner=NULL, modelMeltOuter=NULL, 
                        title="Coefficient Plot", xlab="Value", ylab="Coefficient",
                        lwdInner=1, lwdOuter=0, color="blue",
        				cex=.8, textAngle=0, numberAngle=0, outerCI=2, innerCI=1, multi=FALSE,
						zeroColor="grey", zeroLWD=1, zeroType=2, numeric=FALSE, fillColor="grey", alpha=1/2,
    					horizontal=FALSE, facet=FALSE, scales="free")
{
    ## build the layer infos
    # outerCI layer
    # first is for a normal coefplot or a faceted multiplot
    # the second is for a single-pane multiplot

	outerCIGeom <- list(DisplayOne=geom_line(aes(t=CoefShort, x=value, group=CoefShort), data=modelMeltOuter, colour=color, lwd=lwdOuter),
                        DisplayMany=geom_linerange(aes(ymin=LowOuter, ymax=HighOuter, colour=as.factor(Model)), data=modelCI, lwd=lwdOuter, position=position_dodge(width=1)),
                        None=NULL)
	# innerCI layer
    # first is for a normal coefplot or a faceted multiplot
    # the second is for a single-pane multiplot
	innerCIGeom <- list(DisplayOne=geom_line(aes(y=CoefShort, x=value, group=CoefShort), data=modelMeltInner, colour=color, lwd=lwdOuter),
                        DisplayMany=geom_linerange(aes(ymin=LowInner, ymax=HighInner, colour=as.factor(Model)), data=modelCI, lwd=lwdInner, position=position_dodge(width=1)),
                        None=NULL)
	# ribbon layer
	ribbonGeom <- list(None=NULL, geom_ribbon(aes(ymin=LowOuter, ymax=HighOuter, group=Checkers), data=modelCI, fill=fillColor, alpha=alpha, lwd=lwdOuter))

    # point layer
    # first is for a normal coefplot or a faceted multiplot
    # the second is for a single-pane multiplot
    pointGeom <- list(DisplayOne=geom_point(colour=color),
                      DisplayMany=geom_point(position=position_dodge(width=1), aes(ymax=Coef, colour=as.factor(Model))),
                      None=NULL)
    
	# faceting info
	faceting <- list(None=NULL, Display=facet_wrap(~Checkers, scales=scales))
    
    if(numeric)
	{
        # numeric (sideways) plot
		p <- ggplot(data=modelCI, aes(y=Coef, x=CoefShort))			# the basics of the plot
		p <- p + geom_hline(yintercept=0, colour=zeroColor, linetype=zeroType, lwd=zeroLWD)		# the zero line
		p <- p + ribbonGeom[[numeric + 1]]		# the ribbon
		p <- p + geom_point(colour=color)						# the points
		p <- p + geom_line(data=modelCI, aes(y=HighOuter, x=CoefShort, group=Checkers), colour=color) +
			geom_line(data=modelCI, aes(y=LowOuter, x=CoefShort, group=Checkers), colour=color)
	}else if(multi)
    {
        # for a multiplot that plots everything in one panel with dodged geoms
    	p <- ggplot(data=modelCI, aes(y=Coef, x=CoefShort))			# the basics of the plot
    	p <- p + geom_hline(yintercept=0, colour=zeroColor, linetype=zeroType, lwd=zeroLWD)		# the zero line
    	p <- p + outerCIGeom[[(outerCI/outerCI) + multi]] +					# the outer CI bars
    		    innerCIGeom[[innerCI/innerCI + multi]]						# the inner CI bars
       	p <- p + pointGeom[[1 + multi]]						# the points
        p <- p + scale_x_discrete()
     	p <- p + opts(title=title, axis.text.y=theme_text(angle=textAngle), axis.text.x=theme_text(angle=numberAngle)) + labs(y=xlab, x=ylab)	# labeling and text info
     	p <- p + faceting[[facet + 1]]		# faceting
     	p <- p + if(!horizontal) coord_flip()
    }else
    {
        # for a regular coefplot or a multiplot in seperate facets
        p <- ggplot(data=modelCI, aes(x=Coef, y=CoefShort))    		# the basics of the plot
    	p <- p + geom_vline(xintercept=0, colour=zeroColor, linetype=zeroType, lwd=zeroLWD)		# the zero line
        p <- p + outerCIGeom[[(outerCI/outerCI)]] #+    				# the outer CI bars
    		    #innerCIGeom[[innerCI/innerCI]]						# the inner CI bars
       	p <- p + pointGeom[[1]]						# the points
        p <- p + opts(title=title, axis.text.y=theme_text(angle=textAngle), axis.text.x=theme_text(angle=numberAngle)) + labs(x=xlab, y=ylab)    # labeling and text info
        p <- p + faceting[[facet + 1]]    	# faceting
     	p <- p + if(horizontal) coord_flip()
    }
	rm(modelCI); gc()		# housekeeping
    
	return(p)		# return the ggplot object
}