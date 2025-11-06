#' GRAFICO DE TEMPERATURA PROMEDIO MENSUAL
#'
#' Genera un grafico de lineas con la evolucion mensual de la temperatura promedio
#' para una o varias estaciones meteorologicas.
#' Permite personalizar la paleta de colores y el titulo del grafico.
#'
#' @param df Data frame con los registros meteorologicos de una o mas estaciones.
#'   Debe contener al menos las columnas:
#'   - `id`
#'   - `fecha`
#'   - `temperatura_abrigo_150cm`
#' @param colores Vector opcional de colores a utilizar en el grafico.
#'   Si no se especifica, se seleccionan colores aleatorios.
#' @param titulo Cadena de texto con el titulo principal del grafico.
#'   Por defecto es `"Temperatura"`.
#'
#' @details
#' La funcion calcula el promedio mensual de la variable `temperatura_abrigo_150cm`
#' agrupando por estacion (`id`) y mes (`fecha`). Luego construye un grafico de
#' lineas donde cada estacion se representa con un color distinto.
#' El grafico es generado mediante `ggplot2` y devuelve un objeto de clase `ggplot`.
#'
#' @return
#' Un objeto de clase `ggplot` que muestra la temperatura promedio mensual (C)
#' para cada estacion meteorologica.
#' En el eje X se representan los meses del año y en el eje Y la temperatura
#' promedio correspondiente. Cada linea corresponde a una estacion distinta.
#'
#'
#' @examples
#' # Cargar dataset de ejemplo y graficar
#' data(NH0472)
#' grafico_temperatura_mensual(NH0472)
#'
#' # Cargar otro dataset y personalizar color y titulo
#' data(NH0046)
#' grafico_temperatura_mensual(
#'   df = NH0046,
#'   colores = "darkred",
#'   titulo = "Evolucion mensual de temperatura"
#' )
#' @export
grafico_temperatura_mensual <- function(df, colores = NULL, titulo = "Temperatura") {

  # promedio mensual
  df_mes <- df |>
    dplyr::mutate(mes = lubridate::month(fecha, label = TRUE, abbr = TRUE)) |>
    dplyr::group_by(id, mes) |>
    dplyr::summarise(promedio = mean(temperatura_abrigo_150cm, na.rm = TRUE),
                     .groups = "drop")

  # paleta
  estaciones <- sort(unique(df_mes$id))
  n_ids <- length(estaciones)

  if (is.null(colores)) {
    colores <- sample(colors(), n_ids)
  } else if (length(colores) < n_ids) {
    colores <- c(colores, sample(setdiff(colors(), colores), n_ids - length(colores)))
  }
  # si vienen con nombres, respetar; si no, mapear en orden
  pal <- if (!is.null(names(colores)) && all(estaciones %in% names(colores))) {
    colores[estaciones]
  } else {
    stats::setNames(colores[seq_len(n_ids)], estaciones)
  }

  # grafico
  ggplot2::ggplot(df_mes, ggplot2::aes(x = mes, y = promedio, color = id, group = id)) +
    ggplot2::geom_line(linewidth = 1) +
    ggplot2::geom_point(size = 1.8) +
    ggplot2::scale_color_manual(values = pal, name = "Estacion") +
    ggplot2::labs(
      title = titulo,
      x = "Mes",
      y = "Temperatura promedio (C)"
    ) +
    ggplot2::theme_minimal(base_size = 12) +
    ggplot2::theme(
      legend.position = "bottom",
      plot.title = ggplot2::element_text(face = "bold")
    )
}

