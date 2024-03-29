% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add.R, R/add_.R
\name{e_candle}
\alias{e_candle}
\alias{e_candle_}
\title{Candlestick}
\usage{
e_candle(e, opening, closing, low, high, bind, name = NULL, legend = TRUE, ...)

e_candle_(
  e,
  opening,
  closing,
  low,
  high,
  bind = NULL,
  name = NULL,
  legend = TRUE,
  ...
)
}
\arguments{
\item{e}{An \code{echarts4r} object as returned by \code{\link{e_charts}} or
a proxy as returned by \code{\link{echarts4rProxy}}.}

\item{opening, closing, low, high}{Stock prices.}

\item{bind}{Binding between datasets, namely for use of \code{\link{e_brush}}.}

\item{name}{name of the serie.}

\item{legend}{Whether to add serie to legend.}

\item{...}{Any other option to pass, check See Also section.}
}
\description{
Add a candlestick chart.
}
\examples{
date <- c(
  "2017-01-01",
  "2017-01-02",
  "2017-01-03",
  "2017-01-04",
  "2017-03-05",
  "2017-01-06",
  "2017-01-07"
)

stock <- data.frame(
  date = date,
  opening = c(200.60, 200.22, 198.43, 199.05, 203.54, 203.40, 208.34),
  closing = c(200.72, 198.85, 199.05, 203.73, 204.08, 208.11, 211.88),
  low = c(197.82, 198.07, 197.90, 198.10, 202.00, 201.50, 207.60),
  high = c(203.32, 200.67, 200.00, 203.95, 204.90, 208.44, 213.17)
)

stock |>
  e_charts(date) |>
  e_candle(opening, closing, low, high) |>
  e_y_axis(min = 190, max = 220)
}
\seealso{
\href{https://echarts.apache.org/en/option.html#series-candlestick}{Additional arguments}
}
