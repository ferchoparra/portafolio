# Modelo Zonas Homogéneas Físicas Catastrales

## Resumen ejecutivo

En Colombia en los procesos de actualización catastral se genera un proceso llamado zonas homogéneas físicas, el cual busca a partir de unas variables espaciales conformar zonas homogeneas basado en estas caracteristicas y definir nuevas zonas a las cuales se les asignan valores del terreno. En el proceso actual es necesario realizar visitas de campo para generar estas zonas homogéneas físicas, lo cual implica un desgaste debido a los largos tiempos y presupuesto requerido. Se viene trabajando en propuestas para mejorar estos procesos, desde la construcción de las variables a partir de información secundaria hasta la generación de las zonas físicas preliminares. En esta última parte del proceso se suele realizar una intersección de las variables espaciales generando asi una cantidad muy alta de poligonos sin algún tipo de continuidad espacial. Este proyecto busca aportar en la integración de las variables para formar las zonas físicas preliminares, se utilizó un procedimiento llamado SKATER el cual proviene de téoria de grafos, el cual a partir de las variables y de una estructura de contiguidad forma grupos con caracteristicas similares y una mejor continuidad espacial.   


## Problema

A partir de la capa que produce cada variable actualmente se genera una intercepción de estas para conformar una versión inicial de las zonas homogéneas físicas. Esto genera una gran cantidad de polígonos con características únicas pero con tamaños no representativos en el terreno; generando así una cantidad no manejable de zonas homogéneas físicas. 


## Datos utilizados

- Capas de variables para definir las zonas homogéneas físicas rurales
    - Áreas homogéneas de tierra
    - Disponibilidad de agua
    - Influencia vial
    - Normatividad de uso
    - Uso actual. 
- Intersección inicial de las variables. 


## Metodologia

La propuesta metodologica se compone de tres partes: se construye una matriz de contiguidad en este caso tipo queen con la intersección inicial que generan las variables; se construye la matriz de datos con las variables para cada uno de los poligonos que se genero en la intersección; y finalmente se aplica el procedimiento skater para formar los clusters que forman las zonas homogéneas físicas. 


![Intersección variables](/portafolio/content/projects/assets/modelo-zonas-homogeneas-fisicas/zhf_ini.png)

Se realizó un proceso de validación sobre municipios que contaban con todo el proceso de actualización catastral donde se generaron las zonas homogeneas fisicas. Utilizando la intersección de las variables de este proceso se aplicó la metodología definiendo el mismo número de zonas físicas determinadas en el proceso de actualización, los resultados fueron comparados con las zonas físicas mediante una metrica definida a partir de progamación lineal, donde para cada grupo de las zonas fisicas del proceso de actualización se le asignaba la zona de la metodología con la cual compartieran la mayor cantidad de área, esta área compartida se divide sobre el total del área del municipio.  

![validacion](/portafolio/content/projects/assets/modelo-zonas-homogeneas-fisicas/validacion.png)


## Resultados

Se implementó la metodologia y validación en 24 municipios de diferentes departamentos del país. La siguiente imagen presenta los resultados para el municipio La Capilla ubicado en el departamento de Boyacá, se presenta la intersección, las zonas generadas por la metodologia y las zonas fisicas generadas en su momento por el proceso de actualización. La metrica para este municipio se reporto en 75.7 % de areas homogeneas entre la metodologia y las zonas de la actualización. 

![validacion](/portafolio/content/projects/assets/modelo-zonas-homogeneas-fisicas/results.png)


La siguiente tabla presenta la metrica obtenida para cada uno de los 24 municipios, en algunos municipios la metodologia se comporta muy bien obteniendo similitudes con las zonas de la actualización por encima del 70 %, sin embargo, en otros municipios se llego a metricas de 34.4 %. 

| Departamento | Municipio | Cantidad de ZHF | Métrica |
|--------------|-----------|----------------:|--------:|
| CUNDINAMARCA | GACHANCIPÁ | 111 | 75,6% |
| BOYACÁ | TENZA | 29 | 76,7% |
| BOYACÁ | LA CAPILLA | 19 | 75,7% |
| BOYACÁ | SOMONDOCO | 18 | 75,1% |
| SANTANDER | SAN BENITO | 20 | 57,6% |
| BOYACÁ | VIRACACHÁ | 15 | 61,2% |
| BOYACÁ | SANTANA | 6 | 76,9% |
| BOYACÁ | SAN JOSÉ DE PARE | 35 | 53,2% |
| CUNDINAMARCA | AGUA DE DIOS | 22 | 34,3% |
| QUINDÍO | LA TEBAIDA | 20 | 85,3% |
| RISARALDA | LA CELIA | 7 | 99,0% |
| BOYACÁ | GUAYATÁ | 58 | 58,7% |
| RISARALDA | GUÁTICA | 9 | 57,0% |
| BOYACÁ | RAMIRIQUÍ | 71 | 34,0% |
| BOYACÁ | ÚMBITA | 41 | 49,2% |
| BOYACÁ | GARAGOA | 29 | 34,4% |
| BOLÍVAR | TURBACO | 71 | 50,1% |
| BOYACÁ | SOGAMOSO | 99 | 55,6% |
| BOYACÁ | MONIQUIRÁ | 100 | 77,2% |
| CÓRDOBA | LA APARTADA | 41 | 50,6% |
| CUNDINAMARCA | CHOCONTÁ | 111 | 63,9% |
| META | GRANADA | 28 | 51,9% |
| SANTANDER | VÉLEZ | 92 | 44,8% |
| CÓRDOBA | BUENAVISTA | 49 | 57,0% |


## Lecciones aprendidas

La propuesta implementada es una versión inicial que ya esta teniendo buenos resultados, sin embargo, es necesario trabajar en varios aspectos para mejorarla: revisar los procesos de construcción de las variables originales en donde se pueden estar generando poligonos muy pequeños que aumentar los poligonos de la intersección y vuelven mas complejo generar las zonas finales; trabajar sobre la contrucción de la matriz de datos utilizando diferentes tecnicas que permitan integrar datos cualitativos dentro de este tipo de procedimiento SKATER. 

Finalmente resaltar que el aporte del experto tematico es vital para diseñar e implementar este tipo de metodologias que buscan facilitar el trabajo de ellos, a partir del analisis de la información. 


## Nota: 
El proyecto se desarrollo bajo un contrato ejecutado con el Instituto Geográfico Agustín Codazzi - IGAC.  