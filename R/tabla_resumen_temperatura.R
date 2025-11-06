#' TABLA RESUMEN DE TEMPERATURA
#'
#' Calcula estadisticas descriptivas de la variable `temperatura_abrigo_150cm`
#' para una o varias estaciones meteorologicas y devuelve una tabla resumen con los resultados.
#'
#' @param ... Uno o mas data frames con registros meteorologicos que contengan
#' la columna `temperatura_abrigo_150cm` y el identificador de estacion `id`.
#'
#' @details
#' La funcion valida que todos los argumentos recibidos sean data frames y luego
#' calcula para cada uno un conjunto de medidas descriptivas de (`temperatura_abrigo_150cm`).
#' Devuelve una tabla combinada con un resumen por estacion.
#'
#' @return
#' Un objeto de clase `data.frame` con las siguientes columnas:
#' - `estacion`: identificador unico de la estacion (`id`).
#' - `media`: temperatura media (°C).
#' - `minimo`: temperatura minima registrada (°C).
#' - `maximo`: temperatura maxima registrada (°C).
#' - `desviacion`: desviacion estandar de la temperatura (°C).
#' - `n_observaciones`: cantidad de registros validos considerados en el calculo.
#'
#' Cada fila representa el resumen estadistico de una estacion meteorologica.
#'
#'
#' @examples
#' # Calcular resumen de una sola estacion
#' data(NH0472)
#' resumen_NH0472 <- tabla_resumen_temperatura(NH0472)
#'
#' # Calcular resumen combinado para varias estaciones
#' data(NH0472)
#' data(NH0910)
#' data(NH0046)
#' resumen_multiple <- tabla_resumen_temperatura(NH0472, NH0910, NH0046)
#' @export
tabla_resumen_temperatura <- function(...) {
  args <- list(...)

  # Verificacion: todos deben ser data frames
  if (!all(vapply(args, is.data.frame, logical(1)))) {
    cli::cli_abort("Todos los argumentos deben ser data frames. Verifica los objetos pasados a la funcion.")
  }

  resumenes <- data.frame()

  for (df in args) {
    estacion_nombre <- unique(df$id)

    resumen <- data.frame(
      estacion = estacion_nombre,
      media = mean(df$temperatura_abrigo_150cm, na.rm = TRUE),
      minimo = min(df$temperatura_abrigo_150cm, na.rm = TRUE),
      maximo = max(df$temperatura_abrigo_150cm, na.rm = TRUE),
      desviacion = sd(df$temperatura_abrigo_150cm, na.rm = TRUE),
      n_observaciones = sum(!is.na(df$temperatura_abrigo_150cm))
    )

    print(resumen)
    cat("\n")

    resumenes <- rbind(resumenes, resumen)
  }

  cli::cli_inform("Resumen generado correctamente para {nrow(resumenes)} estacion(es).")
  return(resumenes)
}

