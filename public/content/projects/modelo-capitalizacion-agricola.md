# Modelo de capitalización de renta agropecuaria

## Resumen ejecutivo

Modelo masivo de capitalización de renta agropecuaria desarrollado para estimar valores comerciales de terreno por hectárea en predios rurales, a partir de la productividad económica de cultivos permanentes y transitorios. El modelo fue construido como insumo técnico para la actualización masiva del componente económico catastral asociada al artículo 49 del Plan Nacional de Desarrollo 2022-2026.

La solución integra información productiva, espacial, económica y logística para calcular rendimientos, costos, precios, utilidad bruta y valor por hectárea. En su implementación final generó resultados para 648 municipios del país, considerando 34 cultivos, con desagregación submunicipal por polígonos derivados de áreas homogéneas de tierra, aptitud del cultivo, provincia de humedad y zonas geoeconómicas vigentes.

## Problema

Colombia presenta un rezago importante en valores catastrales rurales. En municipios con información de mercado limitada o poco transparente, el método comparativo tradicional puede ser insuficiente o estar afectado por especulación. Para predios agropecuarios, una alternativa técnica es estimar el valor del suelo a partir de su capacidad de generar renta productiva.

El reto consistía en diseñar e implementar una metodología operativa que permitiera:

- Calcular valores por hectárea de manera masiva y reproducible.
- Incorporar productividad real del suelo y aptitud agropecuaria.
- Integrar costos, precios y transporte con desagregación territorial.
- Generar resultados útiles para zonas homogéneas geoeconómicas de uso agropecuario.
- Procesar municipios de forma eficiente sin cargar toda la información nacional en cada ejecución.
- Producir salidas trazables para tableros, visores y análisis catastral.

## Datos utilizados

- Evaluaciones Agropecuarias (EVA) para área sembrada, producción y rendimientos por cultivo y municipio.
- Mapas de aptitud y zonificación agropecuaria de la UPRA, con 41 capas de zonificación asociadas a cultivos o actividades.
- Áreas Homogéneas de Tierra (AHT) del IGAC, con clases agrológicas, valor potencial y atributos físicos.
- Zonas Homogéneas Geoeconómicas (ZHG) vigentes.
- Provincia de humedad construida por el equipo de Agrología.
- Estructuras normalizadas de costos por cultivo, permanentes y transitorios.
- Series de precios de insumos agropecuarios del SIPSA.
- Series de precios mayoristas del SIPSA, con 635 mil registros, 381 productos y 104 mercados.
- Precios al productor reportados por federaciones para cultivos específicos.
- Registro Nacional de Despacho de Carga (RNDC), filtrado a productos agropecuarios relevantes para modelar transporte.
- Red vial nacional con velocidades estimadas y distancias entre municipios productores y mercados.
- Distancias internas entre zonas geoeconómicas y centros poblados municipales.

## Metodología

El modelo se estructuró como una arquitectura modular que permite construir los insumos de renta agropecuaria y transformarlos en valores por hectárea.

| Módulo | Objetivo | Insumos principales | Salida |
| --- | --- | --- | --- |
| Caracterización | Seleccionar cultivos representativos por municipio | EVA, área sembrada | Cultivos que acumulan cerca del 80% del área sembrada municipal |
| Rendimientos | Estimar rendimiento por unidad espacial | EVA, aptitud UPRA, AHT | Rendimiento ajustado por cultivo, municipio y polígono |
| Costos | Calcular costos por hectárea diferenciados espacialmente | Estructuras de costos, SIPSA insumos, aptitud, humedad | Costos actualizados por cultivo y zona |
| Precios | Asignar precio neto y descontar transporte | SIPSA, federaciones, RNDC, red vial, distancias internas | Precio por tonelada descontando fletes |
| Avalúos | Integrar rendimientos, costos y precios | Salidas de los módulos anteriores, ZHG | Utilidad bruta y valor comercial por hectárea |

### Preparación espacial y homologación

Las capas geográficas fueron simplificadas con conservación de topología, ajustadas a límites municipales, corregidas en geometría y transformadas a MAGNA-SIRGAS origen nacional EPSG:9377. Este paso fue necesario para realizar cruces espaciales robustos entre aptitud, AHT, humedad y zonas geoeconómicas.

También se construyeron códigos de homologación entre las fuentes: EVA, UPRA, CNA, ENA, estructuras de costos, SIPSA y RNDC. La clave principal operativa fue el código de cultivo EVA, ya que las evaluaciones agropecuarias se actualizan anualmente por municipio.

### Módulo de caracterización

El módulo seleccióna los cultivos principales de cada municipio usando el área sembrada reportada en las EVA. Los cultivos se ordenan de mayor a menor participación y se acumulan hasta cubrir aproximadamente el 80% del área sembrada municipal.

Este criterio permite capturar los cultivos más representativos del territorio. En algunos municipios un solo cultivo explica la mayor parte del área, mientras que en otros se requieren hasta 14 cultivos.

### Módulo de rendimientos

El módulo de rendimientos tiene dos etapas. Primero se construye una estructura nacional de rendimientos por cultivo, relacionando categorías de aptitud y clases de AHT. Para escalar el proceso a los cultivos reportados por las EVA, se asignan siete valores de rendimiento por cultivo usando percentiles de la distribución nacional.

Luego la estructura se ajusta a cada municipio. El promedio ponderado por área de los polígonos debe coincidir con el rendimiento reportado por la EVA municipal, conservando la forma relativa de la estructura base. Así, el modelo mantiene diferenciación espacial interna sin perder coherencia con el dato oficial municipal.

### Módulo de costos

El módulo de costos actualiza estructuras normalizadas por cultivo y las diferencia dentro del municipio. Primero asigna precios de insumos a partir del mercado SIPSA más cercano, usando polígonos de Thiessen. Si un insumo no está disponible en la central más cercana, el algoritmo busca en la ciudad capital más cercana y, en último caso, usa el promedio nacional.

Después aplica premisas definidas por Agrología para ajustar costos según aptitud, sistema productivo y provincia de humedad. La lógica es que zonas de alta aptitud requieren menores costos relativos, mientras que suelos de baja aptitud o provincias de humedad exigentes pueden aumentar rubros específicos.

### Módulo de precios

El módulo de precios asigna un precio por cultivo y municipio. Cuando existen precios de federaciones, se usan como precio al productor; en los demás casos se usan series SIPSA. Para estabilizar las series se aplica el filtro Hodrick-Prescott, identificando un período representativo mediante picos locales del componente cíclico.

Para las series masivas se implementó el filtro en R usando `mFilter`, procesando series de federaciones y series producto-mercado del SIPSA.

### Transporte y red vial

El modelo descuenta dos costos de transporte:

- Transporte externo: desde el centro poblado del municipio productor hasta el mercado mayorista más cercano con el producto.
- Transporte interno: desde las zonas geoeconómicas hasta el centro poblado municipal.

El transporte externo se apoyó en un modelo de redes construido en QGIS con QNEAT3, usando una red vial con velocidades asignadas. Para los costos de transporte se ajustaron modelos lineales generalizados de efectos mixtos por cultivo, utilizando información del RNDC y la relación entre kilómetros recorridos y valor por tonelada-kilometro.

La forma general del modelo de transporte fue:

$$
Costo_{ij} = \beta_0 + \beta_1 \log(D_{ij}) + u_j + e_{ij}
$$

Donde `Dij` representa la distancia recorrida, `uj` el efecto aleatorio asociado al tipo de transporte y `eij` el error residual.

### Módulo de avalúos

Los módulos anteriores se integran en una unidad espacial final resultante de la intersección entre aptitud, AHT, humedad y zonas geoeconómicas. En esa unidad consolidada se calcula la utilidad bruta por hectárea:

$$
UB = R \times P - C
$$

Donde:

- `UB`: utilidad bruta por hectárea.
- `R`: rendimiento en toneladas por hectárea.
- `P`: precio en pesos por tonelada, descontando transporte interno y externo.
- `C`: costo en pesos por hectárea.

Con la utilidad bruta y una tasa de capitalización fija de 7.3%, se estiman valores comerciales por hectárea diferenciando cultivos transitorios y permanentes:

| Tipo de cultivo | Ecuacion aplicada |
| --- | --- |
| Transitorios | `VH = 50% x UB / i` |
| Permanentes | `VH = 25% x UB / i` |

## Resultados

El modelo generó valores por hectárea para 648 municipios y 34 cultivos, con resultados a nivel de unidad espacial submunicipal. Las salidas sirvieron como insumo para la definición de valores en Zonas Homogéneas Geoeconómicas vigentes de uso agropecuario y para la implementación del artículo 49 en la vigencia 2025.

Los principales resultados técnicos fueron:

- Metodología masiva para valorar terreno rural en función de productividad y uso agropecuario.
- Selección automatizada de cultivos dominantes por municipio.
- Rendimientos espacializados por aptitud, AHT y ajuste al rendimiento EVA municipal.
- Costos de producción diferenciados por localización, aptitud y humedad.
- Precios estabilizados con series SIPSA, federaciones y filtro Hodrick-Prescott.
- Costos de transporte interno y externo incorporados al precio neto.
- Unidades espaciales finales por intersección de capas productivas, económicas y geoeconómicas.
- Tablero Power BI para resultados agregados y visor geoespacial en ArcGIS Experience para resultados por unidad espacial.

### Costos de transporte

El costo de flete externo varió entre 1% y 57% del precio total del cultivo. Para la mayoría de cultivos y municipios productores, el transporte externo representó entre 3% y 20%. Cultivos como caña panelera y caña azucarera presentaron porcentajes más altos por la relación entre precio, ubicación y logística.

El flete interno, desde zonas geoeconómicas al centro poblado, tuvo porcentajes generalmente menores, desde menos de 1% hasta 15% del precio del producto, excluyendo casos particulares como caña panelera.

### Utilidad bruta y valor por hectárea

La utilidad bruta calculada a partir de rendimientos, costos y precios presentó valores desde 25 millones en pérdidas hasta 153 millones de utilidad. La mediana fue de 3.9 millones y la media de 6.4 millones, considerando las unidades espaciales generadas.

Entre los cultivos con utilidades promedio más bajas se identificaron arveja, fique, papa y diferentes tipos de maíz. Entre los cultivos con mayores utilidades promedio se destacaron pera, cebolla de rama y lulo, con valores medios aproximados de 71, 61 y 45 millones de pesos por hectárea al año.

En valores por hectárea, los transitorios con valores más altos incluyeron cebolla de rama, ñame, lechuga y arracacha. En permanentes destacaron pera, lulo, durazno y aguacate Hass. Los valores negativos se concentraron en cultivos como arveja, maíz, papa, arroz secano mecanizado, fique y cacao.

## Lecciones aprendidas

El proyecto muestra que la valoración rural masiva requiere combinar estadística, GIS, economía agropecuaria, ingeniería de datos y conocimiento valuatorio. El valor por hectárea no depende de una sola variable: surge de la interacción entre rendimiento, aptitud, estructura de costos, precios, transporte, humedad y unidad geoeconómica.

La modularidad fue esencial. Separar caracterización, rendimientos, costos, precios y avalúos permitió actualizar fuentes, depurar supuestos y revisar resultados por componente. Esta estructura también facilita que el modelo se actualice anualmente o se adapte a otros análisis agropecuarios.

Otra lección importante fue la necesidad de validación experta. Por la magnitud del proyecto y los tiempos de implementación, no fue posible validar de forma independiente cada cultivo, municipio y componente. En futuras aplicaciones, la revisión de expertos temáticos y avaluadores debe incorporarse como una etapa formal para detectar valores incoherentes y mejorar la robustez.

## Trabajo futuro

- Definir una metodología para consolidar un único valor por hectárea cuando un polígono tenga varios cultivos con resultados disponibles.
- Incorporar validación experta sistemática por cultivo, región y módulo.
- Actualizar periódicamente EVA, SIPSA, RNDC, AHT, aptitudes y estructuras de costos.
- Evaluar simulaciones de choques en rendimientos, costos y precios para análisis prospectivos.
- Integrar nuevas fuentes como CNA y ENA mediante las homologaciones ya previstas.
- Ampliar el modelo a actividades agropecuarias no incluidas en esta versión, como pastos o plantaciones forestales comerciales, cuando existan insumos compatibles.

## Tecnologías y métodos

- R
- QGIS
- QNEAT3
- ArcGIS Experience
- Power BI
- GIS y cruces espaciales
- MAGNA-SIRGAS EPSG:9377
- Modelos lineales generalizados de efectos mixtos
- Filtro Hodrick-Prescott
- Análisis de redes viales
- Capitalización de renta
- Automatización por municipio

## Nota

Proyecto desarrollado a partir del informe técnico "Modelo de capitalización de renta - Artículo 49", elaborado en el marco del proyecto de analítica y ciencia de datos del IGAC, Dirección de Investigación y Prospectiva, diciembre de 2024.
