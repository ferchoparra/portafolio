
# ABOUT -------------------------------------------------------------------

# Description: <Se implementan los modelos de proyeccion>
# Uso: <Utiliza base de datos para poryectar y genera base de datos con proyecciones, 
# a esta base se pueden integrar las emisiones
# Autor: <Luis Parra>
# Date: <2021 Febrero>

# SETUP -------------------------------------------------------------------

# Script-specific options or packages

# RUN ---------------------------------------------------------------------

# Steps involved in transforming the data for analysis


# Proyecciones Consumo, pobl y pib ----------------------------------------------------
##Consumo#####
#para cada cultivo primario proyectar
BDConsumoFinal
names(BDConsumoFinal)
levels(as.factor(BDConsumoFinal$Cod_cultivo))
levels(as.factor(BDConsumoFinal$Item))
Cultivos <- unique(BDConsumoFinal[,c("Cod_cultivo","Item")])

#Verificacion de modelos lineales para seleccionar
by(BDConsumoFinal,BDConsumoFinal$Cod_cultivo,function(x)functend(x,x$ConsA,"Consumo t",x[1,"Item"],1961,2050,"modelos"))#usar año de inicio de base para incorporar datos historicos
length(BDConsumoFinal[,"ConsA"])

#tabla con proyecciones

ResultProy <- functend(filter(BDConsumoFinal,Cod_cultivo==Cultivos[1,"Cod_cultivo"]),
                        filter(BDConsumoFinal,Cod_cultivo==Cultivos[1,"Cod_cultivo"])$ConsA,"Consumo t",Cultivos[1,"Item"],1961,2050,"proy")




functend(filter(BDConsumoFinal,Cod_cultivo==Cultivos[63,"Cod_cultivo"]),
         filter(BDConsumoFinal,Cod_cultivo==Cultivos[63,"Cod_cultivo"])$ConsA,"Consumo t",Cultivos[63,"Item"],1961,2050,"proy")


for(i in 2:nrow(Cultivos)){
          ResultProy <- rbind(ResultProy ,
                              functend(filter(BDConsumoFinal,Cod_cultivo==Cultivos[i,"Cod_cultivo"]),
                                       filter(BDConsumoFinal,Cod_cultivo==Cultivos[i,"Cod_cultivo"])$ConsA,
                                       "Consumo t",
                                       Cultivos[i,"Item"],
                                       1961,2050,"proyeccion"))
          }


##Poblacion####
proy_polb <- data.frame(Year=seq(2014,2050,1))

#escenarios GCAM
names(pib_pobl)
#124
modPobl_124 <- lm(Pobl_124 ~ poly(Year,2),data = pib_pobl)
proy_polb$pobl_124 <- predict(modPobl_124,proy_polb)

#258
modPobl_258 <- lm(Pobl_258 ~ poly(Year,2),data = pib_pobl)
proy_polb$pobl_258 <- predict(modPobl_258,proy_polb)

#estimacion dane
proy_polb$pobl_dane <- pobl_dane[65:101,"pobl"]


##PIB#####
proy_pib <- data.frame(Year=seq(2014,2050,1))

#escenarios GCAM

#124
modPib_124 <- lm(GDP_124 ~ poly(Year,2),data = pib_pobl)
proy_pib$pib_124 <- predict(modPib_124,proy_pib)

#258
modPib_258 <- lm(GDP_258 ~ poly(Year,2),data = pib_pobl)
proy_pib$pib_258 <- predict(modPib_258,proy_pib)

#estimacion propia
modPib <- lm(PIB15emp ~ poly(Year,2),data = pib_est)
proy_pib$PIM15emp <- predict(modPib,proy_pib)

#estimacion propia NDC hasta 2030, hasta 2050 se mantiene en 4 %
#se aplica en siguiente base




###Base Final####

Proyec <- merge(proy_polb,proy_pib, by.x=c("Year"), by.y=c("Year"),all.x= TRUE)
names(Proyec)
Proyec$t_pobl_124 <- growth_rate(Proyec$pobl_124)
Proyec$t_pobl_258 <- growth_rate(Proyec$pobl_258)
Proyec$t_pobl_dane <- growth_rate(Proyec$pobl_dane)

Proyec$t_pib_124 <- growth_rate(Proyec$pib_124)
Proyec$t_pib_258 <- growth_rate(Proyec$pib_258)
Proyec$t_pib_dane <- growth_rate(Proyec$PIM15emp)

#estimacion propia NDC hasta 2030, hasta 2050 se mantiene en 4 %
#se aplica en siguiente base
#Proyec$t_Pib_NDC <- c(Proyec[1:6,"t_pib_dane"],-0.055,0.066,0.044,0.043,0.043,0.041,rep(0.04,5),rep(0.03,20))
Proyec$t_Pib_NDC1 <- c(Proyec[1:6,"t_pib_dane"],-0.055,0.066,0.044,0.043,0.043,0.041,rep(0.04,5),rep(0.03,20))
Proyec$t_Pib_NDC <- as.vector(sma_old(Proyec$t_Pib_NDC1, h=2, silent=T)$fitted)###DDPALC2
#Proyec$t_Pib_NDC <- as.vector(sma(PIB[PIB[,"Year"] %in% c(2014:2020),"PIB_tasa"], h=2, silent=FALSE)$fitted)###
#modPib <- sma(PIB[PIB[,"Year"] %in% c(2000:2020),"PIB_tasa"], h=6, silent=FALSE)
#modPib$fitted
#plot(predict(modPib,20))
#predict(modPib)$forecast
#Proyec[,c("Year","t_Pib_NDC")]


##Consolidado Base Proyecccion####
names(ResultProy)
names(Proyec)

BDProyec <- merge(ResultProy,Proyec, by.x=c("Year"), by.y=c("Year"),all.x= TRUE)


# Calculo Elasticidad ingreso demanda -------------------------------------
names(BDProyec)

#Poblacion y PIb DANE 
BDProyec$E_exp_dane <- (BDProyec$tcon_exp-BDProyec$t_pobl_dane)/(BDProyec$t_pib_dane-BDProyec$t_pobl_dane)
BDProyec$E_llm_dane <- (BDProyec$tcon_llm-BDProyec$t_pobl_dane)/(BDProyec$t_pib_dane-BDProyec$t_pobl_dane)
BDProyec$E_llog_dane <- (BDProyec$tcon_llog-BDProyec$t_pobl_dane)/(BDProyec$t_pib_dane-BDProyec$t_pobl_dane)
BDProyec$E_Mpoly_dane <- (BDProyec$tcon_Mpoly-BDProyec$t_pobl_dane)/(BDProyec$t_pib_dane-BDProyec$t_pobl_dane)
BDProyec$E_pot_dane <- (BDProyec$tcon_pot-BDProyec$t_pobl_dane)/(BDProyec$t_pib_dane-BDProyec$t_pobl_dane)

#Poblacion y PIb DANE (NDC)
BDProyec$E_exp_NDC <- (BDProyec$tcon_exp-BDProyec$t_pobl_dane)/(BDProyec$t_Pib_NDC-BDProyec$t_pobl_dane)
BDProyec$E_llm_NDC <- (BDProyec$tcon_llm-BDProyec$t_pobl_dane)/(BDProyec$t_Pib_NDC-BDProyec$t_pobl_dane)
BDProyec$E_llog_NDC <- (BDProyec$tcon_llog-BDProyec$t_pobl_dane)/(BDProyec$t_Pib_NDC-BDProyec$t_pobl_dane)
BDProyec$E_Mpoly_NDC <- (BDProyec$tcon_Mpoly-BDProyec$t_pobl_dane)/(BDProyec$t_Pib_NDC-BDProyec$t_pobl_dane)
BDProyec$E_pot_NDC <- (BDProyec$tcon_pot-BDProyec$t_pobl_dane)/(BDProyec$t_Pib_NDC-BDProyec$t_pobl_dane)

#Poblacion y PIb 124
BDProyec$E_exp_124 <- (BDProyec$tcon_exp-BDProyec$t_pobl_124)/(BDProyec$t_pib_124-BDProyec$t_pobl_124)
BDProyec$E_llm_124 <- (BDProyec$tcon_llm-BDProyec$t_pobl_124)/(BDProyec$t_pib_124-BDProyec$t_pobl_124)
BDProyec$E_llog_124 <- (BDProyec$tcon_llog-BDProyec$t_pobl_124)/(BDProyec$t_pib_124-BDProyec$t_pobl_124)
BDProyec$E_Mpoly_124 <- (BDProyec$tcon_Mpoly-BDProyec$t_pobl_124)/(BDProyec$t_pib_124-BDProyec$t_pobl_124)
BDProyec$E_pot_124 <- (BDProyec$tcon_pot-BDProyec$t_pobl_124)/(BDProyec$t_pib_124-BDProyec$t_pobl_124)

#Poblacion y PIb 258
BDProyec$E_exp_258 <- (BDProyec$tcon_exp-BDProyec$t_pobl_258)/(BDProyec$t_pib_258-BDProyec$t_pobl_258)
BDProyec$E_llm_258 <- (BDProyec$tcon_llm-BDProyec$t_pobl_258)/(BDProyec$t_pib_258-BDProyec$t_pobl_258)
BDProyec$E_llog_258 <- (BDProyec$tcon_llog-BDProyec$t_pobl_258)/(BDProyec$t_pib_258-BDProyec$t_pobl_258)
BDProyec$E_Mpoly_258 <- (BDProyec$tcon_Mpoly-BDProyec$t_pobl_258)/(BDProyec$t_pib_258-BDProyec$t_pobl_258)
BDProyec$E_pot_258 <- (BDProyec$tcon_pot-BDProyec$t_pobl_258)/(BDProyec$t_pib_258-BDProyec$t_pobl_258)


summary(BDProyec)

ggplot(BDProyec, aes(x = Year, y = ConsA)) + 
  geom_line() + facet_wrap(~Item, ncol = 11 , scales = "free")

#Elasticidad fija cuando no sirven los modelos
#BDProyec merge

#View(BDProyec[BDProyec[,"Cod_cultivo"]==56,])

##Consumo final####
#merge modelo seleccionado

BDProyec <- merge(BDProyec,
                  Modelos[,c("Cod_cultivo","MOD")], by.x=c("Cod_cultivo"), by.y=c("Cod_cultivo"),all.x= TRUE)


#selecionar elasticidad 

BDProyec$elas <- ifelse(BDProyec$MOD == "exp", BDProyec$E_exp_NDC,
                        ifelse(BDProyec$MOD == "lm", BDProyec$E_llm_NDC,
                               ifelse(BDProyec$MOD == "log", BDProyec$E_llog_NDC,
                                      ifelse(BDProyec$MOD == "Mpoly", BDProyec$E_Mpoly_NDC,
                                             ifelse(BDProyec$MOD == "pot", BDProyec$E_pot_NDC,
                                                    BDProyec$E_pot_NDC)))))#Colocar la columna con el valor fijo de elasticiadad


BDProyec$con_mod <- ifelse(BDProyec$MOD == "exp", BDProyec$M_exp,
                        ifelse(BDProyec$MOD == "lm", BDProyec$M_llm,
                               ifelse(BDProyec$MOD == "log", BDProyec$M_llog,
                                      ifelse(BDProyec$MOD == "Mpoly", BDProyec$M_Mpoly,
                                             ifelse(BDProyec$MOD == "pot", BDProyec$M_pot,
                                                    NA)))))#Colocar la columna con el valor fijo de elasticiadad




AnoBase <- 2014
AnoProy <- 2050
BDProyec_F <- BDProyec[BDProyec[,"Year"]%in%c(AnoBase:AnoProy),c("Year","varia","Cod_cultivo","ConsHist","con_mod","t_pobl_dane","t_Pib_NDC","elas")]


#agregar grupos gcam
names(grupos)
BDProyec_F <- merge(BDProyec_F,
                  grupos[,c("Code","Group_FAO","Group_FAO_Final","GCAM_Class" )], by.x=c("Cod_cultivo"), by.y=c("Code"),all.x= TRUE)


BDProyec_F <- merge(BDProyec_F,
                    GCAMelast[,c("Grupo_GCAM","elasticidad")], by.x=c("GCAM_Class"), by.y=c("Grupo_GCAM"),all.x= TRUE)


summary(BDProyec_F)
by(BDProyec_F$elasticidad,BDProyec_F$GCAM_Class,summary)

#tasa de consumo con elasticidad fija elasticidad, con la del modelo elas
#ajustar elasticidades especificas: 

  #cafe
BDProyec_F[BDProyec_F[,"Cod_cultivo"]=="656","elasticidad"]

#ajustes elasticidad####
BDProyec_F$elasticidad_base <- BDProyec_F$elasticidad

#todos
lambda_elas <- 0.003#hasta que porcentaje baja 0.003
lambda_elas2 <- 0.024#con que intensidad
Year <- c(2021:2050)
plot(Year,(lambda_elas*exp(-lambda_elas2*(Year-(2021-1)))/(lambda_elas*exp(-lambda_elas2*(2021-(2021-1))))),type = "l")
(lambda_elas*exp(-lambda_elas2*(Year-(2021-1)))/(lambda_elas*exp(-lambda_elas2*(2021-(2021-1)))))

#carne
lambda_elasC <- 0.003#hasta que porcentaje baja
lambda_elasC2 <- 0.024#con que intensidad, base 0.024 y escenario 0.068,prueba con otra elasticidad para ajustar
lambda_elasC3 <- 0.024
Year <- c(2021:2050)
plot(Year,(lambda_elasC*exp(-lambda_elasC2*(Year-(2021-1)))/(lambda_elasC*exp(-lambda_elasC2*(2021-(2021-1))))),type = "l")
(lambda_elasC*exp(-lambda_elasC2*(Year-(2021-1)))/(lambda_elasC*exp(-lambda_elasC2*(2021-(2021-1)))))


# BDProyec_F$elasticidad <- ifelse(BDProyec_F$Cod_cultivo == 866,BDProyec_F$elasticidad_base*(lambda_elasC*exp(-lambda_elasC2*(BDProyec_F$Year-(2021-1)))/(lambda_elasC*exp(-lambda_elasC2*(2021-(2021-1))))),
#                                  BDProyec_F$elasticidad_base*(lambda_elas*exp(-lambda_elas2*(BDProyec_F$Year-(2021-1)))/(lambda_elas*exp(-lambda_elas2*(2021-(2021-1))))))

#nuevo para ajustar
BDProyec_F$elasticidad <- ifelse(BDProyec_F$Year %in% c(2014:2021) & BDProyec_F$Cod_cultivo == 866,
                                 BDProyec_F$elasticidad_base*(lambda_elasC*exp(-lambda_elasC3*(BDProyec_F$Year-(2021-1)))/(lambda_elasC*exp(-lambda_elasC3*(2021-(2021-1))))),
                                 ifelse(!(BDProyec_F$Year %in% c(2014:2021)) & BDProyec_F$Cod_cultivo == 866,
                                        BDProyec_F$elasticidad_base*(lambda_elasC*exp(-lambda_elasC2*(BDProyec_F$Year-(2021-1)))/(lambda_elasC*exp(-lambda_elasC2*(2021-(2021-1))))),
                                        BDProyec_F$elasticidad_base*(lambda_elas*exp(-lambda_elas2*(BDProyec_F$Year-(2021-1)))/(lambda_elas*exp(-lambda_elas2*(2021-(2021-1)))))))



#nuevo
#solo ajuste a ganaderia
#BDProyec_F$elasticidad <- ifelse(BDProyec_F$elasticidad >= 0.74 & BDProyec_F$Cod_cultivo == 866 ,0.74,BDProyec_F$elasticidad)

View(filter(BDProyec_F,Cod_cultivo == 866))

#Elasticidades fijas usadas en año base. 
#BDProyec_F$elasticidad <- BDProyec_F$elasticidad_base
#BDProyec_F$elasticidad <- BDProyec_F$elasticidad_base*(lambda_elas*exp(-lambda_elas2*(BDProyec_F$Year-(2015-1)))/(lambda_elas*exp(-lambda_elas2*(2015-(2015-1)))))

ggplot(BDProyec_F, aes(x = Year, y = elasticidad )) +
  geom_line() + facet_wrap(~Cod_cultivo, ncol = 11 , scales = "free") + 
  labs(x = "Año",y ="elasticidad") + theme(legend.position="bottom")


BDProyec_F$tcons_mod <- BDProyec_F$t_pobl_dane+(BDProyec_F$elasticidad*(BDProyec_F$t_Pib_NDC-BDProyec_F$t_pobl_dane))
BDProyec_F <- BDProyec_F[with(BDProyec_F, order(Cod_cultivo, Year)),]

#Atar al consumo historico con elasticidad fija, y atar a consumo modelo con elasticidad modelo
BDProyec_F$con_proy <- ifelse(BDProyec_F$Year == 2014,BDProyec_F$ConsHist,NA)


BDProyec_F[2,]

for(i in 1:nrow(BDProyec_F)){
  BDProyec_F[i,"con_proy"] <- ifelse(is.na(BDProyec_F[i,"con_proy"])==FALSE,BDProyec_F[i,"con_proy"],
                                     BDProyec_F[(i-1),"con_proy"]*(BDProyec_F[i,"tcons_mod"]+1))
}


summary(BDProyec_F$con_proy)  
summary(BDProyec_F$con_proy-BDProyec_F$con_mod)  

BDProyec_F
filter(BDProyec_F,con_proy<0)


# Balanza Comercial -------------------------------------------------------

##Exportaciones importaciones#####
names(BDProyec_F)




#Opcion 1: Relacion promedio ultimos 10 años
Iinicial <- 2010
Ifinal <- 2020
opc1Bal <- cbind(aggregate(BDConsumoFinal[BDConsumoFinal[,"Year"]%in%c(Iinicial:Ifinal),"PorImpo"],
                           list(BDConsumoFinal[BDConsumoFinal[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"],
                                BDConsumoFinal[BDConsumoFinal[,"Year"]%in%c(Iinicial:Ifinal),"Item"]),mean,na.rm=TRUE),
                 aggregate(BDConsumoFinal[BDConsumoFinal[,"Year"]%in%c(Iinicial:Ifinal),"PorExpo"],
                           list(BDConsumoFinal[BDConsumoFinal[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"],
                                BDConsumoFinal[BDConsumoFinal[,"Year"]%in%c(Iinicial:Ifinal),"Item"]),mean,na.rm=TRUE)[3])


summary(opc1Bal)# NA para peas, green 417
colnames(opc1Bal) <- c("Cod_cultivo","Producto","PorImpo_1","PorExpo_1")
#Impo[is.na(Impo)]<-0
#summary(Impo$x)

boxplot(opc1Bal$PorImpo_1)
boxplot(opc1Bal$PorExpo_1)


AnoBase <- 2014
AnoProy <- 2050
BDBalCom <- merge(BDProyec_F,
                  opc1Bal, by.x=c("Cod_cultivo"), by.y=c("Cod_cultivo"),all.x= TRUE)

#agregar grupos gcam
#names(grupos)
#BDBalCom <- merge(BDBalCom,
 #                 grupos[,c("Code","Group_FAO","Group_FAO_Final","GCAM_Class" )], by.x=c("Cod_cultivo"), by.y=c("Code"),all.x= TRUE)

#summary(BDBalCom)
#names(BDBalCom)

#table(BDBalCom$tipo)   


#Opcion 2: modelo de regresión para cada relacion impo/cons y expo/cons




##Produccion####

#con_mod consumo de proyecciones modelos, con_proy: consumo elasticidad fija. 
#opcion1

#BDBalCom <- merge
#BDBalCom$cons_Final <- ifelse()

BDBalCom$Impo1 <- BDBalCom$con_proy * BDBalCom$PorImpo_1
BDBalCom$Expo1 <- BDBalCom$con_proy * BDBalCom$PorExpo_1
BDBalCom$Prod1 <- BDBalCom$con_proy - BDBalCom$Impo1 + BDBalCom$Expo1

BDBalCom$PorProd_1 <- BDBalCom$Prod1/BDBalCom$con_proy


#opcion2
#BDBalCom$Impo2 <- BDBalCom$ConsHist * BDBalCom$PorImpo_2
#BDBalCom$Expo2 <- BDBalCom$ConsHist * BDBalCom$PorExpo_2
#BDBalCom$Prod2 <- BDBalCom$ConsHist - BDBalCom$Impo2 + BDBalCom$Expo2

#BDBalCom$PorProd_1 <- BDBalCom$Prod1/BDBalCom$ConsHist


# Rendimientos ------------------------------------------------------------
#escenarios: 
  #nama ganaderia
  #plantaciones forestales
  #amtec arroz

names(BDCultdes)
BDCultdes <- BDCultdes[with(BDCultdes, order(Cod_cultivo, Year)),]
BDCultdes$tasa_rend <- growth_rate(BDCultdes$Rend_tha)

BDCultdes[,c("Year","Cod_cultivo","Rend_tha","tasa_rend")]

#cultivos

rendcult <- cbind(aggregate(BDCultdes[BDCultdes[,"Year"]%in%c(Iinicial:Ifinal),"Rend_tha"],
                           list(BDCultdes[BDCultdes[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"]),mean,na.rm=TRUE),
                  aggregate(BDCultdes[,"Rend_tha"],
                            list(BDCultdes[,"Cod_cultivo"]),mean,na.rm=TRUE)[2])
                 
colnames(rendcult) <- c("Cod_cultivo","Rend1","Rend2")
rendcult$tipo <- "Cultivos"
rendcult$TasaExtra <- NA
rendcult$P_A_canal <- NA
rendcult$P_A_vivo <- NA
rendcult$PesoVivo <- NA
rendcult$Factor_canal <- NA
rendcult$A_ha <- NA
#rendcult$A_haE2 <- NA
#rendcult$A_haE3 <- NA

#escenario base
rendcult$Rend <- ifelse(rendcult$Rend1 > 0,rendcult$Rend1,ifelse(rendcult$Rend2 > 0,rendcult$Rend2,0))

is.na(rendcult)<-sapply(rendcult, is.infinite)
rendcult[is.na(rendcult)]<-0

rendtasa <- cbind(aggregate(BDCultdes[BDCultdes[,"Year"]%in%c(Iinicial:Ifinal),"tasa_rend"],
                            list(BDCultdes[BDCultdes[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"]),mean,na.rm=TRUE),
                  aggregate(BDCultdes[,"tasa_rend"],
                            list(BDCultdes[,"Cod_cultivo"]),mean,na.rm=TRUE)[2])

colnames(rendtasa) <- c("Cod_cultivo","tasa","tasa2")
rendtasa$tasa_rend <- ifelse(rendtasa$tasa > 0,rendtasa$tasa,ifelse(rendtasa$tasa2 > 0,rendtasa$tasa2,0))

is.na(rendtasa)<-sapply(rendtasa, is.infinite)
rendtasa[is.na(rendtasa)]<-0


#Pecuario
names(BDP_GanSelect)
rendGan <- cbind(aggregate(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"TasaExtra"],
                           list(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"]),mean,na.rm=TRUE),
                 aggregate(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"rend_Animal_canal"],
                           list(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"]),mean,na.rm=TRUE)[2],
                 aggregate(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"rend_AnimalVivo"],
                           list(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"]),mean,na.rm=TRUE)[2],
                 aggregate(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"Pvivo"],
                           list(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"]),mean,na.rm=TRUE)[2],
                 aggregate(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"Factor_canal"],
                           list(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"]),mean,na.rm=TRUE)[2],
                 aggregate(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"A_ha"],
                           list(BDP_GanSelect[BDP_GanSelect[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"]),mean,na.rm=TRUE)[2])

colnames(rendGan) <- c("Cod_cultivo","TasaExtra","P_A_canal","P_A_vivo","PesoVivo","Factor_canal","A_ha")
rendGan$tipo <- "Ganaderia"
rendGan$Rend <- NA
#rendGan$Rend_E2 <- NA
#rendGan$Rend_E3 <- NA


aggregate(BDP_GanSelect[,"TasaExtra"],
          list(BDP_GanSelect[,"Cod_cultivo"]),mean,na.rm=TRUE)

names(rendcult)
names(rendGan)

rend <- rbind(rendcult[,c("Cod_cultivo","tipo","Rend","TasaExtra","P_A_canal","P_A_vivo","PesoVivo","Factor_canal","A_ha")],
              rendGan[,c("Cod_cultivo","tipo","Rend","TasaExtra","P_A_canal","P_A_vivo","PesoVivo","Factor_canal","A_ha")])

#ajustar tasa de extraccion ganaderia 
#2015	19,9, 2016	19,3, 2017	17,6, 2018	17,1, 2019	15,5 2020	14,4 Fuente Fedegan

rend[rend[,"Cod_cultivo"]==866,"TasaExtra"] <- (0.199+0.193+0.176+0.171+0.155+0.144)/6

#Ajustar escenarios



BDBalCom <- merge(BDBalCom,rend, by.x=c("Cod_cultivo"), by.y=c("Cod_cultivo"),all.x= TRUE)



# Area --------------------------------------------------------------------


levels(as.factor(BDBalCom$tipo))
names(BDBalCom)

#animales en produccion proyectados
unique(BDP_GanSelect[,c("Cod_cultivo","Item")])
BDBalCom$Animales_Prod1 <- ifelse(BDBalCom$tipo=="Ganaderia" ,BDBalCom$Prod1/BDBalCom$P_A_vivo,#se puede usar peso vivo constante de tabla excel
                                  NA)



#total animales

BDBalCom$Animales_Total <- ifelse(BDBalCom$tipo=="Ganaderia" ,BDBalCom$Animales_Prod1/BDBalCom$TasaExtra,NA)

aggregate(BDBalCom$Animales_Total,list(BDBalCom$Cod_cultivo),sum, na.rm=TRUE)

#ARea total

BDBalCom$AreaReq <- ifelse(BDBalCom$tipo=="Cultivos",BDBalCom$Prod1/BDBalCom$Rend,
                           ifelse(BDBalCom$tipo=="Ganaderia" & BDBalCom$Cod_cultivo %in% c(866,1016,1096,1034,976,1057,1140,882,1062,1182),BDBalCom$Animales_Total/BDBalCom$A_ha,
                                  NA))#Falta definir colmenas por hectarea

#BDBalCom$AreaReq_E2 <- ifelse(BDBalCom$tipo=="Cultivos",BDBalCom$Prod1/BDBalCom$Rend_E2,
 #                          ifelse(BDBalCom$tipo=="Ganaderia" & BDBalCom$Cod_cultivo %in% c(866,1016,1096,1034,976,1057,1140,882,1062,1182),BDBalCom$Animales_Total/BDBalCom$A_haE2,
  #                                NA))#Falta definir colmenas por hectarea

#BDBalCom$AreaReq_E3 <- ifelse(BDBalCom$tipo=="Cultivos",BDBalCom$Prod1/BDBalCom$Rend_E3,
 #                             ifelse(BDBalCom$tipo=="Ganaderia" & BDBalCom$Cod_cultivo %in% c(866,1016,1096,1034,976,1057,1140,882,1062,1182),BDBalCom$Animales_Total/BDBalCom$A_haE3,
  #                                   NA))#Falta definir colmenas por hectarea



#verificar rendimientos
summary(BDBalCom)
is.na(BDBalCom)<-sapply(BDBalCom, is.infinite)
BDBalCom[is.na(BDBalCom)]<-0

#todo valor de area requerida menor a cero (consumo decreciente) se vuelve area cero
BDBalCom[BDBalCom$AreaReq<0,"AreaReq"] <- 0
#BDBalCom[BDBalCom$AreaReq_E2<0,"AreaReq_E2"] <- 0
#BDBalCom[BDBalCom$AreaReq_E3<0,"AreaReq_E3"] <- 0


summary(BDBalCom$AreaReq)
aggregate(BDBalCom$AreaReq,list(BDBalCom$Year,BDBalCom$Cod_cultivo),sum, na.rm=TRUE)
aggregate(BDBalCom$AreaReq,list(BDBalCom$Year,BDBalCom$tipo),sum, na.rm=TRUE)

ggplot(BDBalCom, aes(x = Year, y = AreaReq)) + 
  geom_line() + facet_wrap(~varia, ncol = 11 , scales = "free")

#AJUSTAR DOBLE CONTABILIDAD DE LECHE Y CARNE, Y POLLO Y HUEVOS. 

names(BDBalCom)

#View(filter(BDBalCom,Cod_cultivo %in% c(882,866)))

#leche y carne
ggplot(filter(BDBalCom,Cod_cultivo %in% c(882,866)), aes(x = Year, y = Animales_Prod1, col=as.factor(Cod_cultivo))) + 
  geom_line() 


ggplot(filter(BDBalCom,Cod_cultivo %in% c(882,866)), aes(x = Year, y = Animales_Total, col=as.factor(Cod_cultivo))) + 
  geom_line() 

ggplot(filter(BDBalCom,Cod_cultivo %in% c(882,866)), aes(x = Year, y = AreaReq, col=as.factor(Cod_cultivo))) + 
  geom_line() 

#pollo y huevos
#leche y carne

ggplot(filter(BDBalCom,Cod_cultivo %in% c(1057,1062)), aes(x = Year, y = Animales_Prod1, col=as.factor(Cod_cultivo))) + 
  geom_line() 


ggplot(filter(BDBalCom,Cod_cultivo %in% c(1057,1062)), aes(x = Year, y = Animales_Total, col=as.factor(Cod_cultivo))) + 
  geom_line() 

ggplot(filter(BDBalCom,Cod_cultivo %in% c(1057,1062)), aes(x = Year, y = AreaReq, col=as.factor(Cod_cultivo))) + 
  geom_line() 


# Emisiones ---------------------------------------------------------------

#FIltro A LECHE Y CARNE, Y POLLO Y HUEVOS. 
names(BDBalCom)

BDBalComFinal <- filter(BDBalCom,!(Cod_cultivo %in% c(882)))#en graficos se observo menor leche y huevos por lo cual se excluyen

names(EmInten)
aggregate(EmInten$`Emissions (CO2eq)_gigagrams`,
          list(EmInten$Year),sum,na.rm=TRUE)

aggregate(EmInten[EmInten[,"Year"]%in%c(2010:2017),"Emissions (CO2eq)_gigagrams"],
          list(EmInten[EmInten[,"Year"]%in%c(2010:2017),"Year"],
               EmInten[EmInten[,"Year"]%in%c(2010:2017),"Cod_cultivo"]),sum,na.rm=TRUE)

Emisiones <- cbind(aggregate(EmInten[EmInten[,"Year"]%in%c(Iinicial:Ifinal),"Emissions (CO2eq)_gigagrams"],
                           list(EmInten[EmInten[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"]),mean,na.rm=TRUE),
                 aggregate(EmInten[EmInten[,"Year"]%in%c(Iinicial:Ifinal),"Emissions intensity_kg CO2eq/kg product"],
                           list(EmInten[EmInten[,"Year"]%in%c(Iinicial:Ifinal),"Cod_cultivo"]),mean,na.rm=TRUE)[2])

colnames(Emisiones) <- c("Cod_cultivo","E CO2eq_gigagrams","E kg CO2eq/kg prod")

BDBalCom <- merge(BDBalCom,Emisiones, by.x=c("Cod_cultivo"), by.y=c("Cod_cultivo"),all.x= TRUE)
aggregate(BDBalCom$`E CO2eq_gigagrams`,
          list(BDBalCom$Year,BDBalCom$tipo),sum,na.rm=TRUE)



BDBalComFinal <- merge(BDBalComFinal,Emisiones, by.x=c("Cod_cultivo"), by.y=c("Cod_cultivo"),all.x= TRUE)

summary(BDBalComFinal)

BDBalComFinal$est_emis <- ifelse(BDBalComFinal$Factor_canal > 0,
                                 (((BDBalComFinal$Prod1*BDBalComFinal$Factor_canal)*1000)*BDBalComFinal$`E kg CO2eq/kg prod`)/1000,
                                 (((BDBalComFinal$Prod1)*1000)*BDBalComFinal$`E kg CO2eq/kg prod`)/1000)

#BDBalComFinal$est_emis <- (((BDBalComFinal$Prod1*BDBalComFinal$Factor_canal)*1000)*BDBalComFinal$`E kg CO2eq/kg prod`)/1000

BDBalComFinal <- BDBalComFinal[with(BDBalComFinal, order(Cod_cultivo, Year)),]

ggplot(BDBalComFinal, aes(x = Year, y = est_emis)) + 
  geom_line() + facet_wrap(~tipo, ncol = 2 , scales = "free")


filter(BDBalComFinal,Cod_cultivo %in% c(1057,1062))

aggregate(BDBalComFinal$AreaReq,list(BDBalComFinal$Year,BDBalComFinal$tipo),sum,na.rm=TRUE)

aggregate(BDBalComFinal$est_emis,list(BDBalComFinal$Year,BDBalComFinal$tipo),sum,na.rm=TRUE)
aggregate(BDBalComFinal$Prod1,list(BDBalComFinal$Year,BDBalComFinal$tipo),sum,na.rm=TRUE)

#View(filter(BDBalComFinal,Cod_cultivo %in% c(866))[,c("Year","tipo","Prod1","Cod_cultivo","Animales_Prod1","Animales_Total","AreaReq","AreaReq_E2","AreaReq_E3","est_emis")])

#View(aggregate(EmInten$Production_tonnes,list(EmInten$Year,EmInten$Item),sum))

#Cultivos para el reporte
Reporte <- c(27,866,882,876,1016,1034,1057,1062)

# Plantaciones Comerciales#####

#factor emisiones segun ndc
10366000/600000

# Escenarios####
#variables: 
  #Consumo
  #Produccion
  #Impo
  #Expo
  #Area
  #Numero de animales


names(BDBalComFinal)
str(BDBalComFinal)
table(BDBalComFinal$tipo)

BDBalComFinal$Rend_E <- ifelse(BDBalComFinal$Year == 2014, BDBalComFinal$Rend,NA)
BDBalComFinal$A_ha_E <- ifelse(BDBalComFinal$Year == 2014, BDBalComFinal$A_ha,NA)


BDBalComFinal <- merge(BDBalComFinal,rendtasa[,c("Cod_cultivo","tasa_rend")], by.x=c("Cod_cultivo"), by.y=c("Cod_cultivo"),all.x= TRUE)


#para funcion 
  #rendimientos cultivos

BDBalComFinal$tasa_rend_E <- ifelse(BDBalComFinal$GCAM_Class == "Corn", BDBalComFinal$tasa_rend + 0.001,
                                    ifelse(BDBalComFinal$GCAM_Class == "FiberCrop", BDBalComFinal$tasa_rend + 0.001,
                                           ifelse(BDBalComFinal$GCAM_Class == "MiscCrop", BDBalComFinal$tasa_rend + 0.001,
                                                  ifelse(BDBalComFinal$GCAM_Class == "OilCrop", BDBalComFinal$tasa_rend + 0.001,
                                                         ifelse(BDBalComFinal$GCAM_Class == "OtherGrain", BDBalComFinal$tasa_rend + 0.001,
                                                                ifelse(BDBalComFinal$GCAM_Class == "PalmFruit", BDBalComFinal$tasa_rend + 0.001,
                                                                       ifelse(BDBalComFinal$GCAM_Class == "Rice", BDBalComFinal$tasa_rend + 0.001,
                                                                              ifelse(BDBalComFinal$GCAM_Class == "Root_Tuber", BDBalComFinal$tasa_rend + 0.001,
                                                                                     ifelse(BDBalComFinal$GCAM_Class == "SugarCrop", BDBalComFinal$tasa_rend + 0.001,
                                                                                            ifelse(BDBalComFinal$GCAM_Class == "Wheat", BDBalComFinal$tasa_rend + 0.001,NA))))))))))


BDBalComFinal <- BDBalComFinal[with(BDBalComFinal, order(Cod_cultivo, Year)),]

for(i in 1:nrow(BDBalComFinal)){
  BDBalComFinal[i,"Rend_E"] <- ifelse(is.na(BDBalComFinal[i,"Rend_E"])==FALSE,BDBalComFinal[i,"Rend_E"],
                                      BDBalComFinal[(i-1),"Rend_E"]*(BDBalComFinal[i,"tasa_rend_E"]+1))
}



  #rendimientos ganaderia



BDBalComFinal$A_ha_tasa <- ifelse(BDBalComFinal$GCAM_Class == "Beef", 0.001,
                                  ifelse(BDBalComFinal$GCAM_Class == "Honey",  0.001,
                                         ifelse(BDBalComFinal$GCAM_Class == "Other Meat",  0.001,
                                                ifelse(BDBalComFinal$GCAM_Class == "Pork",  0.001,
                                                       ifelse(BDBalComFinal$GCAM_Class == "Poultry", 0.001,
                                                              ifelse(BDBalComFinal$GCAM_Class == "SheepGoat",  0.001,NA))))))

BDBalComFinal <- BDBalComFinal[with(BDBalComFinal, order(Cod_cultivo, Year)),]


for(i in 1:nrow(BDBalComFinal)){
  BDBalComFinal[i,"A_ha_E"] <- ifelse(is.na(BDBalComFinal[i,"A_ha_E"])==FALSE,BDBalComFinal[i,"A_ha_E"],
                                      BDBalComFinal[(i-1),"A_ha_E"]*(BDBalComFinal[i,"tasa_rend_E"]+1))
}


#3A y 3C: Ganaderia

E3A_Gan <- filter(BDBalComFinal,tipo == "Ganaderia" & Cod_cultivo %in% c(866,946,976,1016,1126,1096,1034))[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq")]
E3A_Gan$Factor <- "animal"
E3A_Gan$lag_area <- lag(E3A_Gan$AreaReq)
E3A_Gan$Arean_nueva <- E3A_Gan$AreaReq - E3A_Gan$lag_area

E3A_Ave <- filter(BDBalComFinal,tipo == "Ganaderia" & Cod_cultivo %in% c(1057,1062))
E3A_AveF <- aggregate(E3A_Ave[,c("Prod1","Animales_Total","AreaReq")],list(E3A_Ave[,"Year"]),sum)
E3A_AveF$Factor <- "animal"
E3A_AveF$Cod_cultivo <- 1057
E3A_AveF$lag_area <- lag(E3A_AveF$AreaReq)
E3A_AveF$Arean_nueva <- E3A_AveF$AreaReq - E3A_AveF$lag_area
setnames(E3A_AveF,"Group.1","Year")

#E3A_Mulas <- filter(BDBalComFinal,tipo == "Ganaderia" & Cod_cultivo %in% c(1107,1110))
#E3A_MulasF <- aggregate(E3A_Mulas[,c("Prod1","Animales_Total","AreaReq")],list(E3A_Mulas[,"Year"]),sum)
#E3A_MulasF$Factor <- "animal"
#E3A_MulasF$Cod_cultivo <- 1107
#setnames(E3A_MulasF,"Group.1","Year")

E3A <- rbind(E3A_Gan[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq","lag_area","Arean_nueva","Factor")],
             E3A_AveF[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq","lag_area","Arean_nueva","Factor")])



#3B Cultivos
E3B_cult <- filter(BDBalComFinal,tipo == "Cultivos" )[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq")]
E3B_cultF <- aggregate(E3B_cult[,c("Prod1","Animales_Total","AreaReq")],list(E3B_cult[,"Year"]),sum)
E3B_cultF$Factor <- "area"
E3B_cultF$Cod_cultivo <- 1
E3B_cultF$lag_area <- lag(E3B_cultF$AreaReq)
E3B_cultF$Arean_nueva <- E3B_cultF$AreaReq - E3B_cultF$lag_area
setnames(E3B_cultF,"Group.1","Year")



#3B pastisales
E3B_Gan <- E3A_Gan
E3B_Gan$Factor <- "area"

#Nuevo incorporado
names(E3B_cultF)
EBbi <- cbind(filter(E3B_cultF,Cod_cultivo==1)[,c("Year","AreaReq","Arean_nueva")],filter(E3B_Gan,Cod_cultivo==866)[,c("AreaReq","Arean_nueva")])
colnames(EBbi) <- c("Year","AreaReq_cult","ANueva_Cult","AreaReq_Gan","ANueva_Gan")
EBbi$FronteraAgri <- EBbi$AreaReq_cult + EBbi$AreaReq_Gan


# 3B Forestal 1600
names(BDForestal)
BDForestal2 <- BDForestal
BDForestal2 <- BDForestal2[BDForestal2[,"Year"] %in% c(2014:2050),]
setnames(BDForestal2,"Profor2015","AreaReq")
BDForestal2$Factor <- "area"
BDForestal2$Cod_cultivo <- 1601
BDForestal2$lag_area <- lag(BDForestal2$AreaReq)
BDForestal2$Arean_nueva <- BDForestal2$AreaReq - BDForestal2$lag_area
BDForestal2$Prod1 <- NA
BDForestal2$Animales_Total <- NA

BDForestal_N <- BDForestal2[,c("Year","Cod_cultivo","Prod1","Animales_Total")]
BDForestal_N$AreaReq1 <- filter(Forest,Year==2020 & Item =="Forest land")[,"Area_1000 ha"]*1000# valor 2020 no mas deforestación

#Nuevo incorporado
BDForestal_N <- merge(BDForestal_N,EBbi, by.x=c("Year"), by.y=c("Year"),all.x= TRUE)
BDForestal_N$AreaReq <- ifelse(is.na(BDForestal_N$ANueva_Cult), BDForestal_N$AreaReq1,
                               ifelse(BDForestal_N$ANueva_Cult < 0 & BDForestal_N$ANueva_Gan > 0, BDForestal_N$AreaReq1  + (BDForestal_N$ANueva_Cult*-1),
                                      ifelse(BDForestal_N$ANueva_Cult > 0 & BDForestal_N$ANueva_Gan < 0, BDForestal_N$AreaReq1  + (BDForestal_N$ANueva_Gan*-1),
                                             ifelse(BDForestal_N$ANueva_Cult > 0 & BDForestal_N$ANueva_Gan > 0, BDForestal_N$AreaReq1,
                                                    ifelse(BDForestal_N$ANueva_Cult < 0 & BDForestal_N$ANueva_Gan < 0,
                                                           BDForestal_N$AreaReq1  + (BDForestal_N$ANueva_Cult*-1) + (BDForestal_N$ANueva_Gan*-1),0)))))




BDForestal_N$Factor <- "area"
BDForestal_N$Cod_cultivo <- 1600
BDForestal_N$lag_area <- lag(BDForestal_N$AreaReq)
BDForestal_N$Arean_nueva <- BDForestal_N$AreaReq - BDForestal_N$lag_area


E3B <- rbind(BDForestal2[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq","lag_area","Arean_nueva","Factor")],
             BDForestal_N[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq","lag_area","Arean_nueva","Factor")],
             E3B_cultF[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq","lag_area","Arean_nueva","Factor")],
             E3B_Gan[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq","lag_area","Arean_nueva","Factor")])



#3C
E3C_cult <- filter(BDBalComFinal,tipo == "Cultivos" & !(Cod_cultivo %in% c(27)))[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq")]
E3C_cultF <- aggregate(E3C_cult[,c("Prod1","Animales_Total","AreaReq")],list(E3C_cult[,"Year"]),sum)
E3C_cultF$Factor <- "area"
E3C_cultF$Cod_cultivo <- 2
E3C_cultF$lag_area <- lag(E3C_cultF$AreaReq)
E3C_cultF$Arean_nueva <- E3C_cultF$AreaReq - E3C_cultF$lag_area
setnames(E3C_cultF,"Group.1","Year")


E3C_arroz <- filter(BDBalComFinal,tipo == "Cultivos" & Cod_cultivo %in% c(27))[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq")]
E3C_arroz$Factor <- "area"
E3C_arroz$lag_area <- lag(E3C_arroz$AreaReq)
E3C_arroz$Arean_nueva <- E3C_arroz$AreaReq - E3C_arroz$lag_area

E3C <- rbind(E3C_cultF[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq","lag_area","Arean_nueva","Factor")],
             E3C_arroz[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq","lag_area","Arean_nueva","Factor")])


#agregar todas las bases

EBD <- rbind(E3A[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq","lag_area","Arean_nueva","Factor")],
             E3B[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq","lag_area","Arean_nueva","Factor")],
             E3C[,c("Cod_cultivo","Year","Prod1","Animales_Total","AreaReq","lag_area","Arean_nueva","Factor")])



#unir emisiones
names(BurEm)
BurEm[,c("Factor","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")]

Final_emi <- merge(EBD,
                   BurEm[,c("Factor","Cod_cultivo","Modulo","Cat","subcat","Item","tipo","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")],
                   by=NULL)

names(Final_emi)

#Nueva incorporado
Final_emi <- merge(Final_emi,
                   EBbi[,c("Year","ANueva_Cult","ANueva_Gan")], by.x=c("Year"), by.y=c("Year"),all.x= TRUE)


#3B1b Tierras convertidas en tierras forestales: Entran las liberaciones de cultivos y gananderia
#3B2bi Tierras forestales convertidas en tierras de cultivo: si son negativas no hacer nada en la categoria
#3B3bi Tierras forestales convertidas en pastizales: si son negativas no hacer nada en la categoria
#3B1ai Tierras forestales que permanecen (Bosque natural): si cultivos y ganaderia liberan sumar para el siguiente año (viene de la base de bosque natural)


Final_emi$select <- ifelse(Final_emi$Factor.x == Final_emi$Factor.y & Final_emi$Cod_cultivo.x == Final_emi$Cod_cultivo.y,
                           1,0)

setnames(Final_emi,"Factor.x","Factor")

names(Final_emi)


#nuevo
Final_emi$AreaReq_3B1b <- ifelse(Final_emi$ANueva_Cult < 0 & Final_emi$ANueva_Gan > 0, (Final_emi$ANueva_Cult*-1),
                                        ifelse(Final_emi$ANueva_Cult > 0 & Final_emi$ANueva_Gan < 0, (Final_emi$ANueva_Gan*-1),
                                               ifelse(Final_emi$ANueva_Cult < 0 & Final_emi$ANueva_Gan < 0,
                                                      (Final_emi$ANueva_Cult*-1) + (Final_emi$ANueva_Gan*-1),0)))
                                                      

Final_emi$abs_CO2 <- ifelse(Final_emi$Factor=="animal",Final_emi$F_abs_CO2*Final_emi$Animales_Total,
                            ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales"),
                                   Final_emi$F_abs_CO2*Final_emi$AreaReq_3B1b,
                                   ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales") & Final_emi$Arean_nueva > 0,
                                          Final_emi$F_abs_CO2*Final_emi$Arean_nueva,
                                          ifelse(Final_emi$Factor=="area" & !(Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales","3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales")),
                                                 Final_emi$F_abs_CO2*Final_emi$AreaReq,0))))



Final_emi$Em_CO2 <- ifelse(Final_emi$Factor=="animal",Final_emi$F_Em_CO2*Final_emi$Animales_Total,
                           ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales"),
                                  Final_emi$F_Em_CO2*Final_emi$AreaReq_3B1b,
                                  ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales") & Final_emi$Arean_nueva > 0,
                                         Final_emi$F_Em_CO2*Final_emi$Arean_nueva,
                                         ifelse(Final_emi$Factor=="area" & !(Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales","3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales")),
                                                Final_emi$F_Em_CO2*Final_emi$AreaReq,0))))

Final_emi$Em_CH4 <- ifelse(Final_emi$Factor=="animal",Final_emi$F_Em_CH4*Final_emi$Animales_Total,
                           ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales"),
                                  Final_emi$F_Em_CH4*Final_emi$AreaReq_3B1b,
                                  ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales") & Final_emi$Arean_nueva > 0,
                                         Final_emi$F_Em_CH4*Final_emi$Arean_nueva,
                                         ifelse(Final_emi$Factor=="area" & !(Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales","3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales")),
                                                Final_emi$F_Em_CH4*Final_emi$AreaReq,0))))

Final_emi$Em_N2O <- ifelse(Final_emi$Factor=="animal",Final_emi$F_Em_N2O*Final_emi$Animales_Total,
                           ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales"),
                                  Final_emi$F_Em_N2O*Final_emi$AreaReq_3B1b,
                                  ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales") & Final_emi$Arean_nueva > 0,
                                         Final_emi$F_Em_N2O*Final_emi$Arean_nueva,
                                         ifelse(Final_emi$Factor=="area" & !(Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales","3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales")),
                                                Final_emi$F_Em_N2O*Final_emi$AreaReq,0))))

Final_emi$Em_NOX <- ifelse(Final_emi$Factor=="animal",Final_emi$F_Em_NOX*Final_emi$Animales_Total,
                           ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales"),
                                  Final_emi$F_Em_NOX*Final_emi$AreaReq_3B1b,
                                  ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales") & Final_emi$Arean_nueva > 0,
                                         Final_emi$F_Em_NOX*Final_emi$Arean_nueva,
                                         ifelse(Final_emi$Factor=="area" & !(Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales","3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales")),
                                                Final_emi$F_Em_NOX*Final_emi$AreaReq,0))))


Final_emi$Em_CO <- ifelse(Final_emi$Factor=="animal",Final_emi$F_Em_CO*Final_emi$Animales_Total,
                          ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales"),
                                 Final_emi$F_Em_CO*Final_emi$AreaReq_3B1b,
                                 ifelse(Final_emi$Factor=="area" & Final_emi$Item %in% c("3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales") & Final_emi$Arean_nueva > 0,
                                        Final_emi$F_Em_CO*Final_emi$Arean_nueva,
                                        ifelse(Final_emi$Factor=="area" & !(Final_emi$Item %in% c("3B1b Tierras convertidas en tierras forestales","3B2bi Tierras forestales convertidas en tierras de cultivo","3B3bi Tierras forestales convertidas en pastizales")),
                                               Final_emi$F_Em_CO*Final_emi$AreaReq,0))))


Final_emi$Em_totales <- rowSums(Final_emi[,c("Em_CO2","Em_CH4","Em_N2O","Em_NOX","Em_CO")],na.rm = TRUE)

Final_emi$Em_netas <- rowSums(Final_emi[,c("abs_CO2","Em_CO2","Em_CH4","Em_N2O","Em_NOX","Em_CO")],na.rm = TRUE)





# LOG ---------------------------------------------------------------------

# Any descriptives that will be helpful to understand the results of this
# script and how it contributes to the aims of the project

# CLEAN UP ----------------------------------------------------------------

# Remove all current environment variables
#rm(list = ls())
