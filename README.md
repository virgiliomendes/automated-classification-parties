# Função: automated_classification_parties
Usando como base bancos de dados extraídos do TSE via pacote [ElectionsBR](http://electionsbr.com/), este código propõe uma forma de classificação das coligações para as eleições brasileiras de forma automatizada.

## Proposta:
O código desenvolvido propõe extrair dados eleitorais do TSE via pacote ElectionsBR e está formatado para realizar as codificações automáticas de coligações a partir da composição das legendas partidárias (variavel presente nos dados exportados). A adequação das funções de classificação automatica propostas para outros dados pode ser realizadas, desde que os passos para criação, tratamento e classificação dos dados e variaveis sejam respeitados.

## Classificação:
Os dados usados como base para a construção desse classificador foram referentes às coligações eleitorais do executivo municipal nas eleições de 2012 e 2016 no Brasil.

São elaboradas classificações segundo a consistência ideológica das coligações, podendo ser classificadas em *Centro (C)*, *Esquerda (E)* e *Direita (D)*. Outra classificação realizada é se a coligação é consistente ideologicamente, inconsistente ou semiconsistente, seguindo a caracterização a partir das conjunção dos partidos presentes na coligação: 

Classificação dos partidos que compõem a coligação 	Tipo  da coligação
D / D	Consistente 
E / E	Consistente 
E / C	Semiconsistente
D / C	Semiconsistente
D / E	Inconsistente
E / D	Inconsistente
