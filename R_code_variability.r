# calcolo dell'eterogeneità del paesaggio su dati Sentinel ghiacciaio Similaun (> eterogeneità = > biodiversità attesa)
# carico le librerie necessarie
library(raster)
library(RStoolbox)
library(ggplot2)# per plottare ggplot
library(gridExtra)# per plottare insieme più ggplot
install.packages("viridis")# virgolette perchè esco da R
library(viridis)# per colorare i plot di ggplot automaticamente

#set della working directory dove ho salvato i dati
setwd("C:/lab")

# importo l'immagine del ghiacciaio Similaun (dati sentinel, ESA, 10m)
sent <- brick("sentinel.png")# funzione brick e perchè l'immagine è composta da + livelli (raster importerebbe solo 1 livello) 

# band1: NIR
# band2: red
# band3: green
#r=1 (il NIR sulla componente rossa), g=2 (il RED sulla componente verde), b=3 (il GREEN sulla componente blu) nel plot RGB

#plot dell'immagine, per plottarla con tre livelli RGB utilizziamo la funzione plotRGB
plotRGB(sent, r=1, g=2, b=3, stretch="lin") # è lo schema di default, puoi anche scrivere semplicemente plotRGB(sent)

#cambiamo la posizione del NIR
plotRGB(sent, r=2, g=1, b=3, stretch="lin") # l'acqua risulta nera perchè assorbe tutto il NIR



# per utilizzare la tecnica mooving window ho bisogno di compattare il set in un solo strato
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
sentpca <- rasterPCA(sent)
plot(sentpca$map)

#summary per vedere quanta variabilità spiegano le singole componenti
summary(sentpca$model) #la prima componente PC spiega il 67,3%


 #21/05/2021
#sapendo che la prima componente PC1 spiega il 67,3%, per utilizzarla utilizzo il $ e utilozzarla per aplicare la funzione focal
#associo sempre la stringa ad un oggetto così da evitare di riscrivere le funzioni
pc1<-sentpca$map$PC1

#funzione focal
pc1sd5 <-focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd3, col=cl)

#funzione source per importare codici dall'esterno
#calcolo della sd 7x7 tirando dentro il codice
#lo script salvato deve avere gli stessi oggetti del codice in uso, altrimenti non funziona
source("source_test_lezione.r")

#richiamo le librerie necessarie per applicare nuovamente source ma con funzione ggplot
source("source_ggplot.r") #non funziona

#non funziona e riprendiamo il codice sopra
#funzione ggplot per aprire una nuova finestra vuota
#gg plot lavora er blocchi, utilizzo il sinbolo + per aggiungerli dopo essere andata a capo
p1<-ggplot() +

#aggiungo l bloco per la geometria, si tratta di un raster e la geometria è il pixel
#assicurati del nome della tua pca da plottare --> pc1sd5
#aggiungo anche le aestetics, ovvero le indicazioni su cosa plottare (x, y e i valori all'interno (il layer)) tramite l'argomento mapping
geom_raster(pc1sd5, mapping = aes(x=x, y=y, fill=layer)) +

#funzione pacchetto viridis per usare una delle legende di default, non ho bisogno di dichiarare la color
scale_fill_viridis() +

#posso aggiungere un titolo
ggtitle("standard deviation of PC1 by viridis color scale")

#posso usare diverse legende, uso quella "magma"
p2<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="magma") + #argomento option per indicare la diversa legenda
ggtitle("standard deviation of PC1 by magma color scale")

#legenda inferno
p3<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno") + #argomento option per indicare la diversa legenda
ggtitle("standard deviation of PC1 by inferno color scale")

#posso associare ogni plot ad un oggetto e poi plottarli insieme tramite la funzione grid.arrange
grid.arrange(p1, p2, p3, nrow = 1) #argomento nrow per impostare il numero di righe



