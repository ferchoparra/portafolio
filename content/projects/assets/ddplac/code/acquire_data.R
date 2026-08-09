
# ABOUT -------------------------------------------------------------------

# Descripción: <Se cargan los datos necesarios>
# Usage: <Se cargan los datos FAO formato .csv inicialmente, se espera utilizar
# el paquete FAOSTAT para cargarlos posteriormente. 
# Autor: <Luis Parra>
# Date: <2021 febrero 26>

# SETUP -------------------------------------------------------------------

# Script-specific options or packages
#leer y escribir archivos
library(readxl)
library(openxlsx)
#descarga con paquete FAOSTAT
#library(FAOSTAT)


# RUN ---------------------------------------------------------------------

# Steps involved in acquiring and organizing the original data

# Leer data 

# PRODUCCION --------------------------------------------------------------
##CULTIVOS####
##codigo cna
cod_cna <- read_excel("data/original/cultivos_cna.xlsx", sheet = "cna")
cod_cna <- as.data.frame(cod_cna)

cod_fao <- read_excel("data/original/cultivos_cna.xlsx", sheet = "Fao")
cod_fao <- as.data.frame(cod_fao)

cod_trans <- read_excel("data/original/cultivos_cna.xlsx", sheet = "fao_cna")
cod_trans <- as.data.frame(cod_trans)

#Area cosechada, Produccion, Rendimiento
BDCult <- read.csv("data/original/FAOSTAT_dataProdCult_2-26-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                     stringsAsFactors = TRUE, encoding="UTF-8") 
names(BDCult)
#CultProd <- unique(BDCult[,c("Item.Code","Item")])

##GANADERIA PRIMARIA####
#Animales en produccion/sacrificio, Rendimiento, Produccion - cantidad
BDGanExis <- read.csv("data/original/FAOSTAT_ProdGanExistencias_3-9-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                     stringsAsFactors = TRUE, encoding="UTF-8")  
names(BDGanExis)


##GANADERIA PRIMARIA####
#Animales en produccion/sacrificio, Rendimiento, Produccion - cantidad
BDGanPri <- read.csv("data/original/FAOSTAT_dataProdGanPri_2-27-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                    stringsAsFactors = TRUE, encoding="UTF-8")  
names(BDGanPri)
#GanProd <- unique(BDGanPri[,c("Item.Code","Item")])


# COMERCIO ----------------------------------------------------------------

##Cultivos y productos de ganaderia####
#importaciones cantidad y valor, exportaciones cantidad y valor
BDComCultGan <- read.csv("data/original/FAOSTAT_dataComCultGan_2-27-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                         stringsAsFactors = TRUE, encoding="UTF-8") 
names(BDComCultGan)
#ComProd <- unique(BDComCultGan[,c("Item.Code","Item")])

##Animales vivos####
#importaciones cantidad y valor, exportaciones cantidad y valor
BDComGanVivos <- read.csv("data/original/FAOSTAT_dataComGanVivo_2-27-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                           stringsAsFactors = TRUE, encoding="UTF-8") 
names(BDComGanVivos)
#ComProdVivo <- unique(BDComGanVivos[,c("Item.Code","Item")])



# INSUMOS -----------------------------------------------------------------
BDIns_LandUse <- read.csv("data/original/FAOSTAT_InsLandUse_3-2-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                          stringsAsFactors = TRUE, encoding="UTF-8") 
summary(BDIns_LandUse)
levels(as.factor(BDIns_LandUse$Item))

# INDICADORES AGROAMBIENTALES ---------------------------------------------

##Cobertura de la tierra####
BDIAgro_LandCov <- read.csv("data/original/FAOSTAT_IAgroLandCov_3-2-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                          stringsAsFactors = TRUE, encoding="UTF-8") 
summary(BDIAgro_LandCov)
levels(as.factor(BDIAgro_LandCov$Item))


##Intensidad de emisiones####
BDIAgro_EmInten <- read.csv("data/original/FAOSTAT_AgriI_EmInten_3-5-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                            stringsAsFactors = TRUE, encoding="UTF-8") 

levels(as.factor(BDIAgro_EmInten$Item))
levels(as.factor(BDIAgro_EmInten$Item.Code))
levels(as.factor(BDIAgro_EmInten$Unit))
unique(BDIAgro_EmInten[,c("Item.Code","Item")])
table(BDIAgro_EmInten$Element)

# EMISIONES AGRICULTURA ---------------------------------------------------

##Total agricultura####
BDEmAgro_AgriT <- read.csv("data/original/FAOSTAT_EmAgr_AgrTotal_3-6-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                            stringsAsFactors = TRUE, encoding="UTF-8") 
summary(BDEmAgro_AgriT)
str(BDEmAgro_AgriT)
levels(as.factor(BDEmAgro_AgriT$Item))
table(BDEmAgro_AgriT$Item,BDEmAgro_AgriT$Element)
table(BDEmAgro_AgriT$Element,BDEmAgro_AgriT$Unit)

##Fermentacion enterica####
BDEmAgro_FEnte <- read.csv("data/original/FAOSTAT_EmAgr_FEnterica_3-6-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                           stringsAsFactors = TRUE, encoding="UTF-8") 
summary(BDEmAgro_FEnte)
str(BDEmAgro_FEnte)
levels(as.factor(BDEmAgro_FEnte$Item))
table(BDEmAgro_FEnte$Item,BDEmAgro_FEnte$Element)
table(BDEmAgro_FEnte$Element,BDEmAgro_FEnte$Unit)


##Gestion estiercol####
BDEmAgro_GEsti <- read.csv("data/original/FAOSTAT_EmAgr_GestEstiercol__3-6-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                           stringsAsFactors = TRUE, encoding="UTF-8") 

summary(BDEmAgro_GEsti)
str(BDEmAgro_GEsti)
levels(as.factor(BDEmAgro_FEnte$Item))
table(BDEmAgro_GEsti$Item,BDEmAgro_GEsti$Element)
table(BDEmAgro_GEsti$Element,BDEmAgro_GEsti$Unit)

##Cultivo Arroz####
BDEmAgro_CultArr <- read.csv("data/original/FAOSTAT_EmAgr_CultivoArroz_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                           stringsAsFactors = TRUE, encoding="UTF-8") 

summary(BDEmAgro_CultArr)
str(BDEmAgro_CultArr)
levels(as.factor(BDEmAgro_CultArr$Item))
table(BDEmAgro_CultArr$Item,BDEmAgro_CultArr$Element)
table(BDEmAgro_CultArr$Element,BDEmAgro_CultArr$Unit)

##Fertilizantes sinteticos####
BDEmAgro_FerSinte <- read.csv("data/original/FAOSTAT_EmAgr_FertSinteticos_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                             stringsAsFactors = TRUE, encoding="UTF-8") 


##Estiercol Suelos####
BDEmAgro_EstiSuel <- read.csv("data/original/FAOSTAT_EmAgr_EstiercolSuelos_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                              stringsAsFactors = TRUE, encoding="UTF-8") 

##Estiercol depositado pasturas####
BDEmAgro_EstiPasto <- read.csv("data/original/FAOSTAT_EmAgr_EstiercolPastos_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                              stringsAsFactors = TRUE, encoding="UTF-8") 

##Residuos Agricolas####
BDEmAgro_ResAgri <- read.csv("data/original/FAOSTAT_EmAgr_ResiduosCultivos_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                              stringsAsFactors = TRUE, encoding="UTF-8") 


##Cultivacion suelos organicos####
BDEmAgro_CultOrgan <- read.csv("data/original/FAOSTAT_EmAgr_CultivacionOrganico_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                              stringsAsFactors = TRUE, encoding="UTF-8") 


##Combustion sabana####
BDEmAgro_CombSab <- read.csv("data/original/FAOSTAT_EmAgr_CombustionSabana_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                              stringsAsFactors = TRUE, encoding="UTF-8") 


##Combustion residuos agricolas####
BDEmAgro_CombRes <- read.csv("data/original/FAOSTAT_EmAgr_CombustionResiduosAgri_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                              stringsAsFactors = TRUE, encoding="UTF-8") 

##Uso energia####
BDEmAgro_UsoEnerg <- read.csv("data/original/FAOSTAT_EmAgr_UsoEnergia_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                              stringsAsFactors = TRUE, encoding="UTF-8") 



# EMISIONES USO DE LA TIERRA ----------------------------------------------

##Uso de la tierra total####
BDEmUsoTierra_total <- read.csv("data/original/FAOSTAT_EmUsoTierra_Total_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                              stringsAsFactors = TRUE, encoding="UTF-8") 

summary(BDEmUsoTierra_total)
str(BDEmUsoTierra_total)
levels(as.factor(BDEmUsoTierra_total$Item))
table(BDEmUsoTierra_total$Item,BDEmUsoTierra_total$Element)
table(BDEmUsoTierra_total$Element,BDEmUsoTierra_total$Unit)

##Tierras Forestales####
BDEmUsoTierra_forestal <- read.csv("data/original/FAOSTAT_EmUsoTierra_forestal_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                                   stringsAsFactors = TRUE, encoding="UTF-8") 

table(BDEmUsoTierra_forestal$Item,BDEmUsoTierra_forestal$Element)
table(BDEmUsoTierra_forestal$Element,BDEmUsoTierra_forestal$Unit)
table(BDEmUsoTierra_forestal$Item,BDEmUsoTierra_forestal$Unit)


##Tierras de cultivo####
BDEmUsoTierra_cultivos <- read.csv("data/original/FAOSTAT_EmUsoTierra_Cultivos_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                                   stringsAsFactors = TRUE, encoding="UTF-8") 

table(BDEmUsoTierra_cultivos$Item,BDEmUsoTierra_cultivos$Element)
table(BDEmUsoTierra_cultivos$Element,BDEmUsoTierra_cultivos$Unit)
table(BDEmUsoTierra_cultivos$Item,BDEmUsoTierra_cultivos$Unit)

##Pastizales####
BDEmUsoTierra_pastos <- read.csv("data/original/FAOSTAT_EmUsoTierra_Pastos_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                                   stringsAsFactors = TRUE, encoding="UTF-8") 

##Combustion biomasa####
BDEmUsoTierra_CombBio <- read.csv("data/original/FAOSTAT_EmUsoTierra_CombustionBiomasa_3-11-2021.csv", header = TRUE, sep = ",", comment.char = "", strip.white = TRUE,
                                   stringsAsFactors = TRUE, encoding="UTF-8") 



# INFO ADICIONAL --------------------------------------------------

##Grupos gcam y fao####
#grupos asignados a los 74 cultivos por FAO y GCAM
grupos <- read_excel("data/original/Elas_Factores.xlsx", sheet = "Grupos")
grupos <- as.data.frame(grupos)

##Pib y pob GCAM####
pib_pobl <- read_excel("data/original/Elas_Factores.xlsx", sheet = "Pib_pobl")
pib_pobl <- as.data.frame(pib_pobl)

pobl_dane <- read_excel("data/original/Elas_Factores.xlsx", sheet = "Pobl_dane")
pobl_dane <- as.data.frame(pobl_dane)

pib_est<-read_excel("data/original/Elas_Factores.xlsx", sheet = "Pib")
pib_est<-as.data.frame(pib_est)

##Elas grupos GCAM####
elast <- read_excel("data/original/Elas_Factores.xlsx", sheet = "Elasticidades")
elast <- as.data.frame(elast)

GCAMelast <- read_excel("data/original/Elas_Factores.xlsx", sheet = "Grupos_GCAM")
GCAMelast <- as.data.frame(GCAMelast)

##Factores de conversion####
Factores <- read_excel("data/original/Elas_Factores.xlsx", sheet = "Factores_conv")
Factores <- as.data.frame(Factores)

##Peso vivo animales###
InfGanViva <- read_excel("data/original/Elas_Factores.xlsx", sheet = "C_Alive")
InfGanViva <- as.data.frame(InfGanViva)

##modelos proy####
Modelos <- read_excel("data/original/Elas_Factores.xlsx", sheet = "Mod")
Modelos <- as.data.frame(Modelos)

##Forestal proy####
BDForestal <- read_excel("data/original/Elas_Factores.xlsx", sheet = "Forestal")
BDForestal <- as.data.frame(BDForestal)

##Emisiones BUR####
BDEmBur <- read_excel("data/original/NIR_BUR2_Colombia.xlsx", sheet = "Emisiones",na = c("NO","IE","NE","NA"))
BDEmBur <- as.data.frame(BDEmBur)

##Costos y Beneficios####
CyB <- read_excel("data/original/NIR_BUR2_Colombia.xlsx", sheet = "Cost_Benf")
CyB <- as.data.frame(CyB)

##CyB cultivos####
CyB_cult <- read_excel("data/original/NIR_BUR2_Colombia.xlsx", sheet = "cultivos")
CyB_cult <- as.data.frame(CyB_cult)


# LOG ---------------------------------------------------------------------

# Any descriptives that will be helpful to understand the results of this
# script and how it contributes to the aims of the project
# Para consumo aparente es necesario cargar: produccion cultivos, ganaderia primaria, 
# comercio cultivos y ganaderia y comercio animales vivos. 

# CLEAN UP ----------------------------------------------------------------

# Remove all current environment variables
#rm(list = ls())
