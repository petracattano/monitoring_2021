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
#nel plot visualizzo x, y --> le coordinate spaziali dell'oggetto
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
 
