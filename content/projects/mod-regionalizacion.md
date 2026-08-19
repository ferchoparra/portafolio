# Modelo de regionalización para cadenas agropecuarias

## Resumen ejecutivo

Metodología de regionalización agropecuaria desarrollada para conformar grupos territoriales homogéneos a nivel municipal, integrando información productiva, aptitud biofísica, especialización de la cadena, accesibilidad, asistencia técnica, indicadores de desempeño y conocimiento experto.

El proceso combina análisis estadístico no espacial, análisis de correlación, construcción de matrices de vecindad, agrupación espacial con el procedimiento SKATER y ajuste técnico con expertos de cadena. La metodología fue aplicada a diferentes cadenas agropecuarias: maíz, papa, caña panelera, acuicultura, cacao, café, cebolla, ganadería bovina y ovino-caprina.

## Problema

La planificación de cadenas agropecuarias requiere reconocer que los territorios no se comportan de forma homogénea. Municipios con producción similar pueden diferir en aptitud, accesibilidad, infraestructura, dinámica productiva, concentración de productores, asistencia técnica o relación con mercados. Al mismo tiempo, clasificar municipios únicamente por variables estadísticas puede generar grupos dispersos, difíciles de interpretar y poco útiles para la toma de decisiones territoriales.

El reto consistía en diseñar una metodología reproducible para:

- Agrupar municipios con características productivas y territoriales similares.
- Incorporar continuidad espacial dentro del proceso de agrupación.
- Integrar variables de producción, área, rendimiento, aptitud, especialización, asistencia técnica y accesibilidad.
- Generar regiones interpretables para equipos técnicos y expertos de cada cadena.
- Producir mapas, tablas y bases de resultados que apoyaran instrumentos de planificación agropecuaria.
- Adaptar el flujo a varias cadenas productivas con estructuras de datos similares.

## Datos utilizados

- Bases consolidadas por cadena agropecuaria a nivel municipal.
- Series de producción, área sembrada y rendimientos, principalmente a partir de EVA y fuentes sectoriales.
- Indicadores derivados de tendencia en producción, área y rendimiento, calculados mediante modelos lineales por municipio.
- Número de UPA y variables asociadas a asistencia técnica.
- Áreas de aptitud alta y media para la cadena productiva.
- Frontera agrícola y variables de potencialidad territorial.
- Indicadores de especialización productiva, incluyendo relaciones entre área sembrada, área municipal y frontera agrícola.
- Indicadores tipo IDPM y métricas de productividad/potencialidad.
- Porcentajes de destino de venta, autoconsumo o relación con industria/comercializadores, según disponibilidad por cadena.
- Distancias y tiempos medios desde unidades productoras hasta centros poblados.
- Capas municipales y departamentales para construir vecindades espaciales y mapas.
- Aportes de expertos internos de UPRA y especialistas de cadena para ajustar e interpretar las regiones.

## Metodología

El flujo se implementó principalmente en R. El script `clust_esp.R` contiene las funciones principales para construir la estructura de contigüidad y ejecutar el agrupamiento espacial. El script `region_script.R` funciona como un ejemplo completo de aplicación para una cadena específica, incluyendo carga de datos, exploración, selección de variables, cluster no espacial, cluster espacial, subregionalización, mapas y consolidación de resultados.

| Etapa | Objetivo | Herramientas principales | Salida |
| --- | --- | --- | --- |
| Consolidación de datos | Integrar información municipal de la cadena | `readxl`, `openxlsx`, `dplyr`, `sf` | Base analítica por municipio |
| Exploración y preselección | Revisar distribuciones, correlaciones y variables relevantes | Matrices de correlación, mapas temáticos, criterio experto | Set reducido de variables |
| Cluster no espacial | Identificar grupos iniciales por similitud estadística | Escalamiento, distancia euclidiana, `hclust`, método Ward.D2 | Grupos preliminares |
| Estructura espacial | Construir relaciones de vecindad municipal | `poly2nb`, `nb2lines`, matriz queen | Grafo de contigüidad |
| Cluster espacial | Formar regiones homogéneas y espacialmente continuas | `nbcosts`, `nb2listw`, `mstree`, `skater` | Clusters espaciales |
| Ajuste experto | Revisar coherencia técnica y territorial | Talleres y revisión de especialistas | Regiones finales |
| Caracterización | Describir cada región resultante | Tablas, mapas, series e indicadores | Documento técnico por cadena |

### Selección y preparación de variables

La metodología parte de una base municipal consolidada para cada cadena. En el ejemplo revisado se calculan variables derivadas como porcentaje de UPA con asistencia técnica, tendencias de producción, área y rendimiento, indicadores de especialización productiva, potencialidad, productividad, IDPM, variables de aptitud y distancias medias a centros poblados.

Antes de agrupar, se realiza una revisión exploratoria con mapas y estadísticas descriptivas. También se calcula una matriz de correlaciones para reducir redundancia entre variables. Esta etapa es importante porque el objetivo no es incluir todas las variables disponibles, sino un conjunto que represente la estructura productiva y territorial de la cadena sin duplicar información.

### Cluster no espacial

Como primera aproximación se construye un agrupamiento no espacial. Las variables seleccionadas se escalan y se calcula una distancia euclidiana entre municipios. Luego se aplica clustering jerárquico con el método de Ward.D2, que busca minimizar la variabilidad interna de los grupos.

En el ejemplo de cadena, el script corta el dendrograma en 13 grupos para generar una lectura estadística inicial. Este resultado permite identificar municipios similares por sus atributos, pero todavía puede producir grupos fragmentados o territorialmente dispersos.

### Construcción de la matriz de vecindad

Para incorporar el componente territorial, se construye una matriz de contigüidad municipal tipo queen usando `poly2nb`. En este criterio, dos municipios son vecinos si comparten al menos un punto o borde. La matriz se transforma en líneas de vecindad para validación cartográfica y se revisan componentes desconectados.

El script `clust_esp.R` define la función `estr_contigu()`, que automatiza la generación de la estructura de vecindad, produce mapas de la matriz espacial y verifica municipios o subconjuntos desconectados. Cuando existen grafos separados, se utiliza `connect_subgraphs()` del paquete `bigDM` para garantizar una estructura operativa en el procedimiento espacial.

### Agrupación espacial con SKATER

La agrupación espacial se implementa con el procedimiento SKATER. Primero se escalan las variables seleccionadas y se calculan costos entre municipios vecinos con `nbcosts`, usando distancia euclidiana sobre las variables. Luego se construye una lista de pesos espaciales con `nb2listw`, se obtiene el árbol de expansión mínima con `mstree` y se poda el árbol con `skater` para generar el número de regiones definido.

La función `esp_cluster()` de `clust_esp.R` resume esta lógica: recibe la capa municipal, las variables de agrupamiento, la estructura conectada, el número de grupos y el nombre de la cadena; devuelve el mapa con el campo `groups_esp` y genera una salida cartográfica de los grupos.

### Ajuste experto y regiones finales

Los clusters espaciales se usan como una propuesta inicial. Posteriormente, los resultados se revisan con expertos técnicos de la cadena para ajustar límites, interpretar comportamientos productivos y mejorar la coherencia territorial de las regiones.

En el documento de café, por ejemplo, la metodología combina recopilación de información, selección de variables, clusterización no espacial y espacial, integración de conocimiento experto y caracterización de regiones. El resultado final para esa cadena fue una propuesta de 13 regiones cafeteras que cubren 576 municipios productores.

## Resultados

El proyecto dejó una metodología replicable para regionalizar cadenas agropecuarias a partir de criterios estadísticos, espaciales y expertos. El flujo permitió pasar de bases municipales heterogéneas a regiones interpretables, cartografiables y útiles para instrumentos de planificación.

Los principales resultados técnicos fueron:

- Funciones reutilizables para construir matrices de contigüidad municipal y ejecutar agrupación espacial.
- Implementación de clusters no espaciales mediante escalamiento, distancia euclidiana y Ward.D2.
- Implementación de clusters espaciales mediante SKATER, árbol de expansión mínima y matriz de vecindad queen.
- Integración de variables productivas, territoriales, de aptitud, accesibilidad y asistencia técnica.
- Generación de mapas de vecindad, mapas de grupos no espaciales, mapas de grupos espaciales y mapas de regiones finales.
- Tablas resumen por grupo con número de municipios, UPA, área sembrada y producción.
- Bases con códigos municipales y campos de resultado como `groups_esp`, `groups_sub_v1`, `groups_sub_v2`, `Reg_v1`, `Reg_v2` y `Reg_final`.
- Documentos técnicos para caracterizar regiones por cadena productiva.

### Cadenas trabajadas

| Cadena | Uso del proceso |
| --- | --- |
| Maíz | Regionalización para apoyar lectura territorial de producción y potencialidad |
| Papa | Agrupación de municipios con condiciones productivas y territoriales comparables |
| Caña panelera | Identificación de regiones con continuidad espacial y dinámica productiva similar |
| Acuicultura | Regionalización sectorial ajustada a variables disponibles por municipio |
| Cacao | Ejemplo operativo desarrollado en `region_script.R` para clusters no espaciales y espaciales |
| Café | Documento técnico final con 13 regiones y 576 municipios productores |
| Cebolla | Adaptación del flujo a una cadena hortícola |
| Ganadería bovina | Regionalización para lectura territorial de sistemas pecuarios |
| Ovino-caprina | Regionalización para una cadena pecuaria con menor cobertura territorial |

### Ejemplo de café

El documento técnico de café plantea una regionalización de la producción cafetera y su agroindustria mediante análisis estadísticos y conocimiento experto. La metodología incluye recolección de información municipal, preselección de variables, análisis estadístico, ajuste por expertos y caracterización de las regiones.

En esta aplicación se propusieron 13 regiones cafeteras que abarcan 576 municipios productores. Entre las regiones reportadas se encuentran Cauca-Nariño, Cundinamarca, Eje Cafetero, Norte de Santander, Occidente Antioqueño, Oriente Antioqueño, Piedemonte Amazónico, Piedemonte Orinoquense, Santander, Sur del Cesar, Tolima-Huila, Valle del Cauca y Zona Norte.

## Lecciones aprendidas

La regionalización agropecuaria no debe depender únicamente de algoritmos de clustering. Los métodos estadísticos permiten estructurar grupos consistentes, pero el criterio experto es indispensable para revisar continuidad territorial, coherencia productiva, identidad regional y utilidad para la política pública.

El componente espacial fue clave. El cluster no espacial ayuda a entender similitudes entre municipios, pero puede producir agrupaciones fragmentadas. Al incorporar una matriz de vecindad y SKATER, las regiones resultantes son más útiles para planificación porque respetan la estructura territorial.

También fue importante separar el proceso en funciones reutilizables. La lógica de contigüidad y agrupación espacial puede aplicarse a diferentes cadenas, mientras que la selección de variables y el ajuste experto deben adaptarse a la disponibilidad de datos y a las particularidades productivas de cada sector.

## Trabajo futuro

- Estandarizar plantillas de entrada para todas las cadenas agropecuarias.
- Documentar criterios mínimos para seleccionar variables y número de regiones.
- Automatizar reportes con mapas, tablas y perfiles regionales por cadena.
- Incorporar validaciones cuantitativas de estabilidad de clusters.
- Integrar indicadores de logística, infraestructura, transformación y mercado cuando estén disponibles.
- Publicar salidas geográficas en formatos interoperables como GeoPackage o GeoParquet.

## Tecnologías y métodos

- R
- `sf`
- `spdep`
- `bigDM`
- `ggplot2`
- `ggthemes`
- `openxlsx`
- `readxl`
- `dplyr`
- `data.table`
- `officer`
- `flextable`
- Clustering jerárquico
- Método Ward.D2
- Matriz de contigüidad queen
- SKATER
- Árbol de expansión mínima
- Estadística espacial
- Regionalización agropecuaria

## Nota

Proyecto construido a partir de los scripts `clust_esp.R` y `region_script.R`, y del documento técnico de regionalización de café ubicado en `Z:\regionalizacion`. La implementación se usó como metodología replicable para las cadenas maíz, papa, caña panelera, acuicultura, cacao, café, cebolla, ganadería bovina y ovino-caprina.
