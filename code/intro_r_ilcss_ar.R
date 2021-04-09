## ----setup, include=FALSE-----------------------------------------------------------------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(message=FALSE, warning = FALSE, error=TRUE)



## ----echo=FALSE, out.width = "100%"-------------------------------------------------------------------------------
knitr::include_graphics("figs/R_vs_RStudio_1.png") 


## ----echo=FALSE, out.width = "100%"-------------------------------------------------------------------------------
knitr::include_graphics("figs/rstudio.png") 


## -----------------------------------------------------------------------------------------------------------------
2+2


## ----eval=FALSE---------------------------------------------------------------------------------------------------
## # Incomplete Code
## 
## incomplete<- "I am going to give you an incomplete


## ----eval=FALSE---------------------------------------------------------------------------------------------------
## # Rode estas operação em um script.
## # Hashtags permite você comentar seu código.
## 2^2
## 2*2
## 2/2


## -----------------------------------------------------------------------------------------------------------------
# Hello all!


## -----------------------------------------------------------------------------------------------------------------
plot("hello")


## ----eval=FALSE---------------------------------------------------------------------------------------------------
## install.packages("devtools", force=TRUE)


## ----eval=FALSE---------------------------------------------------------------------------------------------------
## library(devtools)


## ----eval=FALSE---------------------------------------------------------------------------------------------------
## devtools::install_github("electorArg/polAr")


## ----eval=FALSE---------------------------------------------------------------------------------------------------
## # Specific to a function
## ?mean  # Help para a função mean.
## help(mean)
## 
## # More General
## ??mean
## 


## ----echo=FALSE, out.width = "70%"--------------------------------------------------------------------------------
knitr::include_graphics("figs/ajuda.png") 


## -----------------------------------------------------------------------------------------------------------------
# Numeric Objects
x <- 5
y <- 7

# Character Objects
nome <- "Tiago Ventura"



## ----eval=FALSE---------------------------------------------------------------------------------------------------
## x<-6
## mean(x=c(5, 7))


## -----------------------------------------------------------------------------------------------------------------
ls()


## -----------------------------------------------------------------------------------------------------------------
rm(y)


## -----------------------------------------------------------------------------------------------------------------
print(nome)


## -----------------------------------------------------------------------------------------------------------------
nome <- "Tiago Augusto Ventura"


## ----echo=FALSE---------------------------------------------------------------------------------------------------
library(kableExtra)
library(tidyverse)
tibble::tribble(~ Example, ~ Tipo, 
                c("a", "swc"), "Character", 
                c(2, 3, 15), "Numeric", 
                c(1L, 2L), "Interger", 
                c(FALSE, TRUE), "Logical") %>%
  kbl() %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"))




## -----------------------------------------------------------------------------------------------------------------
class(3)

class(TRUE)

meu_numero_da_sorte= "13"

class(meu_numero_da_sorte)

class(meu_numero_da_sorte==13)



## -----------------------------------------------------------------------------------------------------------------
is.numeric(2)
is.logical(TRUE)
is.character("2")
is.integer(1L)


## -----------------------------------------------------------------------------------------------------------------
# Cria Objeto
num_1_5 <- c(1, 2, 3, 4, 5)

# Altera a classe
char_1_5 <- as.character(num_1_5)

# Checando
class(char_1_5)
class(num_1_5)

# Ou
as.numeric("25")



## -----------------------------------------------------------------------------------------------------------------

# Numeric Vector
X <- c(1, 2.3, 4, 5, 6.78, 6:10)
X

# Class
class(X)

# Length
length(X)




## -----------------------------------------------------------------------------------------------------------------

# Coerce to a matrix
x_matrix <- as.matrix(X)

# Build a Matrix.
m <- matrix(1:10, nrow=5, ncol=2)
m
# Acessing a values
m[1, 1] # [rows, columns]



## -----------------------------------------------------------------------------------------------------------------

# coerce to a list

x_list<- as.list(X)

# or

lista_1 <- list(X, as.matrix(X), as.character(X))

# Visualize a lista.

str(lista_1)

# Acessing a value: double [[]]
lista_1[[1]]



## -----------------------------------------------------------------------------------------------------------------

# Coercing
as.data.frame(X)

# Criando Manualmente

data <- data.frame(name=c("Tiago", "Tiago"), 
                   last_name=c("Ventura", "Ventura") ,
                   school=c("UMD", "FGV"), age=c(30,32))
data


## -----------------------------------------------------------------------------------------------------------------
mtcars # already loaded in your R environment



## -----------------------------------------------------------------------------------------------------------------
mtcars[,1] # primeira coluna


## -----------------------------------------------------------------------------------------------------------------
mtcars$mpg

# Ou

bakers[,"mpg"]



## -----------------------------------------------------------------------------------------------------------------
bakers[1:5, ]


## ----eval=FALSE---------------------------------------------------------------------------------------------------
## 
## head(mtcars) # First lines
## 
## tail(mtcars) # last lines linhas
## 
## summary(mtcars) # classes
## 
## dim(mtcars) # dimensions
## 
## glimpse(mtcars) # summary
## 


## ----eval=FALSE---------------------------------------------------------------------------------------------------
## # make a fake data set
## 
## dfake <- data.frame(normal=rnorm(100, 0, 1),
##                     uniform=runif(100, 0, 1),
##                     pois=rpois(100, 10))
## # write.function(data, name_to_be_saved)
## write.csv(dfake, "dfake.csv")


## -----------------------------------------------------------------------------------------------------------------
# Where is my R looking at?
getwd()


## ----eval=FALSE---------------------------------------------------------------------------------------------------
## 
## # Where should R be looking instead?
## 
## setwd("/home/venturat/Downloads")


## -----------------------------------------------------------------------------------------------------------------
# Check Dir
getwd()

# See what we have here.
list.files()

# import
dados <- read.csv("dfake.csv")

head(dados)


## -----------------------------------------------------------------------------------------------------------------
x<- c(1, 2, 3, 4, 5)

# Mathematical Functions in R
sum(x, na.rm = TRUE) 
log(x) 
sqrt(x)
mean(x)



## ----eval=FALSE---------------------------------------------------------------------------------------------------
## # Lets see how the mean function works
## ?mean


## -----------------------------------------------------------------------------------------------------------------
some_me <- function( argument1, argument2 ){
  
  value <- argument1 + argument2
  
  return(value) # "return" define the output 
}

some_me(2,3)
some_me(100,123)
some_me(60,3^4)



## ----eval=FALSE---------------------------------------------------------------------------------------------------
## nome_da_funcao <- function(x,y,z){ ## Argumentos
##   ### Corpo: o que a função faz
##    	
##     out <- what the function does.
## 
##   ### Conclui Corpo.
## 
##   	return(out) ## output
## }
##   ## fecha a função
## 


## -----------------------------------------------------------------------------------------------------------------

places_with_ilcss <- c("Buenos Aires",
                       "College Park", 
                       "Mexico City")

# for loop

for(cities in places_with_ilcss){ #iterador
  # repeating
  print(cities)
}



## -----------------------------------------------------------------------------------------------------------------
cities <- places_with_ilcss[1]
print(cities)


## -----------------------------------------------------------------------------------------------------------------
cities <- places_with_ilcss[2]
print(cities)


## -----------------------------------------------------------------------------------------------------------------
cities <- places_with_ilcss[3]
print(cities)


## -----------------------------------------------------------------------------------------------------------------
##devtools::install_github("apreshill/bakeoff")
library(bakeoff)
data("ratings_seasons")


## -----------------------------------------------------------------------------------------------------------------
# How many Seasons?
temporadas <- unique(ratings_seasons$series)
temporadas

# Average Views

#Temporadas
temporada_1 <- ratings_seasons[ratings_seasons$series==temporadas[1],]
temporada_2 <- ratings_seasons[ratings_seasons$series==temporadas[2], ]
temporada_3 <- ratings_seasons[ratings_seasons$series==temporadas[3], ]

# Take the mean

mean(temporada_1$viewers_7day)



## -----------------------------------------------------------------------------------------------------------------

# Containes
container <- list()

for(i in 1:length(temporadas)){ # Step  1
  
 # step 2  
 temp=ratings_seasons[ratings_seasons$series==temporadas[i], ] 
 
 # Step 3
 container[[i]] <- mean(temp$viewers_7day)  
  
}
container

