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



