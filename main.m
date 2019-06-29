NumberLayers = 1; %n�mero de camadas de neur�nios
NumberNeurons = 10; %n�mero de neur�nios por camada

Folder = 1;
InicialCount = 0; %n�mero da primeira imagem da pasta
NumberImagesFolder = 0; %n�mero da ultima imagem da pasta

NumInputs = 10; %n�mero de entradas para o estudo das imagens

TargetShape = zeros(1,4); %vari�vel que transporta as formas de cada imagem

%verifica qual o n�mero de imagens em cada pasta
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

%Convers�o das imagens em Formas_1 em matrizes bin�rias
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