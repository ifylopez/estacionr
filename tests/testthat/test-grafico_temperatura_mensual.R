test_that("grafico_temperatura_mensual genera un gráfico ggplot válido", {
    df <- data.frame(
      id = rep("E1", 6),
      fecha = seq(as.Date("2024-01-01"), by = "30 days", length.out = 6),
      temperatura_abrigo_150cm = c(20, 21, 19, 22, 23, 21)
    )

    grafico <- grafico_temperatura_mensual(df)

    expect_true(inherits(grafico, "ggplot"))
  })

test_that("grafico_temperatura_mensual respeta el título y color personalizado", {
  df <- data.frame(
    id = rep("E2", 6),
    fecha = seq(as.Date("2024-01-01"), by = "30 days", length.out = 6),
    temperatura_abrigo_150cm = c(15, 16, 17, 18, 17, 16)
  )

  grafico <- grafico_temperatura_mensual(df, colores = "blue", titulo = "Gráfico de prueba")

  expect_true(inherits(grafico, "ggplot"))
  expect_equal(grafico$labels$title, "Gráfico de prueba")
  sc <- grafico$scales$get_scales("colour")
  col_hex <- sc$map("E2")
  expect_equal(col_hex, "#0000FF")  # equivalente a "blue"
})

test_that("grafico_temperatura_mensual arroja error si faltan columnas requeridas", {
  # Falta la columna temperatura_abrigo_150cm
  df_incompleto <- data.frame(
    id = rep("E3", 3),
    fecha = as.Date("2024-01-01") + 0:2
  )

  expect_error(
    grafico_temperatura_mensual(df_incompleto),
    regexp = "temperatura_abrigo_150cm"
  )
})
