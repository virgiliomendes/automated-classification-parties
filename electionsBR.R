
# ---
# Virgílio Mendes
# Mestrando em Ciência Política | UFMG
# e-mail: virgilioebm@gmail.com
# ---
# 27/10/2020
# ---
#

# Trabalhando com o Pacote ElectionsBR para entender a consistência ideológica das
# coligações eleitorais do executivo municipal nas eleições de 2012 e 2016 no Brasil


# Material de Apoio:

# http://electionsbr.com/articles/index.html
# https://cran.r-project.org/web/packages/electionsBR/electionsBR.pdf
# http://electionsbr.com/

# Preamble 

rm(list = ls())

library(tidyverse)
library(ggplot2)
library(readxl)
library(electionsBR)
library(dplyr)
library(questionr)
library(stringr)# usar pacote de manipulação de texto -> stringr
library(here)

# Carrega funções
source(here::here("funcoes","funcao_colig.r"), encoding = "UTF-8")


# ---

# Importando dados da eleição para deputados 2018 
#bd = elections_rda(2012, level = "local")

#saveRDS(bd, "bd_eleicoes_locais_2012.rds") # salva banco de 2012
#saveRDS(bd, "bd_eleicoes_locais_2016.rds") # salva banco de 2016
bd = readRDS(here::here("dados", "bd_eleicoes_locais_2012.rds"))
#bd1 = readRDS(here::here("dados", "bd_eleicoes_locais_2016.rds"))


# names
names(bd)

# A partir da classificação manual do posicionamento ideológico por cada partido entre:
# Centro (C), Esquerda (E) e Direita (D) 
# Se classifica se a coligação é consistente ideologicamente, inconsistente ou semiconsistente,

# A ideia é usar um código que busca padrões textuais (no caso os partidos)
# e retorna em uma outra variavel o posicionamento ideologico

# fazendo subset apenas para testar a lógica do código

bd = bd %>% 
  select(NOME_CANDIDATO, ANO_ELEICAO, 
         SIGLA_UF, DESCRICAO_UE,DESCRICAO_CARGO, DESCRICAO_SEXO,SIGLA_PARTIDO,COMPOSICAO_LEGENDA) %>% 
  filter(SIGLA_UF == "MG" & DESCRICAO_CARGO == "PREFEITO")


# COMPOSICAO_LEGENDA| SIGLA_PARTIDO | ANO_ELEICAO | SIGLA_UF
names(bd)

# ---
# Tratamento da variavel coligações para ser aceito na função criada

# A ideia é colocar padrões textuais para facilitar a identificação do partido
#  opção: padronizar " / " por "_" e no início e final da linha incluir "_"

# replicando a variavel COMPOSICAO_LEGENDA em LEGENDA_PARTS
bd$LEGENDA_PARTS = bd$COMPOSICAO_LEGENDA

# pde valore unicos da variavel
unique(bd$LEGENDA_PARTS)

# aplica a função
bd = bd %>% padroniza_colig()

# cria uma variavel com length igual as outras
bd$POSIC_IDEO_C = bd$LEGENDA_PARTS # Centro (C)
bd$POSIC_IDEO_E = bd$LEGENDA_PARTS # Esquerda (E)
bd$POSIC_IDEO_D = bd$LEGENDA_PARTS # Direita (D) 

bd$TIPO_DE_COLIG = NA # consistente ideologicamente, inconsistente ou semiconsistente



# Não conheço a literatura, por motivos didaticos usei essa classificação:
# https://politica.estadao.com.br/noticias/geral,maioria-dos-partidos-se-identifica-como-de-centro,70003135964

# A ideia é criar todas as possibilidades de posicionamento ideologico
# identificando padrões textuais (que são os partidos)
# Lê-se: Busca-se padrão textual do termo "MDB", caso encontre substitui por "C"

# Aplica função de posicionamento ideologico
bd = bd %>% colig_C() %>% colig_D() %>% colig_E() %>% colig_tipo()

# função para ver a frequencia das categorias criadas
freq(bd$TIPO_DE_COLIG)




