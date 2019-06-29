NumberLayers = 1; %n�mero de camadas de neur�nios
NumberNeurons = 10; %n�mero de neur�nios por camada

Folder = 1;
InicialCount = 0; %n�mero da primeira imagem da pasta
NumberImagesFolder = 0; %n�mero da ultima imagem da pasta

%verifica qual o n�mero de imagens em cada pasta
switch Folder
    
    case 1 %Formas_1
        InicialCount = 0;
        NumberImagesFolder = 3;
    case 2 %Formas_2
        InicialCount = 0;
        NumberImagesFolder = 200;
    case 3 %Formas_3
        InicialCount = 201;
        NumberImagesFolder = 250;
    
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
            switch i
               
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
            
        case 2 %Formas_2
            
        case 3 %Formas_3
            
    end
    
end