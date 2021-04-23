# 16/04/2021
# R_code_knitr.r, codice per creare template finali

# set della working directory 
setwd("C:/lab/") # Windows

#installo il pacchetto knitr, mi permette di creare dei report finali delle operazioni su R
install.packages("knitr")

#richiamo il pacchetto knitr
library(knitr)

#salva il codice di cui vuoi il report sul pc tramite qualsiasi gestore di testo (anche word è ok)
#funzione stitch per applicare il pacchetto knitr al codice di cui voglio il report
#nel primo argomento specifica l'estensione se hai problemi durante il caricamento (quì è .tex)
stitch("R_code_greenland.r.tex", template=system.file("misc","knitr-template.Rnw", package="knitr"))

