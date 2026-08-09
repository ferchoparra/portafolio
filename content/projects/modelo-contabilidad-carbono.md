# Modelo de contabilidad de emisiones de carbono AFOLU

## Resumen ejecutivo

Pipeline analitico en R para estimar emisiones y absorciones de gases de efecto invernadero asociadas al sector agropecuario, forestal y de uso de la tierra. El modelo integra series historicas de produccion, comercio, consumo aparente, poblacion, PIB, coberturas, inventarios ganaderos, informacion forestal y factores de emision provenientes de fuentes como FAOSTAT, NIR/BUR y escenarios NDC.

El proyecto permite proyectar demanda agropecuaria hasta 2050, estimar requerimientos de area y animales, traducir esos cambios en categorias AFOLU y simular escenarios de mitigacion relacionados con rendimientos, ganaderia, manejo de pasturas, arroz, bosques naturales, plantaciones comerciales y cambios en consumo de carne.

## Problema

La contabilidad de emisiones AFOLU requiere conectar procesos que normalmente se analizan por separado: produccion agricola, inventarios pecuarios, comercio exterior, consumo, uso del suelo, crecimiento economico, poblacion y factores de emision. Sin una estructura reproducible, los resultados pueden depender de hojas de calculo manuales, supuestos dispersos y cruces poco trazables.

El reto consistia en construir un flujo que permitiera:

- Consolidar fuentes heterogeneas de datos agropecuarios, forestales y climaticos.
- Proyectar consumo y actividad productiva bajo escenarios economicos y demograficos.
- Estimar areas requeridas, existencias animales y cambios de uso del suelo.
- Aplicar factores de emision y absorcion por categoria AFOLU.
- Comparar escenarios base, NDC y estrategias de mitigacion hacia 2050.
- Generar salidas tabulares, graficas y reportes reproducibles.

## Datos utilizados

- Produccion agricola FAOSTAT: area cosechada, produccion y rendimiento.
- Produccion pecuaria FAOSTAT: animales en produccion, sacrificio, rendimiento y produccion.
- Existencias ganaderas FAOSTAT para calcular inventarios y tasas de extraccion.
- Comercio exterior FAOSTAT: importaciones y exportaciones de cultivos, productos pecuarios y animales vivos.
- Uso de la tierra e indicadores agroambientales: coberturas, tierras forestales, cultivos, pastizales y combustion de biomasa.
- Intensidad de emisiones agropecuarias por producto.
- Emisiones de agricultura y uso de la tierra por categorias como fermentacion enterica, gestion de estiercol, cultivo de arroz, fertilizantes, residuos agricolas y suelos organicos.
- Archivo de elasticidades, factores de conversion, grupos FAO/GCAM, poblacion, PIB y escenarios forestales.
- Informacion NIR/BUR de Colombia para construir factores de emision, absorcion y costos-beneficios.

## Metodologia

El modelo se organizo como un pipeline modular con scripts independientes para adquisicion, curaduria, transformacion, simulacion, analisis y generacion de reportes.

| Etapa | Script | Proposito |
| --- | --- | --- |
| Adquisicion | `acquire_data.R` | Cargar fuentes FAOSTAT, NIR/BUR, elasticidades, factores de conversion, poblacion, PIB y escenarios forestales |
| Curaduria | `curate_data.R` | Estandarizar variables, convertir unidades, calcular consumo aparente, inventarios, tasas de extraccion y factores de emision |
| Transformacion | `transform_data.R` | Proyectar consumo, poblacion, PIB, elasticidades, areas requeridas y emisiones hasta 2050 |
| Simulacion | `Sim_data.R` | Construir escenarios de mitigacion y generar salidas de emisiones, series y resultados |
| Analisis | `analyze_data.R` | Explorar historicos, proyecciones, balances y graficas por cadena o categoria |
| Reportes | `generate_reports.R` | Renderizar articulos, presentaciones, paginas e informes con R Markdown |

### Integracion de datos

La primera parte del flujo carga bases de produccion, comercio, uso del suelo, emisiones, elasticidades y factores de conversion. Luego se armonizan codigos FAO, codigos internos de cultivo, grupos GCAM y categorias agropecuarias.

En cultivos se consolidan area cosechada, produccion y rendimiento. En ganaderia se convierten productos derivados hacia unidades comparables, se seleccionan productos principales y se calculan animales en produccion, inventarios y tasas de extraccion.

### Consumo aparente y proyecciones

El modelo calcula consumo aparente integrando produccion, importaciones y exportaciones. Para proyectar demanda se prueban modelos de tendencia por producto, junto con trayectorias de poblacion y PIB.

El flujo calcula elasticidades ingreso-demanda bajo varias trayectorias, incluyendo escenarios GCAM y NDC. Con estas elasticidades se estima la tasa de crecimiento del consumo y se construye una base proyectada entre 2014 y 2050.

### Actividad, area requerida y frontera agropecuaria

Con las proyecciones de produccion y rendimiento se estiman areas requeridas para cultivos. Para ganaderia se estiman animales totales, produccion, carga animal y area requerida. Estas variables alimentan una representacion de la frontera agropecuaria, especialmente para identificar presiones entre cultivos, pastizales y areas forestales.

El modelo tambien incorpora escenarios forestales, incluyendo plantaciones comerciales y bosque natural, para representar cambios en areas forestales y su relacion con emisiones o absorciones.

### Factores de emision y categorias AFOLU

A partir de la informacion BUR/NIR se construyen factores por animal o por area para:

- Absorciones de CO2.
- Emisiones de CO2.
- Emisiones de CH4.
- Emisiones de N2O.
- Emisiones indirectas NOX.
- Emisiones de CO.

Estos factores se cruzan con la actividad proyectada y se organizan en categorias AFOLU como ganaderia, cultivos, tierras forestales, tierras de cultivo, pastizales, arroz, fertilizantes y manejo de pasturas.

### Escenarios de mitigacion

El script de simulacion define estrategias de analisis para evaluar cambios en emisiones frente a un escenario base. Entre las estrategias codificadas se encuentran:

- Incremento de rendimientos agricolas.
- Aumento de animales por hectarea y mejoras en tasa de extraccion ganadera.
- Reducciones asociadas a fuentes agregadas y emisiones no CO2.
- Mejoramiento de pasturas.
- Manejo de arroz.
- Manejo de bosque natural.
- Expansión de plantaciones comerciales.
- Reduccion de consumo de carne mediante ajustes de elasticidad.
- Escenarios integrados tipo "todo" y escenarios NDC.

## Resultados

El proyecto produjo una arquitectura reproducible para conectar demanda agroalimentaria, uso del suelo y contabilidad de emisiones. Las salidas permiten comparar trayectorias historicas y proyectadas, cuantificar emisiones netas y totales, y evaluar estrategias de mitigacion sobre categorias AFOLU.

Los principales resultados tecnicos fueron:

- Construccion de una base consolidada de consumo aparente por producto.
- Proyeccion de demanda agropecuaria hasta 2050 con poblacion, PIB y elasticidades.
- Estimacion de area requerida para cultivos y ganaderia.
- Calculo de inventarios animales, tasas de extraccion y productividad pecuaria.
- Integracion de escenarios forestales y cambios de uso del suelo.
- Derivacion de factores de emision y absorcion desde informacion BUR/NIR.
- Calculo de emisiones netas y totales por categoria, gas y ano.
- Exportacion de escenarios en archivos Excel para analisis de resultados, NDC y costos-beneficios.

| Salida | Descripcion | Uso analitico |
| --- | --- | --- |
| `BDConsumoFinal` | Consumo aparente historico por producto | Base para modelos de demanda |
| `BDBalComFinal` | Produccion, comercio, consumo, rendimiento y area requerida | Balance agropecuario proyectado |
| `BurEm` | Factores de emision y absorcion por categoria | Contabilidad AFOLU |
| `Final_emi` | Emisiones y absorciones calculadas por actividad | Estimacion neta y total |
| `todo_E`, `todo_S`, `NDC_E`, `NDC_S` | Escenarios integrados de emisiones y series | Comparacion de mitigacion |

## Lecciones aprendidas

La contabilidad de carbono en AFOLU exige tanta rigurosidad en la preparacion de datos como en el calculo final de emisiones. Pequenas decisiones sobre unidades, factores de conversion, inventarios animales o areas base pueden cambiar de forma importante los resultados agregados.

Tambien fue clave separar el flujo en etapas. La arquitectura por scripts permite depurar cada componente: datos originales, bases curadas, proyecciones, factores de emision, escenarios y reportes. Esto mejora la trazabilidad de supuestos y facilita actualizar el modelo cuando cambian fuentes, factores o escenarios de politica.

Desde el punto de vista analitico, el proyecto muestra que las estrategias de mitigacion no deben evaluarse aisladamente. Los cambios en consumo, productividad, uso del suelo, bosque natural y plantaciones comerciales interactuan entre si, por lo que el valor del modelo esta en comparar escenarios completos y no solo indicadores individuales.

## Tecnologias y metodos

- R
- FAOSTAT
- NIR/BUR Colombia
- NDC
- AFOLU
- Modelos de tendencia
- Elasticidades ingreso-demanda
- Factores de emision
- Simulacion de escenarios
- `readxl`, `openxlsx`, `dplyr`, `reshape2`, `ggplot2`, `rmarkdown`

## Nota

Proyecto desarrollado a partir de los scripts ubicados en `public/content/projects/assets/ddplac`. La implementacion corresponde a un flujo analitico para modelar emisiones, absorciones y escenarios de mitigacion del sector agropecuario, forestal y de uso de la tierra.
