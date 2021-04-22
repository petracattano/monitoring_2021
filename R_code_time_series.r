# Time series analysis
# Greenland increase of temperature
# Data and code from Emnuela Cosma

#installo il pacchetto raster Vis e lo richiamo insieme al pacchetto raster
install.packages("rasterVis")
library(raster)
library(rasterVis)

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

#per avere le info sul file
TGr

#plotto una immagine e non ho bisogno di fare il plot di 4 immagini
plot(TGr)

#faccio un plot RGB in cui sovrappongo tre immagini, lst 2000, 2005 e 2010. C'è più blu, ho valori più alti nell'lst 2010
plotRGB(TGr, 1, 2, 3, stretch="Lin")

#posso montare le immagini in modi differenti. Es. il 2005 nel red, il 1010 nel green, il 2015 nel blu
plotRGB(TGr, 2, 3, 4, stretch="Lin")
plotRGB(TGr, 4, 3, 2, stretch="Lin")

#09/04/2021 eri assente

#funzione level plot, ho 4 grafici
levelplot(TGr)

#posso applicarla ad un singolo file attraverso il comando con $
levelplot(TGr$lst_2000)
levelplot(TGr$lst_2005)

# cambiamo i colori del plot. L'argomento stavolta non è solo col ma col.regions
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)

# posso rinominare i titoli del singoli attributi 
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# inserisco il titolo totale con l'argomento main. metto le virgolette perchè è un testo 
levelplot(TGr,col.regions=cl, main="LST variation in time",
names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))


