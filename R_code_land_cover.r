#R_code_land_cover

# installo il pacchetto ggplot2
install.packages("ggplot2") # virgolette perchè sto uscendo da R

# installo il pacchetto gridExtra
install.packages("gridExtra") # per la funzione grid.arrange per creare multipannel in ggplot (come par)

# richiamo le librerie necessarie 
library(raster)
library(RStoolbox) # per la classificazione tramite funzione unsuperClass
library(ggplot2)
library(gridExtra)

# set working directory dove ho salvato i dati
setwd("C:/lab")

# utilizzo i dati sulle immagini del Rio Peixoto de Azevedo (defor1 e defor2), zona residua della foresta amazzonica in forte regressione, Brasile
# band1: NIR
# band2: RED
# band3: GREEN
# r=1 (NIR sulla componente red), g=2 (il RED sulla componente verde), b=3 (il GREEN sulla componente blu), nel plot RGB
defor1 <- brick("defor1.jpg") # virgolette perchè esco da R
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

# tramite la funzione ggRGB del pacchetto ggplot2 posso plottare ottenendo più informazioni
# nel plot visualizzo x, y --> le coordinate spaziali dell'oggetto (sono coordinate immagine)
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

# carico la seconda immagine e faccio gli stessi passaggi
defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

# confronto i due plot tramite la funzione par
par(mfrow=c(1,2)) # multipannel 1 riga, 2 colonne
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# posso farlo anche con i plot ggRGB ma tramite la funzione grid.arrange del pacchetto gridExtra
# grid.arrange compone le immagini come vogliamo 
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin") # associamo il plot ad un oggetto (es. p1) così da gestire meglio la creazione del multipannel con grid.arrange
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2) # nrow è il numero di righe. Plot + informativo rispetto alla funzione par
# nel plot visualizzo x, y --> le coordinate spaziali dell'oggetto (sono coordinate immagine)

# classifichiamo la prima immagine in base alla vegetazione presente tramite la funzione unsuperClass del pacchetto RStoolbox
# scelgo 2 classi, è una unsupervised classification, training set creato direttamente dal softwere. Classificazione in base alla distanza nello spazio multispettrale rispetto al training set
d1c <- unsuperClass(defor1, nClasses=2) # scelgo il numero di classi guardando l'immagine in modo esplorativo (foresta, suolo agricolo)
d1c

# plot per visualizzare l'immagine classificata. Devo usare $ perchè dentro l'immagine ha sia il modello che la mappa
# classe n1 = foresta amazzonica; n2 = parte agricola (può essere anche al contrario)
# Per avere gli stessi risultati puoi classificare tramite la funzione set.seed
plot(d1c$map)

# creo la seconda mappa
# classe 1 = foresta amazzonica
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)

# posso classificare anche con tre classi
# i colori diventano 3 perchè nella parte agricola ci sono due zone distinte
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

# posso capire i rapporti tra le classi individuate tramite la funzione freq che mi dice la frequenza delle diverse classi nella prima immagine
freq(d1c$map)

#  value  count
# [1,]     1  34860
# [2,]     2 306432

# posso calcolare la proporzione (valore classe1/totale) e (valore classe2/totale)
# funzione sum per calcolare il totale
s1 <-306432+34860
s1 #per vedere la somma: 341292

# per calcolare la frequenza
freq(d1c$map)/s1
# classe 1 = agricolo (ma anche al contrario, dipende)
# 10,2% di agricolo nel 1992
# 89,98% di foresta nel 1992

# faccio lo stesso per la seconda mappa
# classe 1 è la foresta
freq(d2c$map)/s1
# 52,2% di foresta nel 2006
# 48,25% di agricolo nel 2006

# a questo punto voglio impostare i valori in un dataframe su R
# creo una tabella e delineo prima l'impostazione delle colonne

#prima colonna
# il fattore cover è formato da variabili agriculture e forest
cover <- c("Forest","Agriculture") # la c perchè sono due blocchi all'interno della stessa cosa, "" perchè si tratta di un testo

#la seconda colonna
percent_1992<-c(89.98,10.2) # la c perchè sono due blocchi all'interno della stessa cosa

#la terza colonna
percent_2006<-c(52.2,48.25) # la c perchè sono due blocchi all'interno della stessa cosa

#data.frame funzione per creare dataframe mettendo insieme le colonne create
percentages<-data.frame(cover,percent_1992,percent_2006)
percentages # per visualizzare la tabella

#       cover     percent_1992  percent_2006
#1      Forest        89.98        52.20
#2 Agriculture        10.20        48.25

# a questo punto elaboriamo il grafico con ggplot2, plottiamo il dataframe
# indico il dataset: percentages
# argomento aes: mappatura delle variabili. Nel plot la x sarà il tipo di cover, la y la percentuale nel 1992
# argomento geom_bar per indicare la geometria di visualizzazione
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white") # in fill indica il colore di riempimento del grafico 


# faccio lo stesso con la seconda immagine
# in questo caso su y avrò i le informazioni del 2006
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

# associo a un nome per applicare la funzione grid.arrange e creare un multiframe
p1<-ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2<-ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

grid.arrange(p1,p2,nrow=1) # multipannel su una riga


