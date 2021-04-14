# Time series analysis
# Greenland increase of temperature
# Data and code from Emnuela Cosma

#richiama il pacchetto raster
library(raster)

# Cambio la working directory
setwd("C:/lab/greenland")

#importo il primo dataset con la funzione raster (non uso brick perchè ho singoli file e non pacchetti)
lst_2000 <- raster("lst_2000.tif")

#lo plotto
plot(lst_2000)

#importo anche il dato del 2005
lst_2005 <- raster("lst_2005.tif")

#lo plotto
plot(lst_2005)

 #importo anche le altre immagini
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

#crea un multipannel
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#funzioni per applicare funzioni a più file
#devo creare una lista di file --> tramite la funzione list.files
rlist <- list.files(pattern="lst")
rlist

#funzione lapply per applicare funzione raster su tutta la lista
import <- lapply(rlist,raster)
import

#funzione stack 
TGr <- stack(import)
plot(TGr)


plotRGB(TGr, 1, 2, 3, stretch="Lin")

library(rasterVis)

#09/04/2021 eri assente

#installo il pacchetto raster Vis e lo richiamo insieme al pacchetto raster
install.packages("rasterVis")
library(raster)
library(rasterVis) 

#working directory
setwd("C:/lab/greenland")


#14/04/2021
