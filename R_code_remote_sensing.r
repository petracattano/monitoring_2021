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




