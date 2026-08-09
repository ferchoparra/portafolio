#CARGA DE DATOS PREVIOS####
source("funciones.R")
#librerias
library(lmfor)
#importacion de tablas y modificaciones para correr el modelo
#tablas de crecimiento####
tablas<-c("tamI.csv","tamII.csv","tamIII.csv","tamIV.csv","tamV.csv",
          "tcaoI.csv","tcaoII.csv","tcaoIII.csv","tegI.csv","tegII.csv","tegIII.csv","tegIV.csv",
          "tegspI.csv","tegspII.csv","tegspIII.csv","tegspIV.csv","tetpcsI.csv","tetpcsII.csv" , "tetpcsIII.csv",
          "tetpcsIV.csv","teuI.csv","teuII.csv","teuIII.csv","teuIV.csv","tgaI.csv","tgaII.csv",
          "tgaIII.csv","tgaIV.csv","thbI.csv","thbII.csv","thbIII.csv","toaaI.csv","toaaII.csv",
          "toaaIII.csv","tpmcI.csv","tpmcII.csv","tpmcIII.csv","tpokI.csv","tpokII.csv","tpokIII.csv",
          "tpprspI.csv","tpprspII.csv","tpprspIII.csv","tpqtnI.csv","tpqtnII.csv","tpqtnIII.csv","tpteI.csv",
          "tpteII.csv","tpteIII.csv","ttgI.csv","ttgII.csv","ttgIII.csv")

tabcre<-list(tamI=NA,tamII=NA,tamIII=NA,tamIV=NA,tamV=NA,
             tcaoI=NA,tcaoII=NA,tcaoIII=NA,tegI=NA,tegII=NA,tegIII=NA,tegIV=NA,
             tegspI=NA,tegspII=NA,tegspIII=NA,tegspIV=NA,tetpcsI=NA,tetpcsII=NA,tetpcsIII=NA,
             tetpcsIV=NA,teuI=NA,teuII=NA,teuIII=NA,teuIV=NA,tgaI=NA,tgaII=NA,
             tgaIII=NA,tgaIV=NA,thbI=NA,thbII=NA,thbIII=NA,toaaI=NA,toaaII=NA,
             toaaIII=NA,tpmcI=NA,tpmcII=NA,tpmcIII=NA,tpokI=NA,tpokII=NA,tpokIII=NA,
             tpprspI=NA,tpprspII=NA,tpprspIII=NA,tpqtnI=NA,tpqtnII=NA,tpqtnIII=NA,tpteI=NA,
             tpteII=NA,tpteIII=NA,ttgI=NA,ttgII=NA,ttgIII=NA)

###importar###
for(i in 1:52){#52 tablas de crecimiento 15 con minimo 3 IS
  tabcre[[i]]<-read.csv(tablas[i],sep=";",dec = ".",header = TRUE)
  colnames(tabcre[[i]])<-c("Edad","Densidad","Mort","Dm","Hm","vm","vha","ica","ima")
}
#area basal##
for(i in 1:length(tabcre)){
  tabcre[[i]]["g"]<-pi*(tabcre[[i]]["Dm"]/200)^2*tabcre[[i]]["Densidad"]
}
#volumen total##
for(i in 1:length(tabcre)){
  tabcre[[i]]["voltotal"]<-tabcre[[i]]["Densidad"]*tabcre[[i]]["vm"]
}

#tabla base####
tabase<-read.csv("tablasMADR2021.csv",sep=";",dec = ",",header = TRUE)
tabase<-tabase[,c("zona","Dep","Mun","Especie","comun","sp","siembra","area","IS","base")]
#tabase$IS<-rep("I",nrow(tabase))
tabase<-tabase[!(tabase[,"sp"]%in%c("?","??")),]# deben quedar asignados desde el archivo base excel
str(tabase)
#factor forma####
#esto se utiliza en una de las formulas de volumen que se utilizan en alguans de las funciones del proceso II
ffp<-data.frame(V1=c(0.6999994,0.5599995,0.4599996,0.3799997,0.3749997,0.3669997,0.3549997,
                     0.3499997,0.3499997,0.3499997,0.3479997,0.3449997,0.3419997,0.3369997,
                     0.3369997,0.3365997,0.3345997,0.3345997,0.3340997,0.3334997))

ffa<-data.frame(V1=c(0.6899994,0.5799995,0.5199996,0.4899996,0.4249996,0.3849997,0.3679997,
                     0.3509997,0.3409997,0.3339997,0.3299997,0.3299997))

fft<-data.frame(V1=c(0.6499995,0.5799995,0.4799996,0.4199996,0.3699997,0.3529997,0.3489997,
                     0.3464997,0.3469997,0.3439997,0.3419997,0.3414997,0.3389997,0.3309997,
                     0.3269997,0.3259997,0.3209997,0.3159997,0.3139997,0.3139997))

ffm<-data.frame(V1=c(0.6399995,0.5699995,0.5199996,0.4899996,0.4149996,0.3749997,0.3579997,
                     0.3399997,0.3299997,0.3229997,0.3209997,0.3209997))

ffe<-data.frame(V1=c(0.6899994,0.5799995,0.5199996,0.4699996,0.4149996,0.3699997,0.3549997,
                     0.3479997,0.3429997,0.3399997))

ffo<-data.frame(V1=c(0.6999994,0.5599995,0.4599996,0.3799997,0.3749997,0.3669997,0.3549997,
                     0.3499997,0.3499997,0.3459997,0.345999708,0.344999709,0.341999711,0.336999715,
                     0.336599716,0.336599716,0.334299718,0.334299718,0.334099718,0.333999718))




#SIMULACION####
#proceso I####
reg1<-registros("base","todas","todos","todas","todos")#Base profor (base,dummy,todos)
reg1$mod<-paste(reg1$sp,reg1$IS,sep = "")#si no se usa newreg

#proceso II####
#definir manejo
manreal<-manejo(tabcre)


#indices de utilizacion a implementar
IU<-c(20,15,5)
nIU<-c("IU_20","IU_15","IU_5")

#funcion proceso
system.time(pruebareal<-volproc("si",manreal,tabcre,1,IU,nIU,"vah"))#casi dos minutos
resumen(pruebareal,manreal,"si")

#proceso III####
system.time(VOL<-procIII(reg1,pruebareal,"con raleo",2041,nIU,manreal))

VOLsinreRaleo<-VOL[VOL[,"codrad1"]==1,]
VOLsinreApro<-VOL[VOL[,"codrad2"]==1,]
VOLconreRaleo<-VOL[VOL[,"codrad3"]==1,]
VOLconreApro<-VOL[VOL[,"codrad4"]==1,]

write.csv(VOLsinreRaleo,"volRaleoSR_2021.csv")
write.csv(VOLsinreApro,"volAproSR_2021.csv")
write.csv(VOLconreRaleo,"volRaleoCR_2021.csv")
write.csv(VOLconreApro,"volAproCR_2021.csv")


library(openxlsx)

write.xlsx(VOLsinreRaleo, file = "volRaleoSR_2021.xlsx")
write.xlsx(VOLconreRaleo, file = "volRaleoCR_2021.xlsx")

write.xlsx(VOLsinreApro, file = "volAproSR_2021.xlsx")
write.xlsx(VOLconreApro, file = "volAproCR_2021.xlsx")
