# calcolo dell'eterogeneità del paesaggio su dati Sentinel ghiacciaio Similaun (> eterogeneità = > biodiversità attesa)
# carico le librerie necessarie
library(raster)
library(RStoolbox)
library(ggplot2)# per plottare ggplot
library(gridExtra)# per plottare insieme più ggplot
install.packages("viridis")# virgolette perchè esco da R
library(viridis)# per colorare i plot di ggplot automaticamente 

# set della working directory dove ho salvato i dati
setwd("C:/lab")

# importo l'immagine del ghiacciaio Similaun (dati sentinel, ESA, 10m)
sent <- brick("sentinel.png")# funzione brick e perchè l'immagine è composta da + livelli (raster importerebbe solo 1 livello) 

# band1: NIR
# band2: red
# band3: green
#r=1 (il NIR sulla componente rossa), g=2 (il RED sulla componente verde), b=3 (il GREEN sulla componente blu) nel plot RGB

# plot dell'immagine, per plottarla con tre livelli RGB utilizziamo la funzione plotRGB
plotRGB(sent, r=1, g=2, b=3, stretch="lin") # è lo schema di default, puoi anche scrivere semplicemente plotRGB(sent)

# cambiamo la posizione del NIR
plotRGB(sent, r=2, g=1, b=3, stretch="lin") # l'acqua risulta nera perchè assorbe tutto il NIR

# per calcolare l'eterogeneità posso sfruttare la deviazione standard (variabilità che include il 68% di tutte le osservazioni)
# sfrutto la tecnica della mooving window, finestra mobile che si sposta nell'immagine calcolando statistiche su gruppi di pixel e riportandole sul pixel centrale
# per utilizzare la tecnica mooving window ho bisogno di compattare il set in un solo strato, tramite l'NDVI ottengo un layer sul quale calcolare la deviazione standard
# per trovare il nome delle bande
sent

# band1: sentinel.1, è il NIR
# band2: sentinel.2, è il RED

# banda del NIR e del RED
nir <-sent$sentinel.1
red <-sent$sentinel.2

# calcolo l'NDVI
ndvi <- (nir-red)/(nir+red)
plot(ndvi) # ottengo una immagine ad un solo strato che riassume due bande, posso applicare la mooving window

# cambio la color
cl <- colorRampPalette(c('black','white','red','blue','green'))(100)
plot(ndvi, col=cl)

# funzione focal del pacchetto raster per applicare la mooving window
# argomento w è la window, è la matrice dei numeri formata da 9 pixel in tutto, di tot righe e tot colonne. Di solito si utilizza una window quadrata
# argomento fun per indicare il tipo di statistica, quì sd (deviazione standard)
ndvisd3 <-focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd) # nrow, ncol = n. righe e colonne
plot(ndvisd3) 

# cambio la color
# copertura omogenea nella roccia nuda, in blu e nella vegetazione, in verde
# zone di confine tra roccia e vegetazione presentano valori di sd + alti, > eterogeneità
cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd3, col=cl)

# posso riassumere anche tramite la media, argomento fun=mean
# valori alti per la parte vegetazionale, semialti per la parte naturale di boschi a latifoglie e conifere, valori più bassi per la roccia nuda
ndvimean3 <-focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvimean3, col=cl)

# possiamo cambiare la grandezza della mooving window per la deviazione standard, sempre dispari
ndvisd13 <-focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd13, col=cl)

# utilizzo una finestra 5x5
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd)


# invece dell'NDVI, per accorpare il set di dati poso utilizzare la PCA, con la formazione della PC1
# PCA
sentpca <- rasterPCA(sent)
plot(sentpca$map)

# funzione summary per vedere quanta variabilità spiegano le singole componenti
summary(sentpca$model) # la prima componente PC1 spiega il 67,3%

# sapendo che la prima componente PC1 spiega il 67,3%, per utilizzarla utilizzo il $ e applico la funzione focal per il calcolo della sd
# associo sempre la stringa ad un oggetto così da evitare di riscrivere le funzioni
pc1<-sentpca$map$PC1

#funzione focal, moowing window 5x5 per il calcolo della sd
pc1sd5 <-focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd5, col=cl)
# parte di vegetazione di prateria d’alta quota è la + omogenea, in blu
# variabilità > nelle parti con verde e rosa, zone di roccia in cui c’è un cambiamento più marcato. Lo capiamo dalla sd.

# funzione source per importare codici dall'esterno
# calcolo della sd 7x7 tirando dentro il codice
# lo script salvato deve avere gli stessi oggetti del codice in uso, altrimenti non funziona
source("source_test_lezione.r")# virgolette perchè esco da R

# richiamo le librerie necessarie per applicare nuovamente source ma con funzione ggplot
source("source_ggplot.r") 

#funzione ggplot per creare una nuova finestra vuota
#ggplot lavora per blocchi, utilizzo il simbolo + per aggiungerli e vado a capo
p1<-ggplot() +
# aggiungo il bloco per la geometria, si tratta di un raster e la geometria è il pixel: geom_raster (punti:geom_point; linee: geom_line...)
# assicurati del nome della tua pca da plottare --> pc1sd5
# aggiungo anche le aestetics, ovvero le indicazioni su cosa plottare (x, y e i valori all'interno (cioè il layer)) tramite l'argomento mapping
geom_raster(pc1sd5, mapping = aes(x=x, y=y, fill=layer))

# posso sfruttare il pacchetto viridis per colorazioni particolari
p1<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x=x, y=y, fill=layer))+
scale_fill_viridis() + # funzione pacchetto viridis per usare una delle legende di default, non ho bisogno di dichiarare la color
ggtitle("standard deviation of PC1 by viridis color scale") # aggiungo un titolo

# posso usare diverse leggende, uso quella "magma"
p2<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="magma") + #argomento option per indicare la diversa legenda
ggtitle("standard deviation of PC1 by magma color scale")

# leggenda "inferno"
p3<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno") + # argomento option per indicare la diversa leggenda
ggtitle("standard deviation of PC1 by inferno color scale")

# posso associare ogni plot ad un oggetto e poi plottarli insieme tramite la funzione grid.arrange
grid.arrange(p1, p2, p3, nrow = 1) #argomento nrow per impostare il numero di righe




