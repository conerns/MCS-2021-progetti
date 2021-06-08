import math
import time

import numpy as np
from scipy import fft
import matplotlib.pyplot as plt

matrice_test_traccia_progetto = [[231, 32, 233, 161, 24, 71, 140, 245],
                                 [247, 40, 248, 245, 124, 204, 36, 107],
                                 [234, 202, 245, 167, 9, 217, 239, 173],
                                 [193, 190, 100, 167, 43, 180, 8, 70],
                                 [11, 24, 210, 177, 81, 243, 8, 112],
                                 [97, 195, 203, 47, 125, 114, 165, 181],
                                 [193, 70, 174, 167, 41, 30, 127, 245],
                                 [87, 149, 57, 192, 65, 129, 178, 228]]


# test1 = np.random.randint(low=0, high=255, size=(500, 500))

# t = time.time()
# x = fft.dctn(test1, norm="ortho", type=2)
# y = fft.dct(x.T, norm="ortho")
# elapsed1 = time.time() - t
# print("tempo fft: ", elapsed1)
# print(x)


# rc = np.shape(test1)


def DCT_riga(matrice_iniziale):
    dct_per_riga = np.zeros(np.shape(matrice_iniziale))
    for i in range(0, rc[0]):
        for k in range(0, rc[1]):
            alpha = math.sqrt(1 / rc[1]) if k == 0 else math.sqrt(2 / rc[1])
            value = ['None'] * rc[1]
            for j in range(0, rc[1]):
                value[j] = (math.cos(
                    math.pi * k * (2 * j + 1) / (2 * rc[1])) * matrice_iniziale[i][j])
            dct_per_riga[i][k] = (alpha * np.sum(value))
    return DCT_colonna(dct_per_riga)


def DCT_colonna(dct_per_riga):
    # evitiamo letture errate
    dct_per_colonna = np.zeros(np.shape(dct_per_riga))
    for i in range(0, rc[0]):
        for k in range(0, rc[1]):
            alpha = math.sqrt(1 / rc[1]) if k == 0 else math.sqrt(2 / rc[1])
            value = ['None'] * rc[1]
            for j in range(0, rc[1]):
                value[j] = (math.cos(
                    math.pi * k * (2 * j + 1) / (2 * rc[1])) * dct_per_riga[j][i])
            dct_per_colonna[k][i] = (alpha * np.sum(value))
    return dct_per_colonna


# si tiene traccia del tempo impiegato dalla fft
# elapsed1 = [0] * 8 //risultati molto bassi, una semplice stampa risulta una soluzione
# migliore, essendo il valore spesso arrotondato a 0
# si tiene traccia del tempo impeigato dalla DCT2 fatta da noi
elapsed2 = [0] * 8

"""
dopo aver eseguito dei test preliminari, in  modo da non ottenere tempi di escuzioni pari a 0
dalla fft, e avere quindi dei risultati validi, siamo arrivati a delle matrici di dimensioni 
intorno a 200*200.
Dato che la DCT2 fatta da noi impiega O(n^3) nel caso peggiore, ci siamo limitati superioremente
a una matrice 550*550 che comporta di per se dei tempi decisamente elevati.
"""

dim = [200, 250, 300, 350, 400, 450, 500, 550]
for i in range(len(dim)):
    print(i)  # tenuto per capire durante l'esecuzione in che iterazione ci si trova

    test2 = np.random.randint(low=0, high=255, size=(dim[i], dim[i]))

    t1 = time.time()
    x = fft.dctn(test2, norm="ortho", type=2)
    print(math.log(time.time() - t1))

    rc = np.shape(test2)  # usato per poi poter eseguire la DCT righe/colonne

    t2 = time.time()
    dct2_completa = DCT_riga(test2)
    elapsed2[i] = time.time() - t2

for i in range(len(elapsed2)):
    if elapsed2[i] > 0:
        elapsed2[i] = math.log(elapsed2[i])
print("tempi di dct a mano: ", elapsed2)
print("dimensioni matrice: ", dim)
