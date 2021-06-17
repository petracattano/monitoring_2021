# R_code_copernicus.r
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

# funzione aggregate per ricampionare il dataset e diminuirne la risoluzione
# permette di aggregare, attraverso la loro media, un tot di pixel in  pixel + grandi
fcoverres<-aggregate(fcover, fact=50) #argomento fact indica di quanto diminuire linearmente. In questo caso in uno spazio 50x50 pixel ne avrò solo 1. 

