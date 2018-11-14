#' Choropleth
#' 
#' Draw maps.
#' 
#' @inheritParams e_bar
#' @param serie Values to plot.
#' @param map Map type.
#' @param coord_system Coordinate system to use, one of \code{cartesian3D}, \code{geo3D}, \code{globe}.
#' @param rm_x,rm_y Whether to remove x and y axis, defaults to \code{TRUE}.
#' @param id,value,height Columns corresponding to registered map.
#' 
#' @examples 
#' \dontrun{
#' choropleth <- data.frame(
#'   countries = c("France", "Brazil", "China", "Russia", "Canada", "India", "United States",
#'                 "Argentina", "Australia"),
#'   values = round(runif(9, 10, 25))
#' )
#' 
#' choropleth %>% 
#'   e_charts(countries) %>% 
#'   e_map(values) %>% 
#'   e_visual_map(min = 10, max = 25)
#' 
#' choropleth %>% 
#'   e_charts(countries) %>% 
#'   e_map_3d(values, shading = "lambert") %>% 
#'   e_visual_map(min = 10, max = 30)
#'   
#' buildings <- jsonlite::read_json(
#'   paste0(
#'     "https://ecomfe.github.io/echarts-examples/",
#'     "public/data-gl/asset/data/buildings.json"
#'   )
#' )
#' 
#' heights <- purrr::map(buildings$features, "properties") %>% 
#'   purrr::map("height") %>% 
#'   unlist()
#'   
#' names <- purrr::map(buildings$features, "properties") %>% 
#'   purrr::map("name") %>% 
#'   unlist()
#'   
#' data <- dplyr::tibble(
#'   name = names,
#'   value = round(runif(length(names), 0, 1), 6),
#'   height = heights / 10
#' )
#' 
#' data %>% 
#'   e_charts() %>% 
#'   e_map_register("buildings", buildings) %>%
#'   e_map_3d_custom(name, value, height) %>% 
#'   e_visual_map(
#'     show = FALSE,
#'     min = 0.4,
#'     max = 1
#'   ) 
#' }
#' 
#' @seealso \code{\link{e_country_names}}, 
#' \href{Additional map arguments}{https://ecomfe.github.io/echarts-doc/public/en/option.html#series-map}, 
#' \href{Additional map 3D arguments}{http://echarts.baidu.com/option-gl.html#series-map3D}
#' 
#' @rdname map
#' @export
e_map <- function(e, serie, map = "world", name = NULL, rm_x = TRUE, rm_y = TRUE, ...){
  
  if(missing(e))
    stop("must pass e", call. = FALSE)
  
  if(!missing(serie))
    sr <- deparse(substitute(serie))
  else
    sr <- NULL
  
  e_map_(e, sr, map, name, rm_x, rm_y, ...)
}

#' @rdname map
#' @export
e_map_ <- function(e, serie = NULL, map = "world", name = NULL, rm_x = TRUE, rm_y = TRUE, ...){
  
  if(missing(e))
    stop("must pass e", call. = FALSE)
  
  e <- .rm_axis(e, rm_x, "x")
  e <- .rm_axis(e, rm_y, "y")
  
  app <- list(
    type = "map",
    map = map,
    ...
  )
  
  if(is.null(name) && !is.null(serie))
    app$name <- serie
  
  if(!is.null(serie)){
    data <- .build_data(e, serie)
    data <- .add_bind(e, data, e$x$mapping$x)
    app$data <- data
  }
  
  e$x$opts$series <- append(e$x$opts$series, list(app))
  
  e
}

#' @rdname map
#' @export
e_map_3d <- function(e, serie, map = "world", name = NULL, coord_system = NULL, rm_x = TRUE, rm_y = TRUE, ...){
  if(missing(e))
    stop("must pass e", call. = FALSE)
  
  if(!missing(serie))
    sr <- deparse(substitute(serie))
  else
    sr <- NULL
  
  e_map_3d_(e = e, serie = sr, map, name, coord_system, rm_x, rm_y, ...)
}

#' @rdname map
#' @export
e_map_3d_ <- function(e, serie = NULL, map = "world", name = NULL, coord_system = NULL, rm_x = TRUE, rm_y = TRUE, ...){
  
  if(missing(e))
    stop("must pass e", call. = FALSE)
  
  e <- .rm_axis(e, rm_x, "x")
  e <- .rm_axis(e, rm_y, "y")
  
  app <- list(
    type = "map3D",
    map = map,
    ...
  )
  
  if(is.null(name) && !is.null(serie))
    app$name <- serie
  
  if(!is.null(coord_system))
    app$coordinateSystem <- coord_system
  
  if(!is.null(serie)){
    data <- .build_data(e, serie)
    data <- .add_bind(e, data, e$x$mapping$x)
    app$data <- data
  }
  
  e$x$opts$series <- append(e$x$opts$series, list(app))
  
  e
}

#' @rdname map
#' @export
e_map_3d_custom <- function(e, id, value, height, map = NULL, name = NULL, rm_x = TRUE, rm_y = TRUE, ...){
  
  if(missing(e))
    stop("must pass e", call. = FALSE)
  
  if(missing(id) || missing(value) || missing(height))
    stop("must pass id, value, and height", call. = FALSE)
  
  if(is.null(map) && length(e$x$mapName))
    map <- unlist(e$x$mapName)
  else
    stop("not map registered, see e_map_register", call. = FALSE)
  
  e$x$renderer <- "webgl"
  
  e <- .rm_axis(e, rm_x, "x")
  e <- .rm_axis(e, rm_y, "y")
  
  app <- list(
    type = "map3D",
    map = map,
    ...
  )
  
  if(!is.null(name))
    app$name <- name
  
  name_quo <- dplyr::enquo(id)
  value_quo <- dplyr::enquo(value)
  height_quo <- dplyr::enquo(height)
  
  data <- e$x$data[[1]] %>% 
    dplyr::select(
      name = !!name_quo,
      value = !!value_quo,
      height = !!height_quo
    ) %>% 
    apply(1, as.list)
  
  app$data <- data
  
  e$x$opts$series <- append(e$x$opts$series, list(app))
  
  e
}

#' Register map
#' 
#' Register a \href{geojson}{http://geojson.org/} map.
#' 
#' @param e An \code{echarts4r} object as returned by \code{\link{e_charts}}.
#' @param name Name of map, to use in \code{\link{e_map}}.
#' @param json \href{Geojson}{http://geojson.org/}.
#' 
#' @examples 
#' \dontrun{
#' json <- jsonlite::read_json("http://www.echartsjs.com/gallery/data/asset/geo/USA.json")
#'
#' USArrests %>%
#'   dplyr::mutate(states = row.names(.)) %>%
#'   e_charts(states) %>%
#'   e_map_register("USA", json) %>%
#'   e_map(Murder, map = "USA") %>% 
#'   e_visual_map(min = 0, max = 18)
#' }
#' 
#' @export
e_map_register <- function(e, name, json){
  e$x$registerMap <- TRUE
  e$x$mapName <- name
  e$x$geoJSON <- json
  e
}

#' Mapbox
#' 
#' Use mapbox.
#' 
#' @inheritParams e_bar
#' @param token Your mapbox token from \href{https://www.mapbox.com/}{mapbox}.
#' @param ... Any option.
#' 
#' @examples 
#' \dontrun{
#' url <- paste0("https://ecomfe.github.io/echarts-examples/",
#'               "public/data-gl/asset/data/population.json")
#' data <- jsonlite::fromJSON(url)
#' data <- as.data.frame(data)
#' names(data) <- c("lon", "lat", "value")
#' 
#' data %>% 
#'   e_charts(lon) %>% 
#'   e_mapbox(
#'     token = "YOUR_MAPBOX_TOKEN",
#'     style = "mapbox://styles/mapbox/dark-v9"
#'   ) %>% 
#'   e_bar_3d(lat, value, coord_system = "mapbox") %>% 
#'   e_visual_map()
#' }
#' 
#' @note Mapbox may not work properly in the RSudio console.
#' 
#' @seealso \href{http://www.echartsjs.com/option-gl.html#mapbox3D.style}{Official documentation},
#' \href{https://www.mapbox.com/mapbox-gl-js/api/}{mapbox documentation}
#' 
#' @name mapbox
#' @export
e_mapbox <- function(e, token, ...){
  
  if(missing(token))
    stop("missing token", call. = FALSE)
  
  e$x$opts$mapbox <- list(...)
  e$x$mapboxToken <- token
  e
}