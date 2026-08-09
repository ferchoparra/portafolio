
# ABOUT -------------------------------------------------------------------

# Descripcion: <Se incluyen todos los graficos descriptivos por cadena, historicos y proyectados>
# Uso: <Se utiliza las bases de datos generadas en curate_data y transform_data
# Autor: <Luis Parra>
# Date: <2021 febrero>

# SETUP -------------------------------------------------------------------

# Script-specific options or packages

# RUN ---------------------------------------------------------------------

# Steps involved in analyzing the data


# Bases Analisis ----------------------------------------------------------

#Base Produccion: Cultivos 
BDCultdes

#Base Produccion: Ganaderia primaria
BDGanPrides

#Base Produccion: integra cultivos y ganaderia primaria var: produccion con factor share a animlaes vivos
BDProduccion

#Base Comercio agrupado: cultivos y gananderia y animales vivos
BDComercioAgru3#calculo teniendo en cuenta share
BDComercioAgru3#calculo sin tener en cuenta share

# Analisis general --------------------------------------------------------


##Ganaderia primaria Produccion####
#Produccion 
aggregate(BDGanPrides$`Prod Popultn_No`,list(BDGanPrides$Item),summary)#beewax, honey natural
aggregate(BDGanPrides$`Producing Animals/Slaughtered_1000 Head`,list(BDGanPrides$Item),summary)#meat (chicken, rabbit)
aggregate(BDGanPrides$`Producing Animals/Slaughtered_Head`,list(BDGanPrides$Item),summary)#

#unidad de produccion que se utiliza. para huevos tambien se utiliza en terminos de tonneladas y no de numero
aggregate(BDGanPrides$Production_tonnes,list(BDGanPrides$Item),summary)#

ggplot(BDGanPrides, aes(x = Year, y = Production_tonnes))+ geom_line() +
  facet_wrap(~Item, ncol = 8,scales = "free")

#sin leche
ggplot(filter(BDGanPrides,!(Item.Code %in% c(882))), aes(x = Year, y = Production_tonnes)) + 
  geom_line() + facet_wrap(~Item, ncol = 8)

#meat
ggplot(BDGanPrides[grep("Meat",BDGanPrides$Item),], aes(x = Year, y = Production_tonnes)) + 
  geom_line() + facet_wrap(~Item, ncol = 8)

ggplot(BDGanPrides[grep("Meat",BDGanPrides$Item),], aes(x = Year, y = Prod_factor)) + 
  geom_line() + facet_wrap(~Item, ncol = 8)



#rendimiento
aggregate(BDGanPrides$`Laying_1000 Head`,list(BDGanPrides$Item),summary)#para eggs hen in shell

aggregate(BDGanPrides$Yield_hg,list(BDGanPrides$Item),summary)#solo para Honey, natural
aggregate(BDGanPrides$`Yield_hg/An`,list(BDGanPrides$Item),summary)#solo para hides, milk, skins
aggregate(BDGanPrides$`Yield_100mg/An`,list(BDGanPrides$Item),summary)#solo para eggs hen in shell
aggregate(BDGanPrides$`Yield/Carcass Weight_0.1g/An`,list(BDGanPrides$Item),summary)#solo meat (rabbit, chicken)
aggregate(BDGanPrides$`Yield/Carcass Weight_hg/An`,list(BDGanPrides$Item),summary)#solo meat (resto)

names(Factores)
names(BDGanPrides)

ggplot(prueba, aes(x = Year, y = con_mod)) + 
  geom_line(aes(x = Year, y = Rend,colour="Rend")) + 
  geom_line(aes(x = Year, y = Rend_E,colour="Rend_E")) +
  facet_wrap(~Cod_cultivo, ncol = 11 , scales = "free") + labs(x = "Año",y ="t/ha") + theme(legend.position="bottom")



#comparacion con share y sin share
Graficos1 <- filter(BDComercioAgru3,Cod_cultivo %in% c(866))
Graficos2 <- filter(BDComercioAgru2,Cod_cultivo %in% c(866))

ggplot(Graficos1, aes(x = Year, y = Impo_Factor  )) +
  geom_line (aes(x = Year, y = Impo_Factor,colour="Impo_Factor  "))+
  geom_line (data=Graficos2, aes(x = Year, y = Impo_Factor,colour="Impo_Factor2"))+
  geom_line (aes(x = Year, y = Expo_Factor,colour="Expo_Factor"))+
  geom_line (data=Graficos2, aes(x = Year, y = Expo_Factor,colour="Expo_Factor2"))



##Consumo#####
aggregate(BDGanPrides$`Yield/Carcass Weight_hg/An`,list(BDGanPrides$Item),summary)#solo meat (resto)

ggplot(filter(BDGanPrides,Item.Code %in% c(882)), aes(x = Year, y = Production_tonnes))+ geom_line()

filter(BDConsumoFinal,Cod_cultivo %in% Reporte)

ggplot(BDProyec_F, aes(x = Year, y = con_mod)) + 
  geom_line(aes(x = Year, y = con_mod,colour="con_mod")) + 
  geom_line(aes(x = Year, y = con_proy,colour="con elas fija")) +
  facet_wrap(~varia, ncol = 11 , scales = "free") + labs(x = "Año",y ="t") + theme(legend.position="bottom")



ggplot(filter(BDConsumoFinal,Cod_cultivo %in% Reporte), aes(x = Year, y = ConsA)) + 
  geom_line(aes(x = Year, y = ConsA,colour="Cons")) + 
  geom_line(aes(x = Year, y = Prod_factor,colour="Prod")) +
  geom_line(aes(x = Year, y = Impo_Factor,colour="Impo")) +
  geom_line(aes(x = Year, y = Expo_Factor,colour="Expo")) +
  facet_wrap(~Item, ncol = 3 , scales = "free") + labs(x = "Año",y ="t") + theme(legend.position="bottom")



ggplot(BDConsumoFinal, aes(x = Year, y = ConsA)) + 
  geom_line(aes(x = Year, y = ConsA,colour="Cons")) + 
  geom_line(aes(x = Year, y = Prod_factor,colour="Prod")) +
  geom_line(aes(x = Year, y = Impo_Factor,colour="Impo")) +
  geom_line(aes(x = Year, y = Expo_Factor,colour="Expo")) +
  facet_wrap(~Item, ncol = 11 , scales = "free") + labs(x = "Año",y ="t") + theme(legend.position="bottom")

ggplot(BDBalComFinal, aes(x = Year, y = Prod1)) + 
  geom_line() + 
  facet_wrap(~varia, ncol = 11 , scales = "free") + labs(x = "Año",y ="t") + theme(legend.position="bottom")

ggplot(BDBalComFinal, aes(x = Year, y = AreaReq)) + 
  geom_line() + 
  facet_wrap(~varia, ncol = 11 , scales = "free") + labs(x = "Año",y ="t") + theme(legend.position="bottom")

ggplot(BDBalComFinal, aes(x = Year, y = elas)) + 
  geom_line() + 
  facet_wrap(~varia, ncol = 11 , scales = "free") + labs(x = "Año",y ="t") + theme(legend.position="bottom")

names(BDBalComFinal)

ggplot(filter(BDBalComFinal,Cod_cultivo %in% Reporte), aes(x = Year, y = con_proy)) + 
  geom_line() +
  facet_wrap(~varia, ncol = 3 , scales = "free") + labs(x = "Año",y ="t") + theme(legend.position="bottom")



ggplot(filter(BDBalComFinal,Cod_cultivo %in% Reporte), aes(x = Year, y = elas)) + 
  geom_line() +
  facet_wrap(~varia, ncol = 3 , scales = "free") + labs(x = "Año",y ="t") + theme(legend.position="bottom")

BDProyec_F
filter(BDProyec_F,Cod_cultivo %in% c(866))[,c("Year","ConsHist","con_proy","tcons_mod")]
BDBalCom
filter(BDBalCom,Cod_cultivo %in% c(866))[,c("Year","ConsHist","con_proy","tcons_mod")]
filter(BDBalComFinal,Cod_cultivo %in% c(866))[,c("Year","ConsHist","con_proy","tcons_mod")]


filter(ResultProy,Cod_cultivo %in% c(826))[,c(1:9)]

##Elasticidad#####
names(BDBalCom)
ggplot(BDBalCom, aes(x = Year, y = elas )) +
  geom_line() + facet_wrap(~varia, ncol = 11 , scales = "free") + 
  labs(x = "Año",y ="elasticidad") + theme(legend.position="bottom")

filter(BDBalCom,Cod_cultivo %in% Reporte)
ggplot(filter(BDBalCom,Cod_cultivo %in% Reporte), aes(x = Year, y = elas )) +
  geom_line() + facet_wrap(~varia, ncol = 3 , scales = "free") + 
  labs(x = "Año",y ="elasticidad") + theme(legend.position="bottom")

##Rendimientos#####
BDCultdes

ggplot(BDCultdes, aes(x = Year, y = tasa_rend )) +
  geom_line() + facet_wrap(~Cod_cultivo, ncol = 11 , scales = "free") + 
  labs(x = "Año",y ="tasa Rend") + theme(legend.position="bottom")


#Balanza comercial#####

filter(BDBalCom,Cod_cultivo==656)

ggplot(filter(BDBalCom,Cod_cultivo==656), aes(x = Year, y = con_proy*PorExpo_1 )) +
  geom_line() + 
  labs(x = "Año",y ="elasticidad") + theme(legend.position="bottom")

filter(BDBalCom,Cod_cultivo %in% Reporte)

ggplot(filter(BDBalCom,Cod_cultivo %in% Reporte), aes(x = Year, y = elas )) +
  geom_line() + facet_wrap(~varia, ncol = 11 , scales = "free") + 
  labs(x = "Año",y ="elasticidad") + theme(legend.position="bottom")

#actual
filter(BDConsumoFinal,Cod_cultivo %in% Reporte)

ggplot(filter(BDConsumoFinal,Cod_cultivo %in% Reporte), aes(x = Year, y = ConsA)) + 
  geom_line(aes(x = Year, y = ConsA,colour="Cons")) + 
  geom_line(aes(x = Year, y = Prod_factor,colour="Prod")) +
  geom_line(aes(x = Year, y = Impo_Factor,colour="Impo")) +
  geom_line(aes(x = Year, y = Expo_Factor,colour="Expo")) +
  facet_wrap(~Item, ncol = 3 , scales = "free") + labs(x = "Año",y ="t") + theme(legend.position="bottom")

#proyeccion
names(BDBalCom)
ggplot(filter(BDBalCom,Cod_cultivo %in% Reporte), aes(x = Year, y = con_mod)) + 
  geom_line(aes(x = Year, y = con_mod,colour="Cons")) + 
  geom_line(aes(x = Year, y = Prod1,colour="Prod")) +
  geom_line(aes(x = Year, y = Impo1,colour="Impo")) +
  geom_line(aes(x = Year, y = Expo1,colour="Expo")) +
  facet_wrap(~varia, ncol = 3 , scales = "free") + labs(x = "Año",y ="t") + theme(legend.position="bottom")




#Area requerida#####
names(BDBalCom)
ggplot(filter(BDBalCom,Cod_cultivo==1057), aes(x = Year, y = AreaReq )) +
  geom_line() + 
  labs(x = "Año",y ="elasticidad") + theme(legend.position="bottom")


aggregate(BDBalCom$AreaReq,list(BDBalCom$GCAM_Class,BDBalCom$Year),sum)
ggplot(BDBalCom, aes(x = Year, y = AreaReq )) +
  geom_line() + facet_wrap(~GCAM_Class, ncol = 11 , scales = "free") + 
  labs(x = "Año",y ="elasticidad") + theme(legend.position="bottom")


unique(filter(BDBalCom,AreaReq>0)[,c("Cod_cultivo","varia","tipo")])

nrow(unique(filter(BDBalCom,AreaReq>0)[,c("Cod_cultivo","varia","tipo")]))
table(unique(filter(BDBalCom,AreaReq>0)[,c("Cod_cultivo","varia","tipo")])$tipo)

aggregate(BDBalComFinal$AreaReq,list(BDBalComFinal$Year,BDBalComFinal$tipo),sum,na.rm=TRUE)

ggplot(aggregate(BDBalComFinal$AreaReq,list(BDBalComFinal$Year,BDBalComFinal$tipo),sum,na.rm=TRUE),
       aes(x = Group.1, y = x ,col=Group.2)) +
  geom_line() + labs(x = "Año",y ="ha") + theme(legend.position="bottom") + ggtitle("Área requerida") 

aggregate(BDBalComFinal$AreaReq,list(BDBalComFinal$Year,BDBalComFinal$GCAM_Class),sum,na.rm=TRUE)

ggplot(aggregate(BDBalComFinal$AreaReq,list(BDBalComFinal$Year,BDBalComFinal$GCAM_Class),sum,na.rm=TRUE),
       aes(x = Group.1, y = x )) + 
  geom_line() + facet_wrap(~Group.2, ncol = 3 , scales = "free") +
  labs(x = "Año",y ="ha") + theme(legend.position="bottom") + ggtitle("Área requerida") 


##Emisiones####




# Analisis por producto ---------------------------------------------------


##Forestal####
aggregate(Forest$`Area_1000 ha`,list(Forest$Year),sum)

ggplot(aggregate(Forest$`Area_1000 ha`,list(Forest$Year),sum), aes(x = Group.1, y = x)) + 
  geom_line()

Forest$`Implied emission factor for CO2_tonnes CO2/ha`

names(BDForestal)
ggplot(BDForestal , aes(x = Year, y = Area_E2)) + 
  geom_bar(stat='identity',fill="lightblue")

ggplot(melt(BDForestal[,c("Year","Area_E1","Area_E2","Area_E3")],id="Year",
            variable.name ="Area",value.name = "ha"), aes(x = Year, y = ha, fill=Area)) + 
  geom_bar(position="dodge",stat='identity', width=.5) 
  
ggplot(melt(BDForestal[,c("Year","Emisiones_E1","Emisiones_E2","Emisiones_E3")],id="Year",
            variable.name ="Emisiones",value.name = "t_CO2eq"), aes(x = Year, y = t_CO2eq, fill=Emisiones)) + 
  geom_bar(position="dodge",stat='identity', width=.5) 


melt(BDForestal[,c("Year","Area_E1","Area_E2","Area_E3")],id="Year", variable.name ="Area",value.name = "ha")



ggplot(BDForestal, aes(x = Year, y = Area_E1)) + 
  geom_line(aes(x = Year, y = Area_E1,colour="E1")) + 
  geom_line(aes(x = Year, y = Area_E2,colour="E2")) +
  geom_line(aes(x = Year, y = Area_E3,colour="E3")) +
  labs(x = "Año",y ="ha") + theme(legend.position="bottom")


#Pecuario

filter(BDEmAgro_FEnte,Item=="Cattle, non-dairy" & Unit =="Head")
filter(BDEmAgro_FEnte,Item=="Cattle, dairy" & Unit =="Head")

filter(BDEmAgro_FEnte,Item=="Asses" & Unit =="kg CH4/head")

sum(filter(BDEmAgro_FEnte,Item=="Asses" & Element =="Emissions (CO2eq) (Enteric)")$Value)/
  sum(filter(BDEmAgro_FEnte,Item=="Asses" & Unit =="Head")$Value)

filter(BDEmAgro_FEnte,Item=="Asses" & Element =="Emissions (CO2eq) (Enteric)")$Value/
  filter(BDEmAgro_FEnte,Item=="Asses" & Unit =="Head")$Value

filter(BDEmAgro_FEnte,Item=="Asses" & Element =="Emissions (CH4) (Enteric)")$Value/
  filter(BDEmAgro_FEnte,Item=="Asses" & Unit =="Head")$Value

filter(BDEmAgro_FEnte,Item=="Cattle, dairy" & Element =="Emissions (CO2eq) (Enteric)")$Value/
  filter(BDEmAgro_FEnte,Item=="Cattle, dairy" & Unit =="Head")$Value

filter(BDEmAgro_FEnte,Item=="Cattle, dairy" & Element =="Emissions (CH4) (Enteric)")$Value/
  filter(BDEmAgro_FEnte,Item=="Cattle, dairy" & Unit =="Head")$Value



##Rice####

#30 es milled paddy rice y 27 es paddy rice, parece milled es el total del consumo pero con factor de transformacion 0.66
filter(BDConsumo,Cod_cultivo==30)$ConsA/filter(BDConsumo,Cod_cultivo==27)$ConsA
summary(filter(BDConsumo,Cod_cultivo==30)$ConsA/filter(BDConsumo,Cod_cultivo==27)$ConsA)

##maiz####
ggplot(filter(BDCultdes,Item.Code %in% c(56)), aes(x = Year, y = Production_tonnes)) + 
  geom_line() + theme_bw() + labs(x = "Año",y ="t") +
  ggtitle("Producción")


names(BDComercio)
aggregate(filter(BDComercio,Cod_cultivo %in% c(56))$Impo_Factor,list(filter(BDComercio,Cod_cultivo %in% c(56))$Cod_cultivo,filter(BDComercio,Cod_cultivo %in% c(56))$Year),sum)
aggregate(filter(BDComercio,Cod_cultivo %in% c(56))$`Import Quantity_tonnes`,list(filter(BDComercio,Cod_cultivo %in% c(56))$Cod_cultivo,filter(BDComercio,Cod_cultivo %in% c(56))$Year),sum)


ggplot(filter(BDComercio,Cod_cultivo %in% c(56)), aes(x = Year, y = Impo_Factor)) + 
  geom_line() + facet_wrap(~Item, ncol = 3, scales = "free") + theme_bw() + labs(x = "Año",y ="t")

ggplot(filter(BDComercio,Cod_cultivo %in% c(56)), aes(x = Year, y = Expo_Factor)) + 
  geom_line() + facet_wrap(~Item, ncol = 3, scales = "free") + theme_bw() + labs(x = "Año",y ="t")

#con share valores menores a BDComercio
aggregate(filter(BDConsumoFinal,Cod_cultivo %in% c(56))$Impo_Factor,list(filter(BDConsumoFinal,Cod_cultivo %in% c(56))$Cod_cultivo,filter(BDConsumoFinal,Cod_cultivo %in% c(56))$Year),sum)
aggregate(filter(BDComercio,Cod_cultivo %in% c(56))$`Import Quantity_tonnes`,list(filter(BDComercio,Cod_cultivo %in% c(56))$Cod_cultivo,filter(BDComercio,Cod_cultivo %in% c(56))$Year),sum)


ggplot(filter(BDConsumoFinal,Cod_cultivo %in% c(56)), aes(x = Year, y = ConsA)) + 
  geom_line()  + theme_bw() + labs(x = "Año",y ="t") +
  ggtitle("Consumo Aparente")


ggplot(filter(BDConsumoFinal,Cod_cultivo %in% c(56)), aes(x = Year, y = ConsA)) + 
  geom_line(aes(x = Year, y = ConsA,col="Consumo A."))  +
  geom_line(aes(x = Year, y = Prod_factor,col="Producción"))  +
  geom_line(aes(x = Year, y = Impo_Factor,col="Importaciones"))  +
  geom_line(aes(x = Year, y = Expo_Factor,col="Exportaciones"))  +
  theme_bw() + labs(x = "Año",y ="t") + theme(legend.position="bottom")


#proyecciones
names(BDBalComFinal)
table(BDBalComFinal$Cod_cultivo)

ggplot(filter(BDBalComFinal,Cod_cultivo %in% c(56)), aes(x = Year, y = t_pobl_dane)) + 
  geom_line(aes(x = Year, y = t_pobl_dane,col="tasa Pobl"))  +
  geom_line(aes(x = Year, y = t_Pib_NDC,col="tasa Pib"))  +
  theme_bw() + labs(x = "Año",y ="tasa crecimiento") + theme(legend.position="bottom")

ggplot(filter(BDBalComFinal,Cod_cultivo %in% c(56) & Year %in% c(2015:2040)), aes(x = Year, y = elas)) + 
  geom_line(aes(x = Year, y = elas,col="Elasticidad"))  +
  geom_line(aes(x = Year, y = elasticidad,col="Elasticidad Fija"))  +
  theme_bw() + labs(x = "Año",y ="Elasticidad") + theme(legend.position="bottom")


ggplot(filter(BDBalComFinal,Cod_cultivo %in% c(56) & Year %in% c(2015:2040)), aes(x = Year, y = con_mod)) + 
  geom_line(aes(x = Year, y = con_mod,col="con_mod"))  +
  geom_line(aes(x = Year, y = con_proy,col="con_proy"))  +
  theme_bw() + labs(x = "Año",y ="t") + theme(legend.position="bottom")



names(BDProyec)
names(BDProyec_F)
ggplot(filter(BDProyec,Cod_cultivo %in% c(56) & Year %in% c(2000:2040)), aes(x = Year, y = con_mod)) + 
  geom_line(aes(x = Year, y = con_mod))  + 
  geom_point(aes(x = Year, y = ConsHist)) +
  geom_point(aes(x = 2029, y = 7983000),shape=25, fill="blue") +
  theme_bw() + labs(x = "Año",y ="t") 


#por tipo de consumo
ggplot(filter(BaseProy_Maiz,Cod_cultivo %in% c(56) & Year %in% c(2015:2040)), aes(x = Year, y = con_mod)) + 
  geom_line(aes(x = Year, y = con_mod,col="con_mod"))  +
  geom_line(aes(x = Year, y = Con_Animal,col="Con_Animal"))  +
  geom_line(aes(x = Year, y = Con_Humano,col="Con_Humano"))  +
  geom_line(aes(x = Year, y = Con_Otro,col="Con_Otro"))  +
  theme_bw() + labs(x = "Año",y ="t") + theme(legend.position="bottom")



##Leche####

ggplot(filter(BDGanPrides,Item.Code %in% c(882)), aes(x = Year, y = Production_tonnes))+ geom_line()
#ajustar datos leche ultimos años

#comercio

aggregate(filter(BDComercio,Cod_cultivo %in% c(882))$Impo_Factor,list(filter(BDComercio,Cod_cultivo %in% c(882))$Cod_cultivo,filter(BDComercio,Cod_cultivo %in% c(882))$Year),sum)

ggplot(aggregate(filter(BDComercio,Cod_cultivo %in% c(882))$Impo_Factor,list(filter(BDComercio,Cod_cultivo %in% c(882))$Cod_cultivo,filter(BDComercio,Cod_cultivo %in% c(882))$Year),sum),
       aes(x = Group.2, y = x)) +  geom_line()

ggplot(filter(BDComercio,Cod_cultivo %in% c(882)), aes(x = Year, y = Impo_Factor)) + 
  geom_line() + facet_wrap(~Item, ncol = 3, scales = "free") + theme_bw()

# Guardar graficos####
plots.dir.path <- list.files(tempdir(), pattern="rs-graphics", full.names = TRUE); 
plots.png.paths <- list.files(plots.dir.path, pattern=".png", full.names = TRUE)

file.copy(from=plots.png.paths, to="D:/Trabajo/DDPLAC/Figuras")

# LOG ---------------------------------------------------------------------

# Any descriptives that will be helpful to understand the results of this
# script and how it contributes to the aims of the project

# CLEAN UP ----------------------------------------------------------------

# Remove all current environment variables
rm(list = ls())
