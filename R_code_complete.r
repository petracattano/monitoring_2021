#Summary:

#1. R_code_classification.r

#2. R_code_time_series.r

#3. R_code_copernicus.r

#4. R_code_knitr.r

#5. R_code_multivariate_analysis.r

#6. R_code_classification.r

#7. GGPLOT???

#8. R_code_vegetation_indices.r

#9. R_code_land_cover.r

#10. R_code_variability.r

#11. 



#1. R_code_classification.r
#21/04/2021 classificazione di immagini in funzione della somiglianza dei pixel
#solar orbiter data

#librerie necessarie 
library(raster)
library(RStoolbox)

#working directory, dove pesco i dati
setwd("C:/lab")

#carico l'immagine con la funzione brick 
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#se voglio le info dell'immagine
so

#funzione plotRGB per visualizzare l'immagine con i tre livelli che abbiamo importato
#con i numeri e il loro ordine scelgo quale livello assegnare a quale commponente (red,green,blue)
plotRGB(so, 1,2,3, stretch="lin")

#classificazione immagine, uso la funzione unsuperClass del pacchetto RStoolbox
#unsuperClass sta per unsupervised classification, training set creato direttamente dal softwere
soc <- unsuperClass(so, nClasses=3)

#faccio il plot, uso il $ perchè il mio oggetto presenta diverse componenti e a me interessa la mappa
plot(soc$map)

#possiamo aumentare il numero di classi
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)

#posso cambiare i colori
cl <- colorRampPalette(c('yellow','black','red','green','pink','orange'))(100)
plot(soc20$map,col=cl)

# prendiamo una nuova immagine https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images Solar_Orbiter_s_first_view_of_the_Sun
# importo
sun <- brick("Solar_Orbiter_s_first_view_of_the_Sun.png")

#classifico tramite la funzione unsuperClass in 3 classi
sunc <- unsuperClass(sun, nClasses=3)

#plot con $ per visualizzare la componente mappa dell'oggetto sun
plot(sunc$map)

# Gran Canyon data 23/04/2021

#librerie necessarie 
library(raster)
library(RStoolbox)

#working directory, dove pesco i dati
setwd("C:/lab")

#applico la funzione brick per importare l'immagine
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")

# ho un raster con più strati, posso fare un plot RGB
plotRGB(gc, r=1, g=2, b=3, stretch="lin")

#posso anche cambiare lo streth la lin a hist 
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# per creare una classificazione uso la funzione nsuperClass
gcc2 <- unsuperClass(gc, nClasses=2)

#posso plottare, devo riferirmi al modello di classificazione 
plot(gcc2$map)

#aumento il numero di classi
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

#2. R_code_time_series.ir

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

#3. R_code_copernicus.r
# visualizing copernicus data

#richiamo la libreria raster
library(raster)

#installo la libreria per legger in ncdf, formato di dati che mi interessa
install.packages("ncdf4")

#richiamo il pacchetto insieme al raster, senza le virgolette perchè li ho già installati
library(raster)
library(ncdf4)

#imposto la working directory
setwd("C:/lab/")

# a questo punto devo dare un nome al mio dataset.  copia e incolla il nome del dato lasciando l'estensione
albedo <- raster ("")

#scelgo una colorandpalette
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100)
plot(albed, col=cl)


#4. R_code_knitr.r, codice per creare template finali

# set della working directory 
setwd("C:/lab/") # Windows

#installo il pacchetto knitr, mi permette di creare dei report finali delle operazioni su R
install.packages("knitr")

#richiamo il pacchetto knitr
library(knitr)

#salva il codice di cui vuoi il report sul pc tramite qualsiasi gestore di testo (anche word è ok)
#funzione stitch per applicare il pacchetto knitr al codice di cui voglio il report
#nel primo argomento specifica l'estensione se hai problemi durante il caricamento (quì è .tex)
stitch("R_code_greenland.r.tex", template=system.file("misc","knitr-template.Rnw", package="knitr"))




#5. R_code_multivariate_analysis

#pacchetti necessari
library (raster)
library(RStoolbox)

#imposto la working directory
setwd("C:/lab/")

# carico l'immagine p224r63_2011.grd
# ho 7 bande disponibili, uso la funzione brick perchè ho un set multiplo di dati (la funzione raster carica 1 set per volta)
p224r63_2011 <- brick("p224r63_2011.grd")

#plot della immagine
plot(p224r63_2011)

# voglio le info sull'immagine
p224r63_2011

#faccio un plot della banda 1 contro la banda 2, la correlazione tra due bande
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19, cex=2)

#posso cambiare il posizionamento delle due bande
plot(p224r63_2011$B2_sre,p224r63_2011$B1_sre, col="red", pch=19, cex=2)

# invece di fare manualmente la correlazione tra bande, posso usare la funzione pairs che mi permette di fare la correlazione a due a due di tutte le bande 
pairs(p224r63_2011)

28/04/2021

#funzione aggregate per diminuire la dimensione dell'immagine aggregando i pixel --> ricampionamento
#decidere sia la funzione (es. media) che il fattore di riduzione (es. 10)
p224r63_2011res <- aggregate(p224r63_2011, fact=10)

#per visualizzare la nuova immagine posso sfruttare la funzione par per visualizare entrambe le immagini
par(mfrow=c(2,1))

#plot RGB per confrontarle
plotRGB(p224r63_2011, 1, 2, 3, stretch="Lin")
plotRGB(p224r63_2011res, 1, 2, 3, stretch="Lin")

#raster PCA, prende il pacchetto e lo compatta in un minor numero di bande, passando ad una minore variabilità
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

#funzione summary per capire la rappresentatività delle singole componenti
summary(p224r63_2011res_pca$model)

#plot RGB per visualizzare l'immagine con le nuove bande
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="Lin")


#6. R_code_classification.r

#21/04/2021 classificazione di immagini in funzione della somiglianza dei pixel
#solar orbiter data

#librerie necessarie 
library(raster)
library(RStoolbox)

#working directory, dove pesco i dati
setwd("C:/lab")

#carico l'immagine con la funzione brick 
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#se voglio le info dell'immagine
so

#funzione plotRGB per visualizzare l'immagine con i tre livelli che abbiamo importato
#con i numeri e il loro ordine scelgo quale livello assegnare a quale commponente (red,green,blue)
plotRGB(so, 1,2,3, stretch="lin")

#classificazione immagine, uso la funzione unsuperClass del pacchetto RStoolbox
#unsuperClass sta per unsupervised classification, training set creato direttamente dal softwere
soc <- unsuperClass(so, nClasses=3)

#faccio il plot, uso il $ perchè il mio oggetto presenta diverse componenti e a me interessa la mappa
plot(soc$map)

#possiamo aumentare il numero di classi
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)

#posso cambiare i colori
cl <- colorRampPalette(c('yellow','black','red','green','pink','orange'))(100)
plot(soc20$map,col=cl)

# prendiamo una nuova immagine https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images Solar_Orbiter_s_first_view_of_the_Sun
# importo
sun <- brick("Solar_Orbiter_s_first_view_of_the_Sun.png")

#classifico tramite la funzione unsuperClass in 3 classi
sunc <- unsuperClass(sun, nClasses=3)

#plot con $ per visualizzare la componente mappa dell'oggetto sun
plot(sunc$map)

# Gran Canyon data 23/04/2021

#librerie necessarie 
library(raster)
library(RStoolbox)

#working directory, dove pesco i dati
setwd("C:/lab")

#applico la funzione brick per importare l'immagine
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")

# ho un raster con più strati, posso fare un plot RGB
plotRGB(gc, r=1, g=2, b=3, stretch="lin")

#posso anche cambiare lo streth la lin a hist 
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# per creare una classificazione uso la funzione nsuperClass
gcc2 <- unsuperClass(gc, nClasses=2)

#posso plottare, devo riferirmi al modello di classificazione 
plot(gcc2$map)

#aumento il numero di classi
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)


#8. 28/04/2021 
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



#9. R_code_land_cover.r
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


#10. R_code_variability.r
#carico le librerie necessarie
library(raster)
library(RStoolbox)
library(ggplot2)#per plottare ggplot
library(gridExtra)#per plottare insieme più ggplot
install.packages("viridis")
library(viridis)#per colorare i plot di ggplot automaticamente

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



#11. 











