# Análisis de la estructura espacial de un bosque seco tropical mediante patrones puntuales

## Resumen ejecutivo

Trabajo de investigación estadística aplicado al análisis de la estructura espacial de árboles en un bosque seco tropical. Se analizó un patrón puntual marcado construido a partir de la localización de 1274 plantas en una parcela permanente de una hectárea ubicada en el Parque Nacional Natural El Tuparro, en la Orinoquia colombiana.

El estudio usó dos marcas cualitativas, especie y tamaño, y una marca cuantitativa, diámetro a la altura del pecho (DAP). El objetivo fue evaluar la distribución espacial de la comunidad vegetal para entender señales de competencia, facilitación, agregación e inhibición. La metodología combinó herramientas de primer orden, funciones de segundo orden y métodos de clasificación funcional para agrupar especies según su comportamiento espacial.

## Problema

Los bosques secos tropicales son ecosistemas altamente amenazados por transformación hacia pastos, agricultura y otros usos antrópicos. En Colombia, una parte importante del área original de bosque seco tropical se ha reducido o degradado, lo que hace necesario estudiar su estructura y dinámica para apoyar procesos de conservación, restauración y monitoreo ecológico.

Desde el punto de vista estadístico, el problema consistía en analizar una comunidad con muchas especies y diferentes tamaños de plantas dentro de una ventana espacial pequeña. Esto genera varios retos:

- Modelar una intensidad espacial no homogénea.
- Incorporar covariables ambientales, como la distancia al suelo rocoso.
- Evaluar dependencia intraespecífica e interespecífica.
- Analizar simultáneamente marcas cualitativas y cuantitativas.
- Clasificar especies con pocos individuos usando información espacial completa y no solo índices agregados.

## Datos utilizados

- Localización espacial de 1274 plantas dentro de una parcela de una hectárea.
- Parcela ubicada en el Parque Nacional Natural El Tuparro, Orinoquia colombiana.
- Polígonos o zonas de suelo rocoso dentro del área de estudio.
- Marca cualitativa de especie.
- Marca cualitativa de tamaño basada en rangos de DAP: pequeña, mediana y grande.
- Marca cuantitativa DAP.
- Subconjunto de 32 especies con más de 10 individuos para análisis de clasificación.
- Subconjunto de especies dominantes definido mediante probabilidades derivadas de intensidades espaciales.

![Distribución de los árboles](/portafolio/content/projects/assets/pp-bst/map.png)

## Metodología

La metodología se estructuró en tres fases: características de primer orden, características de segundo orden y clasificación de especies según comportamiento espacial.

![Metodología](/portafolio/content/projects/assets/pp-bst/meto.png)

| Fase | Objetivo | Herramientas |
| --- | --- | --- |
| Intensidad | Estimar variación espacial del patrón e incorporar suelo rocoso | Kernel, modelo log-lineal de intensidad, covariable distancia a rocas |
| Interacciones | Evaluar agregación, inhibición y dependencia entre marcas | Función K inhomogénea, pair correlation function, funciones cruzadas y funciones de marcas |
| Clasificación | Agrupar especies por comportamiento espacial | Índices de dispersión, suavizamiento funcional, FPCA y clustering jerárquico |

### Intensidad espacial

Se estimó la intensidad del patrón puntual mediante suavizamiento kernel y se ajustó un modelo de intensidad que incorpora la distancia a las rocas:

$$
\lambda(u) = b(u)\,e^{(\alpha + \beta Z(u))}
$$

Donde `b(u)` representa la intensidad base estimada por kernel y `Z(u)` la covariable asociada a la distancia al suelo rocoso. Este componente permitió evaluar si la presencia o cercanía de rocas modificaba la probabilidad de encontrar plantas, especies o categorías de tamaño.

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

Para evaluar dependencia espacial se usaron funciones de segundo orden con correccion de borde e intensidades no homogéneas. El patrón sin marca se comparo contra simulaciones de un proceso de Poisson no homogeneo.

Para la marca especie se analizaron dependencias intraespecíficas, entre individuos de la misma especie, e interespecíficas, entre una especie y el resto de la comunidad. Dado el numero alto de especies, se uso una estrategia de selección basada en probabilidad espacial dominante y funciones condensadas para reducir la complejidad del análisis páreado.

Para el tamaño se evaluaron las categorías pequeña, mediana y grande, y se complementó con funciones de marcas cuantitativas usando DAP. Esto permitió contrastar si los patrones encontrados por categorías eran consistentes con la información continua del diámetro.

### Clasificación de especies

Se implementaron tres estrategias para agrupar especies según su patrón espacial:

- Clasificación basada en índices de dispersión.
- Clasificación usando scores de FPCA sobre funciones K inhomogéneas.
- Clasificación usando scores de FPCA sobre pair correlation functions.

Las funciones de segundo orden se trataron como datos funcionales. Luego se aplicó análisis de componentes principales funcionales y clustering jerárquico, permitiendo convertir curvas espaciales completas en variables comparables para clasificación.

## Resultados

### Intensidades

El suelo rocoso mostró influencia sobre la distribución espacial de las plantas. En el patrón sin marca, la intensidad se reduce cerca de las rocas y aumenta al alejarse de ellas. Este patrón también aparece en varias especies y en las categorías mediana y pequeña.

El efecto fue especialmente claro para `Bactris bidentula`, `Eschweilera tenuifolia`, `Inga gracilifolia` y `Morf sp4`, con parametros asociados a distancia a rocas significativos. En contraste, `Pachira nukakica` mostró un comportamiento distinto: algunos individuos grandes estaban ubicados sobre rocas, sugiriendo capacidad de establecimiento en condiciones restrictivas.

### Interacciones

El patrón sin marca presentó agregación a distancias cortas, seguida de inhibición a distancias medias. La función K inhomogénea mostró agregación ligera hasta aproximadamente 5.6 metros y luego valores por debajo de la referencia CSR. La pair correlation function evidenció agregación fuerte hasta cerca de 4.2 metros, inhibición entre 5 y 12 metros y comportamiento cercano a aleatoriedad espacial a mayores distancias.

Para las especies, las funciones de segundo orden indicaron que la mayoría presenta inhibición, aunque varias especies muestran agregación a distancias muy cortas. `Protium guianense` fue una de las especies con agregación de mayor alcance, cercana a 2.4 metros. A distancias más grandes, el patrón tiende a ser regular, compatible con procesos de competencia por recursos.

En la marca tamaño, las plantas pequeñas mostraron agregación con radio cercano a 1 metro; las medianas presentaron agregación más reducida, alrededor de 0.7 metros; y las grandes mostraron un patrón más regular con rango de correlación mayor, cercano a 25 metros. Esto sugiere que la competencia aumenta con el tamaño y que los individuos grandes ejercen una zona de influencia espacial más amplia.

Las interacciones entre categorías mostraron que plantas grandes y medianas tienden a aparecer cerca en pequeñas áreas con mejores condiciones de suelo, mientras que las plantas pequeñas también aparecen alrededor de árboles grandes y en zonas más cercanas a rocas.

### Clasificación

Los tres métodos de clasificación presentaron similitudes, pero los métodos basados en funciones de segundo orden fueron más consistentes entre sí. De las 32 especies analizadas, 18 compartieron el mismo grupo general en los tres métodos; 13 coincidieron en dos métodos; y solo `Matayba sp` quedó en grupos distintos según cada estrategia.

Al comparar solo los métodos basados en función K y pair correlation function, 28 de las 32 especies compartieron una figura o grupo común. Esto sugiere que las curvas de segundo orden capturan mejor el comportamiento espacial que los índices escalares tradicionales.

Los grupos permitieron diferenciar especies con:

- Inhibición fuerte y agregación corta.
- Inhibición fuerte sin agregación cercana marcada.
- Inhibicion más debil y agregación muy fuerte a distancias pequeñas.

## Lecciones aprendidas

El análisis mostró que los patrones puntuales marcados son una herramienta potente para estudiar bosques tropicales con alta diversidad y estructura espacial compleja. La combinacion de intensidad, funciones de segundo orden y análisis funcional permite pasar de mapas de individuos a inferencias sobre competencia, facilitación y dominancia espacial.

Una lección importante fue que los índices de dispersión son útiles como resumen inicial, pero pueden ocultar rasgos relevantes del patrón. Las funciones de segundo orden, al preservar la información por distancia, ofrecieron una clasificación más coherente con la estructura espacial observada.

También se evidenció la necesidad de integrar conocimiento ecológico con estadística espacial. Variables como estrategia de dispersión, tolerancia a sombra, hábito, estado sucesional y seguimiento temporal podrían mejorar la interpretación de los grupos encontrados.

## Trabajo futuro

- Refinar el modelo de intensidad usando nuevas formas de suavizamiento o una covariable binaria de presencia/ausencia de roca.
- Analizar etapas de crecimiento por especie mediante patrones espacio-temporales.
- Explorar patrones puntuales tridimensionales usando coordenadas y altura de los árboles.
- Redefinir categorías de tamaño específicas para la parcela usando resultados de clasificación.
- Proponer modelos generativos capaces de simular la estructura espacial del bosque y evaluar la importancia de especies o categorías particulares.

## Tecnologías y métodos

- R
- Estadística espacial
- Procesos puntuales marcados
- Función K inhomogénea
- Pair correlation function
- Funciones de correlación de marcas
- Análisis funcional de datos
- FPCA
- Clustering jerárquico
- Ecologia cuantitativa

## Nota

Proyecto desarrollado como trabajo de grado de la Maestría en Ciencias - Estadística de la Universidad Nacional de Colombia.

[Documento completo](https://repositorio.unal.edu.co/handle/unal/77014)
