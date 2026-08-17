# Modelo de contabilidad de emisiones de carbono AFOLU

## Resumen ejecutivo

Pipeline analítico en R para estimar emisiones y absorciones de gases de efecto invernadero asociadas al sector agropecuario, forestal y de uso de la tierra. El modelo integra series históricas de producción, comercio, consumo aparente, población, PIB, coberturas, inventarios ganaderos, información forestal y factores de emisión provenientes de fuentes como FAOSTAT, NIR/BUR y escenarios NDC.

El proyecto permite proyectar demanda agropecuaria hasta 2050, estimar requerimientos de área y animales, traducir esos cambios en categorías AFOLU y simular escenarios de mitigación relacionados con rendimientos, ganadería, manejo de pasturas, arroz, bosques naturales, plantaciones comerciales y cambios en consumo de carne.

## Problema

La contabilidad de emisiones AFOLU requiere conectar procesos que normalmente se analizan por separado: producción agrícola, inventarios pecuarios, comercio exterior, consumo, uso del suelo, crecimiento económico, población y factores de emisión. Sin una estructura reproducible, los resultados pueden depender de hojas de cálculo manuales, supuestos dispersos y cruces poco trazables.

El reto consistía en construir un flujo que permitiera:

- Consolidar fuentes heterogéneas de datos agropecuarios, forestales y climáticos.
- Proyectar consumo y actividad productiva bajo escenarios económicos y demográficos.
- Estimar áreas requeridas, existencias animales y cambios de uso del suelo.
- Aplicar factores de emisión y absorción por categoría AFOLU.
- Comparar escenarios base, NDC y estrategias de mitigación hacia 2050.
- Generar salidas tabulares, gráficas y reportes reproducibles.

## Datos utilizados

- Producción agrícola FAOSTAT: área cosechada, producción y rendimiento.
- Producción pecuaria FAOSTAT: animales en producción, sacrificio, rendimiento y producción.
- Existencias ganaderas FAOSTAT para calcular inventarios y tasas de extracción.
- Comercio exterior FAOSTAT: importaciones y exportaciones de cultivos, productos pecuarios y animales vivos.
- Uso de la tierra e indicadores agroambientales: coberturas, tierras forestales, cultivos, pastizales y combustión de biomasa.
- Intensidad de emisiones agropecuarias por producto.
- Emisiones de agricultura y uso de la tierra por categorías como fermentación entérica, gestión de estiércol, cultivo de arroz, fertilizantes, residuos agrícolas y suelos orgánicos.
- Archivo de elasticidades, factores de conversión, grupos FAO/GCAM, población, PIB y escenarios forestales.
- Información NIR/BUR de Colombia para construir factores de emisión, absorción y costos-beneficios.

## Metodología

El modelo se organizo como un pipeline modular con scripts independientes para adquisición, curaduría, transformación, simulación, análisis y generación de reportes.

| Etapa | Script | Proposito |
| --- | --- | --- |
| Adquisicion | `acquire_data.R` | Cargar fuentes FAOSTAT, NIR/BUR, elasticidades, factores de conversión, población, PIB y escenarios forestales |
| Curaduria | `curate_data.R` | Estandarizar variables, convertir unidades, calcular consumo aparente, inventarios, tasas de extracción y factores de emisión |
| Transformacion | `transform_data.R` | Proyectar consumo, población, PIB, elasticidades, áreas requeridas y emisiones hasta 2050 |
| Simulación | `Sim_data.R` | Construir escenarios de mitigación y generar salidas de emisiones, series y resultados |
| Análisis | `analyze_data.R` | Explorar históricos, proyecciones, balances y gráficas por cadena o categoría |
| Reportes | `generate_reports.R` | Renderizar artículos, presentaciones, paginas e informes con R Markdown |

### Integracion de datos

La primera parte del flujo carga bases de producción, comercio, uso del suelo, emisiones, elasticidades y factores de conversión. Luego se armonizan códigos FAO, códigos internos de cultivo, grupos GCAM y categorías agropecuarias.

En cultivos se consolidan área cosechada, producción y rendimiento. En ganadería se convierten productos derivados hacia unidades comparables, se selecciónan productos principales y se calculan animales en producción, inventarios y tasas de extracción.

### Consumo aparente y proyecciones

El modelo calcula consumo aparente integrando producción, importaciones y exportaciones. Para proyectar demanda se prueban modelos de tendencia por producto, junto con trayectorias de población y PIB.

El flujo calcula elasticidades ingreso-demanda bajo varias trayectorias, incluyendo escenarios GCAM y NDC. Con estas elasticidades se estima la tasa de crecimiento del consumo y se construye una base proyectada entre 2014 y 2050.

### Actividad, área requerida y frontera agropecuaria

Con las proyecciones de producción y rendimiento se estiman áreas requeridas para cultivos. Para ganadería se estiman animales totales, producción, carga animal y área requerida. Estas variables alimentan una representación de la frontera agropecuaria, especialmente para identificar presiones entre cultivos, pastizales y áreas forestales.

El modelo también incorpora escenarios forestales, incluyendo plantaciones comerciales y bosque natural, para representar cambios en áreas forestales y su relación con emisiones o absorciones.

### Factores de emisión y categorías AFOLU

A partir de la información BUR/NIR se construyen factores por animal o por área para:

- Absorciones de CO2.
- Emisiones de CO2.
- Emisiones de CH4.
- Emisiones de N2O.
- Emisiones indirectas NOX.
- Emisiones de CO.

Estos factores se cruzan con la actividad proyectada y se organizan en categorías AFOLU como ganadería, cultivos, tierras forestales, tierras de cultivo, pastizales, arroz, fertilizantes y manejo de pasturas.

### Escenarios de mitigación

El script de simulación define estrategias de análisis para evaluar cambios en emisiones frente a un escenario base. Entre las estrategias codificadas se encuentran:

- Incremento de rendimientos agrícolas.
- Aumento de animales por hectárea y mejoras en tasa de extracción ganadera.
- Reducciones asociadas a fuentes agregadas y emisiones no CO2.
- Mejoramiento de pasturas.
- Manejo de arroz.
- Manejo de bosque natural.
- Expansión de plantaciones comerciales.
- Reduccion de consumo de carne mediante ajustes de elasticidad.
- Escenarios integrados tipo "todo" y escenarios NDC.

## Resultados

El proyecto produjo una arquitectura reproducible para conectar demanda agroalimentaria, uso del suelo y contabilidad de emisiones. Las salidas permiten comparar trayectorias históricas y proyectadas, cuantificar emisiones netas y totales, y evaluar estrategias de mitigación sobre categorías AFOLU.

Los principales resultados técnicos fueron:

- Construccion de una base consolidada de consumo aparente por producto.
- Proyeccion de demanda agropecuaria hasta 2050 con población, PIB y elasticidades.
- Estimacion de área requerida para cultivos y ganadería.
- Calculo de inventarios animales, tasas de extracción y productividad pecuaria.
- Integracion de escenarios forestales y cambios de uso del suelo.
- Derivacion de factores de emisión y absorción desde información BUR/NIR.
- Calculo de emisiones netas y totales por categoría, gas y año.
- Exportación de escenarios en archivos Excel para análisis de resultados, NDC y costos-beneficios.

| Salida | Descripción | Uso analítico |
| --- | --- | --- |
| `BDConsumoFinal` | Consumo aparente histórico por producto | Base para modelos de demanda |
| `BDBalComFinal` | Producción, comercio, consumo, rendimiento y área requerida | Balance agropecuario proyectado |
| `BurEm` | Factores de emisión y absorción por categoría | Contabilidad AFOLU |
| `Final_emi` | Emisiones y absorciones calculadas por actividad | Estimacion neta y total |
| `todo_E`, `todo_S`, `NDC_E`, `NDC_S` | Escenarios integrados de emisiones y series | Comparación de mitigación |

## Lecciones aprendidas

La contabilidad de carbono en AFOLU exige tanta rigurosidad en la preparación de datos como en el cálculo final de emisiones. Pequeñas decisiones sobre unidades, factores de conversión, inventarios animales o áreas base pueden cambiar de forma importante los resultados agregados.

También fue clave separar el flujo en etapas. La arquitectura por scripts permite depurar cada componente: datos originales, bases curadas, proyecciones, factores de emisión, escenarios y reportes. Esto mejora la trazabilidad de supuestos y facilita actualizar el modelo cuando cambian fuentes, factores o escenarios de política.

Desde el punto de vista analítico, el proyecto muestra que las estrategias de mitigación no deben evaluarse aisladamente. Los cambios en consumo, productividad, uso del suelo, bosque natural y plantaciones comerciales interactúan entre sí, por lo que el valor del modelo está en comparar escenarios completos y no solo indicadores individuales.

## Tecnologías y métodos

- R
- FAOSTAT
- NIR/BUR Colombia
- NDC
- AFOLU
- Modelos de tendencia
- Elasticidades ingreso-demanda
- Factores de emisión
- Simulación de escenarios
- `readxl`, `openxlsx`, `dplyr`, `reshape2`, `ggplot2`, `rmarkdown`

## Nota

Proyecto desarrollado a partir de los scripts ubicados en `public/content/projects/assets/ddplac`. La implementación corresponde a un flujo analítico para modelar emisiones, absorciones y escenarios de mitigación del sector agropecuario, forestal y de uso de la tierra.
