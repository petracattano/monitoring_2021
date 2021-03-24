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







