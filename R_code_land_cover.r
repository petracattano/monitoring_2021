#R_code_land_cover
#set working directory
setwd("C:/lab")

#installo il pacchetto ggplot2
install.packages("ggplot2")

#installo il pacchetto gridExtra
install.packages("gridExtra")

#richiamo le librerie
library(raster)
library(RStoolbox) #per la classificazione
library(ggplot2)
library(gridExtra)

#utilizzo i dati sulle imamgini del rio peixoto de azevedo defor1 e defor2
#NIR 1, RED 2, GREEN 3

defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

#tramite la funzione ggRGB del pacchetto ggplo2 creo plot con più informazioni
#nel plot visualizzo x, y --> le coordinate spaziali dell'oggetto (sono coordinate immagine)
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

#carico la seconda immagine e faccio gli stessi passaggi
defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#confronto i due plot tramite la funzione par
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#posso farlo anche tramite ggplot, funzione grid.arrange
# multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)

#07/05/2021
#classifichiamo immagini sulla vegetazione
#scelgo 2 classi, classificazione non supervisionata (fa tutto il softwere)
d1c <- unsuperClass(defor1, nClasses=2)
d1c

#plot per visualizzare l'immagine classificata. Devo usare $ perchè dentro l'immagine ha sia il modello che la mappa
#classe n1 = foresta amazzonica; n2 = parte agricola (può essere anche al contrario)
#Per avere gli stessi risultati puoi usare la funzione set.seed
plot(d1c$map)

#creo la seconda mappa
#classe 1 = foresta amazzonica
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)

#provo con tre classi
#i colori diventano 3 erchè nella parte agricola ci sono due zone distinte
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

#funzione freq per capire la frequenza delle diverse classi nella prima immagine
freq(d1c$map)

#  value  count
# [1,]     1  34860
# [2,]     2 306432
#calcolare la proporzione 
#come? valore classe1/totale e valore classe2/totale
#funzione sum per il totale
s1 <-306432+34860
s1 #per vedere la somma

#per calcolare la frequenza
freq(d1c$map)/s1
#classe 1 = agricolo
#10,2% di agricolo nel 1992
#89,98% di foresta

#faccio lo stesso per la seconda mappa
#classe 1 è la foresta
freq(d2c$map)/s1
#52,2% di foresta nel 2006
#48,25% di agricolo

#come creare tabella su R, dataframe
#delineo le colonne
#fattore cover è formato da variabili agriculture e forest
cover <- c("Forest","Agriculture") #la c perchè sono due blocchi all'interno della stessa cosa # "" perchè è testo

#la seconda colonna
percent_1992<-c(89.98,10.2)

#la terza colonna
percent_2006<-c(52.2,48.25)

#data.frame funzione per creare dataframe
percentages<-data.frame(cover,percent_1992,percent_2006)
percentages

#       cover     percent_1992  percent_2006
#1      Forest        89.98        52.20
#2 Agriculture        10.20        48.25

#elaboriamo il grafico con ggplot2, plottiamo il dataframe
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")

#faccio lo stesso con la seconda immagine
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#associo a un nome per applicare la funzione grid.arrange e fare un multiframe
p1<-ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2<-ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

grid.arrange(p1,p2,nrow=1)


