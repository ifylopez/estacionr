test_that("leer_datos_estacion descarga y lee correctamente si el archivo no existe", {
    ruta_temp <- tempfile(fileext = ".csv")
    datos <- leer_datos_estacion("NH0046", ruta_temp)

    expect_true(file.exists(ruta_temp))
    expect_true(is.data.frame(datos))
    expect_true(nrow(datos) > 0)
  })

test_that("leer_datos_estacion lee correctamente si el archivo ya existe", {
  ruta_temp <- tempfile(fileext = ".csv")
  suppressWarnings(leer_datos_estacion("NH0098", ruta_temp))
  datos <- suppressWarnings(leer_datos_estacion("NH0098", ruta_temp))

  expect_true(is.data.frame(datos))
  expect_true(nrow(datos) > 0)
  expect_true(file.exists(ruta_temp))
})

test_that("leer_datos_estacion arroja error si se pasa un ID inválido", {
  ruta_temp <- tempfile(fileext = ".csv")

  expect_error(
    leer_datos_estacion("ESTACION_INEXISTENTE", ruta_temp),
    regexp = "no es valido"
  )
})
