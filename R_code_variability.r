#carico le librerie necessarie
library(raster)
library(RStoolbox)
library(ggplot2)

#set della working directory
setwd("C:/lab")

#importo l'immagine del ghiacciaio Similaun, utilizzo la funzione brick e non quella raster perchè l'immagine è formata da 3 bande 
sent <- brick("sentinel.png")

# band1: NIR
# band2: red
# band3: green
#r=1 (NIR sulla componente red), g=2 (il RED sulla componente verde), b=3 (il GREEN sulla componente blu), nel plot RGB

#plot dell'immagine, per plottarla con tre livelli RGB utilizziamo la funzione plotRGB
plotRGB(sent, r=1, g=2, b=3, stretch="lin") #è lo schema di default, puoi anche scrivere semplicemente plotRGB(sent)

#cambiamo la posizione del NIR
plotRGB(sent, r=2, g=1, b=3, stretch="lin")

#per utilizzare la tecnica mooving window ho bisogno di compattare il set in un solo strato
#posso farlo tramite l'NDVI ottenendo un layer sul quale calcolare la deviazione standard
#Per trovare il nome delle bande
sent

# band1: sentinel.1, è il NIR
# band2: sentinel.2, è il RED

nir <-sent$sentinel.1
red <-sent$sentinel.2

#calcolo l'NDVI
ndvi <- (nir-red)/(nir+red)
plot(ndvi)

#cambio la color
cl <- colorRampPalette(c('black','white','red','blue','green'))(100)
plot(ndvi, col=cl)

#funzione focal 
ndvisd3 <-focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)

#cambio la color
cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd, col=cl)

#calcolo la media
ndvimean3 <-focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvimean, col=cl)

#possiamo cambiare la grandezza della mooving window per la deviazione standard
ndvisd13 <-focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd13, col=cl)

#utilizzo una finestra 5x5
ndvisd5 <-focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd5, col=cl)

#invece dell'NDVI, accorpo il set di dati tramite la PCA, con la formazione della PC1
#PCA
sentinel_pca <- rasterPCA(sent)
plot(sentinel_pca$map)

#summary per vedere quanta variabilità spiegano le singole componenti
summary(sentinel_pca$model) #la prima componente PC spiega il 67,3%



