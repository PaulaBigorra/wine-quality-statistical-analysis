# wine-quality-statistical-analysis
Proyecto Inicial sobre Aprendizaje Supervisado - Inferencia Estadística y Reconocimiento de Patrones - Com 02

**Proyecto Académico | Inferencia Estadística y Reconocimiento de Patrones** *

- Institución: Universidad Nacional Guillermo Brown - UNaB -
- Año: 2025

Resumen del Proyecto
- Este trabajo realiza un análisis estadístico sobre el dataset de calidad del vino tinto (UCI Machine Learning Repository). El objetivo es evaluar y comparar como actúa y sirve cada modelo ante un mismo dataset, tanto como un problema de **regresión** (valor numérico) como de **clasificación** (categorías), evaluando el impacto de sus 11 variables.

## Modelos Aplicados

### I. Modelos de Regresión
* **Regresión Lineal Múltiple** 
* **Modelos Penalizados (Ridge & LASSO)**

### II. Modelos de Clasificación
* **Regresión Logística Binaria** (Error encontrado: En el trabajo realizado aparece como Multinomial, ya que era la que debia aplicarse)
* **Análisis Discriminante (LDA y QDA)** 
* **K-Nearest Neighbors (KNN)** 
* **Naive Bayes** 

## Conclusiones
* - El contenido de **alcohol** y los **sulfatos** demostraron ser las variables más significativas para la calidad.
* **Clasificación:** La Logística Binomial resultó ser el modelo más consistente (Precisión: 0.74 en entrenamiento, 0.72 en test).

## Lenguajes Utilizados
* **Lenguajes:** R (Implementación de Modelos de Regresión) y Python (Implementación de modelos de Clasificación)
* **Librerías R:** `glmnet`, `nnet`.
* **Librerías Python:** `scikit-learn`, `pandas`, `matplotlib`.

---
*Este proyecto fue la primera entrega dentro de mi formación en Ciencia de Datos, enfocada en la validación estadística de modelos de aprendizaje automático.
Informe completo detallado en el documento Pareja4.pdf*
