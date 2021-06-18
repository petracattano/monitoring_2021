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

#classifico tramite la funzione unsuperClass in 3 classi
sunc <- unsuperClass(sun, nClasses=3)

#plot con $ per visualizzare la componente mappa dell'oggetto sun
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

#posso anche cambiare lo streth da lin a hist, cambia la visualizzazione della gamma cromatica disponibile
plotRGB(gc, r=1, g=2, b=3, stretch="hist") 

# per creare una classificazione uso la funzione unsuperClass
gcc2 <- unsuperClass(gc, nClasses=2) # se hai 2 classi, non usare + di 2 colori

# plottaggio dell'immagine, uso il $ per legare l'oggetto alla mappa nella visualizzazione 
plot(gcc2$map)

# aumento il numero di classi
gcc4 <- unsuperClass(gc, nClasses=4) # per capire se il numero di classi scelto è veritiero devo andare in campo e capire se la diversità nella litologia corrisponde
plot(gcc4$map) # $ per visualizzare solo la mappa dell'oggetto



