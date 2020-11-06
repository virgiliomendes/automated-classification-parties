
# ---
# Visualização 


# Referências:
# http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
# https://htmlcolorcodes.com/



bd2 = bd2 %>% filter(DESCRICAO_UE == "BETIM" |
                       DESCRICAO_UE == "CONTAGEM" | DESCRICAO_UE == "BELO HORIZONTE"|
                       DESCRICAO_UE == "IPATINGA")
# Criando variaveis para o calculo e salvando em outro bd
bd2 = bd2 %>% group_by(SIGLA_PARTIDO,DESCRICAO_SEXO,DESCRICAO_UE) %>%
  summarise(n_candidatos = n())

bd3 = bd2 %>% group_by(DESCRICAO_UE) %>% 
  mutate(proporcao = n_candidatos/sum(n_candidatos)*100)


# inclui essa paleta antes do codigo do ggplot e executa, ela vai criar uma paleta de cores personalizada
paleta <- c( "#0D50D8", "#C70039", "#8E0DD8", "#FF5733", "#EDF402", "#3ED715","#0D50D8", "#C70039", 
             "#8E0DD8", "#FF5733", "#EDF402", "#3ED715","#0D50D8", "#C70039", "#8E0DD8", "#FF5733", 
             "#EDF402", "#3ED715","#0D50D8", "#C70039", "#8E0DD8", "#FF5733", "#EDF402", "#3ED715",
             "#0D50D8", "#C70039", "#8E0DD8", "#FF5733", "#EDF402", "#3ED715","#0D50D8", "#C70039", 
             "#8E0DD8", "#FF5733", "#EDF402", "#3ED715")




# Grafico para os partidos com 30 candidatos ou mais
ggplot(bd3, aes(x = DESCRICAO_UE, y = proporcao, fill = SIGLA_PARTIDO)) + 
  geom_bar(position="dodge", stat="identity")+
  geom_text(aes(label = DESCRICAO_UE), position = "dodge") +
  geom_text(aes(label = proporcao, vjust= 2.5), position = "dodge") +
  theme_minimal() +
  labs(title = "Distribuição do Nº de Candidatos por Partido", subtitle = "Para os municípios de BH, Contagem e Betim",
       x = "Partido", y = "Num. de candidatos")  +
  theme(plot.title = element_text(hjust = .5), plot.subtitle = element_text(hjust = .5))+
  theme(legend.position = "bottom") +
  scale_fill_manual(values=paleta )
  
#ggsave("plot2.png", height = 10, width = 12, dpi = 300)








# Separando em 2 df
bd1_1 = bd1 %>% filter(n_candidatos < 30) # banco com partidos com menos de 30 candidatos
bd1_2 = bd1 %>% filter(n_candidatos > 29) # banco com partidos com 30 candidatos ou mais

# grafico para partidos com menos de 30 candidatos
ggplot(bd1_1, aes(fill=SIGLA_PARTIDO, y=votos_partido, x=n_candidatos)) + 
  geom_bar(position="dodge", stat="identity")+
  geom_text(aes(label =votos_partido), position = "dodge") +
  geom_text(aes(label =SIGLA_PARTIDO, vjust= 2.5), position = "dodge") +
  theme_minimal() +
  labs(title = "Distribuição do Nº de Votos por Partido", subtitle = "Para partidos com menos de 30 candidatos",
       x = " Num. de candidatos", y = " Votos por partido")  +
  theme(plot.title = element_text(hjust = .5), plot.subtitle = element_text(hjust = .5))+
  theme(legend.position = "none")

ggsave("plot1.png", height = 10, width = 12, dpi = 300)

# Grafico para os partidos com 30 candidatos ou mais
ggplot(bd1_2, aes(fill=SIGLA_PARTIDO, y=votos_partido, x=n_candidatos)) + 
  geom_bar(position="dodge", stat="identity")+
  geom_text(aes(label =votos_partido), position = "dodge") +
  geom_text(aes(label =SIGLA_PARTIDO, vjust= 2.5), position = "dodge") +
  theme_minimal() +
  labs(title = "Distribuição do Nº de Votos por Partido", subtitle = "Para partidos com mais de 29 candidatos",
       x = " Num. de candidatos", y = " Votos por partido")  +
  theme(plot.title = element_text(hjust = .5), plot.subtitle = element_text(hjust = .5))+
  theme(legend.position = "none")
#ggsave("plot2.png", height = 10, width = 12, dpi = 300)




