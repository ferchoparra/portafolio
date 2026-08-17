# Modelo de crecimiento y rendimiento forestal

## Resumen ejecutivo

Herramienta de simulación en R para estimar crecimiento, rendimiento y volumen disponible de plantaciones forestales comerciales en Colombia. El modelo fue desarrollado como componente técnico del Modelo de Simulación Forestal Comercial (MSFC), integrando tablas de crecimiento, ecuaciones dasométricas, esquemas de manejo silvicultural y proyecciones por registro de plantación.

El proyecto consolida una estructura de modelación en tres procesos: selección y preparación de registros, transformación de tablas de crecimiento a clases diamétricas, y simulación temporal de volumen disponible por especie, zona, departamento, municipio e índice de sitio.

## Problema

La planificación del sector forestal comercial requiere estimar volumen futuro de madera con información limitada, heterogénea y dispersa. Aunque existen tablas de crecimiento y estudios para algunas especies, no siempre se cuenta con bases de datos robustas de parcelas permanentes, perfiles fustales o ecuaciones específicas por especie y zona.

El reto consistía en construir una herramienta reproducible que permitiera:

- Usar información de plantaciones forestales comerciales reportada en fuentes institucionales.
- Asignar tablas de crecimiento y calidad de sitio a registros de plantación.
- Simular escenarios de manejo con y sin raleos.
- Estimar volumen total, volumen comercial e índices de utilización.
- Generar proyecciones agregadas para apoyar análisis sectoriales y prospectivos.

## Datos utilizados

- Base de plantaciones forestales con zona, departamento, municipio, especie, año de siembra, área, índice de sitio y tabla base.
- 52 tablas de crecimiento asociadas a grupos de especies e índices de sitio.
- Información del estudio PROFOR sobre reforestacion comercial potencial.
- Esquemas de manejo silvicultural con edades de raleo, diámetros o porcentajes de extracción y edades de aprovechamiento.
- Ecuaciones altura-diámetro, factores de forma y funciones de ahusamiento recopiladas de literatura técnica forestal.
- Índices de utilización para estimar volumen disponible bajo diferentes diámetros mínimos comerciales.

## Metodología

La metodología se implementó en R y se estructuró en tres procesos operativos, coherentes con la herramienta descrita en el documento técnico del MCRF.

| Proceso | Objetivo | Implementación |
| --- | --- | --- |
| Proceso I | Seleccionar y preparar registros de plantación | Filtros por base, zona, departamento, especie y registro; creación de identificadores y asignación de modelo especie-índice de sitio |
| Proceso II | Transformar tablas de crecimiento en salidas de volumen | Aplicacion de manejo, distribución Weibull por clases diamétricas, funciones altura-diámetro, factor forma, ahusamiento e índices de utilización |
| Proceso III | Simular proyecciones por registro | Asignación de tablas a plantaciones, cálculo de volumen por área sembrada, escenarios con/sin raleo y proyección temporal hasta el año objetivo |

### Selección de registros

El flujo inicia con la función `registros()`, que permite selecciónar información por zona, departamento, especie, base y registro. También se implementó `newreg()` para incorporar registros nuevos de forma individual o mediante una tabla externa.

En el script `Run.R`, la simulación base usa todos los registros disponibles en la base selecciónada y genera un identificador de modelo mediante la combinacion de especie e índice de sitio.

### Tablas de crecimiento y manejo

El proceso carga 52 tablas de crecimiento con variables como edad, densidad, mortalidad, diámetro medio, altura media, volumen medio, volumen por hectárea, incremento corriente anual e incremento medio anual.

A partir de estas tablas se calculan variables adicionales:

- Area basal por hectárea.
- Volumen total por densidad y volumen medio.
- Volumen extraido por raleo.
- Volumen remanente despues de aplicar manejo.

La función `manejo()` define los esquemas de raleo por tabla de crecimiento. Luego `tabmanejo2()` modifica la densidad y los volúmenes a partir de los eventos de raleo definidos.

### Desagregacion por clases diamétricas

La función `Etapa2()` desagrega cada edad de cada tabla de crecimiento en clases diamétricas usando una distribución de Weibull. Para cada clase se estima numero de árboles, altura y volumen.

Esta estrategia permite trabajar con un modelo de rodal desagregado por clases diamétricas, apropiado para proyecciones de largo plazo cuando no existe información individual de árboles para todos los registros.

### Volumen, ahusamiento e índices de utilización

El modelo incorpora funciones de ahusamiento para diferentes grupos de especies. Con ellas se estima volumen total y volumen hasta la altura dónde ocurre un diámetro minimo especifico.

En el script de ejecución se probaron índices de utilización de 20, 15 y 5 cm, lo que permite estimar volumen disponible para distintos usos industriales o criterios comerciales.

### Simulación temporal

La función `procIII()` integra los registros de plantación con las tablas procesadas y genera proyecciones hasta un año de simulación. En el flujo revisado se ejecuta la simulación hasta 2041 y se exportan salidas separadas para:

- Volumen de raleo sin resiembra.
- Volumen de aprovechamiento sin resiembra.
- Volumen de raleo con resiembra.
- Volumen de aprovechamiento con resiembra.

## Resultados

Se construyó una herramienta funcional para simular escenarios de crecimiento y rendimiento forestal a partir de registros de plantaciones comerciales y tablas de crecimiento disponibles.

Los principales resultados técnicos fueron:

- Implementación de un modelo de rodal desagregado por clases diamétricas.
- Integracion de 52 tablas de crecimiento para múltiples grupos de especies e índices de sitio.
- Incorporacion de esquemas de manejo con raleos y edades de aprovechamiento.
- Estimacion de volumen total, volumen con factor forma, volumen por ahusamiento e índices de utilización.
- Generación de proyecciones nacionales y territoriales de volumen disponible.
- Exportación de resultados en CSV y Excel para análisis posterior.

| Salida | Descripción | Uso analítico |
| --- | --- | --- |
| `volRaleoSR_2021` | Volumen de raleo sin resiembra | Evaluar extracciones intermedias |
| `volAproSR_2021` | Volumen de aprovechamiento sin resiembra | Estimar oferta futura bajo una rotacion |
| `volRaleoCR_2021` | Volumen de raleo con resiembra | Simular continuidad productiva |
| `volAproCR_2021` | Volumen de aprovechamiento con resiembra | Analizar escenarios de producción sostenida |

El documento técnico concluye que la herramienta permite generar escenarios dónde el usuario puede modificar área sembrada, especies, índices de sitio, volumen por índices de utilización y salidas por nucleos forestales, departamentos y especies.

## Lecciones aprendidas

El modelo evidenció que la estimación del volumen forestal no depende solo del área sembrada. La calidad de sitio, el manejo silvicultural, las ecuaciones de crecimiento y la disponibilidad de información de parcelas son determinantes para obtener proyecciones confiables.

También se identifico que el sector forestal requiere una estrategia de cooperacion entre reforestadores, universidades, centros de investigacion e instituciones publicas para consolidar datos de crecimiento, perfiles fustales y ecuaciones específicas por especie y zona.

Desde el punto de vista de implementación, la herramienta quedo preparada para actualizarse con nuevas ecuaciones de crecimiento y nuevas tablas, manteniendo una estructura modular basada en funciones R.

## Tecnologías y métodos

- R
- Modelos de crecimiento y rendimiento forestal
- Distribución Weibull
- Funciones de ahusamiento
- Ecuaciones altura-diámetro
- Factores de forma
- Simulación de escenarios
- Exportación CSV y Excel

## Nota

Proyecto desarrollado a partir del documento técnico "Modelo de crecimiento y rendimiento forestal - MCRF" y los scripts R de implementación ubicados en `public/content/projects/assets/mcrf`.
