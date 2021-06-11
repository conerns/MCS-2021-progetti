 
names = ["G3" "GT01R" 'Hook' 'TSC' 'bundle' 'ifiss' 'nd24k' 'ns3Da'];
nonzeros = [7660826 430909 59374451 2012833 20207907 3599932 28715634 1679599];
nonzeros_windows_python = nonzeros([1:2, 4:end]);
nonzeros_ubuntu_python = nonzeros([1:2, 4:4, 6:end]);
matDim = [1585478^2 7980^2 1498023^2 8100^2 513351^2 96307^2 72000^2 20400^2];

width = 800;
height = 400;

% Leggo la matrice
WIN_OCT = readtable('octave_run_windows');
UBU_OCT = readtable('octave_ubunutu_1804lts');
WIN_MLB = readtable('matlab_windows');
UBU_MLB = readtable('matlab_ubunutu_1804lts');
WIN_PYT = readtable('python_run_windows');
UBU_PYT = readtable('python_ubunutu_1804lts');

% Inizializzo le 6 matrici
WIN_OCT = initMatrix(WIN_OCT, nonzeros, matDim);
UBU_OCT = initMatrix(UBU_OCT, nonzeros, matDim);
WIN_MLB = initMatrix(WIN_MLB, nonzeros, matDim);
UBU_MLB = initMatrix(UBU_MLB, nonzeros, matDim);
WIN_PYT = initMatrix(WIN_PYT, nonzeros_windows_python, matDim([1:2, 4:end]));
UBU_PYT = initMatrix(UBU_PYT, nonzeros_ubuntu_python, matDim([1:2, 4:4, 6:end]));

%% Stampo i confronti per SO

% Octave
    printGraphUbuntuWindows(WIN_OCT.NZ, WIN_OCT.Memoria, UBU_OCT.NZ, UBU_OCT.Memoria, 1, "Octave: memory comparision", "Memory used (Mb)");
    printGraphUbuntuWindows(WIN_OCT.NZ, WIN_OCT.Tempo, UBU_OCT.NZ, UBU_OCT.Tempo, 2, "Octave: running time comparision", "Running time (sec)");
    printGraphUbuntuWindows(WIN_OCT.NZ, WIN_OCT.Accuratezza, UBU_OCT.NZ, UBU_OCT.Accuratezza, 3, "Octave: error comparision", "Error");
    % Siccome l'errore risulta uguale a prima vista, abbiamo visto che dai dati
    % c'è qualche differenza. Decidiamo di plottare il tutto senza i dati di
    % bundle_adj, poiché l'errore è uguale.
    printGraphUbuntuWindows(WIN_OCT.NZ([1:5,7:end]), WIN_OCT.Accuratezza([1:5,7:end]), UBU_OCT.NZ([1:5,7:end]), UBU_OCT.Accuratezza([1:5,7:end]), 4, "Octave: error comparision without bundleadj", "Error");

% MATLAB
    printGraphUbuntuWindows(WIN_MLB.NZ, WIN_MLB.Memoria, UBU_MLB.NZ, UBU_MLB.Memoria, 5, "MATLAB: memory comparision", "Memory used (Mb)");
    printGraphUbuntuWindows(WIN_MLB.NZ, WIN_MLB.Tempo, UBU_MLB.NZ, UBU_MLB.Tempo, 6, "MATLAB: running time comparision", "Running time (sec)");
    printGraphUbuntuWindows(WIN_MLB.NZ, WIN_MLB.Accuratezza, UBU_MLB.NZ, UBU_MLB.Accuratezza, 7, "MATLAB: error comparision", "Error");
    % Anche qui l'accuratezza di bundle_adj è uguale: provvediamo ad eliminarla
    printGraphUbuntuWindows(WIN_MLB.NZ([1:5,7:end]), WIN_MLB.Accuratezza([1:5,7:end]), UBU_MLB.NZ([1:5,7:end]), UBU_MLB.Accuratezza([1:5,7:end]), 8, "MATLAB: error comparision without bundleadj", "Error");


% Python
    % Facciamo il confronto solo su quello che abbiamo
    % Tolgo da WIN_PYT bundle_adj, perché l'altro non ce l'ha (su Ubuntu non è
    % riuscito a calcolarlo)
    printGraphUbuntuWindows(WIN_PYT.NZ([1:5,7:end]), WIN_PYT.Memoria([1:5,7:end]), UBU_PYT.NZ, UBU_PYT.Memoria, 9, "Python: memory comparision", "Memory used (Mb)");
    printGraphUbuntuWindows(WIN_PYT.NZ([1:5,7:end]), WIN_PYT.Tempo([1:5,7:end]), UBU_PYT.NZ, UBU_PYT.Tempo, 10, "Python: running time comparision", "Running time (sec)");
    printGraphUbuntuWindows(WIN_PYT.NZ([1:5,7:end]), WIN_PYT.Accuratezza([1:5,7:end]), UBU_PYT.NZ, UBU_PYT.Accuratezza, 11, "Python: error comparision", "Error");

%% Stampo i confronti per linguaggi, per il SO scelto
%     % Da questo confronto tolgo bundle adj e hook, in quanto Python non ce l'ha. Ne
%     % teniamo conto però durante l'analisi di questa mancanza
%     OCT = UBU_OCT([1:5, 7:7],:);
%     MLB = UBU_MLB([1:5, 7:7],:);
%     PYT = UBU_PYT;
%     
%     % Confronto memoria
%     printGraphCompLanguages(OCT.NZ, OCT.Memoria, MLB.NZ, MLB.Memoria, PYT.NZ, PYT.Memoria, 12, "Memory comparision", "Memory used (Mb)");
%     
%     % Confronto tempo
%     printGraphCompLanguages(OCT.NZ, OCT.Tempo, MLB.NZ, MLB.Tempo, PYT.NZ, PYT.Tempo, 13, "Time comparision", "Time elapsed (sec)");
%     
%     % Confronto errore
%     printGraphCompLanguages(OCT.NZ, OCT.Accuratezza, MLB.NZ, MLB.Accuratezza, PYT.NZ, PYT.Accuratezza, 14, "Accuracy comparision", "Error");
%     
%     % Confronto solo tra MATLAB e Octave UBUNTU, per capire l'entità
%     % dell'errore. Rimuovo com sempre dal confronto i valori uguali
%     printGraphCompLanguages(UBU_OCT.NZ([1:5,7:end]), UBU_OCT.Accuratezza([1:5,7:end]), UBU_MLB.NZ([1:5,7:end]), UBU_MLB.Accuratezza([1:5,7:end]), [], [], 15, "Accuracy comparision (Octave vs. MATLAB)", "Error");
%     
    
%% Stampo per ogni misura un grafico relativo alla coppia SO-Applicazione
    
    %% Con Python
        % Memoria
        gfc = figure(100);
        hold on;
        plot(WIN_OCT.NZ, WIN_OCT.Memoria,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0, 0.4470, 0.7410]	);
        plot(UBU_OCT.NZ, UBU_OCT.Memoria,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.8500, 0.3250, 0.0980]);
        plot(WIN_MLB.NZ, WIN_MLB.Memoria,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.9290, 0.6940, 0.1250]);
        plot(UBU_MLB.NZ, UBU_MLB.Memoria,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.4660, 0.6740, 0.1880]);
        plot(WIN_PYT.NZ, WIN_PYT.Memoria,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.6350, 0.0780, 0.1840]);
        plot(UBU_PYT.NZ, UBU_PYT.Memoria,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0, 0.75, 0.75]);
        title('Memory analysis', 'Interpreter', 'latex', 'FontSize', 12)
        M = legend('Octave-Windows','Octave-Ubuntu','MATLAB-Windows','MATLAB-Ubuntu','Python-Windows','Python-Ubuntu');
        set(M, 'Interpreter', 'latex', 'FontSize', 8, 'Location','northwest');
        xlabel('Number of nonzero element', 'Interpreter', 'latex', 'FontSize', 10);
        ylabel('Memory used (Mb)', 'Interpreter', 'latex', 'FontSize', 10);
        set(gcf,'units','inches','position',[0,0,6,2.9]);
        saveas(gcf,".\img\all_memory.png");

        % Tempo
        gfc = figure(101);
        hold on;
        plot(WIN_OCT.NZ, WIN_OCT.Tempo,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0, 0.4470, 0.7410]	);
        plot(UBU_OCT.NZ, UBU_OCT.Tempo,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.8500, 0.3250, 0.0980]);
        plot(WIN_MLB.NZ, WIN_MLB.Tempo,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.9290, 0.6940, 0.1250]);
        plot(UBU_MLB.NZ, UBU_MLB.Tempo,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.4660, 0.6740, 0.1880]);
        plot(WIN_PYT.NZ, WIN_PYT.Tempo,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.6350, 0.0780, 0.1840]);
        plot(UBU_PYT.NZ, UBU_PYT.Tempo,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0, 0.75, 0.75]);
        title('Time analysis', 'Interpreter', 'latex', 'FontSize', 12)
        M = legend('Octave-Windows','Octave-Ubuntu','MATLAB-Windows','MATLAB-Ubuntu','Python-Windows','Python-Ubuntu');
        set(M, 'Interpreter', 'latex', 'FontSize', 8, 'Location','northeast');
        xlabel('Number of nonzero element', 'Interpreter', 'latex', 'FontSize', 10);
        ylabel('Time elapsed (sec)', 'Interpreter', 'latex', 'FontSize', 10);
        set(gcf,'units','inches','position',[0,0,6,2.9]);
        saveas(gcf,".\img\all_time.png");

        % Accuratezza
        gfc = figure(102);
        hold on;
        plot(WIN_OCT.NZ, WIN_OCT.Accuratezza,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0, 0.4470, 0.7410]	);
        plot(UBU_OCT.NZ, UBU_OCT.Accuratezza,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.8500, 0.3250, 0.0980]);
        plot(WIN_MLB.NZ, WIN_MLB.Accuratezza,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.9290, 0.6940, 0.1250]);
        plot(UBU_MLB.NZ, UBU_MLB.Accuratezza,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.4660, 0.6740, 0.1880]);
        plot(WIN_PYT.NZ, WIN_PYT.Accuratezza,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.6350, 0.0780, 0.1840]);
        plot(UBU_PYT.NZ, UBU_PYT.Accuratezza,'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0, 0.75, 0.75]);
        title('Accuracy analysis', 'Interpreter', 'latex', 'FontSize', 12)
        M = legend('Octave-Windows','Octave-Ubuntu','MATLAB-Windows','MATLAB-Ubuntu','Python-Windows','Python-Ubuntu');
        set(M, 'Interpreter', 'latex', 'FontSize', 8, 'Location','northeast');
        xlabel('Number of nonzero element', 'Interpreter', 'latex', 'FontSize', 10);
        ylabel('Error', 'Interpreter', 'latex', 'FontSize', 10);
        set(gcf,'units','inches','position',[0,0,6,2.9]);
        saveas(gcf,".\img\all_accuracy.png");
    
    %% Senza Python
        % Memoria-small
        gfc = figure(104);
        hold on;
        plot(WIN_OCT.NZ([1:5,7:end]), WIN_OCT.Memoria([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', 1, 'MarkerSize', 8, 'Color', [0, 0.4470, 0.7410]	);
        plot(UBU_OCT.NZ([1:5,7:end]), UBU_OCT.Memoria([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', 1, 'MarkerSize', 8, 'Color', [0.8500, 0.3250, 0.0980]);
        plot(WIN_MLB.NZ([1:5,7:end]), WIN_MLB.Memoria([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', 1, 'MarkerSize', 8, 'Color', [0.9290, 0.6940, 0.1250]);
        plot(UBU_MLB.NZ([1:5,7:end]), UBU_MLB.Memoria([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', 1, 'MarkerSize', 8, 'Color', [0.4660, 0.6740, 0.1880]);
        title('Memory analysis without bundleadj, Python', 'Interpreter', 'latex', 'FontSize', 12)
        M = legend('Octave-Windows','Octave-Ubuntu','MATLAB-Windows','MATLAB-Ubuntu');
        set(M, 'Interpreter', 'latex', 'FontSize', 8, 'Location','northwest');
        xlabel('Number of nonzero element', 'Interpreter', 'latex', 'FontSize', 10);
        ylabel('Memory (Mb)', 'Interpreter', 'latex', 'FontSize', 10);
        set(gcf,'units','inches','position',[0,0,6,2.9]);
        saveas(gcf,".\img\all_Memory_small.png");
        
        % Tempo-small
        gfc = figure(105);
        hold on;
        plot(WIN_OCT.NZ([1:5,7:end]), WIN_OCT.Tempo([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', 1, 'MarkerSize', 8, 'Color', [0, 0.4470, 0.7410]	);
        plot(UBU_OCT.NZ([1:5,7:end]), UBU_OCT.Tempo([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', 1, 'MarkerSize', 8, 'Color', [0.8500, 0.3250, 0.0980]);
        plot(WIN_MLB.NZ([1:5,7:end]), WIN_MLB.Tempo([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', 1, 'MarkerSize', 8, 'Color', [0.9290, 0.6940, 0.1250]);
        plot(UBU_MLB.NZ([1:5,7:end]), UBU_MLB.Tempo([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', 1, 'MarkerSize', 8, 'Color', [0.4660, 0.6740, 0.1880]);
        title('Time analysis without bundleadj, Python', 'Interpreter', 'latex', 'FontSize', 12)
        M = legend('Octave-Windows','Octave-Ubuntu','MATLAB-Windows','MATLAB-Ubuntu');
        set(M, 'Interpreter', 'latex', 'FontSize', 8, 'Location','northwest');
        xlabel('Number of nonzero element', 'Interpreter', 'latex', 'FontSize', 10);
        ylabel('Elapsed time (sec)', 'Interpreter', 'latex', 'FontSize', 10);
        set(gcf,'units','inches','position',[0,0,6,2.9]);
        saveas(gcf,".\img\all_Time_small.png");
        
        % Accuratezza-small
            % Tolto Python e il valore alto ed uguale per tutti
        gfc = figure(106);
        hold on;
        plot(WIN_OCT.NZ([1:5,7:end]), WIN_OCT.Accuratezza([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0, 0.4470, 0.7410]	);
        plot(UBU_OCT.NZ([1:5,7:end]), UBU_OCT.Accuratezza([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.8500, 0.3250, 0.0980]);
        plot(WIN_MLB.NZ([1:5,7:end]), WIN_MLB.Accuratezza([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.9290, 0.6940, 0.1250]);
        plot(UBU_MLB.NZ([1:5,7:end]), UBU_MLB.Accuratezza([1:5,7:end]),'LineStyle', '-', 'Marker','.', 'Linewidth', .5, 'MarkerSize', 8, 'Color', [0.4660, 0.6740, 0.1880]);
        title('Accuracy analysis without bundleadj, Python', 'Interpreter', 'latex', 'FontSize', 12)
        M = legend('Octave-Windows','Octave-Ubuntu','MATLAB-Windows','MATLAB-Ubuntu');
        set(M, 'Interpreter', 'latex', 'FontSize', 8, 'Location','northeast');
        xlabel('Number of nonzero element', 'Interpreter', 'latex', 'FontSize', 10);
        ylabel('Error', 'Interpreter', 'latex', 'FontSize', 10);
        set(gcf,'units','inches','position',[0,0,6,2.9]);
        saveas(gcf,".\img\all_Accuracy_small.png");

%% Funzioni utilizzate

function [NewMat] = initMatrix(M, nonzeros, matDim)

    % Ordino le righe
    A = sortrows(M,"Nome");

    % Inserisco nella matrice le dimensioni
    A.Dimensione = transpose(matDim);
    A.NZ = transpose(nonzeros);

    % Ordino nuovamente le righe per dimensione
    NewMat = sortrows(A,"NZ");
end

function [] = printGraphUbuntuWindows(AX, AY, BX, BY, fig, titleStr, yLab)
    gcf = figure(fig);
    hold on;
    plot(AX, AY,'LineStyle', '-', 'Marker','.', 'Linewidth', 0.5, 'MarkerSize', 8, 'Color', [0, 0.4470, 0.7410]	);
    plot(BX, BY,'LineStyle', '-', 'Marker','.', 'Linewidth', 0.5, 'MarkerSize', 8, 'Color', [0.8500, 0.3250, 0.0980]);
    title(titleStr, 'Interpreter', 'latex', 'FontSize', 12)
    M = legend('Windows','Ubuntu');
    set(M, 'Interpreter', 'latex', 'FontSize', 10, 'Location','northwest');
    xlabel('Number of nonzero element', 'Interpreter', 'latex', 'FontSize', 10);
    ylabel(yLab, 'Interpreter', 'latex', 'FontSize', 10);
    set(gcf,'units','inches','position',[0,0,6,2.9]);
    saveas(gcf,".\img\" + strrep(titleStr,':','') + ".png");
    hold off;
end

function[] = printGraphCompLanguages(OCTX, OCTY, MLBX, MLBY, PYTX, PYTY, fig, titleStr, yLab)
    figure(fig);
    hold on;
    plot(OCTX, OCTY,'LineStyle', '-', 'Marker','.', 'Linewidth', 1, 'MarkerSize', 16, 'Color', 'b'	);
    plot(MLBX, MLBY,'LineStyle', '-', 'Marker','.', 'Linewidth', 1, 'MarkerSize', 16, 'Color', 'r'	);
    plot(PYTX, PYTY,'LineStyle', '-', 'Marker','.', 'Linewidth', 1, 'MarkerSize', 16, 'Color', 'y'	);
    title(titleStr, 'Interpreter', 'latex', 'FontSize', 12)
    M = legend('Octave','MATLAB','Python');
    set(M, 'Interpreter', 'latex', 'FontSize', 12, 'Location','northwest');
    xlabel('Number of nonzero element', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel(yLab, 'Interpreter', 'latex', 'FontSize', 14);
    hold off;
end
