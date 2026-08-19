# Sistema de modelación para prospectiva agropecuaria

## Resumen ejecutivo

Sistema de modelación económica desarrollado para apoyar cuantitativamente los ejercicios de prospectiva de cadenas agropecuarias trabajadas por la UPRA en el marco de los Planes de Ordenamiento Productivo (POP). El sistema articula proyecciones económicas, modelos de equilibrio parcial y modelos de optimización regional para analizar escenarios de mediano y largo plazo sobre demanda, oferta, mercado y localización óptima de la producción.

La metodología fue aplicada a cadenas como maíz, papa, caña panelera, acuicultura, cacao, café, cebolla, ganadería bovina y ovino-caprina. El documento revisado corresponde a la cadena de cacao y chocolate, pero su primer capítulo describe la arquitectura metodológica común para las cadenas priorizadas.

## Problema

Los procesos de prospectiva agropecuaria requieren traducir escenarios cualitativos en insumos cuantitativos comparables. Para formular lineamientos de ordenamiento productivo no basta con describir tendencias; también es necesario estimar cómo podrían cambiar la demanda, la oferta nacional, los flujos comerciales, la productividad y la localización territorial de la producción bajo escenarios alternativos.

El reto consistía en construir un sistema de modelación que permitiera:

- Proyectar demanda de mediano y largo plazo para cadenas productivas priorizadas.
- Estimar cambios en la estructura del mercado nacional bajo supuestos de política, productividad y comercio.
- Analizar alternativas óptimas de localización de la producción.
- Encadenar componentes económicos de forma modular y trazable.
- Proveer resultados cuantitativos para apoyar discusiones de prospectiva y formulación de POP.
- Adaptar la arquitectura a múltiples cadenas agropecuarias con información disponible heterogénea.

## Datos utilizados

- Series históricas de producción, importaciones, exportaciones y consumo aparente por cadena.
- Proyecciones de población del DANE.
- Series y supuestos de crecimiento del PIB e ingreso per cápita.
- Elasticidades ingreso y precio de la demanda.
- Información de la Encuesta Nacional de Presupuestos de los Hogares (ENPH) para estimar parámetros de consumo.
- Factores de conversión entre productos primarios, intermedios y finales.
- Información de oferta nacional, demanda doméstica, exportaciones e importaciones.
- Parámetros de productividad, rendimiento, costos o disponibilidad territorial según cadena.
- Información regional de consumo y diferenciales territoriales.
- Insumos de escenarios cualitativos definidos en los ejercicios de prospectiva.
- Restricciones territoriales y productivas para los modelos de optimización.

## Metodología

El sistema se estructura en tres componentes principales: proyecciones económicas, modelación del mercado y optimización regional. Estos módulos pueden operar encadenados o, cuando la información de una cadena no permite una articulación completa, pueden usarse de forma independiente para responder preguntas específicas.

| Componente | Pregunta principal | Enfoque | Salida |
| --- | --- | --- | --- |
| Proyecciones económicas | ¿Cómo puede cambiar la demanda futura? | Crecimiento poblacional, ingreso per cápita y elasticidad ingreso | Demanda proyectada por producto |
| Equilibrio parcial | ¿Cómo cambia el mercado ante escenarios de política, precios o productividad? | Oferta y demanda de la cadena bajo supuestos de mercado | Producción doméstica, comercio y composición de demanda/oferta |
| Optimización regional | ¿Dónde debería localizarse la producción para cumplir un escenario? | Programación lineal y restricciones territoriales | Localización óptima, producción regional y flujos |
| Estimación de parámetros | ¿Qué elasticidades y diferenciales alimentan los modelos? | Econometría aplicada sobre series y microdatos ENPH | Elasticidades ingreso/precio y diferenciales regionales |

### Proyecciones económicas

El módulo de proyecciones estima el comportamiento futuro de la demanda a partir de variables estructurales como población, ingreso per cápita y elasticidad ingreso de la demanda. La lógica base del modelo puede resumirse así:

$$
d \approx p + \eta \times g
$$

Donde `d` representa el cambio porcentual en el consumo, `p` el cambio porcentual de la población, `g` el cambio porcentual del ingreso per cápita y `eta` la elasticidad ingreso de la demanda.

Para el caso cacao, el documento utiliza proyecciones de población del DANE hasta 2041 y una trayectoria de ingreso per cápita construida a partir de población y PIB. También plantea enfoques alternativos para estimar elasticidades: uno basado en series históricas de consumo aparente, producción y comercio, y otro basado en microdatos de la ENPH.

### Modelación del mercado

El componente de mercado se basa en un enfoque de equilibrio parcial. Esto significa que el sistema analiza la cadena seleccionada considerando variables asociadas a su propio mercado, sin modelar de manera explícita efectos cruzados con todos los mercados relacionados.

En términos operativos, el módulo permite simular cambios en la estructura de demanda y oferta bajo escenarios definidos por variables de política comercial, productividad, precios, importaciones, exportaciones, consumo interno o composición de productos. Su salida alimenta el volumen de oferta nacional requerido para los modelos regionales.

### Optimización regional

El componente regional utiliza modelos lineales de optimización para analizar alternativas de localización de la producción. El objetivo es identificar configuraciones territoriales que permitan satisfacer el nivel de oferta estimado bajo un conjunto de restricciones y parámetros regionalizados.

En el caso del cacao, el documento reporta resultados de optimización orientados a localizar producción de grano, producción para industria, flujos desde zonas productoras hacia zonas de acopio, flujos hacia puertos para exportación y flujos hacia zonas de transformación y consumo interno.

### Estimación de elasticidades y diferenciales regionales

El sistema incluye una etapa de estimación de parámetros. Para cacao, se estimaron elasticidades ingreso y precio usando información de la ENPH y especificaciones econométricas con variables como gasto corriente per cápita, precios y factores de expansión. También se construyeron diferenciales regionales de consumo para representar variación territorial en productos como chocolate de mesa y otros productos derivados del cacao.

Esta etapa es clave porque los modelos prospectivos son muy sensibles a supuestos de comportamiento. Separar la estimación de parámetros del módulo de simulación permite revisar supuestos, documentar fuentes y actualizar el sistema cuando exista nueva información.

## Resultados

El proyecto produjo una arquitectura cuantitativa para acompañar ejercicios de prospectiva agropecuaria y formulación de POP. El sistema permite conectar escenarios cualitativos con resultados medibles sobre demanda, oferta, mercado, localización productiva y flujos territoriales.

Los principales resultados técnicos fueron:

- Diseño de una arquitectura modular para modelación económica de cadenas agropecuarias.
- Implementación de un módulo de proyecciones de demanda basado en población, ingreso per cápita y elasticidades.
- Implementación de un modelo de equilibrio parcial para simular cambios de mercado.
- Implementación de modelos de optimización regional para localizar producción bajo restricciones.
- Estimación de elasticidades ingreso y precio a partir de series históricas y microdatos ENPH.
- Construcción de diferenciales regionales de consumo para alimentar los modelos territoriales.
- Generación de escenarios cuantitativos para apoyar la discusión técnica de los POP.
- Adaptación del sistema a varias cadenas agropecuarias priorizadas por UPRA.

### Cadenas trabajadas

| Cadena | Aplicación del sistema |
| --- | --- |
| Maíz | Proyecciones, análisis de mercado y escenarios territoriales para POP |
| Papa | Modelación económica para apoyar prospectiva y ordenamiento productivo |
| Caña panelera | Evaluación cuantitativa de escenarios de demanda, oferta y localización |
| Acuicultura | Adaptación del sistema a una cadena con estructura productiva particular |
| Cacao | Documento técnico completo del sistema de modelación económica de cacao y chocolate |
| Café | Apoyo cuantitativo a escenarios prospectivos de la cadena |
| Cebolla | Modelación para analizar comportamiento futuro y alternativas productivas |
| Ganadería bovina | Análisis cuantitativo de escenarios productivos y territoriales |
| Ovino-caprina | Aplicación a una cadena pecuaria con información y dinámica específicas |

### Ejemplo de cacao

El documento de cacao y chocolate describe el sistema completo y desarrolla módulos específicos para la cadena. En proyecciones económicas se estimó demanda futura usando cinco opciones de elasticidad, combinando enfoques de series históricas y ENPH. En equilibrio parcial se analizaron cambios en demanda y oferta de productos de la cadena expresados en toneladas de grano. En optimización se generaron salidas territoriales sobre zonas productoras, zonas de acopio, puertos, industrias y zonas de consumo.

Entre los resultados reportados para el componente de optimización se destacan: 39 municipios que concentran el 76.4% del área para producción nacional de cacao y 38 municipios productores que concentran el 80% de la producción destinada a industrias. También se generaron mapas y flujos para exportación, transformación y consumo interno.

## Lecciones aprendidas

La prospectiva agropecuaria gana solidez cuando los escenarios cualitativos se conectan con modelos cuantitativos trazables. El sistema no reemplaza el criterio experto, pero permite evaluar órdenes de magnitud, tensiones entre oferta y demanda, necesidades de productividad y posibles configuraciones territoriales.

La modularidad fue fundamental. Separar proyecciones, equilibrio parcial, optimización y estimación de parámetros facilita adaptar el sistema a cadenas con distinta disponibilidad de información. En algunas cadenas los tres módulos pueden encadenarse completamente; en otras, conviene usarlos de manera independiente para responder preguntas puntuales.

También se evidenció que la calidad de los resultados depende de la calidad de los parámetros. Las elasticidades, factores de conversión, diferenciales regionales y supuestos de productividad deben documentarse y actualizarse, porque definen buena parte del comportamiento de los escenarios.

## Trabajo futuro

- Estandarizar bases de entrada por cadena para facilitar actualización anual.
- Automatizar generación de reportes y escenarios comparables entre cadenas.
- Integrar salidas del sistema con visores territoriales y tableros de seguimiento POP.
- Incorporar escenarios climáticos, tecnológicos y logísticos cuando existan datos suficientes.
- Fortalecer la estimación de elasticidades con nuevas encuestas o fuentes administrativas.
- Documentar supuestos por cadena para mejorar trazabilidad y reproducibilidad.

## Tecnologías y métodos

- R
- GAMS
- Series de tiempo
- Econometría aplicada
- Equilibrio parcial
- Programación lineal
- Optimización regional
- Proyecciones de demanda
- Elasticidades ingreso y precio
- ENPH
- DANE
- Modelación de escenarios
- Prospectiva cuantitativa
- Planes de Ordenamiento Productivo

## Nota

Proyecto construido a partir del documento `20231215_DT_SistemaModCacao.docx` y la presentación `20231018_DTR_SistemaModelacionEconomica.pptx`, ubicados en `Z:\prospectiva_agropecuaria`. El primer capítulo del documento describe la metodología común del sistema; los capítulos siguientes desarrollan la aplicación específica para cacao y chocolate.
