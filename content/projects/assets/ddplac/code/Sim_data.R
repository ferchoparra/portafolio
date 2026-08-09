


# ABOUT -------------------------------------------------------------------

# Description: <Se realizan las simulaciones>
# Uso: <Se debe correr acquire curate y transform
# Autor: <Luis Parra>
# Date: <2021 Febrero>

# SETUP -------------------------------------------------------------------

# Script-specific options or packages

library(manipulate)
library(egg)

# RUN ---------------------------------------------------------------------

# Steps involved in transforming the data for analysis


## Generar Escenarios####

#rendimientos
#cultivos
names(BDBalComFinal)
aggregate(BDBalComFinal$PorExpo_1,list(BDBalComFinal$varia,BDBalComFinal$tipo),mean,na.rm =TRUE)
aggregate(BDBalComFinal$Rend,list(BDBalComFinal$varia,BDBalComFinal$tipo),mean,na.rm =TRUE)
aggregate(BDBalComFinal$Rend,list(BDBalComFinal$GCAM_Class,BDBalComFinal$tipo),mean,na.rm =TRUE)
aggregate(BDBalComFinal$tasa_rend,list(BDBalComFinal$GCAM_Class,BDBalComFinal$tipo),mean,na.rm =TRUE)

aggregate(BDBalComFinal$Rend,list(BDBalComFinal$GCAM_Class,BDBalComFinal$varia),mean,na.rm =TRUE)
aggregate(BDBalComFinal$tasa_rend,list(BDBalComFinal$GCAM_Class,BDBalComFinal$varia),mean,na.rm =TRUE)
#ganaderia
aggregate(BDBalComFinal$A_ha,list(BDBalComFinal$GCAM_Class,BDBalComFinal$tipo),mean,na.rm =TRUE)


BDBalComFinal[,c("Cod_cultivo","GCAM_Class","tipo","Year",
                 "Prod1","Animales_Total","AreaReq",
                 "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                 "Rend","Rend_E","A_ha","A_ha_E")]

names(BDBalComFinal)
unique(BDBalComFinal[,c("Cod_cultivo","GCAM_Class","varia")])

View(filter(BDBalComFinal,Cod_cultivo == 866))
View(filter(BDComercio,Cod_cultivo == 56)[,c("Year","AreaRe")])


#maizcomercio <- filter(BDComercio,Cod_cultivo == 56 & Year == 2014)

#aggregate(maizcomercio$`Export Quantity_tonnes`,list(maizcomercio$Item),sum, na.rm=TRUE)
#aggregate(maizcomercio$Expo_Factor,list(maizcomercio$Item),sum, na.rm=TRUE)

#sum(maizcomercio$`Export Quantity_tonnes`)
#sum(maizcomercio$Expo_Factor)

#Estrategias
#1. rendimientos cultivos
#2. aumento animales ha
#3. bovinos: aumento animales ha, tasa extraccion con año de inicio. 
#4. 3C fertilizantes
#5. 3D Mejoramiento de pasturas. 
#6. 3D arroz
#7. Manejo de bosque natural
#8. Consumo Carne
#9. Plantaciones comerciales

#aumento en rendimientos
Corn <- 0.021
fiber <- 0.015
Misc <- 0.013
Oil <- 0.007
Grain <- 0.02
Palm <- 0.005
Rice <- 0.018
Root <- 0.017
Sugar <- 0.005
Wheat <- 0.015


Cattle <- 0.1 # aumento animales por ha
tasa <- 0.18 #
lambdaAha <- 0.0253
AnoTasa <- 9 #año al cual se empieza a aumentar la tasa de extracción
lambdatasa <- 0.206  #intensidad con la cual se aplica tasa de extracción

#aumento en animales ha
Honey <- 0.00
Other <- 0.00
Pig <- 0.02
Poultry <- 0.00
Sheep <- 0.00



#Estrategias:
#3C. Fuentes agregadas y emisiones de no CO2 provenientes de la tierra
EI <- 1 #Porcentaje de afectación al area o a cantidad de animales
lambdaEIA <- 0.113 #intensidad en el tiempo de la afectacción

#3D1. Mejoramiento Pasturas
EII <- 1  #Porcentaje de afectación al area o a cantidad de animales
lambdaEIIA <- 0.113 #intensidad en el tiempo de la afectacción

#3D2. Manejo Arroz
EIII <- 1  #Porcentaje de afectación al area o a cantidad de animales
lambdaEIIIA <- 0.113 #intensidad en el tiempo de la afectacción

#3B1. Tierras forestales
EIV <- 1  #Porcentaje de afectación al area o a cantidad de animales
EIV_R <- 0.5 #Porcentaje de reducción de las emisiones. 
lambdaEIVA <- 0.134 #intensidad en el tiempo de la afectacción


BDForestal <- read_excel("data/original/Elas_Factores.xlsx", sheet = "Forestal")
BDForestal <- as.data.frame(BDForestal)

names(BDForestal)
BDFor <- BDForestal 
names(BDFor)

names(BDBalComFinal)
names(cod_trans)
BDBalComFinal2 <- merge(BDBalComFinal,cod_trans[,c("Cod_cultivo","tipo_f")], by.x=c("Cod_cultivo"), by.y=c("Cod_cultivo"),all.x= TRUE)


#Escenarios: (año base forestal MADR2015)
#Base: consumo ajuste, rendimientos iguales, forestal Profor2015
#1: rendimientos agricultura (con porcino), estrategia 3C (EI), arroz (EIII)
#2: Bovinos (carga, tasaextraccion), manejo de pasturas (EII)
#3: Bosques naturales (EIV)
#4: Plantaciones comerciales (2m). 
#5: Menor consumo de carne 0.1 elasticidad
#6: TODO 


View(BDBalComFinal[,c("Cod_cultivo","GCAM_Class","tipo","Year",
                      "Prod1","Animales_Total","AreaReq",
                      "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                      "Rend","Rend_E","A_ha","A_ha_E")])

#Insumos:
#Base: base de consumo final
#A_Cultivos: segunda linea son aumentos en porcentaje de cultivos, son aumentos por grupos GCAM y no aumentan sobre la tasa actual sino que le agregan aumento en porcentajes ya que unos estan en cero
#A_Ganaderia: aumentos en los grupos de ganaderia como no hay tasas de aumento en animales por ha, se asigna una tasa anual de aumento por grupo GCAM. 
#EForest1 y EForest2: escenarios forestales escoger entre "MADR2015"     "Profor2035"   "PAPFCm1"      "PAPFCm2"      "Profor2015SR"
#EI_porc,EII_porc,EIII_porc,EIV_porc: porcentajes de afectación al area o la cantidad de animales 0-1
#EIV_Red: Porcentaje de reducción a la estrategia IV 3B1aii: tierrras forestales que pasan a otros forestales (extracción de madera)
#AU_pvivo: aumento en porcentaje del peso vivo original (opcional para choque)
#AU_TasaExtra: aumento en porcentaje de tasa de extracción (mejora en rendimiento de peso al sacrificio), tener cuidado con tasas de 100 %
#

View(BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")])

#1: rendimientos agricultura (con porcino), estrategia 3C (EI), arroz (EIII)
# E1 <- funEscenarios(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo_f","tipo","Year",
#                                          "Prod1","Animales_Total","AreaReq",
#                                          "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
#                                          "Rend","Rend_E","A_ha","A_ha_E")],
#                         BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
#                         Corn,fiber,Misc,Oil,Grain,Palm,Rice,Root,Sugar,Wheat,#rendimientos cultivos
#                         0,0, 0, Pig, 0, 0,#tasas de crecimiento animales por ha
#                         "Profor2015","Profor2015",39239481,0.003,0.09,
#                         EI,0,EIII,0,0,
#                         lambdaEIA,0,lambdaEIIIA,0,
#                         0,0,0,0,#el cero es aumento animal vivo
#                         2021,AnoTasa,"serie")#salida "emisiones" o "serie"

E1b <- funEscenarios_Backup2(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo","Year",
                                     "Prod1","Animales_Total","AreaReq",
                                     "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                                     "Rend","Rend_E","A_ha","A_ha_E")],
                    BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
                    Corn,fiber,Misc,Oil,Grain,Palm,Rice,Root,Sugar,Wheat,#rendimientos cultivos
                    0,0, 0, Pig, 0, 0,#tasas de crecimiento animales por ha
                    "Profor2015","Profor2015",
                    EI,0,EIII,0,0,
                    lambdaEIA,0,lambdaEIIIA,0,
                    0,0,0,0,#el cero es aumento animal vivo
                    2022,AnoTasa,"resultados")


# #2: Bovinos (carga, tasaextraccion), manejo de pasturas (EII)
# E2 <- funEscenarios(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo","Year",
#                                      "Prod1","Animales_Total","AreaReq",
#                                      "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
#                                      "Rend","Rend_E","A_ha","A_ha_E")],
#                     BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
#                     0,0,0,0,0,0,0,0,0,0,#rendimientos cultivos
#                     Cattle,0, 0, 0, 0, 0,#tasas de crecimiento animales por ha
#                     "Profor2015","CAIA_E3",39239481,0.003,0.09,
#                     0,EII,0,0,0,
#                     0,lambdaEIIA,0,0,
#                     0,tasa,lambdatasa,lambdaAha,#el cero es aumento animal vivo
#                     2022,AnoTasa,"resultados")
# 
# #3: Bosques naturales (EIV)
# E3 <- funEscenarios(BDBalComFinal[,c("Cod_cultivo","GCAM_Class","tipo","Year",
#                                      "Prod1","Animales_Total","AreaReq",
#                                      "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
#                                      "Rend","Rend_E","A_ha","A_ha_E")],
#                     BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
#                     0,0,0,0,0,0,0,0,0,0,#rendimientos cultivos
#                     0,0, 0, 0, 0, 0,#rendimientos pecuarios
#                     "Profor2015","Profor2015",39239481,0.003,0.09,
#                     0,0,0,EIV,EIV_R,#Estrategias
#                     0,0,0,lambdaEIVA,
#                     0,0,0,0,#el cero es aumento animal vivo
#                     2022,AnoTasa,"resultados")
# 
# #4: Plantaciones comerciales (2m). 
# E4 <- funEscenarios(BDBalComFinal[,c("Cod_cultivo","GCAM_Class","tipo","Year",
#                                      "Prod1","Animales_Total","AreaReq",
#                                      "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
#                                      "Rend","Rend_E","A_ha","A_ha_E")],
#                     BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
#                     0,0,0,0,0,0,0,0,0,0,#rendimientos cultivos
#                     0,0, 0, 0, 0, 0,#rendimientos pecuarios
#                     "Profor2015","DDPLAC_Plan",39239481,0.003,0.09,
#                     0,0,0,0,0,#estrategias
#                     0,0,0,0,#lambdas estrategias
#                     0,0,0,0,#el cero es aumento animal vivo
#                     2022,AnoTasa,"resultados")
# 
# #5: Menor consumo de carne 0.1 elasticidad
# #se ajusta desde el codigo transform_data.R en la elasticidad. 
# #escenario igual al base de todo 
# E5 <- funEscenarios(BDBalComFinal[,c("Cod_cultivo","GCAM_Class","tipo","Year",
#                                      "Prod1","Animales_Total","AreaReq",
#                                      "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
#                                      "Rend","Rend_E","A_ha","A_ha_E")],
#                     BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
#                     0,0,0,0,0,0,0,0,0,0,#rendimientos cultivos
#                     0,0, 0, 0, 0, 0,#rendimientos pecuarios
#                     "Profor2015","Profor2015",39239481,0.003,0.09,
#                     0,0,0,0,0,#estrategias
#                     0,0,0,0,#lambdas estrategias
#                     0,0,0,0,#el cero es aumento animal vivo
#                     2022,AnoTasa,"resultados")
# 
# #todo con elasticidad carne en 0.1
# todo_S <- funEscenarios(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo_f","tipo","Year",
#                                      "Prod1","Animales_Total","AreaReq",
#                                      "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
#                                      "Rend","Rend_E","A_ha","A_ha_E")],
#                     BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
#                     Corn,fiber,Misc,Oil,Grain,Palm,Rice,Root,Sugar,Wheat,
#                     Cattle,Honey, Other, Pig, Poultry, Sheep,
#                     "Profor2015","DDPLAC_Plan",39239481,0.003,0.09,
#                     EI,EII,EIII,EIV,EIV_R,
#                     lambdaEIA,lambdaEIIA,lambdaEIIIA,lambdaEIVA,
#                     0,0.18,lambdatasa,lambdaAha,#el cero es aumento animal vivo
#                     2022,7,"serie")##salida "emisiones" o "serie",todo para escenarios e constante (10 años), para el resto 7 años
# 
# todo_E <- funEscenarios(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo_f","tipo","Year",
#                                          "Prod1","Animales_Total","AreaReq",
#                                          "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
#                                          "Rend","Rend_E","A_ha","A_ha_E")],
#                         BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
#                         Corn,fiber,Misc,Oil,Grain,Palm,Rice,Root,Sugar,Wheat,
#                         Cattle,Honey, Other, Pig, Poultry, Sheep,
#                         "Profor2015","DDPLAC_Plan",39239481,0.003,0.09,
#                         EI,EII,EIII,EIV,EIV_R,
#                         lambdaEIA,lambdaEIIA,lambdaEIIIA,lambdaEIVA,
#                         0,0.18,lambdatasa,lambdaAha,#el cero es aumento animal vivo
#                         2021,7,"emisiones")




#para analisis costos y beneficios 20210822
todo_E <- funEscenarios_Backup2(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo","tipo_f","Year",
                                       "Prod1","Animales_Total","AreaReq",
                                       "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                                       "Rend","Rend_E","A_ha","A_ha_E")],
                      BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
                      Corn,fiber,Misc,Oil,Grain,Palm,Rice,Root,Sugar,Wheat,
                      Cattle,Honey, Other, Pig, Poultry, Sheep,
                      "Profor2015","DDPLAC_Plan",
                      EI,EII,EIII,EIV,EIV_R,
                      lambdaEIA,lambdaEIIA,lambdaEIIIA,lambdaEIVA,
                      0,0.18,lambdatasa,lambdaAha,#el cero es aumento animal vivo, 0.18
                      2022,7,"emisiones")#todo para escenarios e constante (10 años), para el resto 7 años

todo_S <- funEscenarios_Backup2(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo","tipo_f","Year",
                                                 "Prod1","Animales_Total","AreaReq",
                                                 "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                                                 "Rend","Rend_E","A_ha","A_ha_E")],
                                BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
                                Corn,fiber,Misc,Oil,Grain,Palm,Rice,Root,Sugar,Wheat,
                                Cattle,Honey, Other, Pig, Poultry, Sheep,
                                "Profor2015","DDPLAC_Plan",
                                EI,EII,EIII,EIV,EIV_R,
                                lambdaEIA,lambdaEIIA,lambdaEIIIA,lambdaEIVA,
                                0,0.18,lambdatasa,lambdaAha,#el cero es aumento animal vivo
                                2022,7,"serie")#todo para escenarios e constante (10 años), para el resto 7 años

todo_Ebase <- funEscenarios_Backup2(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo","tipo_f","Year",
                                                 "Prod1","Animales_Total","AreaReq",
                                                 "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                                                 "Rend","Rend_E","A_ha","A_ha_E")],
                                BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
                                Corn,fiber,Misc,Oil,Grain,Palm,Rice,Root,Sugar,Wheat,
                                Cattle,Honey, Other, Pig, Poultry, Sheep,
                                "Profor2015","DDPLAC_Plan",
                                EI,EII,EIII,EIV,EIV_R,
                                lambdaEIA,lambdaEIIA,lambdaEIIIA,lambdaEIVA,
                                0,0.18,lambdatasa,lambdaAha,#el cero es aumento animal vivo
                                2022,7,"emisiones")#todo para escenarios e constante (10 años), para el resto 7 años

todo_Sbase <- funEscenarios_Backup2(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo","tipo_f","Year",
                                                 "Prod1","Animales_Total","AreaReq",
                                                 "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                                                 "Rend","Rend_E","A_ha","A_ha_E")],
                                BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
                                Corn,fiber,Misc,Oil,Grain,Palm,Rice,Root,Sugar,Wheat,
                                Cattle,Honey, Other, Pig, Poultry, Sheep,
                                "Profor2015","DDPLAC_Plan",
                                EI,EII,EIII,EIV,EIV_R,
                                lambdaEIA,lambdaEIIA,lambdaEIIIA,lambdaEIVA,
                                0,0.18,lambdatasa,lambdaAha,#el cero es aumento animal vivo
                                2022,7,"serie")#todo para escenarios e constante (10 años), para el resto 7 años



todo <- funEscenarios_Backup2(BDBalComFinal[,c("Cod_cultivo","GCAM_Class","tipo","Year",
                                               "Prod1","Animales_Total","AreaReq",
                                               "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                                               "Rend","Rend_E","A_ha","A_ha_E")],
                              BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
                              Corn,fiber,Misc,Oil,Grain,Palm,Rice,Root,Sugar,Wheat,
                              Cattle,Honey, Other, Pig, Poultry, Sheep,
                              "Profor2015","CAIA_E3",
                              EI,EII,EIII,EIV,EIV_R,
                              lambdaEIA,lambdaEIIA,lambdaEIIIA,lambdaEIVA,
                              0,0.18,lambdatasa,lambdaAha,#el cero es aumento animal vivo
                              2022,7,"serie")#todo para escenarios e constante (10 años), para el resto 7 años


todo <- funEscenarios_Backup2(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo","Year",
                                               "Prod1","Animales_Total","AreaReq",
                                               "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                                               "Rend","Rend_E","A_ha","A_ha_E")],
                              BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
                              Corn,fiber,Misc,Oil,Grain,Palm,Rice,Root,Sugar,Wheat,
                              Cattle,Honey, Other, Pig, Poultry, Sheep,
                              "Profor2015","CAIA_E3",
                              EI,EII,EIII,EIV,EIV_R,
                              lambdaEIA,lambdaEIIA,lambdaEIIIA,lambdaEIVA,
                              0,0.18,lambdatasa,lambdaAha,#el cero es aumento animal vivo
                              2022,7,"resultados")#todo para escenarios e constante (10 años), para el resto 7 años


#NDC
NDC_S <- funEscenarios_Backup2(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo","tipo_f","Year",
                                                     "Prod1","Animales_Total","AreaReq",
                                                     "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                                                     "Rend","Rend_E","A_ha","A_ha_E")],
                                   BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
                                   0,0,0,0,0,0,0,0,0,0,
                                   0,0, 0, 0, 0, 0,
                                   "Profor2015","Profor2015",
                                   0,0,0,0,0,
                                   0,0,0,0,
                                   0,0.18,0,0,#el cero es aumento animal vivo
                                   2022,7,"serie")#todo para escenarios e constante (10 años), para el resto 7 años


NDC_E <- funEscenarios_Backup2(BDBalComFinal2[,c("Cod_cultivo","GCAM_Class","tipo","tipo_f","Year",
                                                 "Prod1","Animales_Total","AreaReq",
                                                 "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                                                 "Rend","Rend_E","A_ha","A_ha_E")],
                               BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
                               0,0,0,0,0,0,0,0,0,0,
                               0,0, 0, 0, 0, 0,
                               "Profor2015","Profor2015",
                               0,0,0,0,0,
                               0,0,0,0,
                               0,0.18,0,0,#el cero es aumento animal vivo
                               2022,7,"emisiones")#todo para escenarios e constante (10 años), para el resto 7 años



write.xlsx(E1,"data/derived/20210503_E1.xlsx")
write.xlsx(E2,"data/derived/20210503_E2.xlsx")
write.xlsx(E3,"data/derived/20210503_E3.xlsx")
write.xlsx(E4,"data/derived/20210503_E4.xlsx")
write.xlsx(todo_E,"data/derived/20210713_ETodo_prueba.xlsx")

write.xlsx(todo_E,"data/derived/20230308_todo_E.xlsx")
write.xlsx(todo_Ebase,"data/derived/20230308_todo_Ebase.xlsx")
write.xlsx(todo_S,"data/derived/20230308_todo_S.xlsx")
write.xlsx(todo_Sbase,"data/derived/20230308_todo_Sbase.xlsx")



write.xlsx(todo,"data/derived/20210429_ETodo_ConConsGanSeries.xlsx")
write.xlsx(NDC_E,"data/derived/NDC_Emisiones.xlsx")

ggplot(prueba, aes(x = Year, y = Factor_AT))+ geom_line() +
  facet_wrap(~Estra, ncol = 8,scales = "free")
names(prueba)
View(filter(prueba,Cod_cultivo == 866 & Year %in% c(2022:2050))[,c("Year","A_ha","A_ha_E","Animales_Total_E","Animales_Total","AreaReq","AreaReq_E")])

write.xlsx(BDBalComFinal,"data/derived/CyB_cultivos.xlsx")


ggplot(aggregate(prueba[,c("Em_netas","Em_totales","Em_netas_E")],list(prueba[,"Year"]),sum,na.rm=TRUE), aes(x = Group.1, y = Em_netas)) +
 geom_line(aes(x = Group.1, y = Em_netas)) +
 geom_line(aes(x = Group.1, y = Em_netas_E))



#manipular

manipulate(
  plot(cars, xlim=c(x.min,x.max)),
  x.min=slider(0,15),
  x.max=slider(15,30))



manipulate(funEscenarios(BDBalComFinal[,c("Cod_cultivo","GCAM_Class","tipo","Year",
                                          "Prod1","Animales_Total","AreaReq",
                                          "tasa_rend","tasa_rend_E","A_ha_tasa","P_A_vivo","TasaExtra",
                                          "Rend","Rend_E","A_ha","A_ha_E")],
                         BDFor,BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","Estra","Porc_A_E","Proc_redu_E","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
                         Corn,fiber,Misc,Oil,Grain,Palm,Rice,Root,Sugar,Wheat,
                         Cattle,Honey, Other, Pig, Poultry, Sheep,
                         "Profor2015","PAPFCm2",
                         EI,EII,EIII,EIV,EIV_R,
                         lambdaEIA,lambdaEIIA,lambdaEIIIA,lambdaEIVA,
                         0,tasa,lambdatasa,lambdaAha,
                         2022,AnoTasa),
           lambdaEIA=slider(0,1,step = 0.0001,initial = 0.113),
           lambdaEIIA=slider(0,1,step = 0.0001,initial = 0.113),
           lambdaEIIIA=slider(0,1,step = 0.001,initial = 0.113),
           lambdaEIVA=slider(0,1,step = 0.001,initial = 0.134),
           tasa=slider(0,1,step = 0.001,initial = 0.29))




(1-exp(-lambdaTasaAha*(Base$Year-(Ano_i-1))))

lambda_elas <- 0.3#hasta que porcentaje baja 0.003
lambda_elas2 <- 0.1#con que intensidad
Year <- c(2021:2050)
plot(Year,0.003*(lambda_elas*exp(-lambda_elas2*(Year-(2021-1)))/(lambda_elas*exp(-lambda_elas2*(2021-(2021-1))))),type = "l")
(lambda_elas*exp(-lambda_elas2*(Year-(2021-1)))/(lambda_elas*exp(-lambda_elas2*(2021-(2021-1)))))
0.003*(exp(-lambda_elas2*(Year-(2021-1)))/(exp(-lambda_elas2*(2021-(2021-1)))))


#Costos y Beneficios####
#archivos de funcion anterior series y emisiones



## funcion 
#Fijo: 
#Consumo
#Produccion
#impo
#expo

#manipular: 
#Rendimientos
#3A1 y 3A2 
#3C

write.xlsx(E1,"data/derived/20210503_E1.xlsx")

#
