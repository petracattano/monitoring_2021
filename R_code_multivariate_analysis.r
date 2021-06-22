#23/04/2021 Analisi multivariata

#pacchetti necessari
library (raster)
library(RStoolbox)

#imposto la working directory
setwd("C:/lab/")

# carico l'immagine p224r63_2011.grd 
# ho 7 bande disponibili, uso la funzione brick perchè ho un set multiplo di dati (la funzione raster carica 1 set per volta)
p224r63_2011 <- brick("p224r63_2011.grd")

#plot della immagine
plot(p224r63_2011) #visualizzerò tante immagini

# se voglio le informazioni sull'immagine
p224r63_2011

# faccio un plot della banda 1 contro la banda 2 per visualizzare la correlazione tra due bande
# potrebbe dare messaggi di warning perchè stiamo plottando solo il 2% circa dei dati
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19, cex=2) # pch=point simbolo; cex=dimensione del simbolo;

# posso invertire il posizionamento delle due bande e quindi l'impostazione del plot
plot(p224r63_2011$B2_sre,p224r63_2011$B1_sre, col="red", pch=19, cex=2)

# invece di fare manualmente la correlazione tra bande, posso usare la funzione pairs che mi permette di fare la correlazione a due a due di tutte le bande 
# la funzione pairs indica anche il coefficiente di correlazione (indice di pearson; -1= corr. neg.; +1= corr. pos.), il grado di correlazione viene evidenziato anche dalle dimensioni del carattere
pairs(p224r63_2011)

# funzione aggregate per diminuire la dimensione dell'immagine aggregando i pixel --> ricampionamento
# decidere sia la funzione (es. media) che il fattore di riduzione (es. 10)
p224r63_2011res <- aggregate(p224r63_2011, fact=10) # ogni 10x10 pixel ne avrò 1

# per visualizzare la nuova immagine posso sfruttare la funzione par per visualizzare entrambe le immagini a diverse risoluzioni
par(mfrow=c(2,1))
plotRGB(p224r63_2011, 1, 2, 3, stretch="Lin") # plot RGB
plotRGB(p224r63_2011res, 1, 2, 3, stretch="Lin")

# la funzione rasterPCA permette di identificare la PCA passando da una variabilità maggiore ad una minore, che sia però rappresentativa. 
# prende il pacchetto e lo compatta in un minor numero di bande
# la PC1 è una banda che riassume tutte e 7 le bande originali, è quella che riassume meglio il modello
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

#funzione summary per capire la rappresentatività delle singole componenti
summary(p224r63_2011res_pca$model)

#plot RGB per visualizzare l'immagine con le nuove bande
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="Lin")



