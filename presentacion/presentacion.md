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

## EM clustering

## Otros

# Multi-documento

## System Based on Statistics and Linguistic Treatment

## Métodos basados en Latent Dirichlet Allocation

## Otros

# Conclusiones

## Conclusiones

- Clustering es muy útil para resúmenes, pero hay pocos usos en documento único y no hay uso de clustering jerárquico
- Retos: evaluación **objetiva** de la calidad
- Líneas futuras: resúmenes de varias fuentes (multimedia)
