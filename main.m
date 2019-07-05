function main()

clc;
NumberLayers = 1; %número de camadas de neurónios
NumberNeurons = 10; %número de neurónios por camada

Folder = 3; %pasta que se quer estudar as imagens
InicialCount = 0; %número da primeira imagem da pasta
NumberImagesFolder = 0; %número da ultima imagem da pasta

%NumInputs = 10; %número de entradas para o estudo das imagens

TargetShape = zeros(1,4); %variável que transporta as formas de cada imagem

Numimagenscomp = 4; % TEMPPP -> numero de imagens lidas pra comparar -> definido para as 4 de imagensleitura

Recizevalue = 2; % 1 se normal, 2 se recized pra 20x20 (aumenta significativamente a velocidade e tirar bugs de ram)




%--------------------------------------------------------
%Consoante o folder escolhido , faz a "preparação" de variaveis necessarias para a leitura
%--------------------------------------------------------
switch Folder 
    case 1 %Formas_1
        NumberImagesFolder = 3;
        outputmatrix = zeros(4,4);
    case 2 %Formas_2
        NumberImagesFolder = 3; % ante -> 200, agora 4 pq algoritmp alterado
        outputmatrix = zeros(4,804);
    case 3 %Formas_3
        NumberImagesFolder = 3; % ante -> 250 agora 3
        outputmatrix = zeros(4,200);
end

%--------------------------------------------------------
%Conversão das imagens em Formas_1 em matrizes binárias
%--------------------------------------------------------
%outputmatrix= zeros(4,NumberImagesFolder - InicialCount + 1);
            
 for i = 0:NumberImagesFolder

    ImageName = '';
    
    switch Folder  %verifica qual a pasta que estamos a analisar
       
        case 1 %Formas_1
            
            ImageName = sprintf('Formas_1\\%d.png', i);
            Img = imread(ImageName);
            Img = imbinarize(Img);
            if Recizevalue == 2
                Img = imresize(Img, 0.1); % temp
                inputmatrix(1:400,i+1)=Img(:); % matrix de input de informação pra rede neuronal 
            else
                inputmatrix(1:40000,i+1)=Img(:); % matrix de input de informação pra rede neuronal 
            end          
            outputmatrix(i+1,i+1)=1;
            
        case 2 %Formas_2
            
            switch i
                case 0
                    for j = 0:200
                        ImageName = sprintf('Formas_2\\circle\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            inputmatrix(1:400,j+1)=Img(:); 
                        else
                            inputmatrix(1:40000,j+1)=Img(:);
                        end   
                        outputmatrix(1,j+1)=1;
                    end
                case 1  
                    for j = 0:200
                        ImageName = sprintf('Formas_2\\square\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            inputmatrix(1:400,j+1 + 201)=Img(:);
                        else
                            inputmatrix(1:40000,j+1 + 201)=Img(:);
                        end   
                        outputmatrix(2,j+1 + 201)=1;
                    end
                case 2  
                    for j = 0:200
                        ImageName = sprintf('Formas_2\\star\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            inputmatrix(1:400,j+1 + 402)=Img(:);
                        else
                            inputmatrix(1:40000,j+1 + 402)=Img(:);
                        end
                        outputmatrix(3,j+1 + 402)=1;
                    end
                case 3
                    for j = 0:200
                        ImageName = sprintf('Formas_2\\triangle\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            inputmatrix(1:400,j+1 + 603)=Img(:);
                        else
                            inputmatrix(1:40000,j+1 + 603)=Img(:);
                        end
                        outputmatrix(4,j+1 + 603)=1;
                    end
            end
                   
        case 3 %Formas_3
           
            switch i
                case 0
                    for j = 201:250
                        ImageName = sprintf('Formas_3\\circle\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            inputmatrix(1:400,j-200)=Img(:);
                        else
                            inputmatrix(1:40000,j-200)=Img(:);
                        end
                        outputmatrix(1,j-200)=1;
                    end
                case 1  
                    for j = 201:250
                        ImageName = sprintf('Formas_3\\square\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            inputmatrix(1:400,j-200 +50)=Img(:);
                        else
                            inputmatrix(1:40000,j-200 +50)=Img(:);
                        end
                        outputmatrix(2,j-200 +50)=1;
                    end
                case 2  
                    for j = 201:250
                        ImageName = sprintf('Formas_3\\star\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            inputmatrix(1:400,j-200 +100)=Img(:);
                        else
                            inputmatrix(1:40000,j-200 +100)=Img(:);
                        end
                        outputmatrix(3,j-200 +100)=1;
                    end
                case 3
                    for j = 201:250
                        ImageName = sprintf('Formas_3\\triangle\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            inputmatrix(1:400,j-200 +150)=Img(:);
                        else
                            inputmatrix(1:40000,j-200 +150)=Img(:);
                        end
                        outputmatrix(4,j-200 +150)=1;
                    end
            end
            
            
    end
    
 end

for i=1:Numimagenscomp
   
    ImageName = sprintf('ImagensLeitura\\%d.png', i - 1);
    Img = imread(ImageName);
    Img = imbinarize(Img);
    
    if Recizevalue == 2
        Img = imresize(Img, 0.1); % temp
        SimulationMatrix(1:400,i)=Img(:); % matrix onde esta os objetos q serão testados
    else
        SimulationMatrix(1:40000,i)=Img(:); % matrix onde esta os objetos q serão testados
    end 


end
 
%{
net = feedforwardnet(NumberNeurons);
net.divideFcn = '';
net.trainFcn = 'trainc'; %Função de treino
net.layers{1}.transferFcn = 'tansig'; %função de ativação
%}

%Segunda Meta
%net.divideFcn = 'dividerand';
% net.divideParam.trainRatio = 0.70;
% net.divideParam.valRatio = 0.15;
% net.divideParam.testRatio = 0.15;
 
%Criação da Rede Neuronal com NumberNeurons neurónios

net = feedforwardnet([100 100]);
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
%net.layers{3}.transferFcn = 'tansig'

net.trainFcn = 'trainscg'; %trainscg (rapido, pouca ram); trainlm (recomandado, mas lento e pesado)->se trainlm obgrigatorio usar recize.
net.trainparam.epochs=1000; % nº de instances
net.divideFcn = ''; %topico A

% topico B \/
%{
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.7;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.15;
%}



%Treinar
%treina com os dados de entrada e com a matriz de objectivos

[net,tr] = train(net,inputmatrix,outputmatrix);

view(net);
disp(tr)

%{
save -> save net
load -> load net
%}

% SIMULAR
%simula a rede neuronal treinada com os novos dados de entrada
out = sim(net, SimulationMatrix);

% matrix pra mostrar plot confusion sem erros
outputresulmatrix= zeros(4,Numimagenscomp); % ultimo valor do (,este) mudar consuanto o no de imagens q são lidas

for i=1:Numimagenscomp
   
    outputresulmatrix(i,i)=1;

end


%VISUALIZAR DESEMPENHO
plotconfusion(outputresulmatrix, out) % Matriz de confusao

plotperf(tr)         % Grafico com o desempenho da rede nos 3 conjuntos  

%Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos
r=0;
for i=1:size(out,2)               % Para cada classificacao  
  [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(outputmatrix(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end

accuracy = r/size(out,2)*100;
fprintf('Precisao total %.2f%%\n', accuracy)

end
