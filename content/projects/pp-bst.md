# Ánalisis de la estructura espacial de un bosque seco tropical mediante patrones puntuales

## Resumen ejecutivo

Se analiza un patrón puntual marcado de un bosque seco tropical, el cual es generado a partir de la localización de los árboles dentro de una parcela de una hectárea ubicada en el parque nacional natural El Tuparro en la Orinoquia Colombiana. Utilizamos dos marcas cualitativas la especie y tamaño, y una marca cuantitativa el diámetro a la altura del pecho - dap. El objetivo del estudio fue analizar a un nivel de comunidad ecológica, la distribución espacial de las plantas mediante el patrón puntual marcado, para entender los procesos de competencia y facilitación que tienen una influencia en el patrón generado. Se propuso una metodología basada en diferentes herramientas provenientes de la teoría de procesos puntuales: primero se estimó la intensidad utilizando un kernel e incorporando la covariable distancia a las rocas; después utilizamos diferentes herramientas de segundo orden para analizar las intra e inter dependencias de cada una de las marcas; y finalmente usamos tres métodos para clasificar a las especies por su comportamiento espacial, uno basado en índices de dispersión y los otros dos con funciones de segundo orden. Los resultados muestran una influencia del suelo rocoso sobre la distribución espacial de las plantas dentro del área de estudio; las funciones de segundo orden indican un patrón de inhibición para todas las especies, y para algunas se identificó un patrón de agrupación a distancias cercanas; el tamaño de las plantas también influye en la distribución espacial, los árboles grandes y medianos tienden a formar pequeños patrones agregados con radios de 1.3 metros, mientras que las plantas pequeñas se agrupan más alrededor de plantas grandes que medianas; los tres tipos de información utilizados para el análisis de clasificación muestran similitudes en los grupos de especies formados, sin embargo, las funciones de segundo orden muestran mejores resultados de clasificación

## Problema

La reducción y degradación de los bosques secos tropicales es una problematica ambiental alta, en Colombia originalmente existian alrededor de 8.8 millones de hectáreas, para el 2019 se redujo a un 22.5 % de esta área. La mayoria fue transformada en pastos para ganaderia (33.2 %) y tierras agrícolas (28.2 %), lo demás en áreas antropicas. Este tipo de ecosistema además de su importancia biologica, tiene varios beneficios como: suministro de alimentos y madera para las comunidades cercanas, servicios ambientales como la estabilización del suelo, el reciclaje de nutrientes y la regulación climática. De aqui la importancia de estudiar los bosques secos tropicales y su estructura espacial, para poder aportar en la conservación y restauración de este tipo de ecosistema. 

## Datos utilizados


- Datos georreferenciados de las especies dentro de la parcela. 
- Información cualitativa: nombre de la especie
- Información cuantitativa: diametro a la altura del pecho de los árboles. 


## Metodologia

Se trabajó con diferentes herramientas de la teoría de procesos puntuales, utilizando la información de una parcela de una hectárea ubicada en el parque nacional natural El Tuparro en la Orinoquia Colombiana.

![Distribución de los árboles](/portafolio/content/projects/assets/pp-bst/map.png)

La metodología implementada se divide en tres partes: 

1. El análisis de las intensidades (herramientas de primer orden)
2. El análisis de las interacciones (herramientas de segundo orden)
3. El análisis de los métodos de clasificación utilizados para agrupar las especies según su comportamiento espacial.

El siguiente diagrama presenta las herramientas utilizadas en cada proceso. 

![Metodologia](/portafolio/content/projects/assets/pp-bst/meto.png)


## Resultados

### Intensidades

Se construyó un modelo que busca analizar la intensidad de los patrones marcados por tamaño y para las principales especies encontradas, este modelo incluye la interacción de las especies con el suelo rocoso de la zona analizada. $ \alpha $

$$
\lambda(u) = b(u)\,e^{(\alpha + \beta Z(u))}
$$


| Category P.P. | alpha | beta | sig alpha | sig beta |
|---------------|------:|-----:|:---------:|:--------:|
| Unmarked      | -0.13 |  0.16 | *** | *** |
| Large         | -0.08 |  0.10 |     |     |
| Medium        | -0.19 |  0.21 | *   | *** |
| Small         | -0.13 |  0.15 | **  | *** |
| Attalea m.    | -0.04 |  0.05 |     |     |
| Bactris b.    | -0.38 |  0.35 | **  | *** |
| Eschweilera t.| -0.25 |  0.28 |     | **  |
| Gustavia a.   | -0.11 |  0.13 |     |     |
| Matayba sp    | -0.05 |  0.06 |     |     |
| Protium g.    | -0.11 |  0.14 |     |     |
| Pachira n.    |  0.29 | -0.53 |     |     |
| Inga g.       | -0.28 |  0.26 |     | *   |
| Morf sp4      | -0.42 |  0.44 |     | **  |

Grafico patron sin marca

### Interacciones



### Clasificación


## Lecciones aprendidas

La calidad del pipeline depende de pruebas simples, contratos de datos claros y monitoreo de volumenes.


## Link para documento completo

https://repositorio.unal.edu.co/handle/unal/77014
