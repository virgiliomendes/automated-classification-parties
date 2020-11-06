# ---
# FUNCAO DE ATRIBUICAO DE IDEOLOGIA PARA COLIGACOES
# ---



### Funcao de correção de ideologia


colig_C <- function(bd){
  
  # Correcoes para Centro (C)
  #bd$POSIC_IDEO_C[stringr::str_detect(bd$POSIC_IDEO_C, "DEM |PMB | MDB | PL | PSD | PTC | DC | PROS ")] <- "CENTRO"
  
  if ("POSIC_IDEO_C" %in% names(bd)){
    bd$POSIC_IDEO_C[stringr::str_detect(bd$POSIC_IDEO_C, "_PMDB_|_PROS_|_PSDB_")] <- "CENTRO"
    bd$POSIC_IDEO_C[bd$POSIC_IDEO_C != "CENTRO"] <- "NÃO SE APLICA"
  }

  
  # Retorma o df com os nomes limpos
  bd
}

colig_E <- function(bd){
  
  # Correcoes para Esquerda (E)
  #bd$POSIC_IDEO_E[stringr::str_detect(bd$POSIC_IDEO_E, "PC do B |PCB |PSOL|PCO| PSTU | PT ")] <- "ESQUERDA"
  
  if ("POSIC_IDEO_E" %in% names(bd)){
    bd$POSIC_IDEO_E[stringr::str_detect(bd$POSIC_IDEO_E, "_PC do B_|_PDT_|_PSB_|_PT_|_PTB_|_PV_|_PSOL_|_PMN_")] <- "ESQUERDA"
    bd$POSIC_IDEO_E[bd$POSIC_IDEO_E != "ESQUERDA"] <- "NÃO SE APLICA"
  }
  
  
  
  # Retorma o df com os nomes limpos
  bd
}

colig_D <- function(bd){
  
  # Correcoes para Direita (D)
  #bd$POSIC_IDEO_D[stringr::str_detect(bd$POSIC_IDEO_D, "PSDB | PV |PMN | PSL")] <- "DIREITA"
  
  # ifelse("POSIC_IDEO_D" %in% names(bd) , bd <- mutate(bd, POSIC_IDEO_D = "DIREITA"),
  #        bd <-  mutate(bd, POSIC_IDEO_D = "NÃO SE APLICA" ))
  if ("POSIC_IDEO_D" %in% names(bd)){
    bd$POSIC_IDEO_D[stringr::str_detect(bd$POSIC_IDEO_D, "_DEM_|_PHS_|_PP_|_PR_|_PRB_|_PRP_|_PSC_|_PSD_|_PSDC_|_PSL_|_PTN_")] <- "DIREITA"
    bd$POSIC_IDEO_D[bd$POSIC_IDEO_D != "DIREITA"] <- "NÃO SE APLICA"
  }
  
  # Retorma o df com os nomes limpos
  bd
}




colig_tipo <- function(bd){
  # Função para categorização de tipos de coligações

  bd <- bd %>%
    mutate(TIPO_DE_COLIG = case_when(
      # condicional para tipo CONSISTENTE
      POSIC_IDEO_D == "DIREITA" & POSIC_IDEO_E != "ESQUERDA" & POSIC_IDEO_C != "CENTRO" ~ "CONSISTENTE",
      POSIC_IDEO_D != "DIREITA" & POSIC_IDEO_E == "ESQUERDA" & POSIC_IDEO_C != "CENTRO" ~ "CONSISTENTE",
      POSIC_IDEO_D != "DIREITA" & POSIC_IDEO_E != "ESQUERDA" & POSIC_IDEO_C == "CENTRO" ~ "CONSISTENTE",
      
      # condicional para tipo INCONSISTENTE
      POSIC_IDEO_D == "DIREITA" & POSIC_IDEO_E == "ESQUERDA" & POSIC_IDEO_C != "CENTRO" ~ "INCONSISTENTE",
      POSIC_IDEO_D == "DIREITA" & POSIC_IDEO_E == "ESQUERDA" & POSIC_IDEO_C == "CENTRO" ~ "INCONSISTENTE",
      
      # condicional para tipo SEMICONSISTENTE
      POSIC_IDEO_D == "DIREITA" & POSIC_IDEO_E != "ESQUERDA" & POSIC_IDEO_C == "CENTRO" ~ "SEMICONSISTENTE",
      POSIC_IDEO_D != "DIREITA" & POSIC_IDEO_E == "ESQUERDA" & POSIC_IDEO_C == "CENTRO" ~ "SEMICONSISTENTE",
      
      # condicional para tipo NÃO SE APLICA
      POSIC_IDEO_D != "DIREITA" & POSIC_IDEO_E != "ESQUERDA" & POSIC_IDEO_C != "CENTRO" ~ "NÃO SE APLICA"
    ))
  
  

  # Retorma o df com os tipos das coligações
  bd
}


padroniza_colig <- function(bd){
  
  # Padronização da variavel coligações partidárias
  if ("LEGENDA_PARTS" %in% names(bd)){
    bd$LEGENDA_PARTS <- stringr::str_replace_all(bd$LEGENDA_PARTS, " / ", "_")

  }
  if ("LEGENDA_PARTS" %in% names(bd)){
    bd <- mutate(bd, LEGENDA_PARTS = paste0("_",LEGENDA_PARTS,"_"))
  }

  
  # Retorma o df com os nomes limpos
  bd
}
