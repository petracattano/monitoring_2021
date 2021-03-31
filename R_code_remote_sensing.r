# Il mio primo codice per il Telerilevamento

# Codice per installazione pacchetti aggiuntivi raster
install.packages("raster")

# Funzione library per richiamare il pacchetto raster 
library(raster)

# Indicare la cartella da cui estrarre i dati
setwd("C:/lab/") 

# Funzione brick per importare i dati
p224r63_2011 <- brick("p224r63_2011_masked.grd")

# Funzione per avere le info sul file
p224r63_2011

# Funzione plot immagini per visualizzare le varie bande
plot(p224r63_2011)

# Per cambiare colore
cl <- colorRampPalette(c("black","grey","light grey")) (100)

# Plot con la nuova color palette
plot(p224r63_2011, col=cl)

# Per cambiare colore --> nuovo
cl <- colorRampPalette(c("blue","pink","light green","yellow","red")) (100)

# Plot con la nuova color palette
plot(p224r63_2011, col=cl)

# DAY 3

# Funzione library per richiamare il pacchetto raster 
library(raster)

# Indicare la cartella da cui estrarre i dati
setwd("C:/lab/") 

# Funzione brick per importare i dati
p224r63_2011 <- brick("p224r63_2011_masked.grd")

# Per cambiare colore --> nuovo
cl <- colorRampPalette(c("blue","pink","light green","yellow","red")) (200)

# Plot con la nuova color palette
plot(p224r63_2011, col=cl)

# Funzione per avere le info sul file
p224r63_2011

#Bande di Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico (lontano)
# B7: infrarosso medio

#per chiudere il plot
dev.off()

# plotto l'immagine legata alla banda 1
plot(p224r63_2011$B1_sre)

# Per cambiare colore
cl <- colorRampPalette(c("red","yellow","light green","pink","blue")) (200)

# Plot con la nuova color palette in B1
 plot(p224r63_2011$B1_sre, col=cl) 

# ripulisci la parte grafica
dev.off()

# funzione par per stabilire come fare il plottaggio
par(mfrow=c(1,2)) # nb se con il primo numero vuoi indicare le colonne e non le righe par(mfcol=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# oppure # 2 row, 1 columns
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

# color per le singole bande
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb) # banda blu

clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg) # banda verde

clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr) # banda rosso

clnir <- colorRampPalette(c("yellow","orange","green")) (100)
plot(p224r63_2011$B4_sre, col=clnir) # per l'infrarosso


# DAI 4 --> PLOT RGB

# Funzione library per richiamare il pacchetto raster 
library(raster)

# Indicare la cartella da cui estrarre i dati
setwd("C:/lab/") 

# Funzione brick per importare i dati
p224r63_2011 <- brick("p224r63_2011_masked.grd")


#Bande di Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico (lontano)
# B7: infrarosso medio

#plot RGB per visualizzare immagine a colori "naturali"
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#Voglio vedere anche l'infrarosso vicino
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# monto la banda 4 dell'infrarosso vicino sul verde
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

# monto la banda 4 nel blu 
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")


# le visualizzo tutte e quattro grazie alla funzione par, 2x2 multiframe
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# per salvare come pdf il multiframe --> funzione pdf
pdf("ll_mio_primo_pdf_con_R.pdf") 
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

# stretch histagram, più aggressivo, pendenza più potente
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

# par per immagine a colori naturali, immagine con infrarosso sul green, immagine con infrarosso sul green e his stretch. a 3 righe e 1 colonna.
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

# DAY 5
 install.packages("RStoolbox") #installo nuovo pacchetto

# importo il dato
library(raster) #richiamo il pacchetto, non metto virgolette perchè è già su r
setwd("C:/lab/") #indico la cartella

#multitemporal set
p224r63_2011 <- brick("p224r63_2011_masked.grd") # Funzione brick per importare i dati
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988  #per avere le info

# Plot, visualizzo tutte le bande
plot(p224r63_1988)

# Plot RGB 
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

#Voglio vedere anche l'infrarosso vicino
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#Voglio plottare le due immagini in RGB per fare confronti, multiframe con par
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#Voglio un multiframe 2x2 visualizzando sia lo tretch lineare che histogram.
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




