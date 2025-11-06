#' LEER DATOS DE UNA ESTACIÓN METEOROLÓGICA
#'
#' Descarga (si es necesario) y lee el archivo CSV de una estacion meteorologica del conjunto de estaciones disponibles.
#'
#' @param id_estacion Cadena de texto que identifica la estacion a leer.
#' @param ruta_archivo Ruta local donde se almacenara o desde donde se leera el archivo CSV.
#'
#' @details
#' La funcion verifica si el archivo correspondiente a la estacion ya esta
#' descargado en el sistema local. Si no existe, lo descarga desde el repositorio
#' en linea de referencia. Luego, lee los datos y
#' devuelve un data frame con las observaciones meteorologicas.
#'
#' @return
#' Un objeto de clase `data.frame` (tibble) con los registros meteorologicos de
#' la estacion seleccionada. Cada fila representa una observacion diaria.
#'
#'
#' @examples
#' # Descargar y leer los datos de la estacion NH0472
#' datos <- leer_datos_estacion("NH0472", "datos/NH0472.csv")
#'
#' # Leer el archivo si ya esta descargado
#' datos_local <- leer_datos_estacion("NH0472", "datos/NH0472.csv")
#' @export


leer_datos_estacion <- function(id_estacion, ruta_archivo) {

  # Estaciones disponibles
  enlaces <- list(
    "metadatos" = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/metadatos_completos.csv",
    "NH0472" = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0472.csv",
    "NH0910" = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0910.csv",
    "NH0046" = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0046.csv",
    "NH0098" = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0098.csv",
    "NH0437" = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0437.csv"
  )

  # Verificar ID valido
  if (!id_estacion %in% names(enlaces)) {
    cli::cli_abort("El ID de estación '{id_estacion}' no es válido. Usa alguno de los siguientes: metadatos, NH0472, NH0910, NH0046, NH0098, NH0437")
  }

  link_archivo <- enlaces[[id_estacion]]

  # Leer o descargar según corresponda
  if (file.exists(ruta_archivo)) {
    cli::cli_inform("El archivo ya está descargado, se procede a leerlo...")
  } else {
    cli::cli_inform("El archivo no está descargado, se procede a descargarlo...")
    dir.create(dirname(ruta_archivo), showWarnings = FALSE, recursive = TRUE)
    utils::download.file(link_archivo, destfile = ruta_archivo)
  }

  # Leer el archivo
  datos_estacion <- readr::read_csv(ruta_archivo, show_col_types = FALSE)

  cli::cli_inform("Lectura completada correctamente para la estación {id_estacion}.")

  return(datos_estacion)
}
