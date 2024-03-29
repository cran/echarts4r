% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add.R, R/add_.R
\name{e_scatter}
\alias{e_scatter}
\alias{e_effect_scatter}
\alias{e_scale}
\alias{e_scatter_}
\alias{e_effect_scatter_}
\title{Scatter}
\usage{
e_scatter(
  e,
  serie,
  size,
  bind,
  symbol = NULL,
  symbol_size = 1,
  scale = e_scale,
  scale_js = "function(data){ return data[3];}",
  name = NULL,
  coord_system = "cartesian2d",
  jitter_factor = 0,
  jitter_amount = NULL,
  legend = TRUE,
  y_index = 0,
  x_index = 0,
  rm_x = TRUE,
  rm_y = TRUE,
  ...
)

e_effect_scatter(
  e,
  serie,
  size,
  bind,
  symbol = NULL,
  symbol_size = 1,
  scale = e_scale,
  scale_js = "function(data){ return data[3];}",
  name = NULL,
  coord_system = "cartesian2d",
  legend = TRUE,
  y_index = 0,
  x_index = 0,
  rm_x = TRUE,
  rm_y = TRUE,
  ...
)

e_scale(x)

e_scatter_(
  e,
  serie,
  size = NULL,
  bind = NULL,
  symbol = NULL,
  symbol_size = 1,
  scale = e_scale,
  scale_js = "function(data){ return data[3];}",
  name = NULL,
  coord_system = "cartesian2d",
  jitter_factor = 0,
  jitter_amount = NULL,
  legend = TRUE,
  y_index = 0,
  x_index = 0,
  rm_x = TRUE,
  rm_y = TRUE,
  ...
)

e_effect_scatter_(
  e,
  serie,
  size = NULL,
  bind = NULL,
  symbol = NULL,
  symbol_size = 1,
  scale = e_scale,
  scale_js = "function(data){ return data[3];}",
  name = NULL,
  coord_system = "cartesian2d",
  legend = TRUE,
  y_index = 0,
  x_index = 0,
  rm_x = TRUE,
  rm_y = TRUE,
  ...
)
}
\arguments{
\item{e}{An \code{echarts4r} object as returned by \code{\link{e_charts}} or
a proxy as returned by \code{\link{echarts4rProxy}}.}

\item{serie}{Column name of serie to plot.}

\item{size}{Column name containing size of points.}

\item{bind}{Binding between datasets, namely for use of \code{\link{e_brush}}.}

\item{symbol}{The symbol to use, default to \code{NULL}, can also be \code{circle}, \code{rect},
\code{roundRect}, \code{triangle}, \code{diamond}, \code{pin}, \code{arrow}, or \code{none}.}

\item{symbol_size}{Size of points, either an integer or a vector of length 2,
if \code{size} is \emph{not} \code{NULL} or missing it is applied as a multiplier to \code{scale}.}

\item{scale}{A function that takes a vector of \code{numeric} and returns a vector of \code{numeric}
of the same length. You can disable the scaling by setting it to \code{NULL}.}

\item{scale_js}{the JavaScript scaling function.}

\item{name}{name of the serie.}

\item{coord_system}{Coordinate system to plot against, see examples.}

\item{jitter_factor, jitter_amount}{Jitter points, passed to \code{jitter}.}

\item{legend}{Whether to add serie to legend.}

\item{x_index, y_index}{Indexes of x and y axis.}

\item{rm_x, rm_y}{Whether to remove x and y axis, only applies if \code{coord_system} is not
set to \code{cartesian2d}.}

\item{...}{Any other option to pass, check See Also section.}

\item{x}{A vector of integers or numeric.}
}
\description{
Add scatter serie.
}
\section{Scaling function}{
 defaults to \code{e_scale} which is a basic function that rescales \code{size}
between 1 and 20 for that makes for decent sized points on the chart.
}

\examples{
# scaling
e_scale(c(1, 1000))

mtcars |>
  e_charts(mpg) |>
  e_scatter(wt, qsec)

# custom function
my_scale <- function(x) scales::rescale(x, to = c(2, 50))

echart <- mtcars |>
  e_charts(mpg) |>
  e_scatter(wt, qsec, scale = my_scale)

echart

# rescale color too
echart |>
  e_visual_map(wt, scale = my_scale)

# or
echart |>
  e_visual_map(min = 2, max = 50)

# disable scaling
mtcars |>
  e_charts(qsec) |>
  e_scatter(wt, mpg, scale = NULL)

# jitter point
mtcars |>
  e_charts(cyl) |>
  e_scatter(wt, symbol_size = 5) |>
  e_scatter(wt, jitter_factor = 2, legend = FALSE)

# examples
USArrests |>
  e_charts(Assault) |>
  e_scatter(Murder, Rape) |>
  e_effect_scatter(Rape, Murder, y_index = 1) |>
  e_grid(index = c(0, 1)) |>
  e_tooltip()

iris |>
  e_charts_("Sepal.Length") |>
  e_scatter_(
    "Sepal.Width",
    symbol_size = c(8, 2),
    symbol = "rect"
  ) |>
  e_x_axis(min = 4)

quakes |>
  e_charts(long) |>
  e_geo(
    roam = TRUE,
    boundingCoords = list(
      c(185, -10),
      c(165, -40)
    )
  ) |>
  e_scatter(lat, mag, coord_system = "geo") |>
  e_visual_map(min = 4, max = 6.5)

# timeline
iris |>
  group_by(Species) |>
  e_charts(Petal.Width, timeline = TRUE) |>
  e_scatter(Sepal.Width, Sepal.Length) |>
  e_tooltip(trigger = "axis")
}
\seealso{
\href{https://echarts.apache.org/en/option.html#series-scatter}{Additional arguments scatter},
 \href{https://echarts.apache.org/en/option.html#series-effectScatter}{Additional arguments for effect scatter}
}
