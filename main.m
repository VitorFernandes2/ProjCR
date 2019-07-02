function main()

clc;
clear all;
close all;

% Carrega o dataset
load iris_dataset;
load fisheriris;
clear meas;

NumberLayers = 1; %n�mero de camadas de neur�nios
NumberNeurons = 10; %n�mero de neur�nios por camada

Folder = 1; %pasta que se quer estudar as imagens
InicialCount = 0; %n�mero da primeira imagem da pasta
NumberImagesFolder = 0; %n�mero da ultima imagem da pasta

NumInputs = 10; %n�mero de entradas para o estudo das imagens

TargetShape = zeros(1,4); %vari�vel que transporta as formas de cada imagem


%###############################################

%verifica qual o n�mero de imagens em cada pasta

%###############################################

switch Folder
    
    case 1 %Formas_1
        InicialCount = 0;
        NumberImagesFolder = 3;
        %Target Matrix � a matriz que guarda os dados relativos aos alvos
        %em estudo
        TargetMatrix = zeros(4, NumberImagesFolder - InicialCount + 1);
        InputMatrix = zeros(NumInputs,NumberImagesFolder - InicialCount + 1); 
        %cada coluna da matriz guarda NumInputs de 
        %caracteres de cada imagem
    
    case 2 %Formas_2
        InicialCount = 0;
        NumberImagesFolder = 200;
        %o *4 no TargetMatrix tem a ver com o n�mero de pastas a autalizar
        %ser� o n�mero da imagem final - o n�mero da imagems inicial * 4 
        %pois � o n�mero de pastas internas 
        TargetMatrix = zeros(4, (NumberImagesFolder - InicialCount + 1) * 4);
        InputMatrix = zeros(NumInputs, (NumberImagesFolder - InicialCount + 1) * 4); 
        %cada coluna da matriz guarda NumInputs de 
        %caracteres de cada imagem
        
    case 3 %Formas_3
        InicialCount = 201;
        NumberImagesFolder = 250;
        TargetMatrix = zeros(4, (NumberImagesFolder - InicialCount + 1) * 4);
        InputMatrix = zeros(NumInputs, (NumberImagesFolder - InicialCount + 1) * 4); 
        %cada coluna da matriz guarda NumInputs de 
        %caracteres de cada imagem
        
end


%#######################################################

%Convers�o das imagens em Formas_1 em matrizes bin�rias

%#######################################################


for i = InicialCount:NumberImagesFolder

    ImageName = '';
    
    %verifica qual a pasta que estamos a analisar
    switch Folder
       
        case 1 %Formas_1
            
            ImageName = sprintf('Formas_1\\%d.png', i);
            Img = imread(ImageName);
            
            %como n�o t�m algo que as possa distinguir para dizer que 
            %forma tem de se usar este switch
            switch (i + 1)
               
                case 1 %circulo
                    %TargetShape � uma vari�vel que diz qual a forma do
                    %alvo em an�lise
                    TargetShape = [1;0;0;0];
                    
                case 2 %ret�ngulo
                    TargetShape = [0;1;0;0];
                    
                case 3 %estrela
                    TargetShape = [0;0;1;0];
                    
                case 4 %tri�ngulo
                    TargetShape = [0;0;0;1];
                    
            end
            
            %coloca��o da TargetShape na TargetMatrix
            TargetMatrix(:,(i - InicialCount + 1)) = TargetShape;
            
            %preenche cada vari�vel com o n�mero de pixel de altura e
            %largura
            [Num_Row, Num_Column] = size(Img);
            
            for h = 1 : NumInputs %vai correr o n�mero de linhas para preencher a matriz com pontos da imagem
               
                for j = (((Num_Row/NumInputs)*(h-1))+1) : ((Num_Row/NumInputs)*(h))
                
                    for k = 1 : Num_Column
                        
                        if Img(j,k) == 0
                        
                            %matriz que guarda toda a informa��o acerca das
                            %formas em estudo
                            InputMatrix(h,(i - InicialCount + 1)) = InputMatrix(h,(i - InicialCount + 1)) + k;
                            
                        end
                            
                    end
                    
                end
                
            end
            
        case 2 %Formas_2
            
            
            
        case 3 %Formas_3
                        
    end
    
end

%Matriz de simula��o para 4 imagens em estudo
SimulationMatrix = zeros(NumInputs, 4);

for i=1:4
   
    %L� as imagens
    ImageName = sprintf('ImagensLeitura\\%d.png', i - 1);
    Img = imread(ImageName);

    %preenche cada vari�vel com o n�mero de pixel de altura e
    %largura
    [Num_Row, Num_Column] = size(Img);

    for h = 1 : NumInputs %vai correr o n�mero de linhas para preencher a matriz com pontos da imagem

        for j = (((Num_Row/NumInputs)*(h-1))+1) : ((Num_Row/NumInputs)*(h))

            for k = 1 : Num_Column

                if Img(j,k) == 0

                    %matriz que guarda toda a informa��o acerca das
                    %formas em estudo
                    SimulationMatrix(h,i) = SimulationMatrix(h,i) + k;

                end

            end

        end

    end
    
end

% Normaliza��o das matrizes
A=[InputMatrix,SimulationMatrix] ;
maxi=max(max(A));
mini=min(min(A));
[a,b]=size(A);
for i=1:a
    for j=1:b
        AN(i,j)=(A(i,j)/(maxi-mini));
    end
end

InputMatrix=AN(:,1:NumberImagesFolder - InicialCount + 1);
SimulationMatrix=AN(:,1:NumberImagesFolder - InicialCount + 1);
%fim da Normaliza��o das matrizes

%Cria��o da Rede Neuronal com NumberNeurons neur�nios
net = feedforwardnet(NumberNeurons);
net.trainFcn = 'trainc'; %Fun��o de treino
net.layers{1}.transferFcn = 'tansig'; %fun��o de ativa��o

%Segunda Meta
%net.divideFcn = 'dividerand';
% net.divideParam.trainRatio = 0.70;
% net.divideParam.valRatio = 0.15;
% net.divideParam.testRatio = 0.15;

%Treinar
%treina com os dados de entrada e com a matriz de objectivos
[net,tr] = train(net,InputMatrix,TargetMatrix);

view(net);
disp(tr)

% SIMULAR
%simula a rede neuronal treinada com os novos dados de entrada
out = sim(net, InputMatrix);

%VISUALIZAR DESEMPENHO

plotconfusion(TargetMatrix, out) % Matriz de confusao

plotperf(tr)         % Grafico com o desempenho da rede nos 3 conjuntos  

%Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos
r=0;
for i=1:size(out,2)               % Para cada classificacao  
  [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(TargetMatrix(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end

accuracy = r/size(out,2)*100;
fprintf('Precisao total %.2f%%\n', accuracy)

end

