% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/opts.R
\name{e_locale}
\alias{e_locale}
\alias{e_locale_manual}
\title{Locale}
\usage{
e_locale(e, locale)

e_locale_manual(e, locale, path)
}
\arguments{
\item{e}{An \code{echarts4r} object as returned by \code{\link{e_charts}} or
a proxy as returned by \code{\link{echarts4rProxy}}.}

\item{locale}{Locale to set to.}

\item{path}{Path to the local file to use.}
}
\description{
Change the locale to auto-translate
days of the week, etc.
}
\details{
The "manual" function expects a file
to use for translations.
You can browse the `.js` files
[here](https://github.com/apache/echarts/tree/master/i18n)
to have an idea of what they should look like.
}
\section{Locales}{

- CS
- DE
- EN
- ES
- FI
- FR
- JA
- PT (brazil)
- SI
- TH
- ZH
}

\examples{
# top right corner zoom is in 
# French
cars |> 
 e_charts(speed) |> 
 e_scatter(dist) |> 
 e_datazoom() |> 
 e_locale("FR")

}
