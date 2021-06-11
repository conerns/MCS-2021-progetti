import scipy.io as sio #usato per la lettura del file in formato .mat
from scipy.sparse import csc_matrix #per convertire la matrice sparse in formato
#richiesto dalla funzione spsolve()
from scipy.sparse.linalg import spsolve #usiamo la funzione spolve per risolvere
#il sistema, si possono usare matrici sparse
import time ##per poter calcoalre tempo di esecuzione
import numpy as np #usato per creare xe
from numpy import array
from numpy.linalg import norm
from scipy.linalg import solve
import os, psutil,glob;

files = glob.glob('*.mat') #prendo tutti i file .mat all'interno della stessa directory del file

import csv

with open('python_run.csv', 'w', newline='') as file: #apro un file in scrittura in modo da non doverlo cancellare sempre
    writer = csv.writer(file,delimiter=',')
    writer.writerow(["Nome", "Tempo", "Accuratezza", "Memoria"])

for i in range(0, len(files)):
    print(psutil.Process(os.getpid()).memory_info().rss / 1024 ** 2)
    file_data = sio.loadmat(files[i]) ##lettura del file
    #estrazione di A
    problem_a =  file_data["Problem"][0][0]['A']
    ##csc_matrix: Compressed Sparse Column format
    A = csc_matrix(problem_a) #matrice A

    # vettore xe di 1, della stessa dimensione di A
    xe = np.ones((int(A.get_shape()[1]),1))
    xe = csc_matrix(xe) ##conversione di xe in matrice

    # calcolo della variabile b, usando l'equazione A*xe = b
    print("Calcolo A*xe ... \n")
    b = np.dot(A,xe)
    # portiamo b alla forma necessaria per poter utilizzare .spsolve()
    csc_matrix.sort_indices(b)  # indici della matrice sparsa ordinati
    b  = csc_matrix.toarray(b)  # creazione di un array colonna
    b  = np.concatenate(b)      # creazione di una matrice formata da una sola colonna

    # calcolo della soluzione x del sistema A*x = b (note A e b)
    print("Calcolo A \ b \n")
    t = time.time() ##tempo iniziale
    x = spsolve(A,b)
    mempria_usata = psutil.Process(os.getpid()).memory_info().rss / 1024 ** 2
    elapsed = time.time() - t # calcolo tempo esecuzione

    print(x, "runned in: ", elapsed) ##x = A\b

    xe = csc_matrix.toarray(xe) #conversione in array

    #rimodellazione di x in una matrice con una sola colonna e conseguente trasposizione
    x = np.transpose(x).reshape((int(A.get_shape()[1]),1))

    # calcolo dell'errore relativo tra x e xe
    errore_relativo = norm(array(x-xe), 2)/norm(array(xe), 2)

    print("Errore relativo: ", errore_relativo)
    with open('python_run.csv', 'a', newline='') as file:# ad ogni run appendo per ogni file i valori necessari
        writer = csv.writer(file,delimiter=',')
        writer.writerow([files[i], elapsed, errore_relativo,mempria_usata])
