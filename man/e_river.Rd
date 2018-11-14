% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add.R, R/add_.R
\name{e_river}
\alias{e_river}
\alias{e_river_}
\title{River}
\usage{
e_river(e, serie, name = NULL, legend = TRUE, rm_x = TRUE,
  rm_y = TRUE, ...)

e_river_(e, serie, name = NULL, legend = TRUE, rm_x = TRUE,
  rm_y = TRUE, ...)
}
\arguments{
\item{e}{An \code{echarts4r} object as returned by \code{\link{e_charts}}.}

\item{serie}{Column name of serie to plot.}

\item{name}{name of the serie.}

\item{legend}{Whether to add serie to legend.}

\item{rm_x, rm_y}{Whether to remove x and y axis, defaults to \code{TRUE}.}

\item{...}{Any other option to pass, check See Also section.}
}
\description{
Build a theme river.
}
\examples{
dates <- seq.Date(Sys.Date() - 30, Sys.Date(), by = "day")

df <- data.frame(
  dates = dates,
  apples = runif(length(dates)),
  bananas = runif(length(dates)),
  pears = runif(length(dates))
)

df \%>\% 
  e_charts(dates) \%>\% 
  e_river(apples) \%>\% 
  e_river(bananas) \%>\% 
  e_river(pears) \%>\% 
  e_tooltip(trigger = "axis")

}
\seealso{
\href{https://ecomfe.github.io/echarts-doc/public/en/option.html#series-themeRiver}{Additional arguments}
}