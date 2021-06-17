# Time series analysis
# Greenland increase of temperature
# Data and code from Emnuela Cosma

#installo il pacchetto rasterVis e lo richiamo insieme al pacchetto raster
install.packages("rasterVis") #per la funzione levelplot
library(raster)
library(rasterVis)

# setto la working directory
setwd("C:/lab/greenland")

# importo il primo dataset con la funzione raster 
# uso la funzione brick quando ho pacchetti di dati raster, in questo caso ho + di 1 file a strati, 4 strati separati
# ogni strato rappresenta la stima della temperatura LST (e non la riflettanza) che deriva da dati copernicus
lst_2000 <- raster("lst_2000.tif") #uso le virgolette perchè sto uscendo da R

# funzione per plottaggio
# la scala graduata nell’immagine sono valori di bit che si riferiscono ai gradi
#il sensore di temperatura misura la riflettanza nell'infrarosso termico e successivamente converte 
plot(lst_2000) 

# importo anche il dato del 2005
lst_2005 <- raster("lst_2005.tif")

# funzione per plottaggio
plot(lst_2005)

# importo anche le altre immagini
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

#crea un multipannel 2x2 con la funzione par per confrontare le 4 immagini
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# la funzione lapply permette di applicare funzioni (es. raster e quindi importazione dati) a liste di file
# per farlo devo prima creare una lista di file tramite la funzione list.files
rlist <- list.files(pattern="lst") #il pattern è un aspetto condiviso da tutti i file interessati che permette il raggruppamento
rlist

# posso applicare la funzione lapply alla lista di file creati
#tramite la funzione raster importo tutti i file della lista in un unico passaggio
import <- lapply(rlist,raster)
import

# ho importato i 4 file separati, posso creare un pacchetto e raggrupparli -> fare uno stack
# la funzione stack mi permette di gestire i file insieme, ho creato una immagine con tante bande

TGr <- stack(import)

#per avere le info sul file
TGr

#lo stack mi permette di plottare direttamente senza importare il multiframe tramite la funzione par
plot(TGr)

#faccio un plot RGB in cui sovrappongo tre immagini, lst 2000, 2005 e 2010. C'è più blu, ho valori più alti nell'lst 2010
# puoi anche specificare le componenti: plotRGB(TGr, r=1, g=2, b=3, stretch="Lin")
plotRGB(TGr, 1, 2, 3, stretch="Lin") 
# file 1 2000 nel livello del red
# file 2 2005 nel livello del green
#file 3 2010 nel livello del blue

#posso montare le immagini in modi differenti.
plotRGB(TGr, 2, 3, 4, stretch="Lin") #2005 nel red, 2010 nel green, 2015 nel blue
plotRGB(TGr, 4, 3, 2, stretch="Lin") #2015 nel red, 2010 nel green, 2005 nel blue



# il pacchetto rasterVis fornisce metodi di visualizzazione raster più potenti tramite la funzione levelplot (+ compatto, chiaro, informativo)
levelplot(TGr) #in questo caso sto plottando tutti i livelli dello stack

# posso applicare la funzione levelplot ad un singolo livello attraverso il legame con $
levelplot(TGr$lst_2000) #$ + nome dello strato mi permette la singola visualizzazione
levelplot(TGr$lst_2005)

# cambio i colori del plot
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl) # L'argomento stavolta non è col ma col.regions

# posso rinominare i titoli del singoli attributi per rendere ancora più chiara e informativo il grafico tramite l'argomento names.attr
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) #c + parentesi perchè creo un vettore, le virgolette perchè sono testi

# inserisco il titolo principale con l'argomento main 
levelplot(TGr,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# creo un pdf del grafico finale
pdf("LST variation in time.pdf")
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr,col.regions=cl, main="LST variation in time",
names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
dev.off()

# scarichiamo i dati melt sulo scioglimento dal 79 al 2007
# abbiamo tantissimi dati, per importarli creiamo una lista e sfruttiamo la funzione lapply per applicare la funzione raster
# creo la lista tramite la funzione list.files
meltlist <- list.files(pattern="melt") #melt è la parola comune a tutti i file

# funzione lapply per applicare funzione raster su tutta la lista
melt_import <- lapply(meltlist,raster)
import

# faccio lo stack per raggrupare tutti i files importati, lo chiamo melt
melt <- stack(melt_import)
melt

# plotto tramite la funzione levelplot
levelplot(melt)

# possiamo fare algebra applicata a matrici per vedere la differenza tra due dati e capire il grado di scioglimento
# facciamo la sottrazione tra il primo e l'ultimo dato e associamo ad un oggetto (melt_amount)
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt # + è alto il valore, + scioglimento c'è stato

# cambio il colore e faccio un plot
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)

# faccio un level plot per avere un grafico ancora più informativo
levelplot(melt_amount, col.regions=clb)




