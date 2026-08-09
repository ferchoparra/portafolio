
# ABOUT -------------------------------------------------------------------

# Descripción: <El objetivo de este archivo es consolidar las bases de datos,
# cruces etc, para posteriormente aplicar los modelos
# Usage: <Se necesitan cargar las bases generadas en el script acquire_data.R, 
# se produce una base consolidada para realizar el análisis
# Autor: <Luis Parra>
# Date: <2021 Febrero 26>

# SETUP -------------------------------------------------------------------

# Script-specific options or packages
#manejo de datos
library(data.table)
library(sqldf)
library(dplyr)
library(pryr)

library(smooth)

#graficos
library(ggplot2)
#library(ggpubr)

#insertSource("functions/functions.R", functions="growth_rate") 
source("functions/functions.R")
#install.packages("ggpubr", dependencies = TRUE)


#in_data <- readLines(file("stdin"),1)

# RUN ---------------------------------------------------------------------

# Steps involved in curating and organizing the data

# 


#colocar variables (elementos) en columnas



# Factores ----------------------------------------------------------------
#PREGUNTA: algunos factores de extracción son mayores a 100 %, supuestamente porque se agregan otras productos. 

names(Factores)
summary(Factores)
Factores$Ext_rate_FAO_L1[is.na(Factores$Ext_rate_FAO_L1)] <- 1 
Factores$Ext_rate_FAO_L2[is.na(Factores$Ext_rate_FAO_L2)] <- 1 
Factores$Ext_rate_FAO_L3[is.na(Factores$Ext_rate_FAO_L3)] <- 1 

Factores$Ext_rate <- Factores$Ext_rate_FAO_L1 * Factores$Ext_rate_FAO_L2 * Factores$Ext_rate_FAO_L3

summary(Factores$Ext_rate)
aggregate(Factores$Ext_rate,list(Factores$Cod_cultivo),summary)

# PRODUCCION ---------------------------------------------------------

##Cultivos####
names(BDCult)
levels(BDCult$Element)

BDCultdes <- reshape2::dcast(BDCult, Item.Code + Item + Year  ~ Element + Unit, fun.aggregate = sum, value.var=c("Value"))

levels(BDComCultGan$Element)

BDCultdes <- merge(BDCultdes,Factores[,c("Item.code","Producto","Cod_cultivo","Share","Ext_rate" )], by.x=c("Item.Code"), by.y=c("Item.code"),all.x= TRUE)
summary(BDCultdes$Ext_rate)#como se esperaba todos tienen factor uno ya que es el cultivo inicial

BDCultdes$Rend_tha <- BDCultdes$`Yield_hg/ha`/10000
BDCultdes$Rend_kgha <- BDCultdes$`Yield_hg/ha`/10

summary(BDCultdes)
  # 924 registros no tienen valor de produccion
  # 979 registros no tienen valor de area cosechada. 

BDCultdes$Production_tonnes[is.na(BDCultdes$Production_tonnes)] <- 0

aggregate(BDCultdes$Rend_tha,list(BDCultdes$Item),summary)#

names(BDCultdes)

sum(BDCultdes$`Area harvested_ha`,na.rm = TRUE)
aggregate(BDCultdes$`Area harvested_ha`,list(BDCultdes$Year),sum,na.rm=TRUE)

###base final####
BDCultdes$Prod_factor <- BDCultdes$Production_tonnes # para unificar con ganaderia
BDCultdes



##Ganaderia####

names(BDGanPri)
levels(BDGanPri$Element)
levels(BDGanPri$Item)

BDGanPrides <- reshape2::dcast(BDGanPri, Item.Code + Item + Year  ~ Element + Unit, fun.aggregate = sum, value.var=c("Value"))
names(BDGanPrides)
summary(BDGanPrides)
str(BDGanPrides)

BDGanPrides <- merge(BDGanPrides,Factores[,c("Item.code","Producto","Cod_cultivo","Share","Ext_rate" )], by.x=c("Item.Code"), by.y=c("Item.code"),all.x= TRUE)

#se lleva todo los productos a producto original para carne en pie
BDGanPrides$Prod_factor <- BDGanPrides$Production_tonnes * (1/BDGanPrides$Ext_rate)


#Análisis share 
levels(as.factor((BDGanPrides$Share)))
table(BDGanPrides$Share, BDGanPrides$Year)
table(BDGanPrides$Share)
#BDGanPrides$share_year <- paste(BDGanPrides$Year,BDGanPrides$Share,sep="_")
#table(BDGanPrides$share_year)


ggplot(filter(BDGanPrides,Share %in% c("0866_1","0976_1","1016_1","1034_1","1057_1","1096_1")), aes(x = Year, y = Prod_factor, color=Item)) + 
  geom_line() + facet_wrap(~Share, ncol = 3)



#Ganado bobino (1.5 millones t aumento)
ggplot(filter(BDGanPrides,Share %in% c("0866_1")), aes(x = Year, y = Prod_factor, color=Item)) + 
  geom_line()

    #Problemas con valores como despojos de carne, son superiores a la carne. 

#Oveja (alrededor de 10 mil t, en desenso)
ggplot(filter(BDGanPrides,Share %in% c("0976_1")), aes(x = Year, y = Prod_factor, color=Item)) + 
  geom_line()

#Caprinos (12 mil t en aumento)
ggplot(filter(BDGanPrides,Share %in% c("1016_1")), aes(x = Year, y = Prod_factor, color=Item)) + 
  geom_line()

#Cerdo (500 mil t en aumento)
ggplot(filter(BDGanPrides,Share %in% c("1034_1")), aes(x = Year, y = Prod_factor, color=Item)) + 
  geom_line()

ggplot(filter(BDGanPrides,Share %in% c("1034_1")), aes(x = Year, y = Prod_factor, color=Item)) + 
  geom_line() + facet_wrap(~Item, ncol = 3)

#Chicken (5 millones t en aumento)
ggplot(filter(BDGanPrides,Share %in% c("1057_1")), aes(x = Year, y = Prod_factor, color=Item)) + 
  geom_line()

ggplot(filter(BDGanPrides,Share %in% c("1057_1")), aes(x = Year, y = Production_tonnes, color=Item)) + 
  geom_line()

ggplot(filter(BDGanPrides,Share %in% c("1057_1")), aes(x = Year, y = Production_tonnes/(1.926/1000), color=Item)) + 
  geom_line()

#Caballo (12 mil t desenso)
ggplot(filter(BDGanPrides,Share %in% c("1096_1")), aes(x = Year, y = Prod_factor, color=Item)) + 
  geom_line()

#filtro: todos los que no son share ("0") se mantienen, los pecuarios share se 
# mantiene la producción de carne ("Meat") sus share que se asumen menores no se tienen en cuenta
BDGanPrides$Select <- ifelse(BDGanPrides$Share=="0",1,
                             ifelse(BDGanPrides$Item.Code %in% c(867,977,1017,1035,1058,1097),1,0))


BDP_GanSelect <- filter(BDGanPrides, BDGanPrides$Select==1)
levels(as.factor(BDGanPrides$Item))
levels(droplevels(as.factor(BDP_GanSelect$Item)))
levels(droplevels(as.factor(BDP_GanSelect$Item)))
BDP_GanSelect$Item <- droplevels(as.factor(BDP_GanSelect$Item))

summary(BDP_GanSelect)
  # 6 registros son miel natural (no tiene producción por tonelada)
BDP_GanSelect[which(is.na(BDP_GanSelect$Prod_factor)),]

ggplot(BDP_GanSelect, aes(x = Year, y = Prod_factor)) + 
  geom_line() + facet_wrap(~Item, ncol = 5)


####Rendimientos#####

names(BDP_GanSelect)
summary(BDP_GanSelect)
table(BDP_GanSelect$Item.Code)
table(BDP_GanSelect$Item)

#####Sacrificio#####

#animales sacrificados o animales en produccion leche
#Milk Animals_Head, Prod Popultn_No, #"Producing Animals/Slaughtered_1000 Head","Producing Animals/Slaughtered_Head"
aggregate(BDP_GanSelect$`Milk Animals_Head`,list(BDP_GanSelect$Item),summary)#solo leche
aggregate(BDP_GanSelect$`Prod Popultn_No`,list(BDP_GanSelect$Item),summary)#solo para Honey, natural y beeswax
aggregate(BDP_GanSelect$`Producing Animals/Slaughtered_1000 Head`,list(BDP_GanSelect$Item),summary)#chicken y rabit
aggregate(BDP_GanSelect$`Producing Animals/Slaughtered_Head`,list(BDP_GanSelect$Item),summary)#cattle, goat, horse, pig, sheep
aggregate(BDP_GanSelect$`Laying_1000 Head`,list(BDP_GanSelect$Item),summary)#egg hen shell
unique(BDP_GanSelect[,c("Cod_cultivo","Item")])

#animales a sacrificio, animales en lactancia, numero de poblacion en produccion y gallinas ponedoras. 
BDP_GanSelect$Animal_Prod <- ifelse(BDP_GanSelect$Cod_cultivo %in% c(866,1016,1096,1034,976),BDP_GanSelect$`Producing Animals/Slaughtered_Head`,
                                   ifelse(BDP_GanSelect$Cod_cultivo %in% c(1057,1140),BDP_GanSelect$`Producing Animals/Slaughtered_1000 Head`*1000,
                                          ifelse(BDP_GanSelect$Cod_cultivo %in% c(882),BDP_GanSelect$`Milk Animals_Head`,
                                                 ifelse(BDP_GanSelect$Cod_cultivo %in% c(1182,1183),BDP_GanSelect$`Prod Popultn_No`,
                                                        ifelse(BDP_GanSelect$Cod_cultivo %in% c(1062),BDP_GanSelect$`Laying_1000 Head`*1000,0)))))

aggregate(BDP_GanSelect$Animal_Prod,list(BDP_GanSelect$Item),summary)

#####tasa de extraccion ####
names(BDGanExis)
levels(as.factor(BDGanExis$Item))
BDGanExis_des <- reshape2::dcast(BDGanExis, Item.Code + Item + Year  ~ Element + Unit, fun.aggregate = sum, value.var=c("Value"))
names(BDGanExis_des)
summary(BDGanExis_des)
aggregate(BDGanExis_des$Stocks_No,list(BDGanExis_des$Item),summary)#solo para Honey, natural
aggregate(BDGanExis_des$`Stocks_1000 Head`,list(BDGanExis_des$Item),summary)#chicken, rabbit
aggregate(BDGanExis_des$Stocks_Head,list(BDGanExis_des$Item),summary)#resto carne. 

aggregate(BDGanExis_des$`Stocks_1000 Head`,list(BDGanExis_des$Year,BDGanExis_des$Item),sum)

#existencias en total de animales y para colmenas total de colmenas. 
BDGanExis_des$Existencias <- ifelse(BDGanExis_des$Item.Code %in% c(1107,946,866,1016,1096,1110,1034,976),BDGanExis_des$Stocks_Head,
                                    ifelse(BDGanExis_des$Item.Code %in% c(1057,1140),BDGanExis_des$`Stocks_1000 Head`*1000,BDGanExis_des$Stocks_No))

levels(as.factor(BDGanExis_des$Item.Code))
unique(BDGanExis_des[,c("Item.Code","Item")])
unique(BDP_GanSelect[,c("Cod_cultivo","Item")])

filter(BDGanExis_des,Item.Code %in% c(1057))[,c("Year", "Existencias")]


table(BDP_GanSelect$Cod_cultivo)
names(BDP_GanSelect)
names(BDGanExis_des)

#Se agrega la serie de existencias o inventario
BDP_GanSelect <- merge(BDP_GanSelect,BDGanExis_des[,c("Item.Code","Year","Existencias")], by.x=c("Year","Cod_cultivo"), by.y=c("Year","Item.Code"),all.x= TRUE)

#Existencias de leche se agrega el valor de ganado
BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==882,"Existencias"] <- BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==866,"Existencias"]

#Existencias pollo y huevos: suma de animal sacrificado y ponedoreas
#opcion 1 hacer como leche y carne 
#BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1062,"Existencias"] <- BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1062,"Animal_Prod"] + BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1057,"Animal_Prod"]
#BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1057,"Existencias"] <- BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1062,"Animal_Prod"] + BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1057,"Animal_Prod"]

#opcion 2 tomar por separado  
BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1062,"Existencias"] <- BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1062,"Animal_Prod"] 
BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1057,"Existencias"] <- BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1057,"Animal_Prod"]



#Existencias conejos: datos existencias alrededor de 500 mil animales, se asume que todo conejo es sacrificado osea 2.5 millones (tomado de produccion animal)
BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1140,"Existencias"] <- BDP_GanSelect[BDP_GanSelect[,"Cod_cultivo"]==1140,"Animal_Prod"] 


ggplot(filter(BDP_GanSelect,Cod_cultivo %in% c(882,866)), aes(x = Year, y = Existencias,col=Item)) + 
  geom_line() 

ggplot(filter(BDP_GanSelect,Cod_cultivo %in% c(1062,1057)), aes(x = Year, y = Existencias,col=Item)) + 
  geom_line() 


BDP_GanSelect$TasaExtra <- BDP_GanSelect$Animal_Prod / BDP_GanSelect$Existencias

aggregate(BDP_GanSelect$TasaExtra,list(BDP_GanSelect$Item),summary)

ggplot(BDP_GanSelect, aes(x = Year, y = Existencias,col=Item)) + 
  geom_line(aes(x = Year, y = Existencias,colour="Existencias")) + 
  geom_line(aes(x = Year, y = Animal_Prod,colour="Animales Prod")) +
  facet_wrap(~Item, scales ="free")

ggplot(BDP_GanSelect, aes(x = Year, y = Existencias,col=Item)) + 
  geom_line(aes(x = Year, y = Existencias,colour="Existencias")) + 
  facet_wrap(~Item, scales ="free")

ggplot(BDP_GanSelect, aes(x = Year, y = TasaExtra,col=Item)) + 
  geom_line() + 
  facet_wrap(~Item, scales ="free")
  
ggplot(BDP_GanSelect, aes(x = Year, y = Prod_factor/(1.8/1000),col=Item)) + 
  geom_line() + 
  facet_wrap(~Item, scales ="free")


ggplot(filter(BDP_GanSelect,Cod_cultivo %in% c(882,866)), aes(x = Year, y = Existencias,col=Item)) + 
  geom_line() 

filter(BDP_GanSelect,Cod_cultivo %in% c(1062,1057))[,c("Year","Animal_Prod", "Existencias")]

filter(BDP_GanSelect,Cod_cultivo %in% c(1140))[,c("Year","Animal_Prod", "Existencias")]

summary(BDP_GanSelect$TasaExtra)

#####Rendimiento####

#rendimiento animales con peso vivo por ha
#valor estimado 20386204 ha en ganaderia se necesita un rendimiento de 1.1 A/ha mas o menos
ggplot(filter(BDP_GanSelect,Cod_cultivo %in% c(866)), aes(x = Year, y = Existencias/1.1,col=Item)) + 
  geom_line() 

animals_ha <- filter(BDP_GanSelect,Cod_cultivo %in% c(866))[,c("Year","Existencias")]
animals_ha$Area <- animals_ha$Existencias/1.1

names(InfGanViva)
names(BDP_GanSelect)
BDP_GanSelect <- merge(BDP_GanSelect,InfGanViva[,c("Item.Code","A_ha","A_ha_E2","A_ha_E3","Pvivo","Factor_canal")], by.x=c("Cod_cultivo"), by.y=c("Item.Code"),all.x= TRUE)


unique(BDP_GanSelect[,c("Cod_cultivo","Item")])
#rendimiento peso canal. leche animal, 100 mg animal huevo
aggregate(BDP_GanSelect$`Yield/Carcass Weight_hg/An`,list(BDP_GanSelect$Item),summary)#cattle, goat, horse, pig, sheep
aggregate(BDP_GanSelect$`Yield/Carcass Weight_0.1g/An`,list(BDP_GanSelect$Item),summary)#chicken y rabit
aggregate(BDP_GanSelect$`Yield_hg/An`,list(BDP_GanSelect$Item),summary)#solo leche
aggregate(BDP_GanSelect$Yield_hg,list(BDP_GanSelect$Item),summary)#honey natural, rendimiento por colmena. 
aggregate((BDP_GanSelect$Yield_hg)*0.0001,list(BDP_GanSelect$Item),summary)
aggregate((BDP_GanSelect$Production_tonnes/BDP_GanSelect$`Prod Popultn_No`),list(BDP_GanSelect$Item),summary)
aggregate(BDP_GanSelect$`Yield_100mg/An`,list(BDP_GanSelect$Item),summary)#egg hen shell


aggregate((BDP_GanSelect$Production_tonnes/BDP_GanSelect$`Prod Popultn_No`)-(BDP_GanSelect$Yield_hg)*0.0001,list(BDP_GanSelect$Item),summary)

#toneladas/animal canal
BDP_GanSelect$rend_Animal_canal <- ifelse(BDP_GanSelect$Cod_cultivo %in% c(866,1016,1096,1034,976),BDP_GanSelect$`Yield/Carcass Weight_hg/An`*0.0001,
                                    ifelse(BDP_GanSelect$Cod_cultivo %in% c(1057,1140),BDP_GanSelect$`Yield/Carcass Weight_0.1g/An`*1e-7,
                                           ifelse(BDP_GanSelect$Cod_cultivo %in% c(882),BDP_GanSelect$`Yield_hg/An`*0.0001,
                                                  ifelse(BDP_GanSelect$Cod_cultivo %in% c(1182,1183),BDP_GanSelect$Yield_hg*0.0001,
                                                         ifelse(BDP_GanSelect$Cod_cultivo %in% c(1062),BDP_GanSelect$`Yield_100mg/An`*1e-7,0)))))

aggregate(BDP_GanSelect$rend_Animal_canal,list(BDP_GanSelect$Item),summary)

#toneladas/animal canal, t leche animal, t miel panal, t huevo gallina ponedora. 
BDP_GanSelect$rend_AnimalVivo <- ifelse(BDP_GanSelect$Cod_cultivo %in% c(866,1016,1096,1034,976,1057,1140),BDP_GanSelect$rend_Animal_canal/BDP_GanSelect$Factor_canal,BDP_GanSelect$rend_Animal_canal)

aggregate(BDP_GanSelect$rend_AnimalVivo,list(BDP_GanSelect$Item),summary)




###base final####


#unir produccion
names(BDCultdes)
names(BDP_GanSelect)

BDProduccion <- rbind(BDCultdes[,c("Cod_cultivo","Item","Year","Prod_factor")],
                   BDP_GanSelect[,c("Cod_cultivo","Item","Year","Prod_factor")])

BDCultdes$Existencias <- NA
BDP_GanSelect$`Area harvested_ha` <- NA

BDProd_FactorEm <- rbind(BDCultdes[,c("Cod_cultivo","Item","Year","Prod_factor","Area harvested_ha","Existencias")],
                      BDP_GanSelect[,c("Cod_cultivo","Item","Year","Prod_factor","Area harvested_ha","Existencias")])

BDProd_FactorEm <- filter(BDProd_FactorEm,Year==2014)

# COMERCIO ----------------------------------------------------------

## Cultivos y Ganaderia####

levels(BDComCultGan$Element)
levels(BDComCultGan$Item)

BDComCultGandes <- reshape2::dcast(BDComCultGan, Item.Code + Item + Year  ~ Element  + Unit, fun.aggregate = sum, value.var=c("Value"))
names(BDComCultGandes)

summary(BDComCultGandes)


## Ganaderia vivos ####
levels(BDComGanVivos$Element)
levels(BDComGanVivos$Item)
levels(as.factor(BDComGanVivos$Item.Code))

BDComGanVivosdes <- reshape2::dcast(BDComGanVivos, Item.Code + Item + Year  ~ Element + Unit , fun.aggregate = sum, value.var=c("Value"))
names(BDComGanVivosdes)

BDComGanVivosdes$`Export Quantity_Head`[is.na(BDComGanVivosdes$`Export Quantity_Head`)] <- 0
BDComGanVivosdes$`Import Quantity_Head`[is.na(BDComGanVivosdes$`Import Quantity_Head`)] <- 0

#llevar a toneladas de animales vivos

levels(BDComGanVivos$Item)
levels(as.factor(BDComGanVivos$Item.Code))
names(BDComGanVivosdes)
names(InfGanViva)
summary(BDComGanVivosdes)

BDComGanVivosdes <- merge(BDComGanVivosdes,InfGanViva[,c("Item.Code","Pvivo")], by.x=c("Item.Code"), by.y=c("Item.Code"),all.x= TRUE)

BDComGanVivosdes$`Import Quantity_tonnes` <- ifelse(BDComGanVivosdes$`Import Quantity_Head`>0,
                                                    BDComGanVivosdes$`Import Quantity_Head`*(BDComGanVivosdes$Pvivo/1000),#esta en kg se lleva a t
                                                    BDComGanVivosdes$`Import Quantity_1000 Head`*(BDComGanVivosdes$Pvivo/1000))

BDComGanVivosdes$`Export Quantity_tonnes` <- ifelse(BDComGanVivosdes$`Export Quantity_Head`>0,
                                                    BDComGanVivosdes$`Export Quantity_Head`*(BDComGanVivosdes$Pvivo/1000),
                                                    BDComGanVivosdes$`Export Quantity_1000 Head`*(BDComGanVivosdes$Pvivo/1000))
summary(BDComGanVivosdes)

###base final####
names(BDComCultGandes)
names(BDComGanVivosdes)


BDComercio <- rbind(BDComCultGandes[,c("Item.Code","Item","Year","Export Quantity_tonnes","Import Quantity_tonnes")],
                    BDComGanVivosdes[,c("Item.Code","Item","Year","Export Quantity_tonnes","Import Quantity_tonnes")])

#unir cod_cultivo y su factor de extracción para llevar a toneladas de cultivo primario. 
BDComercio <- merge(BDComercio,Factores[,c("Item.code","Producto","Cod_cultivo","Share","Ext_rate" )], by.x=c("Item.Code"), by.y=c("Item.code"),all.x= TRUE)

names(BDComercio)
summary(BDComercio)
levels(as.factor(BDComercio$Share))

BDComercio[is.na(BDComercio)] <- 0

#impor y expo en terminos de toneladas por cultivo primario
BDComercio$Impo_Factor <- BDComercio$`Import Quantity` * (1/BDComercio$Ext_rate)
BDComercio$Expo_Factor <- BDComercio$`Export Quantity` * (1/BDComercio$Ext_rate)



#unir segun share y e agrupa por el codigo del cultivo primario (con suma)##
table(BDComercio$Share)
BDComercio_0 <- filter(BDComercio, Share == 0)
BDComercio_share <- filter(BDComercio, Share != 0)


BDComercioAgru <- rbind(aggregate(BDComercio_0[,c("Impo_Factor","Expo_Factor")],list(BDComercio_0$Year, BDComercio_0$Cod_cultivo),sum),
                        aggregate(BDComercio_share[,c("Impo_Factor","Expo_Factor")],list(BDComercio_share$Year, BDComercio_share$Cod_cultivo),max))
setnames(BDComercioAgru,c("Group.1","Group.2"),c("Year","Cod_cultivo"))



BDComercioAgru3 <- aggregate(BDComercioAgru[,c("Impo_Factor","Expo_Factor")],list(BDComercioAgru$Year, BDComercioAgru$Cod_cultivo),sum)
setnames(BDComercioAgru3,c("Group.1","Group.2"),c("Year","Cod_cultivo"))

#comparacion sin tener en cuenta share
BDComercioAgru2 <- aggregate(BDComercio[,c("Impo_Factor","Expo_Factor")],list(BDComercio$Year, BDComercio$Cod_cultivo),sum)
setnames(BDComercioAgru2,c("Group.1","Group.2"),c("Year","Cod_cultivo"))

levels(droplevels(as.factor(BDComercioAgru$cod_cultivo)))
levels(droplevels(as.factor(BDComercioAgru2$cod_cultivo)))



# Unificar base total -----------------------------------------------------
names(BDProduccion)
names(BDComercioAgru3)

#no se incluye area ni rendimientos por ahora, mientras se define rendimientos para ganaderia


BDConsumo <- merge(BDProduccion,BDComercioAgru3, by.x=c("Year","Cod_cultivo"), by.y=c("Year","Cod_cultivo"),all.x= TRUE)
summary(BDConsumo)
BDConsumo[is.na(BDConsumo)]<-0


summary(BDConsumo$Prod_factor-BDConsumo$Expo_Factor)
boxplot(BDConsumo$Prod_factor-BDConsumo$Expo_Factor)$stats
length(which(BDConsumo$Prod_factor-BDConsumo$Expo_Factor < 0))
      #306 registros su expo fue mayor a su produccion lo cual no es posible
      # 3 de estos no reportaban produccion por lo cual su expo se llevo a cero. 


BDConsumo$Expo_Factor2 <- ifelse(BDConsumo$Prod_factor-BDConsumo$Expo_Factor < 0,
                                 BDConsumo$Prod_factor, BDConsumo$Expo_Factor)


plot(BDConsumo$Expo_Factor,BDConsumo$Expo_Factor2)
abline(c(1,1))

plot(BDConsumo$Prod_factor,BDConsumo$Expo_Factor2)
abline(c(1,1))

plot(BDConsumo$Prod_factor,BDConsumo$Expo_Factor)
abline(c(1,1))

length(which(BDConsumo$Prod_factor-BDConsumo$Expo_Factor2 < 0))


BDConsumo$ConsA <- BDConsumo$Prod_factor + BDConsumo$Impo_Factor - BDConsumo$Expo_Factor2

summary(BDConsumo)
summary(BDConsumo$Impo_Factor/BDConsumo$ConsA)
summary(BDConsumo$Expo_Factor/BDConsumo$Prod_factor)

#Carne
names(BDConsumo)
levels(as.factor(BDConsumo$Cod_cultivo))

Graficos <- filter(BDConsumo,Cod_cultivo %in% c(866))

ggplot(Graficos, aes(x = Year, y = ConsA)) +
  geom_line (aes(x = Year, y = ConsA*0.52,colour="ConsA"))+
  geom_line (aes(x = Year, y = Prod_factor*0.52,colour="Prod_factor"))+
  geom_line (aes(x = Year, y = Impo_Factor*0.52,colour="Impo_Factor"))+
  geom_line (aes(x = Year, y = Expo_Factor*0.52,colour="Expo_Factor"))
  

#filtro de datos atipicos para base final

ggplot(BDConsumo, aes(x = Year, y = ConsA)) + 
  geom_line(aes(x = Year, y = ConsA,colour="Cons")) + 
  geom_line(aes(x = Year, y = Prod_factor,colour="Prod")) +
  geom_line(aes(x = Year, y = Impo_Factor,colour="Impo")) +
  geom_line(aes(x = Year, y = Expo_Factor,colour="Expo")) +
  facet_wrap(~Item, ncol = 11 , scales = "free") 



names(BDConsumo)

levels(droplevels(filter(BDConsumo, Cod_cultivo %in% c(161,211) )$Item))


BDConsumoFinal <- filter(BDConsumo, !(Cod_cultivo %in% c(161,211) ))
summary(BDConsumoFinal)

#generar datos NA datos <= a 0
BDConsumoFinal$ConsA[BDConsumoFinal$ConsA <= 0 ] <- NA

#corregir datos atipicos leche 2017, 2018 y 2019 datos fedegan
BDConsumoFinal[BDConsumoFinal["Cod_cultivo"]==882 ,]

BDConsumoFinal[c(BDConsumoFinal["Cod_cultivo"]==882 & BDConsumoFinal["Year"]==2017),]
BDConsumoFinal[c(BDConsumoFinal["Cod_cultivo"]==882 & BDConsumoFinal["Year"]==2017), "Prod_factor"] <- 7094000
BDConsumoFinal[BDConsumoFinal["Cod_cultivo"]==882 & BDConsumoFinal["Year"]==2017, "ConsA" ] <- 7094000+306978.4-52488.03

BDConsumoFinal[BDConsumoFinal["Cod_cultivo"]==882 & BDConsumoFinal["Year"]==2018, ]  
BDConsumoFinal[BDConsumoFinal["Cod_cultivo"]==882 & BDConsumoFinal["Year"]==2018, "Prod_factor" ] <- 7257000
BDConsumoFinal[BDConsumoFinal["Cod_cultivo"]==882 & BDConsumoFinal["Year"]==2018, "ConsA" ] <- 7257000+332402.8-56466.32

BDConsumoFinal[BDConsumoFinal["Cod_cultivo"]==882 & BDConsumoFinal["Year"]==2019, ]    
BDConsumoFinal[BDConsumoFinal["Cod_cultivo"]==882 & BDConsumoFinal["Year"]==2019, "Prod_factor" ] <- 7184000
BDConsumoFinal[BDConsumoFinal["Cod_cultivo"]==882 & BDConsumoFinal["Year"]==2019, "ConsA" ] <-7184000+484070.2-12564.46
  

ggplot(BDConsumoFinal, aes(x = Year, y = ConsA)) + 
  geom_line() + facet_wrap(~Item, ncol = 11 , scales = "free")

BDConsumoFinal <- droplevels(BDConsumoFinal)

BDConsumoFinal$PorProd <- BDConsumoFinal$Prod_factor/BDConsumoFinal$ConsA
BDConsumoFinal$PorImpo <- BDConsumoFinal$Impo_Factor/BDConsumoFinal$ConsA
BDConsumoFinal$PorExpo <- BDConsumoFinal$Expo_Factor/BDConsumoFinal$ConsA

summary(BDConsumoFinal$PorExpo)

(BDConsumoFinal$PorExpo)
length(which(is.infinite(BDConsumoFinal$PorExpo)==TRUE))# no hay problemas de inf, dividir por cero
length(which(is.infinite(BDConsumoFinal$PorImpo)==TRUE))# no hay problemas de inf, dividir por cero

aggregate(BDConsumoFinal$PorProd,list(BDConsumoFinal$Item),summary,na.rm=TRUE)
aggregate(BDConsumoFinal$PorImpo,list(BDConsumoFinal$Item),summary,na.rm=TRUE)
aggregate(BDConsumoFinal$PorExpo,list(BDConsumoFinal$Item),summary)

ggplot(BDConsumoFinal, aes(x = Year, y = PorProd)) + 
  geom_line(aes(x = Year, y = PorProd,colour="% prod")) + 
  geom_line(aes(x = Year, y = PorImpo,colour="% impo")) +
  geom_line(aes(x = Year, y = PorExpo,colour="% Expo")) +
  facet_wrap(~Item, ncol = 11 , scales = "free") 

ggplot(BDConsumoFinal, aes(x = Year, y = ConsA)) + 
  geom_line(aes(x = Year, y = ConsA,colour="Cons")) + 
  geom_line(aes(x = Year, y = Prod_factor,colour="Prod")) +
  geom_line(aes(x = Year, y = Impo_Factor,colour="Impo")) +
  geom_line(aes(x = Year, y = Expo_Factor,colour="Expo")) +
  facet_wrap(~Item, ncol = 11 , scales = "free") + labs(x = "Año",y ="t") + theme(legend.position="bottom")

#Grupos gcam y fao
#Base <- merge(Base,grupos,
             # by.x=c("C?digo.Producto"), by.y=c("Code"),all.x= TRUE)

# Forestal ----------------------------------------------------------------

Forest <- reshape2::dcast(BDEmUsoTierra_forestal, Item.Code + Item + Year  ~ Element + Unit, fun.aggregate = sum, value.var=c("Value"))
names(Forest)
table(Forest$`Area_1000 ha`)



# EMISIONES ---------------------------------------------------------------

## Por unidad de produccion####
names(BDIAgro_EmInten)

EmInten <- reshape2::dcast(BDIAgro_EmInten, Item.Code + Item + Year  ~ Element + Unit, fun.aggregate = sum, value.var=c("Value"))
EmInten <- merge(EmInten,Factores[,c("Item.code","Producto","Cod_cultivo" )], by.x=c("Item.Code"), by.y=c("Item.code"),all.x= TRUE)
names(EmInten)

aggregate(EmInten$`Emissions (CO2eq)_gigagrams`*1000,list(EmInten$Year),sum)

EmInten$Tipo <- ifelse(EmInten$Item.Code %in% c(867,882,1017,977,1058,1062,1035),"Pecuario","Agricultura")

aggregate(EmInten$`Emissions (CO2eq)_gigagrams`*1000,list(EmInten$Year,EmInten$Tipo),sum)

## Por cambio de uso del suelo####

EmUso <- reshape2::dcast(BDEmUsoTierra_total, Item.Code + Item + Year  ~ Element + Unit, fun.aggregate = sum, value.var=c("Value"))
names(EmUso)

## Tabla para factores Emisiones####

names(BDEmBur)
names(BDProd_FactorEm)

BurEm <- merge(BDEmBur,BDProd_FactorEm[,c("Cod_cultivo","Area harvested_ha","Existencias")], by.x=c("Cod_cultivo"), by.y=c("Cod_cultivo"),all.x= TRUE)
names(BurEm)


# 3A aves y conejos etc
BurEm[BurEm[,"Item"]=="3A1j Otros","Existencias"] <- BDProd_FactorEm[BDProd_FactorEm[,"Cod_cultivo"]==1062,"Existencias"] + BDProd_FactorEm[BDProd_FactorEm[,"Cod_cultivo"]==1057,"Existencias"] #pollos y ponedoras
BurEm[BurEm[,"Item"]=="3A2j Otros","Existencias"] <- BDProd_FactorEm[BDProd_FactorEm[,"Cod_cultivo"]==1062,"Existencias"] + BDProd_FactorEm[BDProd_FactorEm[,"Cod_cultivo"]==1057,"Existencias"] 
BurEm[BurEm[,"Item"]=="3C6j Otros","Existencias"] <- BDProd_FactorEm[BDProd_FactorEm[,"Cod_cultivo"]==1062,"Existencias"] + BDProd_FactorEm[BDProd_FactorEm[,"Cod_cultivo"]==1057,"Existencias"]

# 3A mulas y asnos
#REvisar programacion para incluir buffalos, asnos y mulas 

BurEm[BurEm[,"Item"]=="3A1g Mulas y asnos","Existencias"] <- 78735 + 166329 #asnos y mulas
BurEm[BurEm[,"Item"]=="3A2g Mulas y asnos","Existencias"] <- 78735 + 166329 
BurEm[BurEm[,"Item"]=="3C6g Mulas y asnos","Existencias"] <- 78735 + 166329

BurEm[BurEm[,"Item"]=="3A1b Búfalos","Existencias"] <- 218352 #Bufalos
BurEm[BurEm[,"Item"]=="3A2b Búfalos","Existencias"] <- 218352 
BurEm[BurEm[,"Item"]=="3C6b Búfalos","Existencias"] <- 218352

# 3B TIerras forestales
filter(Forest,Year==2014 & Item =="Forest land")[,"Area_1000 ha"]
filter(Forest,Year==2013 & Item =="Forest land")[,"Area_1000 ha"]
BurEm[BurEm[,"Item"]=="3B1ai Tierras forestales que permanecen (Bosque natural)","Area harvested_ha"] <- filter(Forest,Year==2014 & Item =="Forest land")[,"Area_1000 ha"]*1000
BurEm[BurEm[,"Item"]=="3B1aii Tierras forestales que permanecen (Transiciones entre bosque natural y otras tierras forestales)","Area harvested_ha"] <- filter(Forest,Year==2014 & Item =="Forest land")[,"Area_1000 ha"]*1000 #se utiliza los bosques naturales para sacar un factor "constante" 
BurEm[BurEm[,"Item"]=="3B1aiii Tierras forestales que permanecen (Plantaciones Comerciales)","Area harvested_ha"] <- 373984 #Disponibilidad de madera Ministerio finales 2013
BurEm[BurEm[,"Item"]=="3B1b Tierras convertidas en tierras forestales","Area harvested_ha"] <- 30229*25 # se calcula con reforestacion comercial falta conservacion no aplica para nosotros y se divide por periodo de saturacion 25 años, en la proyeccion se usa unicamente lo que sale de cultivos y ganaderia

# 3B Tierras cultivos
BurEm[BurEm[,"Item"]=="3B2a Tierras de cultivo que permanecen como tales","Area harvested_ha"] <- sum(filter(BDCultdes,Year==2014)[,"Area harvested_ha"],na.rm = TRUE) #Se toma el area cosechada total

#(junio 2021)ajustar con valor de emisiones de 3B3bi Tierras forestales convertidas en pastizales, 
BurEm[BurEm[,"Item"]=="3B2bi Tierras forestales convertidas en tierras de cultivo","Area harvested_ha"] <- 162700# opcion1: Se utiliza un valor de area para obtener un valor de 20t/ha
#BurEm[BurEm[,"Item"]=="3B2bi Tierras forestales convertidas en tierras de cultivo","Area harvested_ha"] <- 30411.19# opcion2: se ajusta un valor de area para obtener un valor igual al de ganaderia 107 t /ha
levels(as.factor(BDIAgro_LandCov$Element))
names(BDIAgro_LandCov)
sum(filter(BDIAgro_LandCov,Item %in% c("Herbaceous crops","Multiple or layered crops","Woody crops")
           & Year ==2014 & Element== "Area from CCI_LC" )[,"Value"],na.rm = TRUE)

sum(filter(BDIAgro_LandCov,
            Year ==2014 & Element== "Area from MODIS" )[,"Value"],na.rm = TRUE)

aggregate(BDIAgro_LandCov$Value,list(BDIAgro_LandCov$Item, BDIAgro_LandCov$Year),sum)

AreaModis <- filter(BDIAgro_LandCov,
                    Year %in% c(2013,2014) & Element== "Area from CCI_LC" )

aggregate(AreaModis$Value,list(AreaModis$Item,AreaModis$Year),sum)

# 3BTierras Area ganaderia calculo 
BurEm[BurEm[,"Item"]=="3B3a Pastizales que permanecen como tales","Area harvested_ha"] <- 20386204
BurEm[BurEm[,"Item"]=="3B3bi Tierras forestales convertidas en pastizales","Area harvested_ha"] <- 284168# se asume que la tala de bosque natural va a pastos (134626) sin embargo se usa 284 mil para ajustar el factor a 107 t/ha  

# 3C 
summary(BurEm$Existencias)
BurEm$Existencias <- ifelse(is.na(BurEm$Existencias)==FALSE,BurEm$Existencias,
                            ifelse(BurEm$tipo=="Ganaderia" & BurEm$Factor == "animal",filter(BDProd_FactorEm,Cod_cultivo == 866)[,"Existencias"],NA)) # solo se tiene en cuenta ganaderia

BurEm$`Area harvested_ha` <- ifelse(is.na(BurEm$`Area harvested_ha`)==FALSE,BurEm$`Area harvested_ha`,
                            ifelse(BurEm$tipo=="Cultivos",sum(filter(BDProd_FactorEm,!(Cod_cultivo==27))[,"Area harvested_ha"],na.rm = TRUE),NA))

filter(BDProd_FactorEm,Cod_cultivo == 866)[,"Existencias"]


# 3D area ganaderia
BurEm[BurEm[,"Item"]=="3D1. Mejoramiento Pasturas","Area harvested_ha"] <- 20386204


#Factores

BurEm$F_abs_CO2 <- ifelse(BurEm$Factor=="animal",BurEm$abs_CO2/BurEm$Existencias,
                          ifelse(BurEm$Factor=="area",BurEm$abs_CO2/BurEm$`Area harvested_ha`,NA))

BurEm$F_Em_CO2 <- ifelse(BurEm$Factor=="animal",BurEm$Em_CO2/BurEm$Existencias,
                          ifelse(BurEm$Factor=="area",BurEm$Em_CO2/BurEm$`Area harvested_ha`,NA))

BurEm$F_Em_CH4 <- ifelse(BurEm$Factor=="animal",BurEm$Em_CH4/BurEm$Existencias,
                          ifelse(BurEm$Factor=="area",BurEm$Em_CH4/BurEm$`Area harvested_ha`,NA))

BurEm$F_Em_N2O <- ifelse(BurEm$Factor=="animal",BurEm$Em_N2O/BurEm$Existencias,
                          ifelse(BurEm$Factor=="area",BurEm$Em_N2O/BurEm$`Area harvested_ha`,NA))

BurEm$F_Em_NOX <- ifelse(BurEm$Factor=="animal",BurEm$EmIndi_NOX/BurEm$Existencias,
                          ifelse(BurEm$Factor=="area",BurEm$EmIndi_NOX/BurEm$`Area harvested_ha`,NA))

BurEm$F_Em_CO <- ifelse(BurEm$Factor=="animal",BurEm$EmIndi_CO/BurEm$Existencias,
                          ifelse(BurEm$Factor=="area",BurEm$EmIndi_CO/BurEm$`Area harvested_ha`,NA))


BurEm$F_abs_CO2_E <- ifelse(BurEm$Factor=="animal",BurEm$abs_CO2_E/BurEm$Existencias,
                          ifelse(BurEm$Factor=="area",BurEm$abs_CO2_E/BurEm$`Area harvested_ha`,NA))


BurEm$Estra[is.na(BurEm$Estra)] <- 0

#factor deforestacion
BurEm[BurEm[,"Item"]=="3B deforestacion","F_Em_CO2"] <- 0.107


names(BurEm)

View(BurEm[,c("Item","Factor","Area harvested_ha","Existencias","F_abs_CO2_E","F_abs_CO2","F_Em_CO2","F_Em_CH4","F_Em_N2O","F_Em_NOX","F_Em_CO")])


#codigos fao y cna
names(cod_fao)
names(cod_cna)


length(cod_cna[grep(cod_fao[4,"nombre"],cod_cna$Nombre_Cultivo),"Nombre_Cultivo"])
cod_cna[grep(cod_fao[1,"nombre"],cod_cna$Nombre_Cultivo),"Nombre_Cultivo"][1]

cod_fao$num_cna <- NA
cod_fao$name_cna <- NA
cod_fao$name_cna2 <- NA

for(i in 1:nrow(cod_fao)){
  cod_fao[i,"num_cna"] <- length(cod_cna[grep(cod_fao[i,"nombre2"],cod_cna$Nombre_Cultivo,fixed = FALSE),"Nombre_Cultivo"])
}

for(i in 1:nrow(cod_fao)){
  ifelse(cod_fao[i,"num_cna"]>0,
         cod_fao[i,"name_cna"] <- cod_cna[grep(cod_fao[i,"nombre2"],cod_cna$Nombre_Cultivo,fixed = FALSE),"Nombre_Cultivo"][1],
         NA)
  
}

for(i in 1:nrow(cod_fao)){
  ifelse(cod_fao[i,"num_cna"]>1,
         cod_fao[i,"name_cna2"] <- cod_cna[grep(cod_fao[i,"nombre2"],cod_cna$Nombre_Cultivo,fixed = FALSE),"Nombre_Cultivo"][2],
         NA)
  
}

table(cod_fao$num_cna)

#write.xlsx(cod_fao,"data/derived/cod_cultivos.xlsx")

# LOG ---------------------------------------------------------------------

# Any descriptives that will be helpful to understand the results of this
# script and how it contributes to the aims of the project

# CLEAN UP ----------------------------------------------------------------

# Remove all current environment variables
#rm(list = ls())

#rm(list=setdiff(ls(), c("BDConsumoFinal","pib_pobl","pib_est","pobl_dane","functend","growth_rate","BDCultdes","Modelos")))
