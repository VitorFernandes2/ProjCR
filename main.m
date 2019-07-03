function main()

clc;
NumberLayers = 1; %número de camadas de neurónios
NumberNeurons = 10; %número de neurónios por camada

Folder = 1; %pasta que se quer estudar as imagens
InicialCount = 0; %número da primeira imagem da pasta
NumberImagesFolder = 0; %número da ultima imagem da pasta

NumInputs = 10; %número de entradas para o estudo das imagens

TargetShape = zeros(1,4); %variável que transporta as formas de cada imagem


%###############################################

%verifica qual o número de imagens em cada pasta

%###############################################

switch Folder
    
    case 1 %Formas_1
        InicialCount = 0;
        NumberImagesFolder = 3;
        %Target Matrix é a matriz que guarda os dados relativos aos alvos
        %em estudo
    
    case 2 %Formas_2

        
    case 3 %Formas_3

        
end


%#######################################################

%Conversão das imagens em Formas_1 em matrizes binárias

%#######################################################

outputmatrix= zeros(4,4);
            
 for i = InicialCount:NumberImagesFolder

    ImageName = '';
    
    %verifica qual a pasta que estamos a analisar
    switch Folder
       
        case 1 %Formas_1
            
            ImageName = sprintf('Formas_1\\%d.png', i);
            Img = imread(ImageName);
            Img = imbinarize(Img);
            inputmatrix(1:40000,i+1)=Img(:); % input <- mudar o nome
                      
            outputmatrix(i+1,i+1)=1;
            
            % https://www.mathworks.com/matlabcentral/answers/196072-how-to-read-all-the-images-in-a-folder
            % -> rever
            
        case 2 %Formas_2
            
        case 3 %Formas_3
                        
    end
    
 end
 
 
 %SimulationMatrix = zeros(NumInputs, 4);

for i=1:4
   
    ImageName = sprintf('ImagensLeitura\\%d.png', i - 1);
    Img = imread(ImageName);
    Img = imbinarize(Img);
    SimulationMatrix(1:40000,i)=Img(:); % input <- mudar o nome

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

net = feedforwardnet(NumberNeurons);
net.layers{1}.transferFcn = 'tansig';
%net.layers{2}.transferFcn = 'tansig';

net.trainFcn = 'trainscg';

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

% SIMULAR
%simula a rede neuronal treinada com os novos dados de entrada
out = sim(net, SimulationMatrix);

%VISUALIZAR DESEMPENHO

plotconfusion(outputmatrix, out) % Matriz de confusao

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

