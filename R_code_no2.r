#esercizio su concentrazione NO2 EU dati sentinel gennaio-marzo 2020, importare un metodo di lavoro
#1. set della working directry sulla cartella EN
setwd("C:/lab/EN")

#carica i pacchetti necessari
library(raster) #funzione raster per importare i dataset
library(RStoolbox) #funzione per la PCA

#2. importa il primo set EN_001 con la funzione raster perchè ti serve solo la prima banda
#stiamo selezionando la prima banda perchè la funziona raster non può selezionarne altre, prende la prima di default
EN01 <- raster ("EN_0001.png")

#3. plotta la prima immagine con una color a tua scelta
cl <- colorRampPalette(c('light blue','light green','red','pink','yellow'))(100)
plot(EN01, col=cl)

#4. importa l'ultima immagine (13) e plottala con la stessa color
EN13 <- raster ("EN_0013.png")
plot(EN13, col=cl)

#4. fai la differenza fra le due immagini, associa ad un oggetto e plottalo
differenza <- EN01-EN13
plot(differenza, col=cl)

#5. plotta le tre immagini insieme, crea un multipannel
par(mfrow=c(3,1))
plot(EN01)
plot(EN13)
plot(differenza, main="differenza (Gennaio-Marzo)")

#6. importa tutto il set di dati 
#fai una lista dei file
rlist<-list.files(pattern="EN")
rlist

#importa
import <- lapply(rlist,raster)
import

#faccio lo stack per raggrupare tutti i files importati, lo chiamo EN
EN <- stack(import)
plot(EN, col=cl)

#plotta utilizzando lo stack di base
par(mfrow=c(1,1))
plot(EN_0001, col=cl)
plot(EN_0013,col=cl)

#fai la PCA
ENpca<-rasterPCA(EN)
summary(ENpca$model)
plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")

#calcola la variabilità 
#faccio il calcolo della sd sulla prima componente





