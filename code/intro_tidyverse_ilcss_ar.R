## ----setup, include=FALSE-----------------------------------------------------------------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(message=FALSE, warning = FALSE, error=FALSE, cache=TRUE)



## ----echo = FALSE, out.width =" 60% "-----------------------------------------------------------------------------
knitr::include_graphics("https://media.giphy.com/media/elUGwgiPOdq7e/giphy.gif")


## ----eval = FALSE-------------------------------------------------------------------------------------------------
## 
## install.packages ("tidyverse")
## 


## -----------------------------------------------------------------------------------------------------------------
library (tidyverse)


## -----------------------------------------------------------------------------------------------------------------

# Class of mtcars Database
class (mtcars)

# Convert to tibbles
mtcars_tib <- as_tibble (mtcars)
mtcars_tib


## -----------------------------------------------------------------------------------------------------------------
tibble (a = c ("Tiago", "Ventura"),
       b = c ("first name", "last name"))


## ----echo = FALSE, out.width =" 60% "-----------------------------------------------------------------------------
knitr::include_graphics ("figs/pipe.jpg")


## -----------------------------------------------------------------------------------------------------------------
# R
x <- c(1:10)
round(exp(sqrt(mean (x))), 1)



## -----------------------------------------------------------------------------------------------------------------
x%>%
  mean()%>%
  sqrt()%>%
  exp()%>%
  round(1)


## ----eval = FALSE-------------------------------------------------------------------------------------------------
## 
## # Do not run this code.
## x%>%
##   function1 (arg1 = x)%>%
##   function2 (arg = output_da_funcao1)


## ----out.width ="30%"---------------------------------------------------------------------------------------------
sample (1: 1000, 500, replace = TRUE)%>%
  density ()%>% # function 1.
  plot () # function 2.


## -----------------------------------------------------------------------------------------------------------------
sample(1:1000, 500, replace = TRUE)%>%
  density(.)%>% # function 1.
  plot(.) # function 2.


## -----------------------------------------------------------------------------------------------------------------
graph <- sample (1: 1000, 500, replace = TRUE)%>%
              density (.)%>% # function 1.
              plot (.) # function 2.


## ----eval = FALSE-------------------------------------------------------------------------------------------------
## if(!require ("devtools")) install.packages("devtools")
## devtools::install_github("Cepesp-Fgv/cepesp-r")


## -----------------------------------------------------------------------------------------------------------------
library(cepespR)
library(tidyverse)
pres_rio <- get_votes(year = 2018,
                         position = "President",
                         regional_aggregation = "Municipio",
                         state = "RJ")%>%
                  as_tibble()


## ----echo = FALSE, out.width =" 80% "-----------------------------------------------------------------------------
knitr::include_graphics("figs/select.png")


## -----------------------------------------------------------------------------------------------------------------

pres_rio %>% # Data
  select(ANO_ELEICAO, SIGLA_UE, COD_MUN_IBGE) #<<


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>% # Data
  # select columns
  select(QTDE_VOTOS, ANO_ELEICAO,  SIGLA_UE, #<<
         NOME_MUNICIPIO, COD_MUN_IBGE) # #<<


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  # selects columns with new names.
  select(votes = QTDE_VOTOS, #<<
         year = ANO_ELEICAO, #<<
         parents = SIGLA_UE, #<<
         mun = NOME_MUNICIPIO, #<<
         cod = COD_MUN_IBGE) # columns


## -----------------------------------------------------------------------------------------------------------------
rio_reduced <- pres_rio %>% # Data
                 # selects columns with new names.
                 select(votes = QTDE_VOTOS, #<<
                        year = ANO_ELEICAO, #<<
                        states = SIGLA_UE, #<<
                        mun = NOME_MUNICIPIO, #<<
                        cod = COD_MUN_IBGE)# columns


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  # select columns where NOME appears
  select(contains("NOME")) #<<


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  # select columns ending with UF and
  # all other remaining columns
  select(ends_with("UF"), everything()) #<<


## ----echo = FALSE, out.width="80%"--------------------------------------------------------------------------------
knitr::include_graphics ("figs/filter.png")


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  # filter cases where 17 is equal.
  filter (NUMERO_CANDIDATO == 17)%>% #<<
  # select
  select (DESCRICAO_CARGO, NUMERO_CANDIDATO, QTDE_VOTOS, NOME_MUNICIPIO)


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  # filter using or
  filter(NUMERO_CANDIDATO == 17 | NUMERO_CANDIDATO == 13, # or #<<
  #filter using and
         NOME_MUNICIPIO == "Rio de Janeiro")%>% # and #<<
  #select
  select(DESCRICAO_CARGO, NUMERO_CANDIDATO, QTDE_VOTOS, NOME_MUNICIPIO)


## ----echo = FALSE, out.width="80%"--------------------------------------------------------------------------------
knitr::include_graphics("figs/arrange.png")


## -----------------------------------------------------------------------------------------------------------------

pres_rio %>%
  # filter by lines
  filter(NUMERO_CANDIDATO == 13)%>%
  # select
  select(DESCRICAO_CARGO, NUMERO_CANDIDATO,
         QTDE_VOTOS, NOME_MUNICIPIO)%>%
  # sort in ascending order
  arrange(QTDE_VOTOS) #<<


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  # filter by lines
  filter(NUMERO_CANDIDATO == 13)%>%
  # select
  select(DESCRICAO_CARGO, NUMERO_CANDIDATO,
         QTDE_VOTOS, NOME_MUNICIPIO)%>%
  # sort in descending order
  arrange(desc(QTDE_VOTOS)) # <<


## ----echo = FALSE, out.width =" 80% "-----------------------------------------------------------------------------
knitr::include_graphics("figs/mutate.png")


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  # create variable with state and city
  mutate(city_state = paste(NOME_MUNICIPIO, "-", NOME_UF)) %>% #<<
  #selects to view
  select (NOME_MUNICIPIO, NOME_UF, city_state)


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  # create variable using conditionals
  mutate(state_sigla = ifelse(NOME_UF == "Rio de Janeiro", "RJ", NA), #<<
  # concatenate new variable with city
         state_city = paste(state_sigla, "-", NOME_MUNICIPIO))  %>% #<<
  #select
  select(NOME_UF, NOME_MUNICIPIO, state_sigla, everything())


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  # log of votes
  mutate(log_votos = log(QTDE_VOTOS)) %>% #<<
  # select
  select(QTDE_VOTOS, log_votos) #<<


## ----echo=FALSE, out.width="60%"----------------------------------------------------------------------------------
knitr::include_graphics("figs/group_by.png")


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  # grouping by the number of the candidates
  group_by(NUMERO_CANDIDATO) 


## ----echo=FALSE, out.width="50%"----------------------------------------------------------------------------------
knitr::include_graphics("figs/summarize.png")


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  # first round
  filter(NUM_TURNO==1) %>%
  # group
  group_by(NUMERO_CANDIDATO) %>%
  # Summing the number of votes
  summarise(voto_estado=sum(QTDE_VOTOS)) %>%
  # arranging
  arrange(desc(voto_estado))




## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%
  
  filter(NUM_TURNO==2) %>%

  group_by(NUMERO_CANDIDATO) %>%
  
  summarise(voto_estado=sum(QTDE_VOTOS)) %>%

    arrange(desc(voto_estado))


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%

  filter(NUM_TURNO==1) %>%
  
  group_by(NOME_MUNICIPIO) %>%

  summarise(voto_mun=sum(QTDE_VOTOS)) 


## -----------------------------------------------------------------------------------------------------------------
pres_rio %>%

  filter(NUM_TURNO==1) %>%
  
  group_by(NUMERO_CANDIDATO, NOME_MESO) %>%
  
  summarise(voto_media=mean(QTDE_VOTOS), 
            voto_min=min(QTDE_VOTOS), 
            voto_max=max(QTDE_VOTOS))
  


## -----------------------------------------------------------------------------------------------------------------

pres_rio %>%

  filter(NUM_TURNO==1) %>%
  
  group_by(NUMERO_CANDIDATO) %>%
  
  mutate(voto_estado=sum(QTDE_VOTOS)) %>%
  
  select(NUMERO_CANDIDATO, voto_estado) %>%
  

  ungroup() 




## -----------------------------------------------------------------------------------------------------------------

pres_rio %>%

  filter(NUM_TURNO==1) %>%
  
  group_by(NUMERO_CANDIDATO) %>%
  
  summarize(voto_estado=sum(QTDE_VOTOS)) %>%
  
  slice(1:5) 




## -----------------------------------------------------------------------------------------------------------------
data1 <- tibble(nome=c("A", "B", "C"), 
                value=c(10, 20, 30)) 
data2 <- tibble(nome=c("A", "D", "C"), 
                value2=c(10, 50, 30))
data1
data2


## ----echo=FALSE,out.width="80%"-----------------------------------------------------------------------------------
knitr::include_graphics("figs/left-join.gif")


## -----------------------------------------------------------------------------------------------------------------
left_join(data1, data2)


## ----echo=FALSE,out.width="80%"-----------------------------------------------------------------------------------
knitr::include_graphics("figs/inner-join.gif")


## -----------------------------------------------------------------------------------------------------------------
inner_join(data1, data2)



## ----echo=FALSE,out.width="80%"-----------------------------------------------------------------------------------
knitr::include_graphics("figs/full-join.gif")


## -----------------------------------------------------------------------------------------------------------------
full_join(data1, data2)



## -----------------------------------------------------------------------------------------------------------------
data3 <- data2 %>%
          # alterando o nome
          select(chave=nome, everything())

# Join

left_join(data1, data3, 
          by=c("nome"="chave")) # adicione argumento by.


