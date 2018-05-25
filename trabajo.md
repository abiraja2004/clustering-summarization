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

## _System Based on Statistics and Linguistic Treatment_

Este sistema propuesto por [@ferreira2014] es un altoritmo de _clustering_ de oraciones que solventa los problemas generados por la redundancia  y diversidad de información. Este sistema asume que crear un modelo conjunto de oraciones y conexiónes genera un mejor modelo para identificar la diversidad entre ellas. Para ello se transforma el texto en un modelo gráfico que contiene cuatro tipos de relaciones entre oraciones.

- Estadísticas de similitud.
- Similitud semántica.
- Co-referencia.
- Relaciones en el discurso.

En concreto el algoritmo propuesto por [@ferreira2014] funciona del siguiente modo:

1. Convierte el texto en un modelo gráfico.
2. Identifica las oraciones principales del grafo usando _Text Rank_.
3. Agrupa cada sentencia en base a su similitud.

Este sistema propuesto se basa en métodos estadísticos y tratamientos lingüísticos para icrementar la diversidad de información de los resúmenes y tratar con la redundancia. Las principales diferencias con los citados anteriormente son:

1. Este sistema genera resúmenes genéricos y es no supervisado.
2. Trata con problemas de redundancia y diversidad de información agrupando oraciones. Además de utilizar similitudes semánticas y sintácticas, este sistema también analiza co-referencias y relaciones del discurso.
3. Usa un modelo gráfico basado en estadísticas de similitud y tratamiento lingüístico para representar la colección de documentos de entrada.
4. Minimiza las co-referencias en la mayoría de los casos.
5. Las similitudes estadísticas y semánticas, junto con operaciones lingüísticas  como resolución de co-referencias y análisis del discurso se usan para realizar el resumen.

El sistema en su conjunto funciona del siguiente modo:

1. Abre todos los documentos de la colección de entrada y los trata como un único documento.
2. Agrupa oraciones para encontrar sus relaciones con un tema específico.
3. Puntúa cada oración para seleccionar las mejores y crear cada _cluster_.
4. Selecciona las oraciones principales de los _clusters_. El número de oraciones seleccionadas depende de la proporción de resumen solicitada por el usuario.

### Método de puntuación de oraciones

En este módulo se usan dos servicios de puntuación de oraciones. El primero es la **frecuencia de palabra** -- se efectúa en tres pasos: (i) elimina todas las _stopwords_, (ii) Cuenta las ocurrencias de cada palabra en el texto. (iii) Para cada oración, añade la puntuación de frecuencias de palabra. **TF/IDF** -- se compone de (i) elimina las *stopwords* (ii) calcula el **TF/IDF** de cada palabra. (iii) Para cada oración, suma la puntuación **TF/IDF** de cada palabra.

### Agrupamiento de oraciones

En este paso se crea un modelo gráfico de cuatro dimensiones. Cada sentencia del documento se representa como un vértice y cuatro tipos de enlaces:

*Similitud estadística:* Este método mide el solapamiento del contenido entre un par de oraciones. Si supera un límite proporcionado por el usario, el enlace entre dicho par se crea. Para medir la similitud se usa el coseno. Crea un modelo de  bolsa de palabras que representa cada oración como un vector N-Dimensional. El vector encapsula la palabra y su frecuencia en el texto. La similitud entre dos oraciones se define como el coseno entre los dos vectores correspondientes. Esta medida viene dada por:

$$
\text{Wsim}(Si, Sj) = \frac{\vec{Si}\vec{Sj}}{\left \| \vec{Si} \right \| \times \left \| \vec{Sj} \right \|}
$$



# Conclusiones

- Reto: Evaluación de resúmenes?
- Nuevas vías para el uso de clustering en summarization

# Referencias
