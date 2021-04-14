#R_code_copernicus.r
# visualizing copernicus data

#richiamo la libreria raster
library(raster)

#installo la libreria per legger in ncdf, formato di dati che mi interessa
install.packages("ncdf4")

#richiamo il pacchetto insieme al raster, senza le virgolette perchè li ho già installati
library(raster)
library(ncdf4)

#imposto la working directory
setwd("C:/lab/")

# a questo punto devo dare un nome al mio dataset.  copia e incolla il nome del dato lasciando l'estensione
albedo <- raster ("")

#scelgo una colorandpalette
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100)
plot(albed, col=cl)

