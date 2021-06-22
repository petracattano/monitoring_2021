# R_code_spectral_signatures.r
# studio sulle firme spettrali. Ogni habitat, specie, tipo geologico... ha una firma particolare
# dati dall'Earth Observatory

# richiamo i pacchetti necessari
library(raster)
library(rgdal) # per la funzione click
library(ggplot2) # per plot con ggplot

# set della working directory dove ho salvato i dati
setwd("C:/lab/")

# carico il dataset defor2.jpg sul Rio Peixoto de Azevedo 
# uso la funzione brick per caricare tutte le bande
defor2<-brick("defor2.jpg") #virgolette perchè esco da R

# info sull'immagine per vedere le bande
defor2

# defor2.1, defor2.2, defor2.3
# NIR, red, green

# plot RGB, NIR nella componente red, red nella componente green, green della componente blue
plotRGB(defor2, r=1, g=2, b=3, stretch="lin") 

# posso usare anche l'histogram stretch, usa una curca logistica e aumenta artificialmente la pendenza, le differenze cromatiche + accentuate
plotRGB(defor2, r=1, g=2, b=3, stretch="hist") 

# funzione click per creare firme spettrali
# mi permette di ottenere info cliccando sull'immagine
# in questo caso le informazioni saranno relative alla riflettanza
# argomento id per assegnare un valore identificativo
# argomento xy per avere le info spaziali
# argomento cell per sapere il numero della cella (pixel)
# argomento type p perchè cliccheremo su un punto
# argomento pch (point character) per il tipo di simbolo
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow") # T = true; altrimenti F = false

# risultati
# vegetazione
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 91.5 150.5 234551      198       14       26
# acqua
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 175.5 187.5 208106       82       54       92

# per uscire dalla funzione chiudo il plot

# creiamo un dataframe tramite ggplot2
# tabella con 3 colonne (banda, foresta, acqua) e 3 righe
# creo le colonne
band <- c(1,2,3)# le tre bande, decido io l'ordine, sarà quello che avrò poi nel grafico, di solito per primo il rosso
forest <- c(198,14,26)# i valori di riflettanza
water <- c(82,54,92)# i valori di riflettanza

# le metto insieme in un dataframe tramite la funzione data.frame
spectrals <- data.frame(band, forest, water)

 #band forest water
#    1    198    82
#    2     14    54
#    3     26    92


# plotto con ggplot2 il dataset
# asse x le bande, la definiamo per prima
# asse y la riflettanza 
ggplot(spectrals, aes(x=band)) + #ho aperto il plot
geom_line(aes(y=forest), color="green") + #inserisco le geometrie che mi interessano, in questo caso linee riferite a foresta e acqua
# tantissima riflettanza nella banda 1, bassa nella 2, intermedia nella 3
# aggiungo la retta relativa all'acqua
geom_line(aes(y=water), color=("blue")) + # bassi valori nel NIR, si alza verso il verde per riflettanza >
labs(x="band",y="reflectance") # rinomino gli assi

############### Multitemporal
# posso fare una analisi multitemporale con defor1.jpg e defor2.jpg
# carico anche la defor1.jpg
defor1 <- brick("defor1.jpg") # funzione brick per iportare tutte le bande

# plotto l'immagine defor1
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

# creiamo le firme spettrali anche della defor1
# 5 punti in zona di deforestazione 
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow") # T = true; altrimenti F = false

# risultati
#x     y  cell defor1.1 defor1.2 defor1.3
#1 31.5 346.5 93566      139      103       81
#    x     y  cell defor1.1 defor1.2 defor1.3
#1 18.5 350.5 90697      142       90       76
#    x     y  cell defor1.1 defor1.2 defor1.3
#1 36.5 373.5 74293      255      171      179
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 54.5 371.5 75739      163       82       78
#     x     y  cell defor1.1 defor1.2 defor1.3
#1 68.5 361.5 82893      176      110      112



