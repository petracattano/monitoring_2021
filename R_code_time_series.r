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

# inserisco il titolo principale con l'argomento main. metto le virgolette perchè è un testo 
levelplot(TGr,col.regions=cl, main="LST variation in time",
names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#se voglio creare un pdf del grafico finale
pdf("LST variation in time.pdf")
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr,col.regions=cl, main="LST variation in time",
names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
dev.off()

# scarichiamo i dati melt sulo scioglimento dal 79 al 2007
#abbiamo tantissimi dati, per importarli creiamo una lista e sfruttimao la funzione lapply per applicare a tutti i dati la funzione raster
#funzioni per applicare funzioni a più file
#devo creare una lista di file --> tramite la funzione list.files. Uso melt come parola comune ai files
meltlist <- list.files(pattern="melt")

#funzione lapply per applicare funzione raster su tutta la lista
melt_import <- lapply(meltlist,raster)
import

#faccio lo stack per raggrupare tutti i files importati, lo chiamo melt
melt <- stack(melt_import)
melt

#facciamo lo stesso levelplot ma con i dati melt
levelplot(melt)

#possiamo fare algebra applicata a matrici es. per vedere la differenza tra due dati e capire il grado di scioglmento
#vogliamo fare la sottrazione tra il primo dato e l'ultimo. Dbbiamo associare un nome alla sottrazione (melt_amount)
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

#cambio il colore e faccio un plot
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)

#faccio un level plot per avere un grafico ancora più comprensibile
levelplot(melt_amount, col.regions=clb)




