# Contribuir a estacionr

¡Gracias por querer colaborar en la mejora de **estacionr**!  
Este documento explica, de manera simple, cómo podés proponer cambios, reportar errores o sumar ideas al proyecto.  
El objetivo es que contribuir sea fácil, ordenado y, sobre todo, una buena experiencia para todos.


## Como colaborar

Podés ayudarnos de muchas formas: mejorando la documentación, reportando errores, proponiendo nuevas funciones o ideas,  
o simplemente probando el paquete y contando tu experiencia.

Si querés sugerir algo o informar un problema, abrí un **issue** en el repositorio de GitHub para que podamos conversarlo.  
De esa forma mantenemos todo organizado y visible para quienes también quieran participar.

Para hacer cambios directamente en el código, hacé un Pull Request.

### Cómo hacer un Pull Request

1. **Hacé un fork** del repositorio y clonalo en tu compu.  
   Si no sabés cómo, podés hacerlo fácilmente con:  
   `usethis::create_from_github("ifylopez/estacionr", fork = TRUE)`

2. **Instalá las dependencias de desarrollo** con:  
   `devtools::install_dev_deps()`  
   y verificá que todo funcione corriendo:  
   `devtools::check()`

3. **Creá una rama nueva** para tu cambio con un nombre descriptivo, por ejemplo:  
   `usethis::pr_init("arreglo-funcion-tabla")`

4. **Hacé tus cambios**, guardá y confirmalos (commit).  


## Estilo de código

Queremos que el código de **estacionr** sea claro y fácil de leer.  
Para eso seguimos la [guía de estilo del tidyverse](https://style.tidyverse.org).  
No hace falta que sea perfecto: si tenés dudas, subí tu aporte igual y lo revisamos juntos 🙂  

Usamos:
- [roxygen2](https://cran.r-project.org/package=roxygen2) con sintaxis Markdown para documentar las funciones.  
- [testthat](https://cran.r-project.org/package=testthat) para los tests (si podés incluir alguno, ¡mejor!).  

## Código de conducta

Este proyecto está pensado para aprender, compartir y colaborar.  
Esperamos que todas las interacciones se den en un ambiente respetuoso y constructivo.  
Por eso, **estacionr** sigue un [ver el Código de Conducta](../CODE_OF_CONDUCT.md) 
Al contribuir, aceptás sus términos.

---

✨ ¡Gracias de nuevo por sumar tu granito de arena!  
Cada corrección, sugerencia o comentario ayuda a que **estacionr** siga creciendo y mejorando.
