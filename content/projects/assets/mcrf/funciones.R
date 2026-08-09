



####Proceso I####
#Seleccion de registros#


#funcion para seleccionar que registros usar
#nota despues de usar esta funcion toca agregar regreal$mod<-paste(regreal$sp,regreal$IS,sep = ""), si no se usa la siguiente funcion newreg
registros<-function(base,zona,dept,especie,reg){#se modifico, funcion para determinar registros por zona (usar "todas"), departamento (usar "todos") y especie (uasr "todas", regsitros usar "todos")
  if(zona=="todas"){
    tabasen<-tabase
  }else{tabasen<-tabase[tabase[,"zona"]==zona,]}
  if(dept=="todos"){
    tabasen<-tabasen
  }else{tabasen<-tabasen[tabasen[,"Dep"]==dept,]}
  if(especie=="todas"){
    tabasen<-tabasen
  }else{tabasen<-tabasen[tabasen[,"Especie"]==especie,]}
  if(reg=="todos"){
    tabasen<-tabasen
  }else{tabasen<-tabasen[tabasen[,"reg"]==reg,]}
  if(base=="todos"){
    tabasen<-tabasen
  }else{tabasen<-tabasen[tabasen[,"base"]==base,]}
  tabasen$reg<-as.character(seq(1,nrow(tabasen),1))
  tabasen
}

#funcion para agregar nuevos registros, de manera individual o mediante una tabla importada desde excel u otro formato
newreg<-function(registab,zona,dept,mun,Especie,sp,siembra,area,IS,tabon,tab){#se modifico
  if(tabon=="on"){
    tabla<-rbind(registab,tab)
  }else{tabla<-rbind(registab,c(zona,dept,mun,Especie,NA,sp,siembra,area,IS,base=NA,reg=NA))}
  tabla$reg<-as.character(seq(1,nrow(tabla),1))
  tabla$mod<-paste(tabla$sp,tabla$IS,sep = "")
  tabla
}




####PROCESO II####
#modificar tablas de crecimiento y calculo de volumen#

#funcion definir manejo (raleos) 
manejo<-function(tabcre){#parametros: tabcre es las 52 tablas de crecimiento
  raleo<-list()
  raleo[1][[1]]<-c(2,c(4,8),c(16,23),1,12)#tamI
  raleo[2][[1]]<-c(2,c(5,9),c(16,21),1,12)#tamII
  raleo[3][[1]]<-c(2,c(6,9),c(16,19),1,12)#tamIII
  raleo[4][[1]]<-c(2,c(6,9),c(14,16),1,12)#tamIV
  raleo[5][[1]]<-c(2,c(7,10),c(13,14),1,12)#tamV
  
  raleo[6][[1]]<-c(2,c(7,12),c(17,21),1,20)#tcaoI
  raleo[7][[1]]<-c(2,c(8,13),c(17,21),1,20)#tcaoII
  raleo[8][[1]]<-c(2,c(9,14),c(16,18),1,20)#tcaoIII
  
  raleo[9][[1]]<-c(2,c(4,7),c(16,21),1,10)#tegI
  raleo[10][[1]]<-c(2,c(4,7),c(15,19),1,10)#tegII
  raleo[11][[1]]<-c(2,c(4,7),c(12,16),1,10)#tegIII
  raleo[12][[1]]<-c(2,c(4,7),c(10,15),1,10)#tegIV
  
  raleo[13][[1]]<-c(2,c(4,7),c(14,18),1,10)#tegspI
  raleo[14][[1]]<-c(2,c(4,7),c(13,16),1,10)#tegspII
  raleo[15][[1]]<-c(2,c(4,7),c(10,14),1,10)#tegspIII
  raleo[16][[1]]<-c(2,c(4,7),c(9,13),1,10)#tegspIV
  
  raleo[17][[1]]<-c(2,c(4,7),c(15,19),1,10)#tetpcsI
  raleo[18][[1]]<-c(2,c(4,7),c(14,17),1,10)#tetpcsII
  raleo[19][[1]]<-c(2,c(4,7),c(11,14),1,10)#tetpcsIII
  raleo[20][[1]]<-c(2,c(4,7),c(10,13),1,10)#tetpcsIV
  
  raleo[21][[1]]<-c(2,c(4,7),c(17,22),1,10)#teuI
  raleo[22][[1]]<-c(2,c(4,7),c(16,20),1,10)#teuII
  raleo[23][[1]]<-c(2,c(4,7),c(13,17),1,10)#teuIII
  raleo[24][[1]]<-c(2,c(4,7),c(11,16),1,10)#teuIV
  
  raleo[25][[1]]<-c(2,c(4,8),c(13,18),1,12)#tgaI
  raleo[26][[1]]<-c(2,c(4,8),c(11,16),1,12)#tgaII
  raleo[27][[1]]<-c(2,c(4,8),c(10,15),1,12)#tgaIII
  raleo[28][[1]]<-c(2,c(4,8),c(9,14),1,12)#tgaIV
  
  raleo[29][[1]]<-c(0,c(0),c(0),1,20)#thbI
  raleo[30][[1]]<-c(0,c(0),c(0),1,20)#thbII
  raleo[31][[1]]<-c(0,c(0),c(0),1,20)#thbIII
  
  raleo[32][[1]]<-c(2,c(4,8),c(11,16),1,12)#toaaI
  raleo[33][[1]]<-c(2,c(4,8),c(8,15),1,12)#toaaII
  raleo[34][[1]]<-c(2,c(4,8),c(7,14),1,12)#toaaIII
  
  raleo[35][[1]]<-c(2,c(5,10),c(18,24),1,20)#tpmc
  raleo[36][[1]]<-c(2,c(6,11),c(19,24),1,20)#tpmc
  raleo[37][[1]]<-c(2,c(6,11),c(16,21),20)#tpmc
  
  raleo[38][[1]]<-c(2,c(5,10),c(18,24),1,20)#tpok
  raleo[39][[1]]<-c(2,c(6,11),c(18,23),1,20)#tpok
  raleo[40][[1]]<-c(2,c(6,11),c(16,20),1,20)#tpok
  
  raleo[41][[1]]<-c(2,c(5,10),c(17,23),1,20)#tpprsp
  raleo[42][[1]]<-c(2,c(6,11),c(16,22),1,20)#tpprsp
  raleo[43][[1]]<-c(2,c(6,11),c(15,20),1,20)#tpprsp
  
  raleo[44][[1]]<-c(2,c(7,12),c(16,20),1,20)#tpqtn
  raleo[45][[1]]<-c(2,c(8,13),c(16,20),1,20)#tpqtn
  raleo[46][[1]]<-c(2,c(8,13),c(13,17),1,20)#tpqtn
  
  raleo[47][[1]]<-c(2,c(5,10),c(19,26),1,20)#tpte
  raleo[48][[1]]<-c(2,c(6,11),c(20,25),1,20)#tpte
  raleo[49][[1]]<-c(2,c(6,11),c(17,22),1,20)#tpte
  
  raleo[50][[1]]<-c(3,c(5,10,16),c(16,21,25),1,20)#ttg
  raleo[51][[1]]<-c(3,c(7,12,18),c(18,23,25),1,20)#ttg
  raleo[52][[1]]<-c(2,c(8,15),c(19,23),1,20)#ttg #el cuato IS no esta para teca
  mod=names(tabcre)
  esqmanejo<-list(manejo=raleo)
  names(esqmanejo$manejo)<-mod
  esqmanejo<-edit(esqmanejo)
}


#funcion que modifica las tablas de crecimiento mediante los manejos seleccionados en la anterior funcion (manejo)
#esta funcion disminuye el numero de individuos en los años de raleo y calcula el volumen que se extrajo
tabmanejo2<-function(tabcre,esqmanejo){#parametros: tabcre es las 52 tablas de crecimiento, esquemanejo es el objeto de la función manejo
  ahk<-pi/40000
  library(lmfor)
  for(i in 1:length(tabcre)){
    tabcre[[i]][,"volraleo"]<-0
    tabcre[[i]][,"volsinraleo"]<-0#nueva linea
    if(esqmanejo$manejo[[i]][1]!=0){
      for(j in 1:esqmanejo$manejo[[i]][1]){
        d<-tabcre[[i]][esqmanejo$manejo[[i]][(j+1)],"Dm"]
        g<-tabcre[[i]][esqmanejo$manejo[[i]][(j+1)],"g"]
        n<-tabcre[[i]][esqmanejo$manejo[[i]][(j+1)],"Densidad"]
        Fu<-recweib(g,n,d,"C")[1:2]
        clase<-seq(2,ceiling(qweibull(0.999,shape=Fu$shape,scale=Fu$scale,lower.tail=TRUE)),1)#generar clases diametricas
        clase<-c(clase,(tail(clase,1)+1))#asignar una clase mas para mantener todos los individuos especialmente los ultimos que son los mas grandes
        prob<-pweibull(clase,shape=Fu$shape,scale=Fu$scale,lower.tail=TRUE,log.p=FALSE)#probabilidad para el percentil de cada clase diametrica
        n<-tabcre[[i]][esqmanejo$manejo[[i]][(j+1)],"Densidad"]*prob[1]#probabilidad clase uno
        for(l in 2:length(clase)){
          ni<-tabcre[[i]][esqmanejo$manejo[[i]][(j+1)],"Densidad"]*(prob[l]-prob[l-1])
          n<-c(n,ni)
        }
        volind<-vector(length = length(clase))
        for(m in 1:length(clase)){
          if(names(tabcre[i])%in% c("tamI","tamII","tamIII","tamIV","tamV","toaaI","toaaII","toaaIII")){
            h<-1.6016+0.9034*clase
            ah<-function(hi){ahga(hi,clase[m],h[m])}  
          }else if(names(tabcre[i])%in% c("tpteI","tpteII","tpteIII","tpokI","tpokII","tpokIII","tpmcI","tpmcII","tpmcIII")){
            h<-0.005*clase^2+0.4433*clase+1.3577
            ah<-function(hi){ahp1(hi,clase[m],h[m])}
          }else if(names(tabcre[i])%in% c("tpprspI","tpprspII","tpprspIII")){
            h<-0.005*clase^2+0.4433*clase+1.3577
            ah<-function(hi){ahp2(hi,clase[m],h[m])}
          }else if(names(tabcre[i])%in% c("ttgI","ttgII","ttgIII")){
            h<-0.0232*clase^2+0.2594*clase+1.4244
            ah<-function(hi){ahtg(hi,clase[m],h[m])}
          }else if(names(tabcre[i])%in% c("tgaI","tgaII","tgaIII","tgaIV")){
            h<-1.6016+0.9034*clase
            ah<-function(hi){ahga(hi,clase[m],h[m])}
          }else if(names(tabcre[i])%in% c("teuI","teuII","teuIII","teuIV","tegI","tegII","tegIII","tegIV","tegspI","tegspII","tegspIII","tegspIV")){
            h<-1.4959*clase-0.0119*clase^2
            ah<-function(hi){ahe1(hi,clase[m],h[m])}
          }else if(names(tabcre[i])%in% c("tetpcsI","tetpcsII","tetpcsIII","tetpcsIV")){
            h<-1.4959*clase-0.0119*clase^2
            ah<-function(hi){ahe2(hi,clase[m],h[m])}
          }else{
            h<-0.0232*clase^2+0.2594*clase+1.4244
            ah<-function(hi){ahn(hi,clase[m],h[m])}}
          volind[m]<-ahk*integrate(ah,0.2,h[m])$value#cambio
        }
        ral<-data.frame(cbind(clase,n,h,volind))
        if(j!=1){#nuevo if para excluir los arboles que ya fueron raleados, solo aplica para despues del primer raleo
          if(esqmanejo$manejo[[i]][(length(esqmanejo$manejo[[i]])-1)]==1){
            ninf<-sum(ral[ral[,"clase"]<=esqmanejo$manejo[[i]][esqmanejo$manejo[[i]][1]+j],"n"])
            ral[ral[,"clase"]<=esqmanejo$manejo[[i]][esqmanejo$manejo[[i]][1]+j],"n"]<-0
            ral[ral[,"clase"]>esqmanejo$manejo[[i]][(esqmanejo$manejo[[i]][1]+j)],"n"]<-ral[ral[,"clase"]>esqmanejo$manejo[[i]][esqmanejo$manejo[[i]][1]+j],"n"]+(ninf/nrow(ral[ral[,"clase"]>esqmanejo$manejo[[i]][esqmanejo$manejo[[i]][1]+j],]))
          }else{ninf<-sum(ral[ral[,"clase"]<=round(qweibull(esqmanejo$manejo[[i]][(esqmanejo$manejo[[i]][1]+j)]/100,shape=Fu$shape,scale=Fu$scale,lower.tail=TRUE,log.p=FALSE)),"n"])
          ral[ral[,"clase"]<=round(qweibull(esqmanejo$manejo[[i]][(esqmanejo$manejo[[i]][1]+j)]/100,shape=Fu$shape,scale=Fu$scale,lower.tail=TRUE,log.p=FALSE)),"n"]<-0
          ral[ral[,"clase"]>round(qweibull(esqmanejo$manejo[[i]][(esqmanejo$manejo[[i]][1]+j)]/100,shape=Fu$shape,scale=Fu$scale,lower.tail=TRUE,log.p=FALSE)),"n"]<-ral[ral[,"clase"]>round(qweibull(esqmanejo$manejo[[i]][(esqmanejo$manejo[[i]][1]+j)]/100,shape=Fu$shape,scale=Fu$scale,lower.tail=TRUE,log.p=FALSE)),"n"]+(ninf/nrow(ral[ral[,"clase"]>round(qweibull(esqmanejo$manejo[[i]][(esqmanejo$manejo[[i]][1]+j)]/100,shape=Fu$shape,scale=Fu$scale,lower.tail=TRUE,log.p=FALSE)),]))
          }
          ral
        }
        ral[,"volr"]<-ral[,"n"]*ral[,"volind"]#cambio
        if(esqmanejo$manejo[[i]][(length(esqmanejo$manejo[[i]])-1)]==1){
          nn<-sum(ral[ral[,"clase"]>esqmanejo$manejo[[i]][(esqmanejo$manejo[[i]][1]+1+j)],"n"])
          tabcre[[i]][esqmanejo$manejo[[i]][(j+1)],"volraleo"]<-sum(ral[ral[,"clase"]<=esqmanejo$manejo[[i]][(esqmanejo$manejo[[i]][1]+1+j)],"volr"])
        }else{nn<-sum(ral[,"n"])-(sum(ral[,"n"])*esqmanejo$manejo[[i]][(esqmanejo$manejo[[i]][1]+1+j)]/100)
        tabcre[[i]][esqmanejo$manejo[[i]][(j+1)],"volraleo"]<-sum(ral[ral[,"clase"]<=round(qweibull(esqmanejo$manejo[[i]][(esqmanejo$manejo[[i]][1]+1+j)]/100,shape=Fu$shape,scale=Fu$scale,lower.tail=TRUE,log.p=FALSE)),"volr"])#cambio en > por <=
        }
        tabcre[[i]][esqmanejo$manejo[[i]][(j+1)],"volsinraleo"]<-sum(ral[,"volr"])#nueva linea
        tabcre[[i]][esqmanejo$manejo[[i]][(j+1)],"Densidad"]<-as.integer(round(nn))
        for(k in (esqmanejo$manejo[[i]][(j+1)]+1):nrow(tabcre[[i]])){#edad de raleo hasta el final
          tabcre[[i]][k,"Densidad"]<-as.integer(round(tabcre[[i]][(k-1),"Densidad"]-(tabcre[[i]][(k-1),"Densidad"]*(tabcre[[i]][k,"Mort"]/100))))
        }
        tabcre[[i]][,"g"]<-pi*(tabcre[[i]]["Dm"]/200)^2*tabcre[[i]]["Densidad"]
        tabcre[[i]]["voltotal"]<-tabcre[[i]]["Densidad"]*tabcre[[i]]["vm"]
      }
    }else{tabcre[[i]]<-tabcre[[i]]}
  }
  tabcre
}




#funcion Etapa 2, desagrega cada año de cada tabla de crecimiento en tablas por clases diametricas (cada dos cm) mediante la implementacion de la distribucion de weibull, para cada clase se calcula la altura y volumen 
Etapa2<-function(tabcre){#parametros: tabcre es las 52 tablas de crecimiento, aqui esta la opción de utilizar las 52 tablas de crecimiento originales o las modificadas por manejo osea la salida de la funcion tabmanejo2
  E2edad<-list()
  library(lmfor)
  for(i in 1:length(tabcre)){
    
    if(names(tabcre[i])%in% c("tamI","tamII","tamIII","tamIV","tamV","toaaI","toaaII","toaaIII")){
      F2mod1<-list()
      for(j in 1:nrow(tabcre[[i]])){#con esto se encuentra la forma y escala de la distribucion para un registro o una tabla de crecimiento
        d<-tabcre[[i]][j,"Dm"]
        g<-tabcre[[i]][j,"g"]
        n<-tabcre[[i]][j,"Densidad"]
        F2mod1[[j]]<-recweib(g,n,d,"C")[1:2]
      }
      edad<-list()
      options(scipen = 999)
      #options(scipen = 0)
      for(k in 1:length(F2mod1)){
        clase<-seq(2,ceiling(qweibull(0.999,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE)),1)#generar clases diametricas
        clase<-c(clase,(tail(clase,1)+1))#asignar una clase mas para mantener todos los individuos especialmente los ultimos que son los mas grandes
        prob<-pweibull(clase,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE,log.p=FALSE)#probabilidad para el percentil de cada clase diametrica
        n<-tabcre[[i]][k,"Densidad"]*prob[1]#probabilidad clase uno
        for(l in 2:length(clase)){
          ni<-tabcre[[i]][k,"Densidad"]*(prob[l]-prob[l-1])
          n<-c(n,ni)
        }
        h<-1.6016+0.9034*clase #altura
        v<-pi*(clase/200)^2*h*n*ffa[k,1]#volumen
        edad[[k]]<-as.data.frame(cbind(clase,n,h,v)) #tabla edad
      }
      
    }else if(names(tabcre[i])%in% c("tpteI","tpteII","tpteIII","tpokI","tpokII","tpokIII","tpmcI","tpmcII","tpmcIII","tpprspI","tpprspII","tpprspIII")){
      F2mod1<-list()
      for(j in 1:nrow(tabcre[[i]])){#con esto se encuentra la forma y escala de la distribucion para un registro o una tabla de crecimiento
        d<-tabcre[[i]][j,"Dm"]
        g<-tabcre[[i]][j,"g"]
        n<-tabcre[[i]][j,"Densidad"]
        F2mod1[[j]]<-recweib(g,n,d,"C")[1:2]
      }
      edad<-list()
      options(scipen = 999)
      #options(scipen = 0)
      for(k in 1:length(F2mod1)){
        clase<-seq(2,ceiling(qweibull(0.999,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE)),1)#generar clases diametricas
        clase<-c(clase,(tail(clase,1)+1))#asignar una clase mas para mantener todos los individuos especialmente los ultimos que son los mas grandes
        prob<-pweibull(clase,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE,log.p=FALSE)#probabilidad para el percentil de cada clase diametrica
        n<-tabcre[[i]][k,"Densidad"]*prob[1]#probabilidad clase uno
        for(l in 2:length(clase)){
          ni<-tabcre[[i]][k,"Densidad"]*(prob[l]-prob[l-1])
          n<-c(n,ni)
        }
        h<-0.005*clase^2+0.4433*clase+1.3577 #altura
        v<-pi*(clase/200)^2*h*n*ffp[k,1]#volumen
        edad[[k]]<-as.data.frame(cbind(clase,n,h,v)) #tabla edad
      }
    }else if(names(tabcre[i])%in% c("ttgI","ttgII","ttgIII")){#FALTAN ECUACION DE ALTURA
      F2mod1<-list()
      for(j in 1:nrow(tabcre[[i]])){#con esto se encuentra la forma y escala de la distribucion para un registro o una tabla de crecimiento
        d<-tabcre[[i]][j,"Dm"]
        g<-tabcre[[i]][j,"g"]
        n<-tabcre[[i]][j,"Densidad"]
        F2mod1[[j]]<-recweib(g,n,d,"C")[1:2]
      }
      edad<-list()
      options(scipen = 999)
      #options(scipen = 0)
      for(k in 1:length(F2mod1)){
        clase<-seq(2,ceiling(qweibull(0.999,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE)),1)#generar clases diametricas
        clase<-c(clase,(tail(clase,1)+1))#asignar una clase mas para mantener todos los individuos especialmente los ultimos que son los mas grandes
        prob<-pweibull(clase,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE,log.p=FALSE)#probabilidad para el percentil de cada clase diametrica
        n<-tabcre[[i]][k,"Densidad"]*prob[1]#probabilidad clase uno
        for(l in 2:length(clase)){
          ni<-tabcre[[i]][k,"Densidad"]*(prob[l]-prob[l-1])
          n<-c(n,ni)
        }
        h<-0.0232*clase^2+0.2594*clase+1.4244 #altura FALTA
        v<-pi*(clase/200)^2*h*n*fft[k,1]#volumen
        edad[[k]]<-as.data.frame(cbind(clase,n,h,v)) #tabla edad
      }
    }else if(names(tabcre[i])%in% c("tgaI","tgaII","tgaIII","tgaIV")){
      F2mod1<-list()
      for(j in 1:nrow(tabcre[[i]])){#con esto se encuentra la forma y escala de la distribucion para un registro o una tabla de crecimiento
        d<-tabcre[[i]][j,"Dm"]
        g<-tabcre[[i]][j,"g"]
        n<-tabcre[[i]][j,"Densidad"]
        F2mod1[[j]]<-recweib(g,n,d,"C")[1:2]
      }
      edad<-list()
      options(scipen = 999)
      #options(scipen = 0)
      for(k in 1:length(F2mod1)){
        clase<-seq(2,ceiling(qweibull(0.999,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE)),1)#generar clases diametricas
        clase<-c(clase,(tail(clase,1)+1))#asignar una clase mas para mantener todos los individuos especialmente los ultimos que son los mas grandes
        prob<-pweibull(clase,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE,log.p=FALSE)#probabilidad para el percentil de cada clase diametrica
        n<-tabcre[[i]][k,"Densidad"]*prob[1]#probabilidad clase uno
        for(l in 2:length(clase)){
          ni<-tabcre[[i]][k,"Densidad"]*(prob[l]-prob[l-1])
          n<-c(n,ni)
        }
        h<-1.6016+0.9034*clase #altura
        v<-pi*(clase/200)^2*h*n*ffm[k,1]#volumen
        edad[[k]]<-as.data.frame(cbind(clase,n,h,v)) #tabla edad
      }
    }else if(names(tabcre[i])%in% c("tegI","tegII","tegIII","tegIV","tegspI","tegspII","tegspIII","tegspIV","tetpcsI","tetpcsII","tetpcsIII","tetpcsIV","teuI","teuII","teuIII","teuIV")){
      F2mod1<-list()
      for(j in 1:nrow(tabcre[[i]])){#con esto se encuentra la forma y escala de la distribucion para un registro o una tabla de crecimiento
        d<-tabcre[[i]][j,"Dm"]
        g<-tabcre[[i]][j,"g"]
        n<-tabcre[[i]][j,"Densidad"]
        F2mod1[[j]]<-recweib(g,n,d,"C")[1:2]
      }
      edad<-list()
      options(scipen = 999)
      #options(scipen = 0)
      for(k in 1:length(F2mod1)){
        clase<-seq(2,ceiling(qweibull(0.999,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE)),1)#generar clases diametricas
        clase<-c(clase,(tail(clase,1)+1))#asignar una clase mas para mantener todos los individuos especialmente los ultimos que son los mas grandes
        prob<-pweibull(clase,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE,log.p=FALSE)#probabilidad para el percentil de cada clase diametrica
        n<-tabcre[[i]][k,"Densidad"]*prob[1]#probabilidad clase uno
        for(l in 2:length(clase)){
          ni<-tabcre[[i]][k,"Densidad"]*(prob[l]-prob[l-1])
          n<-c(n,ni)
        }
        h<-1.4959*clase-0.0119*clase^2 #altura
        v<-pi*(clase/200)^2*h*n*ffe[k,1]#volumen
        edad[[k]]<-as.data.frame(cbind(clase,n,h,v)) #tabla edad
      }    
    }else if(names(tabcre[i])%in% c("tpqtnI","tpqtnII","tpqtnIII")){
      F2mod1<-list()
      for(j in 1:nrow(tabcre[[i]])){#con esto se encuentra la forma y escala de la distribucion para un registro o una tabla de crecimiento
        d<-tabcre[[i]][j,"Dm"]
        g<-tabcre[[i]][j,"g"]
        n<-tabcre[[i]][j,"Densidad"]
        F2mod1[[j]]<-recweib(g,n,d,"C")[1:2]
      }
      edad<-list()
      options(scipen = 999)
      #options(scipen = 0)
      for(k in 1:length(F2mod1)){
        clase<-seq(2,ceiling(qweibull(0.999,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE)),1)#generar clases diametricas
        clase<-c(clase,(tail(clase,1)+1))#asignar una clase mas para mantener todos los individuos especialmente los ultimos que son los mas grandes
        prob<-pweibull(clase,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE,log.p=FALSE)#probabilidad para el percentil de cada clase diametrica
        n<-tabcre[[i]][k,"Densidad"]*prob[1]#probabilidad clase uno
        for(l in 2:length(clase)){
          ni<-tabcre[[i]][k,"Densidad"]*(prob[l]-prob[l-1])
          n<-c(n,ni)
        }
        h<-0.0232*clase^2+0.2594*clase+1.4244 #altura
        v<-pi*(clase/200)^2*h*n*ffo[k,1]#volumen
        edad[[k]]<-as.data.frame(cbind(clase,n,h,v)) #tabla edad
      }}else{
        F2mod1<-list()
        for(j in 1:nrow(tabcre[[i]])){#con esto se encuentra la forma y escala de la distribucion para un registro o una tabla de crecimiento
          d<-tabcre[[i]][j,"Dm"]
          g<-tabcre[[i]][j,"g"]
          n<-tabcre[[i]][j,"Densidad"]
          F2mod1[[j]]<-recweib(g,n,d,"C")[1:2]
        }
        edad<-list()
        options(scipen = 999)
        #options(scipen = 0)
        for(k in 1:length(F2mod1)){
          clase<-seq(2,ceiling(qweibull(0.999,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE)),1)#generar clases diametricas
          clase<-c(clase,(tail(clase,1)+1))#asignar una clase mas para mantener todos los individuos especialmente los ultimos que son los mas grandes
          prob<-pweibull(clase,shape=F2mod1[[k]]$shape,scale=F2mod1[[k]]$scale,lower.tail=TRUE,log.p=FALSE)#probabilidad para el percentil de cada clase diametrica
          n<-tabcre[[i]][k,"Densidad"]*prob[1]#probabilidad clase uno
          for(l in 2:length(clase)){
            ni<-tabcre[[i]][k,"Densidad"]*(prob[l]-prob[l-1])
            n<-c(n,ni)
          }
          h<-0.0232*clase^2+0.2594*clase+1.4244 #altura
          v<-pi*(clase/200)^2*h*n*ffo[k,1]#volumen
          edad[[k]]<-as.data.frame(cbind(clase,n,h,v)) #tabla edad
        }
      }    
    E2edad[[names(tabcre[i])]]<-edad
  }
  E2edad
}

#funcion para mejorar volumenes con raleo
Etapa2cor<-function(etapa2,esquema){
  for(i in 1:length(etapa2)){#k tabla
    for(m in 1:length(etapa2[[i]])){
      etapa2[[i]][[m]]["vffind"]<-etapa2[[i]][[m]]["v"]/etapa2[[i]][[m]]["n"]
    }
    if(esquema$manejo[[i]][1]!=0){#equema
      for(j in 1:esquema$manejo[[i]][1]){
        for(k in (esquema$manejo[[i]][(j+1)]+1):length(etapa2[[i]])){#edad
          ninf<-sum(etapa2[[i]][[k]][etapa2[[i]][[k]][,"clase"]<=esquema$manejo[[i]][esquema$manejo[[i]][1]+1+j],"n"])
          etapa2[[i]][[k]][etapa2[[i]][[k]][,"clase"]<=esquema$manejo[[i]][esquema$manejo[[i]][1]+1+j],"n"]<-0
          etapa2[[i]][[k]][etapa2[[i]][[k]][,"clase"]>esquema$manejo[[i]][esquema$manejo[[i]][1]+1+j],"n"]<-
            etapa2[[i]][[k]][etapa2[[i]][[k]][,"clase"]>esquema$manejo[[i]][esquema$manejo[[i]][1]+1+j],"n"]+
            (ninf/length(etapa2[[i]][[k]][etapa2[[i]][[k]][,"clase"]>esquema$manejo[[i]][esquema$manejo[[i]][1]+1+j],"n"]))
          
        } 
      } 
    }
    for(m in 1:length(etapa2[[i]])){
      etapa2[[i]][[m]]["v"]<-etapa2[[i]][[m]]["vffind"]*etapa2[[i]][[m]]["n"]
    }
  }
  etapa2
}



#funciones de ahusamiento para poder calcular volumen total y volumen hasta la altura donde ocurra un diametro especifico
#los parametros de estas funciones son hi altura i, d diametro medio, h altura media
ahp1<-function(hi,d,h){#funcon para los siguientes modelos: tpte,tpok,tpmc.
  I1<-ifelse((0.50222-(hi/h))>0,1,0)
  I2<-ifelse((0.12113-(hi/h))>0,1,0)
  d^2*(-1.77809*((hi/h)-1)+
         0.73761*((hi/h)^2-1)-
         1.80441*(0.50222-(hi/h))^2*I1+
         26.30485*(0.12113-(hi/h))^2*I2)
}


ahp2<-function(hi,d,h){#modelo: tpprsp
  (1.82322*d^(0.63366)*1.01470^d*((1-sqrt(hi/h))/(1-sqrt(0.15)))^(1.39529*(hi/h)^2-0.27545*log((hi/h)+0.001)+
                                                                    2.12982*sqrt(hi/h)-1.17718*exp(hi/h)+
                                                                    0.29926*(d/h)))^2
}

ahtg<-function(hi,d,h){#ttg
  I1<-ifelse((0.9994-(hi/h))>0,1,0)
  I2<-ifelse((0.12404-(hi/h))>0,1,0)
  d^2*(-4.1845*((hi/h)-1)+
         1.9274*((hi/h)^2-1)-
         1.4046*(0.9994-(hi/h))^2*I1+
         60.9044*(0.12404-(hi/h))^2*I2)
}

ahga<-function(hi,d,h){#di^2, tga
  (1.83205*d^(0.62205)*1.01703^d*((1-sqrt(hi/h))/(1-sqrt(0.17)))^(1.3976*(hi/h)^2-0.2999*log((hi/h)+0.001)+
                                                                    2.1363*sqrt(hi/h)-1.1586*exp(hi/h)+
                                                                    0.31409*(d/h)))^2
}


ahe1<-function(hi,d,h){#teu, teg, tegsp 
  x<-((h-hi)/(h-1.3))
  d^2*(0.82414*x^1.5-0.01143*(x^1.5-x^3)*d+
         0.001184*(x^1.5-x^3)*h+
         0.000136*(x^1.5-x^32)*h*d+
         0.0048236*(x^1.5-x^32)*h^0.5-
         0.00012749*(x^1.5-x^40)*h^2)
}


ahe2<-function(hi,d,h){#tetpcs
  x<-((h-hi)/(h-1.3))
  d^2*(0.8229*x^1.5-0.0297*(x^1.5-x^3)*d+
         0.0293*(x^1.5-x^3)*h+
         0.0000771*(x^1.5-x^32)*h*d+
         0.02685*(x^1.5-x^32)*h^0.5-
         0.0003088*(x^1.5-x^40)*h^2)
}



ahn<-function(hi,d,h){#di^2, tpqtn, tcao, thb
  (1.8197*d^(0.6189)*1.0171^d*((1-sqrt(hi/h))/(1-sqrt(0.16)))^(1.3998*(hi/h)^2-0.3006*log((hi/h)+0.001)+
                                                                 2.1399*sqrt(hi/h)-1.1499*exp(hi/h)+
                                                                 0.3198*(d/h)))^2
}


#funcion para calcular el volumen total mediante las funciones de ahusamiento, se hace para cada edad y clase de diametro
volah<-function(E2edad){#parametros: E2edad es la salida de la anterior funcion Etapa2
  ahk<-pi/40000
  for(k in 1:length(E2edad)){
    for(i in 1:length(E2edad[[k]])){
      for(j in 1:nrow(E2edad[[k]][[i]])){
        if(names(E2edad[k])%in% c("tamI","tamII","tamIII","tamIV","tamV","toaaI","toaaII","toaaIII")){
          ah<-function(hi){ahga(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}#falta asginar a acacia y alnus
        }else if(names(E2edad[k])%in% c("tpteI","tpteII","tpteIII","tpokI","tpokII","tpokIII","tpmcI","tpmcII","tpmcIII")){
          ah<-function(hi){ahp1(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
        }else if(names(E2edad[k])%in% c("tpprspI","tpprspII","tpprspIII")){
          ah<-function(hi){ahp2(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
        }else if(names(E2edad[k])%in% c("ttgI","ttgII","ttgIII")){
          ah<-function(hi){ahtg(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
        }else if(names(E2edad[k])%in% c("tgaI","tgaII","tgaIII","tgaIV")){
          ah<-function(hi){ahga(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
        }else if(names(E2edad[k])%in% c("teuI","teuII","teuIII","teuIV","tegI","tegII","tegIII","tegIV","tegspI","tegspII","tegspIII","tegspIV")){
          ah<-function(hi){ahe1(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
        }else if(names(E2edad[k])%in% c("tetpcsI","tetpcsII","tetpcsIII","tetpcsIV")){
          ah<-function(hi){ahe2(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
        }else{ah<-function(hi){ahn(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}}
        E2edad[[k]][[i]][j,"vah"]<-ahk*integrate(ah,0.2,E2edad[[k]][[i]][j,"h"])$value*E2edad[[k]][[i]][j,"n"]
      }
    }
  }
  E2edad
}


#funcion para calcular el volumen hasta la altura donde ocurre un diametro especifico, a esto se le llama indice de utilización IU. Esta funcion se puede utilizar varias veces para generar diferentes volumenes con difirentes IU
volIU<-function(IU,E2edad){#parametros: IU es el indice de utilizacion osea el diametro que se especifica, E2edad es el objeto generado de la funcion volah (tambien se puede usar el de la funcion Etapa2, pero este no incluiria el volumen total de ahusamiento)
  ahk<-pi/40000
  nom<-paste("IU",IU,sep="_")
  for(k in 1:length(E2edad)){
    for(i in 1:length(E2edad[[k]])){
      for(j in 1:nrow(E2edad[[k]][[i]])){
        if(E2edad[[k]][[i]][j,"clase"]<=IU){# cuando el IU es menor al dap se toma como un volumen de cero
          E2edad[[k]][[i]][j,nom]<-0
        }else{# problemas con la funcion de ahusamiento para integrar 
          hi<-seq(0.1,E2edad[[k]][[i]][j,"h"],0.01)  
          if(names(E2edad[k])%in% c("tamI","tamII","tamIII","tamIV","tamV","toaaI","toaaII","toaaIII")){
            ah<-function(hi){ahga(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}#falta asginar a acacia y alnus
          }else if(names(E2edad[k])%in% c("tpteI","tpteII","tpteIII","tpokI","tpokII","tpokIII","tpmcI","tpmcII","tpmcIII")){
            ah<-function(hi){ahp1(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
          }else if(names(E2edad[k])%in% c("tpprspI","tpprspII","tpprspIII")){
            ah<-function(hi){ahp2(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
          }else if(names(E2edad[k])%in% c("ttgI","ttgII","ttgIII")){
            ah<-function(hi){ahtg(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
          }else if(names(E2edad[k])%in% c("tgaI","tgaII","tgaIII","tgaIV")){
            ah<-function(hi){ahga(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
          }else if(names(E2edad[k])%in% c("teuI","teuII","teuIII","teuIV","tegI","tegII","tegIII","tegIV","tegspI","tegspII","tegspIII","tegspIV")){
            ah<-function(hi){ahe1(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
          }else if(names(E2edad[k])%in% c("tetpcsI","tetpcsII","tetpcsIII","tetpcsIV")){
            ah<-function(hi){ahe2(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}
          }else{ah<-function(hi){ahn(hi,E2edad[[k]][[i]][j,"clase"],E2edad[[k]][[i]][j,"h"])}}
          hd<-hi[min(which(round(sqrt(ah(hi)),1)==IU))]#mejorar la funcion de optimizacion
          E2edad[[k]][[i]][j,nom]<-ahk*integrate(ah,0.2,hd)$value*E2edad[[k]][[i]][j,"n"]
        }
      }
    }
  }
  E2edad
}


#funcion que determina un diametro a la altura del pecho DAP (1.37 m de altura), para calcular el volumen que se tendra. 
dmin<-function(dminge,voliu){#parametros: dminge es el DAP general para se usado en todas las tablas de crecimiento y en todos los años, voliu es el objeto generado de la funcion volIU
        v<-rep(dminge,52)
        mod=names(voliu)
        prueba8<-data.frame(mod=mod,dap=v)
        volfinal<-edit(prueba8)
}

#funcion para agrupar nuevamente en edades las tablas de crecimiento

volf<-function(manejosino,tabedad,tabcre,dmin,vol,nIU,esqmanejo){
  #parametros: tabedad es el objeto de la funcion volIU,
  #tabcre es las tablas de crecimiento ya sea la original o con manejo (objeto que sale de la funcion tabmanejo2)
  #dmin es el objeto de la funcion dmin
  #vol es para escoger que volumen se quiere visualizar de forma agregada (volumen total de ahusamiento vah o el de algu indice de utilizacion ejemplo IU_20)
  for(k in 1:length(tabedad)){
    for(i in 1:length(tabedad[[k]])){
      tabcre[[k]][i,"volf"]<-sum(tabedad[[k]][[i]][tabedad[[k]][[i]][,"clase"]>dmin[k,2],vol])
      for(m in 1:length(nIU)){
        tabcre[[k]][i,nIU[m]]<-sum(tabedad[[k]][[i]][tabedad[[k]][[i]][,"clase"]>dmin[k,2],nIU[m]])
      }
      tabcre[[k]][i,"volforma"]<-sum(tabedad[[k]][[i]][tabedad[[k]][[i]][,"clase"]>dmin[k,2],"v"],na.rm=TRUE)#volumen forma
    }
    tabcre[[k]][,"volf2"]<-tabcre[[k]]["volf"]
    if(manejosino=="si"){
      if(esqmanejo$manejo[[k]][1]!=0){#nueva linea
        for(j in 1:esqmanejo$manejo[[k]][1]){#nueva linea
          tabcre[[k]][esqmanejo$manejo[[k]][(j+1)],"volf2"]<-tabcre[[k]][esqmanejo$manejo[[k]][(j+1)],"volsinraleo"]-tabcre[[k]][esqmanejo$manejo[[k]][(j+1)],"volraleo"]#nueva linea
        }#nueva linea
      }#nueva linea
      tabcre[[k]][,"volf1"]<-tabcre[[k]]["volf2"]+tabcre[[k]]["volraleo"]
      tabcre[[k]][,"ima_sim"]<-tabcre[[k]]["volf1"]/tabcre[[k]]["Edad"]
    }#nueva linea
    if(manejosino=="si"){
      tabcre[[k]]<-tabcre[[k]][c("Edad","Densidad","Mort","Dm","Hm","vha","ica","ima","volf1","volraleo","volf2",nIU,"ima_sim","volforma")]
    }else{
      tabcre[[k]]<-tabcre[[k]][c("Edad","Densidad","Mort","Dm","Hm","vha","ica","ima","volf2",nIU)]
    }
  }
  tabcre
  #volf1: volumen del raleo + volumen seleccionado
  #volraleo: volumen extraido del raleo funcion tabmanejo
  #volf2: volumen sin raleo
  #volforma: volumen con factor forma pero con desagregacion (diferente a voltotal de tabmanejo que es el numero de individuos por el volumen del individuo medio)
}#version 12 de enero 2018


#PROCESO III####
##Asignacion de tablas de crecimiento a los registros seleccionados y suma de volumenes por año

#funcion para asignacion tablas de crecimiento a registros
asigna<-function(reg,tabcref,vol,raleo){
  #parametros:reg tabla de registros a simular,
  #tabcref: tabla de crecimiento con o sin modificaciones,
  #vol: volumen a utilizar para rodal (profor, vh total, vol IU), 
  #raleo: "con raleo" o "sin raleo"
  creg<-list()
  for(i in 1:nrow(reg)){
    creg[[i]]<-tabcref[[as.character(reg[i,"mod"])]]
    creg[[i]]$año<-creg[[i]][,1]+reg[i,"siembra"]-1
    creg[[i]]$zona<-reg[i,"zona"]
    creg[[i]]$Dep<-reg[i,"Dep"]
    creg[[i]]$Mun<-reg[i,"Mun"]
    creg[[i]]$Especie<-reg[i,"Especie"]
    creg[[i]]$sp<-reg[i,"sp"]
    creg[[i]]$siembra<-reg[i,"siembra"]
    creg[[i]]$area<-reg[i,"area"]
    creg[[i]]$IS<-reg[i,"IS"]
    creg[[i]]$base<-reg[i,"base"]
    creg[[i]]$reg<-reg[i,"reg"]
    creg[[i]]$mod<-reg[i,"mod"]
    creg[[i]]$volrodal<-creg[[i]][,vol]*reg[i,"area"]
    if(raleo=="con raleo"){
      creg[[i]]$volrarod<-creg[[i]][,"volraleo"]*reg[i,"area"]
      creg[[i]]$volrodcr<-creg[[i]]$volrarod+creg[[i]]$volrodal
    }
  }
  creg
}



#funcionnes que agregan los procesos
#proceso II
volproc<-function(manejosino,esquema,tabcre,dming,IU,nIU,vol){
  #manejosino: indica si utilizar manejo ("si", "no")
  #esquema: salida de la funcion manejo
  #tabcre: tabla de crecimiento
  #IU: valor indice de sitio que se desea calcular 
  #dming: DAP minimo general para todas las 52 tablas de crecimiento para sumar volumen (se puede modificar de forma individual)
  #vol: volumen que se desea ver de las etapas de ahusamiento depende de los IU implementados (ejemp: "vah", "IU_15")
  if(manejosino=="si"){
    modraleo<-tabmanejo2(tabcre,esquema)
    etapaII<-Etapa2(modraleo)
    etapaIIc<-Etapa2cor(etapaII,esquema)#
    voltotalah<-volah(etapaIIc)#
  }else{
    etapaII<-Etapa2(tabcre)
    etapaIIc<-Etapa2cor(etapaII,esquema)#
    voltotalah<-volah(etapaIIc)#
    
  }
  voltotalah
  voliu<-volIU(IU[1],voltotalah)
  for(i in 1:length(IU)){
    voliu<-volIU(IU[i],voliu)
  }
  voliu
  vol<-edit(vol)
  volfinal<-dmin(dming,voliu)
  if(manejosino=="si"){
    tabcremod<-volf(manejosino,voliu,modraleo,volfinal,vol,nIU,esquema)#se agrego manejosino y esquema
  }else{
    tabcremod<-volf(manejosino,voliu,tabcre,volfinal,vol,nIU,esquema)#se agrego manejosino y esquema
  }
  voliu
  tabcremod
}

#proceso III

procIII<-function(reg,tabcre,raleo,simano,nIU,esquema){
  #parametros:reg tabla de registros a simular,
  #tabcref: tabla de crecimiento con o sin modificaciones,
  #raleo: "con raleo" o "sin raleo"
  #simano: año de simulacion
  #nIU: vector con Indices de utilizacion
  prueba121<-asigna(reg,tabcre,"volf2","con raleo")
  prueba12<-prueba121
  for(h in 1:length(prueba12)){
    prueba12[[h]]<-prueba12[[h]][,c(9:17,27,28)]
    prueba12[[h]]$codrad1<-ifelse(prueba12[[h]]$volraleo==0,0,1)#codigo1 raleos sin resiembra
    pruebada1<-as.data.frame(matrix(ncol = length(prueba12[[h]]),nrow =length(seq(prueba121[[h]]$año[nrow(prueba121[[h]])]+1,simano,1))))
    colnames(pruebada1)<-colnames(prueba12[[h]])
    pruebada1$año<-seq(prueba12[[h]]$año[nrow(prueba12[[h]])]+1,simano,1)
    prueba12[[h]]<-rbind(prueba12[[h]],pruebada1)
    #despues de union
    for(j in (esquema$manejo[[prueba12[[h]][1,"mod"]]][length(esquema$manejo[[prueba12[[h]][1,"mod"]]])]+1):(nrow(prueba121[[h]])+nrow(pruebada1))){
      prueba12[[h]][j,"volraleo"]<-prueba12[[h]][j-esquema$manejo[[prueba12[[h]][1,"mod"]]][length(esquema$manejo[[prueba12[[h]][1,"mod"]]])],"volraleo"]
    }
    for(i in nrow(prueba121[[h]])+1:(nrow(prueba121[[h]])+nrow(pruebada1))){
      prueba12[[h]][i,"volf1"]<-prueba12[[h]][(i-1),"volf1"]+(prueba12[[h]][(i-1),"volf1"]*0.01)
      prueba12[[h]][i,"volf2"]<-prueba12[[h]][(i-1),"volf2"]+(prueba12[[h]][(i-1),"volf2"]*0.01)
      prueba12[[h]][i,"ima_sim"]<-prueba12[[h]][i,"volf2"]/i
      prueba12[[h]][i,"volforma"]<-prueba12[[h]][(i-1),"volforma"]+(prueba12[[h]][(i-1),"volforma"]*0.01)
      prueba12[[h]][i,"reg"]<-prueba12[[h]][1,"reg"]
      prueba12[[h]][i,"mod"]<-prueba12[[h]][1,"mod"]
      prueba12[[h]][i,"codrad1"]<-prueba12[[h]][1,"codrad1"]
      for(j in 1:length(nIU)){
        prueba12[[h]][i,nIU[j]]<-prueba12[[h]][(i-1),nIU[j]]+(prueba12[[h]][(i-1),nIU[j]]*0.01)
      }
    }
    for(j in (esquema$manejo[[prueba12[[h]][1,"mod"]]][length(esquema$manejo[[prueba12[[h]][1,"mod"]]])]+1):(nrow(prueba121[[h]])+nrow(pruebada1))){
      prueba12[[h]][j,"volf2"]<-prueba12[[h]][j-esquema$manejo[[prueba12[[h]][1,"mod"]]][length(esquema$manejo[[prueba12[[h]][1,"mod"]]])],"volf2"]
      for(k in 1:length(nIU)){
        prueba12[[h]][j,nIU[k]]<-prueba12[[h]][j-esquema$manejo[[prueba12[[h]][1,"mod"]]][length(esquema$manejo[[prueba12[[h]][1,"mod"]]])],nIU[k]]
      }
    }
    
  }
  for(h in 1:length(prueba12)){
    pruebada1<-as.data.frame(matrix(ncol = length(prueba12[[h]]),nrow =length(seq(prueba121[[h]]$año[nrow(prueba121[[h]])]+1,simano,1))))
    prueba12[[h]]$codrad2<-0
    prueba12[[h]][esquema$manejo[[prueba12[[h]][1,"mod"]]][length(esquema$manejo[[prueba12[[h]][1,"mod"]]])],"codrad2"]<-1#codigo 2 aprovechamiento sin resiembra
    prueba12[[h]]$codrad3<-ifelse(prueba12[[h]]$volraleo==0,0,1)#codigo3 raleo con resiembra
    prueba12[[h]]$codrad4<-prueba12[[h]]$codrad2
    
    for(j in (esquema$manejo[[prueba12[[h]][1,"mod"]]][length(esquema$manejo[[prueba12[[h]][1,"mod"]]])]+1):(nrow(prueba121[[h]])+nrow(pruebada1))){
      prueba12[[h]][j,"codrad4"]<-prueba12[[h]][j-esquema$manejo[[prueba12[[h]][1,"mod"]]][length(esquema$manejo[[prueba12[[h]][1,"mod"]]])],"codrad4"]
    }
    prueba12[[h]][is.na(prueba12[[h]])] <- 0
    prueba12[[h]]$codradT<-prueba12[[h]]$codrad1+prueba12[[h]]$codrad2+prueba12[[h]]$codrad3+prueba12[[h]]$codrad4#codigo3
    prueba12[[h]]<-prueba12[[h]][1:(nrow(prueba121[[h]])+nrow(pruebada1)),]
  }
  
  prueba<-prueba12
  #filtro
  for(h in 1:length(prueba)){
    prueba[[h]]<-prueba[[h]][prueba[[h]][,"codradT"]!=0,]
  }
  #agrupar
  pruebadata<-do.call("rbind", prueba) 
  pruebafinal<-merge(pruebadata,reg,by.y = "reg",by.x = "reg")
  pruebafinal$volf1rodal<-pruebafinal$volf1*pruebafinal$area
  pruebafinal$volraleorodal<-pruebafinal$volraleo*pruebafinal$area
  pruebafinal$volf2rodal<-pruebafinal$volf2*pruebafinal$area
  pruebafinal$IU_20rodal<-pruebafinal$IU_20*pruebafinal$area
  pruebafinal$IU_15rodal<-pruebafinal$IU_15*pruebafinal$area
  pruebafinal$IU_5rodal<-pruebafinal$IU_5*pruebafinal$area
  pruebafinal$volformarodal<-pruebafinal$volforma*pruebafinal$area
  pruebafinal<-pruebafinal[,c("volf1","volraleo","volf2","IU_20","IU_15","IU_5","ima_sim","volforma","año",
                              "zona","Dep","Mun","Especie","sp","siembra","area","IS","base","reg","mod.x",
                              "codrad1","codrad2","codrad3","codrad4","codradT","volf1rodal","volraleorodal",
                              "volf2rodal","IU_20rodal","IU_15rodal","IU_5rodal","volformarodal")]
  pruebafinal
}

#otras
resumen<-function(tabmod,esquema,sinoesquema){
  
  if(sinoesquema=="si"){
    ima<-data.frame(mod=names(tabmod))
    
    for(i in 1:52){
      ima[i,"ima ff"]<-(tabmod[[i]][nrow(tabmod[[i]]),"volforma"]+sum(tabmod[[i]][,"volraleo"]))/tabmod[[i]][nrow(tabmod[[i]]),"Edad"]
      ima[i,"ima ah"]<-(tabmod[[i]][nrow(tabmod[[i]]),"volf2"]+sum(tabmod[[i]][,"volraleo"]))/tabmod[[i]][nrow(tabmod[[i]]),"Edad"]
      ima[i,"ima profor"]<-tabmod[[i]][nrow(tabmod[[i]]),"ima"]
      ima[i,"n raleos"]<-esquema[[1]][[i]][1]
    }
    
    for(j in 1:max(ima[,"n raleos"])){
      namano<-paste("año",j,sep = "_")
      nam<-paste("raleo",j,sep = "_")
      ima[,namano]<-NA
      ima[,nam]<-NA
      for(i in 1:52){
        if(ima[i,"n raleos"]>=j){
          ima[i,namano]<-esquema$manejo[[i]][(j+1)]
          ima[i,nam]<-esquema$manejo[[i]][(esquema$manejo[[i]][1]+j+1)]
        }else{}
      }
    }
    for(i in 1:52){
      ima[i, "cosecha"]<-esquema[[1]][[i]][length(esquema[[1]][[i]])]
    }
  }else{
    for(i in 1:52){
      ima[i,"ima ff"]<-(tabmod[[i]][nrow(tabmod[[i]]),"volforma"])/tabmod[[i]][nrow(tabmod[[i]]),"Edad"]
      ima[i,"ima ah"]<-(tabmod[[i]][nrow(tabmod[[i]]),"volf2"])/tabmod[[i]][nrow(tabmod[[i]]),"Edad"]
      ima[i,"ima profor"]<-tabmod[[i]][nrow(tabmod[[i]]),"ima"]
    }
  }
  ima
}
