"Librerías y Datasets utilizadas en el análisis"
library(glmnet)
library(nnet)
vinos <- read.csv2("winequality-red.csv",dec=".")

#===========================================================================================================================================
#REGRESIÓN LINEAL MULTIPLE
#===========================================================================================================================================

"Creamos el modelo con quality como la variable respuesta y los demás datos como las variables explicativas
para luego mostrar un resumen estadistico"

modelo_lineal <-lm(vinos$quality~.,data=vinos)  
summary(modelo_lineal) 

"Creacion de graficos para evaluar las cuatro supuestos clásicos de la regresión lienal"

par(mfrow = c(2, 2)) 
plot(modelo_lineal) 

"Nuevo Modelo con las variables estadísticamente significativas"

modelo_nuevo <- lm(quality~volatile.acidity+chlorides+density+pH+sulphates+alcohol, data=vinos)
summary(modelo_nuevo)

#===========================================================================================================================================
# Regresión Ridge y Regresión LASSO
#===========================================================================================================================================

"Creación de la matríz (X = variables predictoras/explicativas ; Y = variable respuesta)"
x <- as.matrix(vinos[, -which(names(vinos) == "quality")]) 
y <- vinos$quality 


"Dividimos el conjunto de datos en train (80%) y test (20%) tomando de manera aletoria"

set.seed(123) 
train <- sample(1:nrow(vinos), 0.8 * nrow(vinos)) 
test <- setdiff(1:nrow(vinos), train) 

"Extrae las filas de train/test de la matriz X y de los valores de quality"
x_train <- x[train, ] 
y_train <- y[train] 
x_test <- x[test, ]
y_test <- y[test] 

"Creacion de una grilla para obetner el cunjuntos de valores candidatos para lambda"

grilla <- 10^seq(10, -2, length = 100) 

"Uso de los modelos Ridge y LASSO a partir de la grilla para evaluar el efecto de penalizacion sobre los coeficientes"

ridge.mod <- glmnet(x[train,], y[train], alpha = 0, lambda = grilla) 
lasso.mod <- glmnet(x[train,], y[train], alpha = 1, lambda = grilla) #Elimina variables irrelevantes (coeficientes se vuelven cero)

"Realizamos validación cruzada en los dististos modelos.Obteniendo el lambda que minimiza el error de validacion"

set.seed(123)
cv.ridge <- cv.glmnet(x[train,], y[train], alpha = 0, lambda = grilla) 
cv.lasso <- cv.glmnet(x[train,], y[train], alpha = 1, lambda = grilla)

"Guarda los dos mejores lambda que minimiza el error en los modelos"
best.lambda.ridge <- cv.ridge$lambda.min 
best.lambda.lasso <- cv.lasso$lambda.min

"Visualización de los valores"
best.lambda.ridge 
best.lambda.lasso

"Observación los coeficientes finales en el lambda óptimo y cuanto influye cada variable ajustada por los modelos"

coef(cv.ridge, s = "lambda.min") 
coef(cv.lasso, s = "lambda.min")

"Evaluación de la eficiencia de predicción de los modelos Ridge y LASSO usando el conjunto de pruebas"

pred.ridge <- predict(cv.ridge, s = best.lambda.ridge, newx = x[test,]) 
pred.lasso <- predict(cv.lasso, s = best.lambda.lasso, newx = x[test,])

"Comparacion de las predicciones con los valores reales y calculo de MSE"
mean((y[test] - pred.ridge)^2) # MSE RIDGE 
mean((y[test] - pred.lasso)^2) # MSE LASSO

# GRÁFICOS DE TRAYECTORIAS DE COEFICIENTES
"Muestra cómo cambian los coeficientes de cada variable cuando varía el valor de lambda. El eje X representa lambda y el eje Y los coeficientes."

par(mfrow = c(1, 1))
plot(ridge.mod , xvar = "lambda", label = TRUE, main = "Trayectoria de coeficientes - Ridge")

plot(lasso.mod, xvar = "lambda", label = TRUE, main = "Trayectoria de coeficientes - Lasso")
