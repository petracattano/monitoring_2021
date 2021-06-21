# R_code_vegetation_indices.r

# richiamo le librarie necessarie
library(raster)
library(RStoolbox) # per la funzione spectrakindices
library(rasterVis)
install.packages("rasterdiv") # installo il pacchetto rasterdiv per usufrire del dataset sugli indici di vegetazione
library(rasterdiv)

# settaggio della working directory dove ho salvato i dati
setwd("C:/lab")

#importo le due immagini tramite la funzione brick
defor1 <- brick("defor1.jpg") # virgolette perchè esco da R
defor2 <- brick("defor2.jpg")

#plot RGB e faccio un par 2x1 per visualizzare la multitemporalità
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin") 
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")


# voglio calcolare il DVI, difference vegetation index. E' un indice di vegetazione ed è uguale alla differenza tra la riflettanza nell’infrarosso vicino e quella nel rosso 
# dobbiamo fare il NIR-RED della defor 1
# scrivo defor1 per vedere le informazioni dei file e i nomi delle bande
defor1

# band1: NIR, defor1_.1
# band2: red, defor1_.2


# il NIR si chiama defor1.1 
# il RED si chiama defor1.2
# posso calcolare la differenza
dvi1 <- defor1$defor1.1-defor1$defor1.2 # $ perchè mi interessa solo una parte dei vari oggetti presenti nel dato, quelle due bande

# plot dell'immagine risultante per visualizzarla
plot(dvi1)

# cambio il colore
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl)

# posso rinominare la mappa tramite l'argomento main
plot(dvi1, col=cl, main="DVI at time 1" )

# faccio lo stesso per il DVI della seconda immagine
# scrivo il nome dell'immagine per visualizzare le informazioni e i nomi delle bande
defor2

# band1: NIR, defor2_.1
# band2: red, defor2_.2
dvi2 <- defor2$defor2.1-defor2$defor2.2 # $ perchè mi serve solo una parte dei vari oggetti presenti nel dato, quelle due bande

# plotto per visualizzare l'immagine e la rinomino tramite l'argomento main
plot(dvi2, col=cl,  main="DVI at time 2")

# se voglio confrontarle posso utilizzare la funzione par per creare un multiframe
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1" )
plot(dvi2, col=cl,  main="DVI at time 2") #Le parti in giallo sono tutte in regressione, suolo agricolo

# La differenza tra i due DVI mi permette di capire lo stato di salute della vegetazione: se il DVI cala, la vegetazione è meno in salute
difdvi <- dvi1-dvi2

# plotto per visualizzare l'immagine
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld) # parte in rosso dove la differenza è + alta (molta deforestazione). Parte blu e bianca dove è - marcata.


# il DVI può essere normalizzato per ottenere l'NDVI
# i valori di riflettanza dipendono dai bit. Nel calcolo del DVI posso confrontare solo immagini con gli stessi bit. NDVI assume valori che vanno da -1 a 1 e permette confronti anche tra immagini a bit differenti
# NDVI= (NIR-RED)/(NIR+RED)
# NDVI1, calcolo sulla prima immagine
ndvi1 <- (defor1$defor1.1-defor1$defor1.2)/(defor1$defor1.1+defor1$defor1.2)
plot(ndvi1, col=cl,  main="NDVI at time 1")

# calcolo dell'NDVI sulla seconda immagine 
ndvi2 <- (defor2$defor2.1-defor2$defor2.2)/(defor2$defor2.1+defor2$defor2.2)
plot(ndvi2, col=cl,  main="NDVI at time 2")

# confronto i due plot tramite la funzione par
par(mfrow=c(2,1))
plot(ndvi1, col=cl,  main="NDVI at time 1")
plot(ndvi2, col=cl,  main="NDVI at time 2")

# posso ottenere gli stessi dati dalla funzione spectrakindices del pacchetto RStoolbox, mi permette di fare calcoli in modo + spedito
# la funzione calcola tutta una serie di indici tra cui NDVI
vi <-spectralIndices(defor1, green=3,red=2,nir=1) #devo indicare le bande
plot(vi, col=cl)

#fai lo stesso per la seconda immagine
vi2<-spectralIndices(defor2, green=3,red=2,nir=1)
plot(vi2, col=cl)

#05/05/2021

# worldwide NDVI, visualizziamo il database copNDVI (dati copernicus 1999-2017) del pacchetto rasterdiv per ottenere una mappa NDVI a scala globale
# plotto il dataset, ottengo mappa NDVI a scala globale
plot(copNDVI)

# nella mappa non mi interessa visualizzare l'acqua, appesantisce la visualizzazione 
# posso eliminare i valori del database corrispondenti ai pixel di acqua tramite la funzione reclassify, argomento cbind
# i pixel con valori da 253 a 255 verranno classificati come NA, non valori
copNDVI <- reclassify(copNDVI, cbind(253:255, NA)) # ignoro dei valori specifici tramite l'argomento cbind
plot(copNDVI)

# funzione level plot per visualizzare la varianza in termini di biomassa sul grafico
# grafico più potente e informativo
# abbiamo una visione dell'estensione della biomassa, ricorda la distribuzione dei biomi 
levelplot(copNDVI)



