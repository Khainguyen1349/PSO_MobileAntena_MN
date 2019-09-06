function fitness = fitness_function(freq, agent,tmpPrjFile, tmpDataFile)

% Set up frequency
fC = freq(2);
fLow = freq(1);
fHigh = freq(3);
nPoints = freq(4);

% mobile antenna parameters
gndx = 73;
gndy = 140;
patchy = 5;
patchh = 4.5;

w = 1;

% Chosing PEC
PEC = 0;

rx1 = agent(1);
rx2 = agent(2);
rgap = agent(3);

%processing feeds' positions
x1 = rx1*(gndx - w)-gndx/2;
if (gndx - 3*w)*rx2 + w - gndx/2 >= x1
    x2 = (gndx - 3*w)*rx2 - gndx/2 + 2*w + 0.01;
else
    x2 = (gndx - 3*w)*rx2 - gndx/2;
end

gap = rgap*(gndx - 1);

Optenni_command = strcat('"C:\Program Files (x86)\Optenni\Optenni Lab 4.1\OptenniLab.exe" "',pwd,'\data\tmpData.s2p" -matching "', pwd, '\optenni\matchfile.xml"');

% Creating VB Script file and launch HFSS simulation
VBS_creation_coupling(gndx,gndy,patchy,patchh, x1, x2,w,gap,fC,fLow,fHigh,nPoints,tmpPrjFile, tmpDataFile, PEC)
vbsfile = [pwd, '\mobile.vbs'];
Status1 = hfssExecuteScript('C:\"Program Files"\AnsysEM\AnsysEM18.2\Win64\ansysedt.exe',  vbsfile, true,true);

if Status1 == 0
    % Load the data by running the exported matlab file.
    % run(tmpDataFile);
    filename = 'RadEff.csv';
    delimiter = ',';
    startRow = 2;
    endRow = 2;
    formatSpec = '%*s%*s%f%[^\n\r]';
    fileID = fopen(filename,'r');
    dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    efficiencyAnt = dataArray{1}; %positive number
    %Close the text file.
    fclose(fileID);
    
    
    %Execute Optenni to obtain best MN & best efficiency
    Status2 = system(Optenni_command);
    if Status2 == 0
        outputMN =  xml2struct('\optenni\outputMobile_ant.xml');
        efficiencyMN = str2double(outputMN.optennicurves.Attributes.costFunctionValue); %outputMN.Attributes(1,4).Value;
    end
    if efficiencyAnt < 0
        fitness=10^((efficiencyMN + efficiencyAnt)/10);
    else
        fitness=10^(efficiencyMN/10);
    end
else
    fitness = 0;
end

fprintf('fitness: %f \n', fitness);
clearvars filename delimiter startRow endRow formatSpec fileID dataArray ans;


