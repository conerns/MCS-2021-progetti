files = dir('*.mat'); 
%%%%%%
%Il confronto deve avvenire in termini di:
%tempo, accuratezza, impiego della memoria e anche facilità d’uso e documentazione
%%%%%%
csvfile = fopen('octave_run.csv', "w");
scrivo = strcat("Nome,", "Memoria,", "Tempo,","Accuratezza")
fprintf(csvfile, "%s", scrivo);

fprintf(csvfile, "\n");  
for i = 1:length(files) 
    %display per stampare a video il nome dei file
    disp(files(i).name) 
    %carico del file in memoria 
    load(files(i).name)
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
        memoria_usata =  monitor_memory_whos;        
        disp(memoria_usata)
    tempo = toc; %fine di time
    
    %calcolo dell'errore relativo tra x e xe
    errore_relativo = norm(x-xe)/norm(xe)
    %scrivere su file
    fprintf(csvfile, "%s", files(i).name);
    fprintf(csvfile, ",");
    fprintf(csvfile, "%f", memoria_usata);    
    fprintf(csvfile, ",");
    fprintf(csvfile, "%f", tempo);
    fprintf(csvfile, ",");
    fprintf(csvfile, "%e", errore_relativo);
    fprintf(csvfile, "\n");  
end
fclose(csvfile);
