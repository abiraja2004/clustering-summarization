---
title: Agrupamiento para generación automática de resúmenes
author:
  - Cristina Heredia
  - Alejandro Alcalde
  - David Charte
date: Trabajo acordado con Juan Huete Guadix. Sistemas de recuperación de información y de recomendación, curso 2017-2018
toc: yes
numbersections: yes
lang: es
fontsize: 11pt
graphics: yes
bibliography: references.bib
csl: iso690-author-date-es.csl
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

El interés por la construcción automática de resúmenes reside en su utilidad práctica para transmitir de forma rápida las ideas de un documento y en el hecho de que el aumento de volumen de información online hace muy costosa la elaboración manual de dichos resúmenes. Estos, a la vez, pueden permitir al lector decidir qué documentos (procedentes, por ejemplo, de una búsqueda de información) le interesan realmente y ahorrar tiempo.

El problema de generación de resúmenes se puede tratar mediante técnicas con diversos orígenes [@lloret2012]: estadística, análisis de grafos, lingüística, etc. Pese a que los primeros esfuerzos en construcción automática de resúmenes se dieron en los años 50 [@luhn1958], los primeros métodos de generación de resúmenes basados en aprendizaje automático no surgieron hasta final de siglo, e incluían clasificadores binarios [@kupiec1995], técnicas bayesianas [@aone1998] y modelos ocultos de Markov [@conroy2001].

La generación automática de resúmenes es una tarea que se encuadra dentro del procesamiento de lenguaje natural [@liddy2001], y está conectada a otras como extracción de información, respuestas automáticas y generación de lenguaje natural. Los enfoques para la generación de resúmenes, por tanto, son diversos. El problema se puede abordar tanto mediante recuperación de información, extrayendo las frases más importantes de un documento, como desde el ámbito de lenguaje natural, generando nuevas frases que sinteticen el contenido.

Una de las dificultades a la hora de realizar aprendizaje para construir resúmenes es que, generalmente, no se cuenta con resúmenes hechos por humanos contra los que entrenar un algoritmo, ni es trivial evaluar la calidad de un resumen de por sí. Así, podemos tratar de recurrir a métodos no supervisados que extraigan conocimiento de los textos sin que su entrenamiento requiera de una evaluación de este tipo. En particular, el uso de métodos de agrupamiento puede ser una opción interesante, gracias a la amplia gama de técnicas de clustering disponibles que se podrían aplicar en distintas partes del problema.

En este trabajo realizamos una revisión de los métodos más relevantes para generación automática de resúmenes que se apoyan en el clustering. Exploraremos para ello métodos de dos tipos, como se ilustra en la figura \ref{f.singlemulti}:

- de documento único (_single-document_): se dedican a extraer o abstraer un resumen a partir de un solo texto.
- multi-documento (_multi-document_): se encargan de reunir la información de varios documentos y presentarla de forma condensada.

\begin{figure}[hbtp]
\centering
\includegraphics[width=0.33\textwidth]{single-document.png}\quad
\includegraphics[width=0.33\textwidth]{multi-document.png}
\caption{\label{f.singlemulti}Generación de resúmenes de documento único (izquierda) y multi-documento (derecha)}
\end{figure}

El resto del texto se estructura como sigue. En la sección \ref{s.single} se estudian técnicas que resumen un único documento, y en la sección \ref{s.multi} se exponen algunas herramientas para resumir varios documentos. Finalmente, en la sección \ref{s.conc} se extraen unas conclusiones.

# Métodos de documento único

\label{s.single}

## K-means

En el trabajo propuesto por [@garcia2008text] se emplea un algoritmo K-medias para extraer las frases más relevantes de un documento. La idea es representar las frases de un documento con distintas características que hagan posible su particionamiento en diferentes clusters, tal que después se puedan seleccionar las frases de cada cluster que extraen un mejor resumen del texto en cuanto a contenido y diversidad. Es decir, dado un conjunto de ${x_1,...,x_n}$ vectores m-dimensionales, particionar los $n$ vectores en $k$ particiones. El procedimiento del algoritmo es el siguiente:

1. Etapa de asignación: $Asignar(x_i,C_j)=min_{c_j}||x_i-c_j||^2$ Para cada punto $x_i$ se trata de encontrar el centroide $c_j$ más cercano a él, asignando $x_i$ al cluster $C_j$.
2. Etapa de actualización: $Para cada C_j, actualizar(c_j)=\frac{1}{|C_j|}\sum_{x_i \in C_j}{}x_i$ donde se actualizan los centroides de cada cluster de acuerdo a la media de los puntos dentro de dicho cluster.

Una vez particionadas las frases en $k$ clusters, hay que seleccionarlas para producir un resumen del documento de una longitud deseada en palabras ($L$). Normalmente se selecciona $k$ tal que $k=\frac{L}{avg_D}$ donde $avg_D$ es la longitud media de las frases en el Documento, por tanto, seleccionando una frase de cada cluster se obtendría un resumen de longitud $L$. Para establecer en que orden se seleccionan las frases de los distintos clusters, se plantean dos estrategias:

1. Ordenar los clusters en orden descendente según su tamaño, considerando el más grande el cluster de mayor importancia debido a que concentraría a palabras que se repiten en varias frases del documento
2. Considerar el cluster más denso como el de mayor importancia 

Por último, una vez se tiene una estrategia para decidir la importancia de los cluster, queda decidir en qué orden se seleccionarán las frases de cada cluster. Para esto se proponen tres estrategias:

1. Seleccionar la frase de cada cluster que esté más cercana al centroide
2. Ordenar las frases en función del orden en el que aparecen en el documento
3. Aplicar TextRank a las frases del cluster y elegirlas en función de los valores de los vértices

A nuestro parecer, este algoritmo presenta varios inconvenientes, como que los centroides iniciales se eligen de forma aleatoria, lo que puede condicionar la creación de clusters y el rendimiento del algoritmo. En este caso puede ser más interesante utilizar una variante como K-means++, que no tome los $k$ centroides iniciales de forma aleatoria, sino que, por ejemplo, tome las k-primeras frases como centroides. Otro posible inconveniente es que la selección de $k$ en función de $L$ y $avg_D$ no garantiza realmente que seleccionando una frase por cluster se obtenga un resumen de longitud $L$, pues si la longitud del resumen deseada puede ser 15 palabras y las frases tienen en media 5 palabras por frase, obtendríamos tres clusters, pero nada nos garantiza que las frases que escojamos para construir el resumen de dichos clusters tengan longitud exactamente igual a 5. Quizás cambiando la media por otra medida de tendencia similar o usando otra estrategia de selección de las frases de cada cluster se podría proporcionar un resumen de tamaño más adecuado al especificado.

## EM Clustering

En el trabajo de [@ledeneva2011clustering] emplean el algoritmo de clustering de maximización de expectación para formar los grupos de frases similares. Previamente al EM se aplica un preprocesamiento que incluye eliminación de stopwords y un proceso de estemificación. Tras esto, se extraen  MFSs, tras lo que se aplica un proceso de asignación de pesos, en este caso, booleano. 
Al igual que en el algoritmo descrito anteriormente, EM representa cada frase del documento como un vector de términos, que en este caso será MFSs, mientras que los clusters vienen dados por métodos probabilísticos. Por tanto, el algoritmo intenta encontrar la función de densidad de probabilidad (PDF) de la que provienen los datos. Esta función puede estimarse como una combinación lineal de tantas componentes como número de clusters haya (NC), tal que:
${\theta}=\left\{\theta_j \forall_j=1..NC\right\}, P(x)=\sum_{j=1}^{NC} \pi_j p(x;\theta_j) con \sum_{j=1}^{NC}\pi_j=1$
donde $\pi_j$ son las probabilidades a priori de cada cluster y $p(x;\theta_j)$ la función de densidad de la componente $j$ que puede estimarse mediante alguna distribución t-Student, Poission, Bernoulli o n-normal. Cada cluster se corresponde con las muestras pertenecientes a cada una de las densidades mezcladas.

Como desventaja del algoritmo, asume que el número de clusters es conocido de forma previa, aunque esto permite hacer una estimación aproximada de la longitud que tendrá el resumen. Como posible mejora, podría probarse con alguna representación de términos diferente, como BoW o n-gramas, y con algún esquema de asignación de pesos algo más complejo, como TF-IDF.

## Otros algoritmos para resumen de un único documento

Además de los ya mencionados, existen algoritmos como _CollabRank_ [@wan2008collabrank] que ponen en práctica un enfoque diferente. En concreto, CollabRank utiliza información de varios documentos para resumir un único documento, para lo que inicialmente emplea un algoritmo de clustering para obtener clusters de documentos y después emplea un algoritmo de ranking basado en grafos para extraer frases relevantes de un documento de forma colaborativa. 
En el posterior trabajo de [@li2011single] se construye un grafo de dependencias del documento donde los nodos representan términos o frases con alta frecuencia de aparición, mientras que las aristas representan relaciones entre los mismos, y se aplica un coeficiente de clustering modificado en base al número de triángulos y tripletas que involucran a cada nodo, para medir la fuerza de las conexiones que se dan en el grafo, de esta forma, se extraen las frases más relevantes para componer el resumen. 
Por último, mencionar el trabajo de [@matsuo2004keyword] que en 2003 usaron matrices de co-ocurrencia y clustering para extraer frases de documentos, y
_MEAD_ , un resumidor de documentos basado en centroides propuesto por [radev2001experiments] de la Universidad de Michigan que se puede emplear para múltiples documentos o documento único.

# Métodos multi-documento

\label{s.multi}

## _System Based on Statistics and Linguistic Treatment_

Este sistema propuesto por [@ferreira2014] es un altoritmo de _clustering_ de oraciones que solventa los problemas generados por la redundancia y diversidad de información. Este sistema asume que crear un modelo conjunto de oraciones y conexiones genera un mejor modelo para identificar la diversidad entre ellas. Para ello se transforma el texto en un modelo gráfico que contiene cuatro tipos de relaciones entre oraciones.

- Estadísticas de similitud.
- Similitud semántica.
- Co-referencia.
- Relaciones en el discurso.

### Metodología

En concreto el algoritmo propuesto por [@ferreira2014] funciona del siguiente modo:

1. Convierte el texto en un modelo gráfico.
2. Identifica las oraciones principales del grafo usando _Text Rank_.
3. Agrupa cada sentencia en base a su similitud.

Este sistema propuesto se basa en métodos estadísticos y tratamientos lingüísticos para incrementar la diversidad de información de los resúmenes y tratar con la redundancia. Las principales diferencias con los citados anteriormente son:

1. Este sistema genera resúmenes genéricos y es no supervisado.
2. Trata con problemas de redundancia y diversidad de información agrupando oraciones. Además de utilizar similitudes semánticas y sintácticas, este sistema también analiza co-referencias y relaciones del discurso.
3. Usa un modelo gráfico basado en estadísticas de similitud y tratamiento lingüístico para representar la colección de documentos de entrada.
4. Minimiza las co-referencias en la mayoría de los casos.
5. Las similitudes estadísticas y semánticas, junto con operaciones lingüísticas como resolución de co-referencias y análisis del discurso se usan para realizar el resumen.

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
$\vec{Si}$ y $\vec{Sj}$ son los vectores ponderados de las oraciones $Si, Sj$.

*Similitud semántica:* Esta medida se encarga de las relaciones tales como sinónimos. El proceso se compone de cuatro pasos:

1. Las oraciones se representan como vectores de palabras, solo se almacenan los nombres.
2. La puntuación de similitud semántica para cada par de palabras entre dos oraciones se calcula.
3. Se combinan los resultados sumando cada uno de las puntuaciones.
4. La puntuación final se normaliza al rango $[0,1**$

*Resolución de Co-referencia:* Se ocupa de identificar distintos nombres que hacen referencia a la misma identidad. Este algoritmo usa el framework de Stanford CoreNLP. Cuando se encuentra una co-referencia, se añade un enlace al grafo con la relación.

*Relaciones de discurso:* Las relaciones entre sentencias y partes en un texto se representan por una relación de discurso. Para ello se presenta un conjunto de estructuras de relaciones de discurso basadas en las conjunciones de todo el contenido.

### Algoritmo de Clustering

Consta de seis pasos para generar los grupos de texto. La entrada es un gráfo obtenido en el módulo anterior junto con un fichero de configuración. Este es el pseudocódigo:

- Entrada: Se recibe el gráfo y un fichero de configuración. El grafo describe el texto mediante los vértices y enlaces descritas en el módulo anterior. El ficehero de configuración debe contener los umbrales que definen la importancia de un vértice.
- TextRank: La puntuación se calcula usando la información proporcionada por el módulo de resumen. Extrae palabras clave del documento y determina el peso de la importancia de la oración dentro de todo el documento usando el modelo basado en gráfos.
- Selección del vértice principal: Identifica el vértice con mayor puntuación TextRank.
- Selección de vértices líderes: Usa el umbral proporcionado por el usuario y las puntuaciones de TextRank para identificar los vértices líderes. Dichos vértices se usan para crear los clusters, cada uno será un cluster.
- Cálculo del camino mínimo: Para cada vértice, se calcula la distancia mínima entre dicho vértice y cada vértice líder.
- Eliminación de caminos: Elimina todos los caminos enlazando un vértice con un líder.
- Salida: Se devuelven n grafos, donde n es el número de vértices líderes, representando n clusters.

### Ventajas e inconvenientes

Este método proporciona la ventaja de ser no supervisado, proporcionando un sistema genérico de resúmenes de texto. Como desventajas, presenta problemas a la hora de ordenar las oraciones para encontrar las más relevantes en grupos de temas distintos. Otra desventaja es que solo funciona para Inglés.

## LDA

[@ijain43] muestra que los resúmenes de texto con LDA alcanzan un 72% en LDA 40% comparado con el K-medias tradicional, el cual solo alcanza un 66%.

### Metodología

Antes de tratar los datos, para obtener los documentos en una forma adecuada se realiza tokenización, eliminación de stopwords y stemming.

En este sistema se usan las siguientes características:

- Para el título $Score(S_i) = \frac{\text{\# title word in} S_i}{\text{ \# word in title}}$
- Longitud de oración: $Score(S_i) = \frac{\text{\# word ocurring in }S_i}{\text{\# word occurring in longest sentence}}$
- Peso del término: $Score(S_i) = \frac{\text{Sum of TF-IDF in} S_i}{\text{Max(Sum of TF-IDF)}}$
- Posición en la oración; $Score(S_i) = 1$ para la primera y última oración, 0 para el resto.
- Similitud de sentencia a sentencia: $Score(S_i) = \frac{\text{Sum of sentence similarity in} S_i}{\text{Max(Sum of sentence Similarity)}}$
- Nombre propio: $Score(S_i) = \frac{\text{\# proper nouns in } S_i}{\text{Length}(S_i)}$
- Palabra temática: $Score(S_i) = \frac{\text{\# thematic word in } S_i}{\text{Length}(S_i)}$
- Datos numéricos: $Score(S_i) = \frac{\text{\# numerical data in} S_i}{\text{Length}(S_i)}$

Este algoritmo usa K-means (explicado en secciones anteriores) junto a LDA para resumir los documentos en distintos clusters. LDA (Latent Dirichlet Allocation) es un modelo estadítico que intenta capturar los temas latentes en una colección de documentos. La idea básica consiste en que todos los documentos están representados por mezclas de funciones de densidad aleatorias en los temas, donde cada tema se caracteriza por una distribución sobre palabras. Un requisito importante de este método es que se debe propornionar el número de temas con antelación.

## Otros algoritmos para el resumen multi-documento

[@luo] se basa en análisis estadístico para encontrar la relevancia, cobertura y novedad en resúmenes multi documento. Para ello aplica *Latent Semantic Analysis* probabilístico y búsqueda de temas inducida por enlaces probabilística.

[@canhasi] modelan la consulta y los documentos como un grafo para incrementar la variabilidad y diversidad del resumen centrándose en la consulta realizada. Usa términos, oraciones y documentos como conjuntos de vértices y la similitudes entre ellos como enlaces. Los clusters se crean en base a los pesos de los enlaces. Tanto [@canhasi] como [@luo] solo son útiles para resúmenes que acepten una consulta.

[@gupta] combina resúmenes de un solo documento usando técnicas de clustering para generar resúmenes multi documento. PAra ello crea primero un resumen uni documento, luego agrupa oraciones usando similitudes sintáticas y semánticas para representar partes del texto que deben incluirse en el resumen. Por último, genera el resumen extrayendo una sola oración de cada cluster.

[goldstein] intenta minimizar la redundancia y maximizar tanto la relevancia como la diversidad. Primero segmenta los documentos en pasajes relevantes a la consulta realizada usando la medida del coseno. En base a la proporción de compresión, se selecciona un número de oraciones. Por último, se reunen las oraciones selecciondas para construir el resulmen final.

# Conclusiones

\label{s.conc}


En este trabajo hemos explorado algunos algoritmos relevantes en la escena de la generación automática de resúmenes utilizando clustering. Se ha comprobado cómo los métodos de agrupamiento pueden ser de gran utilidad a la hora de resumir textos pero también quedan abiertas vías para el aprovechamiento de algunas de dichas técnicas.

Uno de los retos a la hora de comparar algoritmos de construcción de resúmenes es la evaluación objetiva de la calidad de un resumen. Es necesaria más investigación en esta dirección, ...

- Reto: Evaluación de resúmenes?
- Nuevas vías para el uso de clustering en summarization

# Referencias
