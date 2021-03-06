# 1. R_code_remote_sensing.r

# 2. R_code_time_series.r

# 3. R_code_copernicus.r

# 4. R_code_knit.r

# 5. R_code_classification.r

# 6. R_code_multivariate_analysis

# 7. R_code_vegetation_indices.r

# 8. R_code_land_cover

# 9. R_code_variability.r

# 10. 

# 11. 











# 1. R_code_remote_sensing.r

# Il mio primo codice per il Telerilevamento
# funzione per installazione pacchetti 
# scrivo le virgolette perchè sto uscendo da R
install.packages("raster") #pacchetto raster

# Funzione library per richiamare il pacchetto raster 
# scrivi sempre all'inizio del codice le librerie necessarie
library(raster)

# settaggio della working directory, cartella da cui estrarre i dati
setwd("C:/lab/") 

# Funzione brick per importare i dati
#immagine Amazzonia
p224r63_2011 <- brick("p224r63_2011_masked.grd") #virgolette perchè sto uscendo da R

# Funzione per avere le informazioni sul file (numero di pixel, sistema di riferimento...) scrivo il nome dell'immagine
p224r63_2011

# Funzione plot per visualizzare le varie bande
plot(p224r63_2011) #colorazione di default

# funzione per cambiare colore
# scrivo la c davanti la parentesi perchè si tratta di elementi dello stesso tipo che sto raggruppando in un vettore, rappresentano lo stesso argomento (il colore)
cl <- colorRampPalette(c("black","grey","light grey")) (100) #ultimo argomento indica quanti livelli di ciascun colore voglio visualizzare

# Plot con la nuova color palette tramite l'argomento col
plot(p224r63_2011, col=cl)

# Per cambiare colore --> nuovo
cl <- colorRampPalette(c("blue","pink","light green","yellow","red")) (100)

# Plot con la nuova color palette
plot(p224r63_2011, col=cl)

#Bande di Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico (lontano)
# B7: infrarosso medio

#per chiudere il plot uso la funzione dev.off
dev.off()

# plotto l'immagine legata alla banda 1, il $ (una corda) mi permette di legare al plot lo strato da visualizzare
plot(p224r63_2011$B1_sre)

# cambio colore
cl <- colorRampPalette(c("red","yellow","light green","pink","blue")) (200)

# Plot con la nuova color palette in B1
 plot(p224r63_2011$B1_sre, col=cl) 

# ripulisci la parte grafica
dev.off()

# plotto B1 e B2 insieme
# funzione par per stabilire come fare il plottaggio, mi permette di creare un sistema di righe e colonne in cui impostare un multiframe
par(mfrow=c(1,2)) # avrò 1 riga e 2 colonne. Se con il primo numero vuoi indicare le colonne e non le righe --> par(mfcol=c(2,1)).
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# se voglio 2 righe e 1 colonna
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 4 righe e 1 colonna con le quattro bande
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# disponi le immagini in modo che si distribuiscano 2x2
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# Posso plottare le singole bande in un multiframe differenziandole nel colore
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb) # banda blu

clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg) # banda verde

clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr) # banda rosso

clnir <- colorRampPalette(c("yellow","orange","green")) (100)
plot(p224r63_2011$B4_sre, col=clnir) # banda infrarosso vicino


# DAY 4 
#funzione plotRGB per visualizzare l'immagine con colori naturali, sistema RGB (red, green, blue sono i colori fondamentali)
# monto le tre bande una sull’altra secondo un ordine che decido io (max. 3 bande)
#l'argomento stretch per evitare che ci siano uno schiacciamento verso una sola parte del colore
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #banda 3 del rosso nella componente red, banda 2 del verde nella componente green, banda 1 del blue nella componente blu

#la natura vede in infrarosso
# se voglio vedere anche l'infrarosso vicino (altissima riflettanza nelle piante, in questo caso sarà visibile in rosso perchè monto la banda 4 nella componente red)
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #banda 4 sulla componente red, banda 3 sulla componente green, banda 2 sulla componente blue

# monto la banda 4 dell'infrarosso vicino sul verde (altissima riflettanza nelle piante, in questo caso sarà visibile in verde perchè monto la banda 4 nella componente red)
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #banda 3 sulla componente red, banda 4 sulla componente green, banda 2 sulla componente blue

# monto la banda 4 dell'infrarosso vicino sul blue (altissima riflettanza nelle piante, in questo caso sarà visibile in blu perchè monto la banda 4 nella componente blue)
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# confronto i 4 plot tramite la funzione par creando un multiframe 2x2 
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# posso salvare i plot in PDF tramite la funzione pdf con questa sequenza di funzioni
pdf("ll_mio_primo_pdf_con_R.pdf") #uso le virgolette perchè sto uscendo da R
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

# oltre a quello lineare, posso utilizzare lo stretch histagram, più aggressivo, mi permette di visualizzare + dettagli
# le zone in violetto nella foresta probabilmente sono le più umide, presenza di acqua
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

# par per immagine a colori naturali, immagine con infrarosso sul green, immagine con infrarosso sul green e his stretch. a 3 righe e 1 colonna.
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #RGB
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #infrarosso sulla componente green con stretch lineare
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #infrarosso sulla componente green con stretch histogram 

# DAY 5
# importo sia l'immagine del 1988 che quella del 2011 per creare un multitemporal set e confrontare le due situazioni
p224r63_2011 <- brick("p224r63_2011_masked.grd") # funzione brick per importare i dati
p224r63_1988 <- brick("p224r63_1988_masked.grd") 
p224r63_1988  #per avere le informazioni sui file
p224r63_2011

# Plot per visualizzare tutte le bande della immagine del 1988
plot(p224r63_1988)

# Plot RGB colori naturali
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") #RGB
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") #vedo anche l'infrarosso vicino sulla componente red

# funzione par per creare un multiframe RGB e confrontare le due situazioni
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#Voglio un multiframe 2x2 per visualizzare sia lo tretch lineare che histogram
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

# salvo in pdf
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()


# 2. R_code_time_series.r

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



# 3. R_code_copernicus.r

# visualizing Copernicus data
# installo la libreria per legger in ncdf, formato di dati copernicus .nc
install.packages("ncdf4") #virgolette perchè esco da R

# richiamo il pacchetto insieme a quello raster, senza le virgolette perchè li ho già installati
library(raster)
library(ncdf4)

# imposto la working directory dove ho i dati
setwd("C:/lab/")

# a questo punto devo dare un nome al mio dataset. Copia e incolla il nome del dataset lasciando l'estensione
# uso la funzione raster perchè è un singolo strato, virgolette perchè usciamo da R
fcover <- raster ("c_gls_FCOVER_202006130000_GLOBE_PROBAV_V1.5.1.nc") #FCOVER: riguarda l'estensione spaziale della vegetazione (componente sana)
fcover # per avere info sul file

# scelgo una colorandpalette, ho un singolo strato e non posso montare più bande nel sistema RGB
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100)
plot(fcover, col=cl)

# funzione aggregate per ricampionare (è un resampling) il dataset e diminuirne la risoluzione
# permette di aggregare, attraverso la loro media, un tot di pixel in  pixel + grandi
fcoverres<-aggregate(fcover, fact=100) #argomento fact indica di quanto diminuire linearmente. In questo caso in uno spazio 100x100 pixel ne avrò solo 1. 

#plottaggio del dato ricampionato
plot(fcoverres, col=cl)


# 4. R_code_knitr.r

# codice per creare template finali, report di codici
# set della working directory 
setwd("C:/lab/")

# installo il pacchetto knitr, mi permette di creare dei report finali delle operazioni su R
install.packages("knitr")

# richiamo il pacchetto knitr
library(knitr)

# salva il codice di cui vuoi il report sul pc tramite qualsiasi gestore di testo (anche word)
# funzione stitch per applicare il pacchetto knitr al codice di cui voglio il report
# nel primo argomento specifica l'estensione se hai problemi durante il caricamento (quì è .tex)
stitch("R_code_greenland.r.tex", template=system.file("misc","knitr-template.Rnw", package="knitr"))


# 5. R_code_classification.r

# classificazione di immagini in funzione della somiglianza dei pixel
# solar orbiter data, immagini già processate che evidenziano i diversi livelli energetici del sole

# richiamo le librerie necessarie 
library(raster)
library(RStoolbox)

# settaggio della working directory
setwd("C:/lab")

# carico l'immagine con la funzione brick 
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") # metto le virgolette perchè sto uscendo da R

# visualizzo le informazioni dell'immagine
so

# funzione plotRGB per visualizzare l'immagine con i tre livelli importati
# con i numeri e il loro ordine scelgo quale livello assegnare a quale componente (red,green,blue)
plotRGB(so, 1,2,3, stretch="lin")

# destra immagine: parte + chiara, alti livelli energetici
# centro: parte + scura; sinistra: parte + grigia; potrebbero esserci 3 classi possibili 
# classificazione dell'immagine tramite la funzione unsuperClass del pacchetto RStoolbox
# unsuperClass sta per unsupervised classification, training set creato direttamente dal softwere
# classificazione in base alla distanza nello spazio multispettrale rispetto al training set
soc <- unsuperClass(so, nClasses=3) #scelgo il numero di classi guardando l'immagine in modo esplorativo
# il training set è sempre diverso, per classificazioni sempre uguali si usa la funzione set.seed 

#faccio il plot, uso il $ perchè il mio oggetto presenta diverse componenti (punti dei training set, mappa etc.) e voglio visualizzare la mappa
plot(soc$map) # $ per legare la mappa all'oggetto nella visualizzazione

# possiamo aumentare il numero di classi
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)

# posso cambiare i colori
cl <- colorRampPalette(c('yellow','black','red','green','pink','orange'))(100)
plot(soc20$map,col=cl)

# prendiamo una nuova immagine https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images Solar_Orbiter_s_first_view_of_the_Sun
# importo tramite la funzione brick
sun <- brick("Solar_Orbiter_s_first_view_of_the_Sun.png") # virgolette perchè sto uscendo da R

# classifico tramite la funzione unsuperClass in 3 classi
sunc <- unsuperClass(sun, nClasses=3)

# plot con $ per visualizzare la componente mappa dell'oggetto sun
plot(sunc$map)

# Classificazione immagini Gran Canyon 
# diversi tipi di roccia = diversa riflettanza. Le nuvole possono essere un problema per la classificazione

#librerie necessarie 
library(raster)
library(RStoolbox)

# settaggio della working directory dove ho salvato i dati
setwd("C:/lab")

# applico la funzione brick per importare l'immagine
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg") #virgolette perchè sto uscendo da R

# ho un raster con più strati, posso fare un plot RGB
plotRGB(gc, r=1, g=2, b=3, stretch="lin")

#  posso anche cambiare lo streth da lin a hist, cambia la visualizzazione della gamma cromatica disponibile
plotRGB(gc, r=1, g=2, b=3, stretch="hist") 

# per creare una classificazione uso la funzione unsuperClass
gcc2 <- unsuperClass(gc, nClasses=2) # se hai 2 classi, non usare + di 2 colori

# plottaggio dell'immagine, uso il $ per legare l'oggetto alla mappa nella visualizzazione 
plot(gcc2$map)

# aumento il numero di classi
gcc4 <- unsuperClass(gc, nClasses=4) # per capire se il numero di classi scelto è veritiero devo andare in campo e capire se la diversità nella litologia corrisponde
plot(gcc4$map) # $ per visualizzare solo la mappa dell'oggetto


# 6. R_code_multivariate_analysis

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


# 7. R_code_vegetation_indices.r

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



# 8. R_code_land_cover.r

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


# 9. R_code_variability.r


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














