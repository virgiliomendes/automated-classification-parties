# Função: automated_classification_parties
Usando como base bancos de dados extraídos do TSE via pacote [ElectionsBR](http://electionsbr.com/), este código propõe uma forma de classificação das coligações para as eleições brasileiras de forma automatizada.

## Proposta:
O código desenvolvido propõe extrair dados eleitorais do TSE via pacote ElectionsBR e está formatado para realizar as codificações automáticas de coligações a partir da composição das legendas partidárias (variavel presente nos dados exportados). A adequação das funções de classificação automatica propostas para outros dados pode ser realizadas, desde que os passos para criação, tratamento e classificação dos dados e variaveis sejam respeitados.

## Classificação:
Os dados usados como base para a construção desse classificador foram referentes às coligações eleitorais do executivo municipal nas eleições de 2012 e 2016 no Brasil.

São elaboradas classificações segundo a consistência ideológica das coligações, podendo ser classificadas em **Centro (C)**, **Esquerda (E)** e **Direita (D)**. Outra classificação realizada é se a coligação é consistente ideologicamente, inconsistente ou semiconsistente, seguindo a caracterização a partir das conjunção dos partidos presentes na coligação: 

Classificação da tipologia da coligação segundo a composição da coligação (exemplo usado como referência para o código):


| Posicionamento Ideológico   | Classificação   |
|-----------------------------|-----------------|
| Direita (D) / Direita (D)   | Consistente     |
| Esquerda (E) / Esquerda (E) | Consistente     |
| Esquerda (E) / Centro (C)   | Semiconsistente |
| Direita (D) / Centro (C)    | Semiconsistente |
| Direita (D) / Esquerda (E)  | Inconsistente   |
| Esquerda (E) / Direita (D)  | Inconsistente   |

## Funções:
As funções que fazem a classificação automática usam a função **[strdetect](https://stringr.tidyverse.org/reference/str_detect.html)** do pacote [rstring](https://www.rdocumentation.org/packages/stringr/versions/1.4.0) como base para identificar as siglas dos partidos que compõe a coligação da qual o candidato(a) pertence. E a partir da identificação deste padrões textuais é realizada a primeira classificação segundo **Posicionamento Ideológico do Partido**. 

**NOTE QUE OS PARTIDOS CLASSIFICADOS COMO DIREITA, CENTRO E ESQUERDA FORAM COLOCADOS ASSIM NO CÓDIGO PARA MOTIVOS DIDÁTICOS E NÃO REPRESENTAM NECESSARIAMENTE A CLASSIFICAÇÃO CORRETA SEGUNDO A LITERATURA.**
