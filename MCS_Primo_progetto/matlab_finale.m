files = dir('*.mat'); %recupero files come in octave
%%%%%%
%Il confronto deve avvenire in termini di:
%tempo, accuratezza, impiego della memoria e anche facilità d’uso e documentazione
%%%%%%

user = memory;
tempo_di_esecuzione = []; %tempo
nome_della_matrice = {}; 
memoria_usata = {}; %impiego della memoria
error_relativo_matrice = []; %acuratezza
T = table(nome_della_matrice',memoria_usata',tempo_di_esecuzione',error_relativo_matrice');

for i = 1:length(files) 
    %display per stampare a video il nome dei file
    disp(files(i).name) 
    %carico del file in memoria 
    load(files(i).name)
    nome_della_matrice = [nome_della_matrice, files(i).name];
    A = Problem.A;
    
    %vettore xe di 1, della stessa dimensione di A
    xe = ones(length(A), 1);
    
    %calcolo della variabile b, usando l'equazione A*xe = b
    disp("Calcolo A * xe ...")
    b = A * xe;
    
    %calcolo della soluzione x del sistema A*x = b (note A e b)
    disp("Calcolo A \\ b")
    
    tic; %inizio di time
        x = A\b;
        disp("Memory usage(Mb):") %memoria utilizzata
        memoria_usata = [memoria_usata, monitor_memory_whos];
    tempo = toc; %fine time
    
    tempo_di_esecuzione = [tempo_di_esecuzione, tempo];
    
    %calcolo dell'errore relativo tra x e xe
    errore_relativo = norm(x-xe)/norm(xe)
    error_relativo_matrice = [error_relativo_matrice, errore_relativo];
end

T = table(nome_della_matrice',memoria_usata',tempo_di_esecuzione',error_relativo_matrice');
T.Properties.VariableNames = {'Nome','Memoria','Tempo','Accuratezza'};
writetable(T,'matlab_run.csv','Delimiter',',','QuoteStrings',true)
type 'matlab_run.csv'