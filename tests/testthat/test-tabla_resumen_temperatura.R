test_that("tabla_resumen_temperatura calcula correctamente para una estación", {
    df <- data.frame(
      id = rep("E1", 5),
      temperatura_abrigo_150cm = c(20, 22, 21, 23, 24)
    )

    resumen <- tabla_resumen_temperatura(df)

    # Debe devolver un data.frame con una fila y columnas esperadas
    expect_true(is.data.frame(resumen))
    expect_equal(nrow(resumen), 1L)
    expect_true(all(c("estacion", "media", "minimo", "maximo", "desviacion", "n_observaciones") %in% names(resumen)))

    expect_equal(resumen$media, mean(df$temperatura_abrigo_150cm))
    expect_equal(resumen$minimo, min(df$temperatura_abrigo_150cm))
    expect_equal(resumen$maximo, max(df$temperatura_abrigo_150cm))
  })


test_that("tabla_resumen_temperatura combina correctamente varias estaciones", {
  df1 <- data.frame(
    id = rep("E1", 3),
    temperatura_abrigo_150cm = c(20, 21, 22)
  )

  df2 <- data.frame(
    id = rep("E2", 4),
    temperatura_abrigo_150cm = c(15, 16, 17, 18)
  )

  resumen <- tabla_resumen_temperatura(df1, df2)

  # Debe devolver un data.frame con una fila por estación
  expect_true(is.data.frame(resumen))
  expect_equal(nrow(resumen), 2L)
  expect_true(all(c("E1", "E2") %in% resumen$estacion))
})

test_that("tabla_resumen_temperatura arroja error si se pasa un argumento no válido", {
  df <- data.frame(
    id = rep("E1", 3),
    temperatura_abrigo_150cm = c(20, 21, 22)
  )

  # Pasamos un número en lugar de un data frame
  expect_error(
    tabla_resumen_temperatura(df, 123),
    regexp = "data frames"
  )
})
