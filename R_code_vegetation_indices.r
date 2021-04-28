28/04/2021 
# R_code_ecosystem_functions.r

#working directory, dove pesco i dati
setwd("C:/lab")

#importo la prima immagine
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

#plot RGB e faccio un par per visualizzare la multitemporalità
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
