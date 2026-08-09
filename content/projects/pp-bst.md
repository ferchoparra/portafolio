# Analisis de la estructura espacial de un bosque seco tropical mediante patrones puntuales

## Resumen ejecutivo

Trabajo de investigacion estadistica aplicado al analisis de la estructura espacial de arboles en un bosque seco tropical. Se analizo un patron puntual marcado construido a partir de la localizacion de 1274 plantas en una parcela permanente de una hectarea ubicada en el Parque Nacional Natural El Tuparro, en la Orinoquia colombiana.

El estudio uso dos marcas cualitativas, especie y tamano, y una marca cuantitativa, diametro a la altura del pecho (DAP). El objetivo fue evaluar la distribucion espacial de la comunidad vegetal para entender senales de competencia, facilitacion, agregacion e inhibicion. La metodologia combino herramientas de primer orden, funciones de segundo orden y metodos de clasificacion funcional para agrupar especies segun su comportamiento espacial.

## Problema

Los bosques secos tropicales son ecosistemas altamente amenazados por transformacion hacia pastos, agricultura y otros usos antropicos. En Colombia, una parte importante del area original de bosque seco tropical se ha reducido o degradado, lo que hace necesario estudiar su estructura y dinamica para apoyar procesos de conservacion, restauracion y monitoreo ecologico.

Desde el punto de vista estadistico, el problema consistia en analizar una comunidad con muchas especies y diferentes tamanos de plantas dentro de una ventana espacial pequena. Esto genera varios retos:

- Modelar una intensidad espacial no homogenea.
- Incorporar covariables ambientales, como la distancia al suelo rocoso.
- Evaluar dependencia intraespecifica e interespecifica.
- Analizar simultaneamente marcas cualitativas y cuantitativas.
- Clasificar especies con pocos individuos usando informacion espacial completa y no solo indices agregados.

## Datos utilizados

- Localizacion espacial de 1274 plantas dentro de una parcela de una hectarea.
- Parcela ubicada en el Parque Nacional Natural El Tuparro, Orinoquia colombiana.
- Poligonos o zonas de suelo rocoso dentro del area de estudio.
- Marca cualitativa de especie.
- Marca cualitativa de tamano basada en rangos de DAP: pequena, mediana y grande.
- Marca cuantitativa DAP.
- Subconjunto de 32 especies con mas de 10 individuos para analisis de clasificacion.
- Subconjunto de especies dominantes definido mediante probabilidades derivadas de intensidades espaciales.

![Distribucion de los arboles](/portafolio/content/projects/assets/pp-bst/map.png)

## Metodologia

La metodologia se estructuro en tres fases: caracteristicas de primer orden, caracteristicas de segundo orden y clasificacion de especies segun comportamiento espacial.

![Metodologia](/portafolio/content/projects/assets/pp-bst/meto.png)

| Fase | Objetivo | Herramientas |
| --- | --- | --- |
| Intensidad | Estimar variacion espacial del patron e incorporar suelo rocoso | Kernel, modelo log-lineal de intensidad, covariable distancia a rocas |
| Interacciones | Evaluar agregacion, inhibicion y dependencia entre marcas | Funcion K inhomogenea, pair correlation function, funciones cruzadas y funciones de marcas |
| Clasificacion | Agrupar especies por comportamiento espacial | Indices de dispersion, suavizamiento funcional, FPCA y clustering jerarquico |

### Intensidad espacial

Se estimo la intensidad del patron puntual mediante suavizamiento kernel y se ajusto un modelo de intensidad que incorpora la distancia a las rocas:

$$
\lambda(u) = b(u)\,e^{(\alpha + \beta Z(u))}
$$

Donde `b(u)` representa la intensidad base estimada por kernel y `Z(u)` la covariable asociada a la distancia al suelo rocoso. Este componente permitio evaluar si la presencia o cercania de rocas modificaba la probabilidad de encontrar plantas, especies o categorias de tamano.

| Category P.P. | alpha | beta | sig alpha | sig beta |
| --- | ---: | ---: | :---: | :---: |
| Unmarked | -0.13 | 0.16 | *** | *** |
| Large | -0.08 | 0.10 | | |
| Medium | -0.19 | 0.21 | * | *** |
| Small | -0.13 | 0.15 | ** | *** |
| Attalea m. | -0.04 | 0.05 | | |
| Bactris b. | -0.38 | 0.35 | ** | *** |
| Eschweilera t. | -0.25 | 0.28 | | ** |
| Gustavia a. | -0.11 | 0.13 | | |
| Matayba sp | -0.05 | 0.06 | | |
| Protium g. | -0.11 | 0.14 | | |
| Pachira n. | 0.29 | -0.53 | | |
| Inga g. | -0.28 | 0.26 | | * |
| Morf sp4 | -0.42 | 0.44 | | ** |

### Interacciones espaciales

Para evaluar dependencia espacial se usaron funciones de segundo orden con correccion de borde e intensidades no homogeneas. El patron sin marca se comparo contra simulaciones de un proceso de Poisson no homogeneo.

Para la marca especie se analizaron dependencias intraespecificas, entre individuos de la misma especie, e interespecificas, entre una especie y el resto de la comunidad. Dado el numero alto de especies, se uso una estrategia de seleccion basada en probabilidad espacial dominante y funciones condensadas para reducir la complejidad del analisis pareado.

Para el tamano se evaluaron las categorias pequena, mediana y grande, y se complemento con funciones de marcas cuantitativas usando DAP. Esto permitio contrastar si los patrones encontrados por categorias eran consistentes con la informacion continua del diametro.

### Clasificacion de especies

Se implementaron tres estrategias para agrupar especies segun su patron espacial:

- Clasificacion basada en indices de dispersion.
- Clasificacion usando scores de FPCA sobre funciones K inhomogeneas.
- Clasificacion usando scores de FPCA sobre pair correlation functions.

Las funciones de segundo orden se trataron como datos funcionales. Luego se aplico analisis de componentes principales funcionales y clustering jerarquico, permitiendo convertir curvas espaciales completas en variables comparables para clasificacion.

## Resultados

### Intensidades

El suelo rocoso mostro influencia sobre la distribucion espacial de las plantas. En el patron sin marca, la intensidad se reduce cerca de las rocas y aumenta al alejarse de ellas. Este patron tambien aparece en varias especies y en las categorias mediana y pequena.

El efecto fue especialmente claro para `Bactris bidentula`, `Eschweilera tenuifolia`, `Inga gracilifolia` y `Morf sp4`, con parametros asociados a distancia a rocas significativos. En contraste, `Pachira nukakica` mostro un comportamiento distinto: algunos individuos grandes estaban ubicados sobre rocas, sugiriendo capacidad de establecimiento en condiciones restrictivas.

### Interacciones

El patron sin marca presento agregacion a distancias cortas, seguida de inhibicion a distancias medias. La funcion K inhomogenea mostro agregacion ligera hasta aproximadamente 5.6 metros y luego valores por debajo de la referencia CSR. La pair correlation function evidencio agregacion fuerte hasta cerca de 4.2 metros, inhibicion entre 5 y 12 metros y comportamiento cercano a aleatoriedad espacial a mayores distancias.

Para las especies, las funciones de segundo orden indicaron que la mayoria presenta inhibicion, aunque varias especies muestran agregacion a distancias muy cortas. `Protium guianense` fue una de las especies con agregacion de mayor alcance, cercana a 2.4 metros. A distancias mas grandes, el patron tiende a ser regular, compatible con procesos de competencia por recursos.

En la marca tamano, las plantas pequenas mostraron agregacion con radio cercano a 1 metro; las medianas presentaron agregacion mas reducida, alrededor de 0.7 metros; y las grandes mostraron un patron mas regular con rango de correlacion mayor, cercano a 25 metros. Esto sugiere que la competencia aumenta con el tamano y que los individuos grandes ejercen una zona de influencia espacial mas amplia.

Las interacciones entre categorias mostraron que plantas grandes y medianas tienden a aparecer cerca en pequenas areas con mejores condiciones de suelo, mientras que las plantas pequenas tambien aparecen alrededor de arboles grandes y en zonas mas cercanas a rocas.

### Clasificacion

Los tres metodos de clasificacion presentaron similitudes, pero los metodos basados en funciones de segundo orden fueron mas consistentes entre si. De las 32 especies analizadas, 18 compartieron el mismo grupo general en los tres metodos; 13 coincidieron en dos metodos; y solo `Matayba sp` quedo en grupos distintos segun cada estrategia.

Al comparar solo los metodos basados en funcion K y pair correlation function, 28 de las 32 especies compartieron una figura o grupo comun. Esto sugiere que las curvas de segundo orden capturan mejor el comportamiento espacial que los indices escalares tradicionales.

Los grupos permitieron diferenciar especies con:

- Inhibicion fuerte y agregacion corta.
- Inhibicion fuerte sin agregacion cercana marcada.
- Inhibicion mas debil y agregacion muy fuerte a distancias pequenas.

## Lecciones aprendidas

El analisis mostro que los patrones puntuales marcados son una herramienta potente para estudiar bosques tropicales con alta diversidad y estructura espacial compleja. La combinacion de intensidad, funciones de segundo orden y analisis funcional permite pasar de mapas de individuos a inferencias sobre competencia, facilitacion y dominancia espacial.

Una leccion importante fue que los indices de dispersion son utiles como resumen inicial, pero pueden ocultar rasgos relevantes del patron. Las funciones de segundo orden, al preservar la informacion por distancia, ofrecieron una clasificacion mas coherente con la estructura espacial observada.

Tambien se evidencio la necesidad de integrar conocimiento ecologico con estadistica espacial. Variables como estrategia de dispersion, tolerancia a sombra, habito, estado sucesional y seguimiento temporal podrian mejorar la interpretacion de los grupos encontrados.

## Trabajo futuro

- Refinar el modelo de intensidad usando nuevas formas de suavizamiento o una covariable binaria de presencia/ausencia de roca.
- Analizar etapas de crecimiento por especie mediante patrones espacio-temporales.
- Explorar patrones puntuales tridimensionales usando coordenadas y altura de los arboles.
- Redefinir categorias de tamano especificas para la parcela usando resultados de clasificacion.
- Proponer modelos generativos capaces de simular la estructura espacial del bosque y evaluar la importancia de especies o categorias particulares.

## Tecnologias y metodos

- R
- Estadistica espacial
- Procesos puntuales marcados
- Funcion K inhomogenea
- Pair correlation function
- Funciones de correlacion de marcas
- Analisis funcional de datos
- FPCA
- Clustering jerarquico
- Ecologia cuantitativa

## Nota

Proyecto desarrollado como trabajo de grado de la Maestria en Ciencias - Estadistica de la Universidad Nacional de Colombia.

[Documento completo](https://repositorio.unal.edu.co/handle/unal/77014)
