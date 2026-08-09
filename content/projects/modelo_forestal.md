# Modelo de crecimiento y rendimiento forestal

## Resumen ejecutivo

Herramienta de simulacion en R para estimar crecimiento, rendimiento y volumen disponible de plantaciones forestales comerciales en Colombia. El modelo fue desarrollado como componente tecnico del Modelo de Simulacion Forestal Comercial (MSFC), integrando tablas de crecimiento, ecuaciones dasometricas, esquemas de manejo silvicultural y proyecciones por registro de plantacion.

El proyecto consolida una estructura de modelacion en tres procesos: seleccion y preparacion de registros, transformacion de tablas de crecimiento a clases diametricas, y simulacion temporal de volumen disponible por especie, zona, departamento, municipio e indice de sitio.

## Problema

La planificacion del sector forestal comercial requiere estimar volumen futuro de madera con informacion limitada, heterogenea y dispersa. Aunque existen tablas de crecimiento y estudios para algunas especies, no siempre se cuenta con bases de datos robustas de parcelas permanentes, perfiles fustales o ecuaciones especificas por especie y zona.

El reto consistia en construir una herramienta reproducible que permitiera:

- Usar informacion de plantaciones forestales comerciales reportada en fuentes institucionales.
- Asignar tablas de crecimiento y calidad de sitio a registros de plantacion.
- Simular escenarios de manejo con y sin raleos.
- Estimar volumen total, volumen comercial e indices de utilizacion.
- Generar proyecciones agregadas para apoyar analisis sectoriales y prospectivos.

## Datos utilizados

- Base de plantaciones forestales con zona, departamento, municipio, especie, ano de siembra, area, indice de sitio y tabla base.
- 52 tablas de crecimiento asociadas a grupos de especies e indices de sitio.
- Informacion del estudio PROFOR sobre reforestacion comercial potencial.
- Esquemas de manejo silvicultural con edades de raleo, diametros o porcentajes de extraccion y edades de aprovechamiento.
- Ecuaciones altura-diametro, factores de forma y funciones de ahusamiento recopiladas de literatura tecnica forestal.
- Indices de utilizacion para estimar volumen disponible bajo diferentes diametros minimos comerciales.

## Metodologia

La metodologia se implemento en R y se estructuro en tres procesos operativos, coherentes con la herramienta descrita en el documento tecnico del MCRF.

| Proceso | Objetivo | Implementacion |
| --- | --- | --- |
| Proceso I | Seleccionar y preparar registros de plantacion | Filtros por base, zona, departamento, especie y registro; creacion de identificadores y asignacion de modelo especie-indice de sitio |
| Proceso II | Transformar tablas de crecimiento en salidas de volumen | Aplicacion de manejo, distribucion Weibull por clases diametricas, funciones altura-diametro, factor forma, ahusamiento e indices de utilizacion |
| Proceso III | Simular proyecciones por registro | Asignacion de tablas a plantaciones, calculo de volumen por area sembrada, escenarios con/sin raleo y proyeccion temporal hasta el ano objetivo |

### Seleccion de registros

El flujo inicia con la funcion `registros()`, que permite seleccionar informacion por zona, departamento, especie, base y registro. Tambien se implemento `newreg()` para incorporar registros nuevos de forma individual o mediante una tabla externa.

En el script `Run.R`, la simulacion base usa todos los registros disponibles en la base seleccionada y genera un identificador de modelo mediante la combinacion de especie e indice de sitio.

### Tablas de crecimiento y manejo

El proceso carga 52 tablas de crecimiento con variables como edad, densidad, mortalidad, diametro medio, altura media, volumen medio, volumen por hectarea, incremento corriente anual e incremento medio anual.

A partir de estas tablas se calculan variables adicionales:

- Area basal por hectarea.
- Volumen total por densidad y volumen medio.
- Volumen extraido por raleo.
- Volumen remanente despues de aplicar manejo.

La funcion `manejo()` define los esquemas de raleo por tabla de crecimiento. Luego `tabmanejo2()` modifica la densidad y los volumenes a partir de los eventos de raleo definidos.

### Desagregacion por clases diametricas

La funcion `Etapa2()` desagrega cada edad de cada tabla de crecimiento en clases diametricas usando una distribucion de Weibull. Para cada clase se estima numero de arboles, altura y volumen.

Esta estrategia permite trabajar con un modelo de rodal desagregado por clases diametricas, apropiado para proyecciones de largo plazo cuando no existe informacion individual de arboles para todos los registros.

### Volumen, ahusamiento e indices de utilizacion

El modelo incorpora funciones de ahusamiento para diferentes grupos de especies. Con ellas se estima volumen total y volumen hasta la altura donde ocurre un diametro minimo especifico.

En el script de ejecucion se probaron indices de utilizacion de 20, 15 y 5 cm, lo que permite estimar volumen disponible para distintos usos industriales o criterios comerciales.

### Simulacion temporal

La funcion `procIII()` integra los registros de plantacion con las tablas procesadas y genera proyecciones hasta un ano de simulacion. En el flujo revisado se ejecuta la simulacion hasta 2041 y se exportan salidas separadas para:

- Volumen de raleo sin resiembra.
- Volumen de aprovechamiento sin resiembra.
- Volumen de raleo con resiembra.
- Volumen de aprovechamiento con resiembra.

## Resultados

Se construyo una herramienta funcional para simular escenarios de crecimiento y rendimiento forestal a partir de registros de plantaciones comerciales y tablas de crecimiento disponibles.

Los principales resultados tecnicos fueron:

- Implementacion de un modelo de rodal desagregado por clases diametricas.
- Integracion de 52 tablas de crecimiento para multiples grupos de especies e indices de sitio.
- Incorporacion de esquemas de manejo con raleos y edades de aprovechamiento.
- Estimacion de volumen total, volumen con factor forma, volumen por ahusamiento e indices de utilizacion.
- Generacion de proyecciones nacionales y territoriales de volumen disponible.
- Exportacion de resultados en CSV y Excel para analisis posterior.

| Salida | Descripcion | Uso analitico |
| --- | --- | --- |
| `volRaleoSR_2021` | Volumen de raleo sin resiembra | Evaluar extracciones intermedias |
| `volAproSR_2021` | Volumen de aprovechamiento sin resiembra | Estimar oferta futura bajo una rotacion |
| `volRaleoCR_2021` | Volumen de raleo con resiembra | Simular continuidad productiva |
| `volAproCR_2021` | Volumen de aprovechamiento con resiembra | Analizar escenarios de produccion sostenida |

El documento tecnico concluye que la herramienta permite generar escenarios donde el usuario puede modificar area sembrada, especies, indices de sitio, volumen por indices de utilizacion y salidas por nucleos forestales, departamentos y especies.

## Lecciones aprendidas

El modelo evidencio que la estimacion del volumen forestal no depende solo del area sembrada. La calidad de sitio, el manejo silvicultural, las ecuaciones de crecimiento y la disponibilidad de informacion de parcelas son determinantes para obtener proyecciones confiables.

Tambien se identifico que el sector forestal requiere una estrategia de cooperacion entre reforestadores, universidades, centros de investigacion e instituciones publicas para consolidar datos de crecimiento, perfiles fustales y ecuaciones especificas por especie y zona.

Desde el punto de vista de implementacion, la herramienta quedo preparada para actualizarse con nuevas ecuaciones de crecimiento y nuevas tablas, manteniendo una estructura modular basada en funciones R.

## Tecnologias y metodos

- R
- Modelos de crecimiento y rendimiento forestal
- Distribucion Weibull
- Funciones de ahusamiento
- Ecuaciones altura-diametro
- Factores de forma
- Simulacion de escenarios
- Exportacion CSV y Excel

## Nota

Proyecto desarrollado a partir del documento tecnico "Modelo de crecimiento y rendimiento forestal - MCRF" y los scripts R de implementacion ubicados en `public/content/projects/assets/mcrf`.
