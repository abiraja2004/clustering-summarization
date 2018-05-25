---
title: Agrupamiento para generación automática de resúmenes
author:
  - Cristina Heredia
  - Alejandro Alcalde
  - David Charte
date: Sistemas de recuperación de información y de recomendación, curso 2017-2018
toc: yes
numbersections: yes
lang: es
bibliography: references.bib
csl: elsevier-with-titles.csl
link-citations: yes
header-includes:
  - \usepackage{hyperref}
abstract: >
  En este trabajo se realiza una revisión de los métodos más relevantes que
  utilizan el agrupamiento no supervisado para tareas de generación de resúmenes. ======AMPLIAR======
---

\clearpage

# Introducción a la generación automática de resúmenes

Un resumen es un texto producido a partir de uno o más documentos, que transmite la información más relevante y que es significativamente más corto que el texto original [@radev2002]. Así, el objetivo de la generación de resúmenes [@mani2001] es tomar una fuente de información, extraer su contenido y presentar lo más importante de forma condensada y adaptada a las necesidades de cada aplicación. La generación automática de resúmenes engloba todas las técnicas que hacen uso de la potencia de cómputo de las máquinas para analizar rápidamente diversos textos y producir resúmenes.

El interés por la construcción automática de resúmenes reside en su utilidad práctica


El problema de generación de resúmenes se puede tratar mediante técnicas con diversos orígenes [@lloret2012]: estadística, análisis de grafos, lingüística, etc. Pese a que los primeros esfuerzos en construcción automática de resúmenes se dieron en los años 50 [@luhn1958], los primeros métodos de generación de resúmenes basados en aprendizaje automático no surgieron hasta final de siglo, e incluían clasificadores binarios [@kupiec1995], técnicas bayesianas [@aone1998] y modelos ocultos de Markov [@conroy2001].

La generación automática de resúmenes es una tarea que se encuadra dentro del procesamiento de lenguaje natural [@liddy2001], y está conectada a otras como extracción de información, respuestas automáticas y generación de lenguaje natural. Los enfoques para la generación de resúmenes, por tanto, son diversos. El problema se puede abordar tanto mediante recuperación de información, extrayendo las frases más importantes de un documento, como desde el ámbito de lenguaje natural, generando nuevas frases que sinteticen el contenido.


- Aplicaciones reales de la generación de resúmenes
- Qué puede hacer el clustering para generación de resúmenes

El uso de métodos de agrupamiento para ayudar a la tarea de construcción de resúmenes es una opción interesante, ya que el problema es inherentemente no supervisado y existe una amplia gama de técnicas de clustering disponibles que se podrían aplicar en distintas partes del problema.

# Métodos de documento único
- K-means
- K-means++
- EM Clustering

# Métodos multi-documento

# Conclusiones

- Reto: Evaluación de resúmenes?
- Nuevas vías para el uso de clustering en summarization

# Referencias
