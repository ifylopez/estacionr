#' TABLA RESUMEN DE TEMPERATURA
#'
#' Calcula estadísticas descriptivas de la variable `temperatura_abrigo_150cm`
#' para una o varias estaciones meteorológicas y devuelve una tabla resumen con los resultados.
#'
#' @param ... Uno o más data frames con registros meteorológicos que contengan
#' la columna `temperatura_abrigo_150cm` y el identificador de estación `id`.
#'
#' @details
#' La función valida que todos los argumentos recibidos sean data frames y luego
#' calcula para cada uno un conjunto de medidas descriptivas de (`temperatura_abrigo_150cm`).
#' Devuelve una tabla combinada con un resumen por estación.
#'
#' @return
#' Un objeto de clase `data.frame` con las siguientes columnas:
#' - `estacion`: identificador único de la estación (`id`).
#' - `media`: temperatura media (°C).
#' - `minimo`: temperatura mínima registrada (°C).
#' - `maximo`: temperatura máxima registrada (°C).
#' - `desviacion`: desviación estándar de la temperatura (°C).
#' - `n_observaciones`: cantidad de registros válidos considerados en el cálculo.
#'
#' Cada fila representa el resumen estadístico de una estación meteorológica.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Calcular resumen de una sola estación
#' resumen_NH0472 <- tabla_resumen_temperatura(datos_NH0472)
#'
#' # Calcular resumen combinado para varias estaciones
#' resumen_multiple <- tabla_resumen_temperatura(datos_NH0472, datos_NH0910, datos_NH0046)
#' }
tabla_resumen_temperatura <- function(...) {
  args <- list(...)

  # Verificación: todos deben ser data frames
  if (!all(vapply(args, is.data.frame, logical(1)))) {
    cli::cli_abort("Todos los argumentos deben ser data frames. Verifica los objetos pasados a la función.")
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

  cli::cli_inform("Resumen generado correctamente para {nrow(resumenes)} estación(es).")
  return(resumenes)
}
