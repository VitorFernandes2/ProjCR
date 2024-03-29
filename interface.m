function varargout = interface(varargin)
% INTERFACE MATLAB code for interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface

% Last Modified by GUIDE v2.5 05-Jul-2019 02:26:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interface (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%----------- Apaga data que possa ter ficado em memoria no uso anterior---
if isappdata(0,'sharedinputmatrix')
    rmappdata(0,'sharedinputmatrix');
end
if isappdata(0,'sharedoutputmatrix')
    rmappdata(0,'sharedoutputmatrix');
end
if isappdata(0,'sharedRecizevalue')
    rmappdata(0,'sharedRecizevalue');
end
if isappdata(0,'sharedSimulationMatrix')
    rmappdata(0,'sharedSimulationMatrix');
end
if isappdata(0,'sharednet')
    rmappdata(0,'sharednet');    
end
if isappdata(0,'sharedtargetsim')
    rmappdata(0,'sharedtargetsim'); 
end


% --- Outputs from this function are returned to the command line.
function varargout = interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function numberlayerinput_Callback(hObject, eventdata, handles)
% hObject    handle to numberlayerinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberlayerinput as text
%        str2double(get(hObject,'String')) returns contents of numberlayerinput as a double


% --- Executes during object creation, after setting all properties.
function numberlayerinput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberlayerinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Numberneuronsinput_Callback(hObject, eventdata, handles)
% hObject    handle to Numberneuronsinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isnan(str2double(get(handles.Numberneuronsinput,'string')))
    set(handles.Numberneuronsinput, 'string', '0');
end
if str2double(get(handles.Numberneuronsinput,'string')) < 0
    set(handles.Numberneuronsinput, 'string', '0');
end
% Hints: get(hObject,'String') returns contents of Numberneuronsinput as text
%        str2double(get(hObject,'String')) returns contents of Numberneuronsinput as a double


% --- Executes during object creation, after setting all properties.
function Numberneuronsinput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Numberneuronsinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in createnewnet.
function createnewnet_Callback(hObject, eventdata, handles)
% hObject    handle to createnewnet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

intFolder = get(handles.pastaselect, 'Value');
switch intFolder
    case 1
        Folder = 1; %pasta que se quer estudar as imagens
    case 2
        Folder = 2; %pasta que se quer estudar as imagens
    case 3
        Folder = 3; %pasta que se quer estudar as imagens
end

infRecize = get(handles.redimopcion, 'Value');
switch infRecize
    case 1
        Recizevalue = 2; % 1 se normal, 2 se recized pra 20x20 (aumenta significativamente a velocidade e tirar bugs de ram)
    case 2
        Recizevalue = 1; % 1 se normal, 2 se recized pra 20x20 (aumenta significativamente a velocidade e tirar bugs de ram)
end

%--------------------------------------------------------
%Consoante o folder escolhido , faz a "prepara��o" de variaveis necessarias para a leitura
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
%Convers�o das imagens em Formas_1 em matrizes bin�rias
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
                inputmatrix(1:400,i+1)=Img(:); % matrix de input de informa��o pra rede neuronal 
            else
                inputmatrix(1:40000,i+1)=Img(:); % matrix de input de informa��o pra rede neuronal 
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

setappdata(0,'sharedinputmatrix',inputmatrix);
setappdata(0,'sharedoutputmatrix',outputmatrix);
setappdata(0,'sharedRecizevalue',Recizevalue);

set(handles.createnetconfirm, 'string', 'Rede preparada');
set(handles.createnetconfirm, 'ForegroundColor', [0 0.6 0.1]);


% --- Executes on selection change in functreino.
function functreino_Callback(hObject, eventdata, handles)
% hObject    handle to functreino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns functreino contents as cell array
%        contents{get(hObject,'Value')} returns selected item from functreino


% --- Executes during object creation, after setting all properties.
function functreino_CreateFcn(hObject, eventdata, handles)
% hObject    handle to functreino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in selectimg.
function selectimg_Callback(hObject, eventdata, handles)
% hObject    handle to selectimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Recizevalue = getappdata(0,'sharedRecizevalue');
if(isempty(Recizevalue))
    infRecize = get(handles.redimopcion, 'Value');
    switch infRecize
        case 1
            Recizevalue = 2; % 1 se normal, 2 se recized pra 20x20 (aumenta significativamente a velocidade e tirar bugs de ram)
        case 2
            Recizevalue = 1; % 1 se normal, 2 se recized pra 20x20 (aumenta significativamente a velocidade e tirar bugs de ram)
    end
end

NumberImagesFolder = 1;

option = 1;
targetsim = zeros(4,NumberImagesFolder);


[file,path] = uigetfile('*.png');
if isequal(file,0)
   disp('User selected Cancel');
else
  
    i = 0;
    ImageName = '';   
    ImageName = strcat(path,file);
    Img = imread(ImageName);
    Img = imbinarize(Img);
    if Recizevalue == 2
        Img = imresize(Img, 0.1); % temp
        SimulationMatrix(1:400,i+1)=Img(:); % matrix de input de informa��o pra rede neuronal 
    else
        SimulationMatrix(1:40000,i+1)=Img(:); % matrix de input de informa��o pra rede neuronal 
    end
    targetsim(i+1,i+1)=1;

    setappdata(0,'sharedSimulationMatrix',SimulationMatrix);
    setappdata(0,'sharedtargetsim',targetsim);

    set(handles.statusimg, 'string', 'Img de util. carregada');
    set(handles.statusimg, 'ForegroundColor', [0 0.6 0.1]);
end


% --- Executes on button press in drawimg.
function drawimg_Callback(hObject, eventdata, handles)
% hObject    handle to drawimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Recizevalue = getappdata(0,'sharedRecizevalue');
if(isempty(Recizevalue))
    infRecize = get(handles.redimopcion, 'Value');
    switch infRecize
        case 1
            Recizevalue = 2; % 1 se normal, 2 se recized pra 20x20 (aumenta significativamente a velocidade e tirar bugs de ram)
        case 2
            Recizevalue = 1; % 1 se normal, 2 se recized pra 20x20 (aumenta significativamente a velocidade e tirar bugs de ram)
    end
end

NumberImagesFolder = 3;

infRecize = get(handles.predimgs, 'Value');
switch infRecize
    case 1
        option = 1;
        targetsim = zeros(4,4);
    case 2
        option = 2;
        targetsim = zeros(4,804);
    case 3
        option = 3;
        targetsim = zeros(4,200);
end

%--------------------------------------------------------
%Convers�o das imagens em Formas_1 em matrizes bin�rias
%--------------------------------------------------------
%outputmatrix= zeros(4,NumberImagesFolder - InicialCount + 1);
            
 for i = 0:NumberImagesFolder

    ImageName = '';
    
    switch option  %verifica qual a pasta que estamos a analisar
       
        case 1 %Formas_1
            
            ImageName = sprintf('Formas_1\\%d.png', i);
            Img = imread(ImageName);
            Img = imbinarize(Img);
            if Recizevalue == 2
                Img = imresize(Img, 0.1); % temp
                SimulationMatrix(1:400,i+1)=Img(:); % matrix de input de informa��o pra rede neuronal 
            else
                SimulationMatrix(1:40000,i+1)=Img(:); % matrix de input de informa��o pra rede neuronal 
            end          
            targetsim(i+1,i+1)=1;
            
        case 2 %Formas_2
            
            switch i
                case 0
                    for j = 0:200
                        ImageName = sprintf('Formas_2\\circle\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            SimulationMatrix(1:400,j+1)=Img(:); 
                        else
                            SimulationMatrix(1:40000,j+1)=Img(:);
                        end
                        targetsim(1,j+1)=1;
                    end
                case 1  
                    for j = 0:200
                        ImageName = sprintf('Formas_2\\square\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            SimulationMatrix(1:400,j+1 + 201)=Img(:);
                        else
                            SimulationMatrix(1:40000,j+1 + 201)=Img(:);
                        end
                        targetsim(2,j+1 + 201)=1;
                    end
                case 2  
                    for j = 0:200
                        ImageName = sprintf('Formas_2\\star\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            SimulationMatrix(1:400,j+1 + 402)=Img(:);
                        else
                            SimulationMatrix(1:40000,j+1 + 402)=Img(:);
                        end
                        targetsim(3,j+1 + 402)=1;
                    end
                case 3
                    for j = 0:200
                        ImageName = sprintf('Formas_2\\triangle\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            SimulationMatrix(1:400,j+1 + 603)=Img(:);
                        else
                            SimulationMatrix(1:40000,j+1 + 603)=Img(:);
                        end
                        targetsim(4,j+1 + 603)=1;
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
                            SimulationMatrix(1:400,j-200)=Img(:);
                        else
                            SimulationMatrix(1:40000,j-200)=Img(:);
                        end
                        targetsim(1,j-200)=1;
                    end
                case 1  
                    for j = 201:250
                        ImageName = sprintf('Formas_3\\square\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            SimulationMatrix(1:400,j-200 +50)=Img(:);
                        else
                            SimulationMatrix(1:40000,j-200 +50)=Img(:);
                        end
                        targetsim(2,j-200 +50)=1;
                    end
                case 2  
                    for j = 201:250
                        ImageName = sprintf('Formas_3\\star\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            SimulationMatrix(1:400,j-200 +100)=Img(:);
                        else
                            SimulationMatrix(1:40000,j-200 +100)=Img(:);
                        end
                        targetsim(3,j-200 +100)=1;
                    end
                case 3
                    for j = 201:250
                        ImageName = sprintf('Formas_3\\triangle\\%d.png', j);
                        Img = imread(ImageName);
                        Img = imbinarize(Img);
                        if Recizevalue == 2
                            Img = imresize(Img, 0.1); % temp
                            SimulationMatrix(1:400,j-200 +150)=Img(:);
                        else
                            SimulationMatrix(1:40000,j-200 +150)=Img(:);
                        end
                        targetsim(4,j-200 +150)=1;
                    end
            end     
    end  
 end

setappdata(0,'sharedSimulationMatrix',SimulationMatrix);
setappdata(0,'sharedtargetsim',targetsim);

set(handles.statusimg, 'string', 'Imgs predef carregadas');
set(handles.statusimg, 'ForegroundColor', [0 0.6 0.1]);


% --- Executes on button press in runbtn.
function runbtn_Callback(hObject, eventdata, handles)
% hObject    handle to runbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SimulationMatrix = getappdata(0,'sharedSimulationMatrix');
outputresulmatrix = getappdata(0,'sharedtargetsim');
net = getappdata(0,'sharednet');

out = sim(net, SimulationMatrix);

set(handles.uitable1 ,'Data' ,out);


%{
outputresulmatrix= zeros(4,4); % ultimo valor do (,este) mudar consuanto o no de imagens q s�o lidas
for i=1:4   
    outputresulmatrix(i,i)=1;
end
%}
f1 = figure;
plotconfusion(outputresulmatrix, out) % Matriz de confusao




% --- Executes on button press in saveneubut.
function saveneubut_Callback(hObject, eventdata, handles)
% hObject    handle to saveneubut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isappdata(0,'sharednet')
    f = warndlg('N�o existe um rede neuronal','Warning');
else
    net = getappdata(0,'sharednet');
    %save net;
    [file,path] = uiputfile('*.mat');
    if isequal(file,0)
        f = msgbox('Escolha cancelada','Erro');
    else
        output = strcat(path,file);
        out = net;
        save(output,'out');
        f = msgbox('Rede neuronal guardada','Success');
        %setappdata(0,'sharednet',net); % mete a net em "global" 
    end
end


% --- Executes on button press in loadneubut.
function loadneubut_Callback(hObject, eventdata, handles)
% hObject    handle to loadneubut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    %net = getappdata(0,'sharednet');
    %load net;
    %setappdata(0,'sharednet',net); % mete a net em "global" 
    
    [file,path] = uigetfile('*.mat');
    if isequal(file,0)
        f = msgbox('Escolha cancelada','Erro');
    else
       intput = strcat(path,file);
        %out = net;
        out = load(intput);
        net = out.out;
        setappdata(0,'sharednet',net); % mete a net em "global" 
        f = msgbox('Rede neuronal lida com sucesso','Successo');
        
        set(handles.createnetconfirm, 'string', 'Rede preparada');
        set(handles.createnetconfirm, 'ForegroundColor', [0 0.6 0.1]);
        
        set(handles.trainlabel, 'string', 'Treino carregado');
        set(handles.trainlabel, 'ForegroundColor', [0 0.6 0.1]);
    end


%{
[file,path] = uigetfile('*.mat');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end
%}

% --- Executes on button press in saveresult.
function saveresult_Callback(hObject, eventdata, handles)
% hObject    handle to saveresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
table = get(handles.uitable1,'Data');
xlswrite('output.xlsx',table);
f = msgbox('Ficheiro exel guardado na diretoria do programa','Sucesso');




function trainRationum_Callback(hObject, eventdata, handles)
% hObject    handle to trainRationum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isnan(str2double(get(handles.trainRationum,'string')))
    set(handles.trainRationum, 'string', '0');
end
if str2double(get(handles.trainRationum,'string')) < 0
    set(handles.trainRationum, 'string', '0');
end
if str2double(get(handles.trainRationum,'string')) > 100
    set(handles.trainRationum, 'string', '0');
end
percTot = str2double(get(handles.trainRationum,'string')) + str2double(get(handles.valRationum,'string')) + str2double(get(handles.testRationum,'string'));
if percTot > 100 || percTot < 0
   set(handles.trainRationum, 'string', '0');
end
% Hints: get(hObject,'String') returns contents of trainRationum as text
%        str2double(get(hObject,'String')) returns contents of trainRationum as a double


% --- Executes during object creation, after setting all properties.
function trainRationum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trainRationum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function valRationum_Callback(hObject, eventdata, handles)
% hObject    handle to valRationum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isnan(str2double(get(handles.valRationum,'string')))
    set(handles.valRationum, 'string', '0');
end
if str2double(get(handles.valRationum,'string')) < 0
    set(handles.valRationum, 'string', '0');
end
if str2double(get(handles.valRationum,'string')) > 100
    set(handles.valRationum, 'string', '0');
end
percTot = str2double(get(handles.trainRationum,'string')) + str2double(get(handles.valRationum,'string')) + str2double(get(handles.testRationum,'string'));
if percTot > 100 || percTot < 0
   set(handles.valRationum, 'string', '0');
end

% Hints: get(hObject,'String') returns contents of valRationum as text
%        str2double(get(hObject,'String')) returns contents of valRationum as a double


% --- Executes during object creation, after setting all properties.
function valRationum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valRationum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function testRationum_Callback(hObject, eventdata, handles)
% hObject    handle to testRationum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isnan(str2double(get(handles.testRationum,'string')))
    set(handles.testRationum, 'string', '0');
end
if str2double(get(handles.testRationum,'string')) < 0
    set(handles.testRationum, 'string', '0');
end
if str2double(get(handles.testRationum,'string')) > 100
    set(handles.testRationum, 'string', '0');
end
percTot = str2double(get(handles.trainRationum,'string')) + str2double(get(handles.valRationum,'string')) + str2double(get(handles.testRationum,'string'));
if percTot > 100 || percTot < 0
   set(handles.testRationum, 'string', '0');
end
% Hints: get(hObject,'String') returns contents of testRationum as text
%        str2double(get(hObject,'String')) returns contents of testRationum as a double


% --- Executes during object creation, after setting all properties.
function testRationum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to testRationum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pastaselect.
function pastaselect_Callback(hObject, eventdata, handles)
% hObject    handle to pastaselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pastaselect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pastaselect


% --- Executes during object creation, after setting all properties.
function pastaselect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pastaselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in treinstart.
function treinstart_Callback(hObject, eventdata, handles)
% hObject    handle to treinstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NumberNeurons = str2num(get(handles.Numberneuronsinput, 'string'));
inflayer = get(handles.layerconf, 'Value');
switch inflayer
    case 1
        net = feedforwardnet(NumberNeurons);
        net.layers{1}.transferFcn = 'tansig'; 
    case 2
        net = feedforwardnet(NumberNeurons);
        net.layers{1}.transferFcn = 'logsig';
    case 3
        net = feedforwardnet(NumberNeurons);
        net.layers{1}.transferFcn = 'purelin'; 
    case 4
        net = feedforwardnet([NumberNeurons NumberNeurons NumberNeurons]);
        net.layers{1}.transferFcn = 'tansig'; 
        net.layers{2}.transferFcn = 'tansig';
        net.layers{3}.transferFcn = 'tansig'; 
    case 5
        net = feedforwardnet([NumberNeurons NumberNeurons NumberNeurons]);
        net.layers{1}.transferFcn = 'tansig'; 
        net.layers{2}.transferFcn = 'logsig'; 
        net.layers{3}.transferFcn = 'purelin'; 
end

%------------- trainfcn-----
allItems = get(handles.functreino,'string');
selectedIndex = get(handles.functreino,'Value');
selectedItem = allItems{selectedIndex};

net.trainFcn = selectedItem; %trainscg (rapido, pouca ram); trainlm (recomandado, mas lento e pesado)->se trainlm obgrigatorio usar recize.
%--------------------------
net.trainparam.epochs=250; % n� de instances

if ~get(handles.checkboxtype, 'Value')
    net.divideFcn = ''; %topico A
else
    net.divideFcn = 'dividerand'; %topico B
    a = str2double(get(handles.trainRationum,'string')) / 100;
    net.divideParam.trainRatio = str2double(get(handles.trainRationum,'string'));
    net.divideParam.valRatio = str2double(get(handles.valRationum,'string'));
    net.divideParam.testRatio = str2double(get(handles.testRationum,'string'));
end

    inputmatrix = getappdata(0,'sharedinputmatrix');
    outputmatrix = getappdata(0,'sharedoutputmatrix');
    
    [net,tr] = train(net,inputmatrix,outputmatrix);

    setappdata(0,'sharednet',net); % mete a net em "global"
    
    
    set(handles.trainlabel, 'string', 'Treino realizado');
    set(handles.trainlabel, 'ForegroundColor', [0 0.6 0.1]);
    %view(net);
    %disp(tr)



% --- Executes on button press in checkboxtype.
function checkboxtype_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if get(hObject,'Value') == 0
        set(handles.trainRationum, 'enable', 'off');
        set(handles.valRationum, 'enable', 'off');
        set(handles.testRationum, 'enable', 'off');
    else
        set(handles.trainRationum, 'enable', 'on');
        set(handles.valRationum, 'enable', 'on');
        set(handles.testRationum, 'enable', 'on');

    end
% Hint: get(hObject,'Value') returns toggle state of checkboxtype


% --- Executes on selection change in redimopcion.
function redimopcion_Callback(hObject, eventdata, handles)
% hObject    handle to redimopcion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns redimopcion contents as cell array
%        contents{get(hObject,'Value')} returns selected item from redimopcion


% --- Executes during object creation, after setting all properties.
function redimopcion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to redimopcion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in predimgs.
function predimgs_Callback(hObject, eventdata, handles)
% hObject    handle to predimgs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns predimgs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from predimgs


% --- Executes during object creation, after setting all properties.
function predimgs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to predimgs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in layerconf.
function layerconf_Callback(hObject, eventdata, handles)
% hObject    handle to layerconf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns layerconf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from layerconf


% --- Executes during object creation, after setting all properties.
function layerconf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layerconf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
