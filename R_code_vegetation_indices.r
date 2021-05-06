28/04/2021 
# R_code_ecosystem_functions.r

#richiamo le librarie necessarie
library(raster)
library(RStoolbox)
library(rasterVis)

#installo il pacchetto rastervid per usufrire del dataset sugli indici di vegetazione
install.packages("rasterdiv")
library(rasterdiv)

#working directory, dove pesco i dati
setwd("C:/lab")

#importo la prima immagine
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

#plot RGB e faccio un par per visualizzare la multitemporalità
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")


30/04/2021

#primo indice, DVI1
#dobbiamo fare il NIR-RED della defor 1
#defor1 per vedere i nomi delle bande
defor1

## band1: NIR, defor1_.1
# band2: red, defor1_.2
# band3: green

#il NIR si chiama defor1.1 
#il RED si chiama defor1.2

dvi1 <- defor1$defor1.1-defor1$defor1.2

#plot dvi1 per visualizzarla
plot(dvi1)

#cambio il colore
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl)

#posso rinominare le mappe
plot(dvi1, col=cl, main="DVI at time 1" )

#faccio lo stesso per il dvi2
#defor2 per visualizzare i nomi delle bande
defor2

## band1: NIR, defor2_.1
# band2: red, defor2_.2
# band3: green
dvi2 <- defor2$defor2.1-defor2$defor2.2

#plotto per visualizzare
plot(dvi2, col=cl,  main="DVI at time 2")

#se voglio confrontarle sfrutto la funzione par
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1" )
plot(dvi2, col=cl,  main="DVI at time 2")

#faccio la differenza tra i 2 dvi
difdvi <- dvi1-dvi2

#plotto per visualizzare
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)

#calcolo dell'ndvi
#NDVI= (NIR-RED)/(NIR+RED)
#ndvi1
ndvi1 <- (defor1$defor1.1-defor1$defor1.2)/(defor1$defor1.1+defor1$defor1.2)
plot(ndvi1, col=cl,  main="NDVI at time 1")

#calcolo dell'ndvi2
ndvi2 <- (defor2$defor2.1-defor2$defor2.2)/(defor2$defor2.1+defor2$defor2.2)
plot(ndvi2, col=cl,  main="NDVI at time 2")

#li confronto tramite la funzione par
par(mfrow=c(2,1))
plot(ndvi1, col=cl,  main="NDVI at time 1")
plot(ndvi2, col=cl,  main="NDVI at time 2")

#posso ottenere gli stessi dati dalla funzione spectrakindices del paccherro RStoolbox
#calcla tutta una serie di indici insieme
vi <-spectralIndices(defor1, green=3,red=2,nir=1)
plot(vi, col=cl)

#fai lo stesso per la seconda immagine
vi2<-spectralIndices(defor2, green=3,red=2,nir=1)
plot(vi2, col=cl)

#05/05/2021

# worldwide NDVI, visualizziamo il database copNDVI del pacchetto rasterdiv
#mappa NDVI a scala globale
plot(copNDVI)

#non voglio visualizzare l'acqua 
#posso eliminare i valori del database corrispondenti tramite la funzione reclassify, argomento cbind
#i pixels con valori da 253 a 255 verranno classificati come NA, non valori
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

#funzione level plot per visualizzare la varianza in termini di biomassa
#abbiamo una visione dell'estensione della biomassa, ricorda la distribuzione dei biomi 
levelplot(copNDVI)



