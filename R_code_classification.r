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



