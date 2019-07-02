NumberLayers = 1; %n�mero de camadas de neur�nios
NumberNeurons = 10; %n�mero de neur�nios por camada

Folder = 2; %pasta que se quer estudar as imagens
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
            
            %nesta sec��o ir�o ser lidas 4 imagens 1 por por cada pasta,
            %ou seja, vai ser lido um circulo, um quadrado, uma estrela, e
            %um tri�ngulo
            
            %imagens da pasta circulo
            ImageName = sprintf('Formas_2\\circle\\%d.png', i);
            Img = imread(ImageName);
            
            TargetShape = [1;0;0;0]; %Circulo
            
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
            
            %imagens da pasta square
            ImageName = sprintf('Formas_2\\square\\%d.png', i);
            Img = imread(ImageName);
            
            TargetShape = [0;1;0;0]; %Quadrado
            
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
              
            %imagens da pasta star
            ImageName = sprintf('Formas_2\\star\\%d.png', i);
            Img = imread(ImageName);
            
            TargetShape = [0;0;1;0]; %Estrela
            
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
            
            %imagens da pasta triangle
            ImageName = sprintf('Formas_2\\triangle\\%d.png', i);
            Img = imread(ImageName);
            
            TargetShape = [0;0;0;1]; %Tri�ngulo
            
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
            
        case 3 %Formas_3
            
            %nesta sec��o ir�o ser lidas 4 imagens 1 por por cada pasta,
            %ou seja, vai ser lido um circulo, um quadrado, uma estrela, e
            %um tri�ngulo
            
            %imagens da pasta circulo
            ImageName = sprintf('Formas_3\\circle\\%d.png', i);
            Img = imread(ImageName);
            
            TargetShape = [1;0;0;0]; %Circulo
            
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
            
            %imagens da pasta square
            ImageName = sprintf('Formas_3\\square\\%d.png', i);
            Img = imread(ImageName);
            
            TargetShape = [0;1;0;0]; %Quadrado
            
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
              
            %imagens da pasta star
            ImageName = sprintf('Formas_3\\star\\%d.png', i);
            Img = imread(ImageName);
            
            TargetShape = [0;0;1;0]; %Estrela
            
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
            
            %imagens da pasta triangle
            ImageName = sprintf('Formas_3\\triangle\\%d.png', i);
            Img = imread(ImageName);
            
            TargetShape = [0;0;0;1]; %Tri�ngulo
            
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