---
title: Revisión del uso de técnicas de agrupamiento para la generación automática de resúmenes
author:
  - Cristina Heredia
  - Alejandro Alcalde
  - David Charte
header-includes:
  - \input{_preamble.tex}
---

# Introducción

## Introducción

Un buen resumen transmite la **información más relevante** y es significativamente **más corto**.

Utilidad: reduce el tiempo para escanear grandes volúmenes de información

Enfoques:

- extracción (recuperación de información)
- abstracción (generación de lenguaje natural)

Categorías:

- documento único
- multi-documento

# Documento único

## K-means

- Representar las frases tal que se puedan particionar en (K) clusters y seleccionar frases de esos clusters para construir resumen.

1. Representación: vectores m-dimensionales
2. Selección de K: $K=\frac{L}{Avg_D}$
3. Particionado: asignación/actualización
4. Selección de frases: definir importancia de cada cluster y de cada frase dentro de cada cluster

- Desventajas

## EM clustering

- Clusters vienen dados por métodos probabilísticos
- Representación: extraer Maximal Frequent Sequences (MFS)
- Proceso de asignación de pesos: booleano
- Encontrar la función de densidad de probabilidad de los datos: como CL de tantas componentes como número de clusters (k)
- Desventajas

## Otros

- CollabRank(2008): varios documentos para resumir uno
- grafo de dependencias junto con coeficiente de clustering modificado (2011)
	- nodos representan términos o frases con mucha aparición
	- aristas representan relaciones
- Matsuo y Ishizuka (2004): matrices de co-ocurrencia y clustering
- MEAD (2001): basado en centroides

# Multi-documento

## System Based on Statistics and Linguistic Treatment

- _Puntuación de oraciones_: Frecuencia palabra/TF-IDF
- _Agrupamiento de oraciones_: Modelo Gráfico 4D. Vértice => Sentencia.
- _Desventajas_: Ordenar frases en grupos distintos.
- _Ventajas_: No supervisado

### Agrupamiento de Oraciones

4 Tipos de enlaces:

- Similitud Estadística: $\text{Wsim}(Si, Sj) = \frac{\vec{Si}\vec{Sj}}{\left \lVert \vec{Si} \right \rVert \times \left \lVert \vec{Sj} \right \rVert}$.
- Similitud Semántica: Relaciones como sinónimos. Solo guarda nombres.
- Resolución Co-Referencia: Identifica nombres que referencian a misma entidad.
- Relaciones de Discurso: Cómo se conectan lógicamente dos segmentos de un discurso.

## Métodos basados en Latent Dirichlet Allocation

- Modelo Generativo LDA.
- Input: Diffs de documentos.
- Puntúa términos y los acumula para frase.

### Puntuación

3 Enfoques

- Función Jatowt, Bun y Ishizuka (_Baseline_)
- Puntuar más alto palabras insertadas en diff, más bajo eliminado. (TTS)
- Generarlas con LDA a partir de diffs. (2 temas)

## Otros

-

# Conclusiones

## Conclusiones

- Clustering es muy útil para resúmenes, pero hay pocos usos en documento único y no hay uso de clustering jerárquico
- Retos: evaluación **objetiva** de la calidad
- Líneas futuras: resúmenes de varias fuentes (multimedia)
