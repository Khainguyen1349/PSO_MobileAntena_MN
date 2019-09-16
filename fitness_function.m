function fitness = fitness_function(freq, agent,tmpPrjFile, tmpDataFile)

% Set up frequency
Antenna.fC = freq(2);
Antenna.fLow = freq(1);
Antenna.fHigh = freq(3);
Antenna.nPoints = freq(4);

% mobile antenna parameters
Antenna.gndx = 73;
Antenna.gndy = 140;
Antenna.patchy = 5;
Antenna.patchh = 4.5;

Antenna.feed_linew = 1;
Antenna.gapw = 1;
 
Antenna.gnd_clearance = 3;

% Chosing PEC
Antenna.PEC = 0;

%processing feeds' positions
Antenna.gap_pos = -Antenna.gndx/2 + agent(3)*Antenna.gndx;
Antenna.feed_pos1 = -Antenna.gndx/2 + Antenna.feed_linew/2 + agent(1)*...
    (agent(3)*Antenna.gndx - Antenna.gapw/2 - Antenna.feed_linew);
Antenna.feed_pos2 = Antenna.gap_pos + Antenna.gapw/2 + Antenna.feed_linew/2+...
    agent(2)*(Antenna.gndx - Antenna.feed_linew/2 - agent(3)*Antenna.gndx - Antenna.gapw/2);


Optenni_command = strcat('"C:\Program Files (x86)\Optenni\Optenni Lab 4.1\OptenniLab.exe" "',...
    pwd,'\data\tmpData.s2p" -matching "', pwd, '\optenni\matchfile.xml"');

% Creating VB Script file and launch HFSS simulation
VBS_creation_coupling(Antenna,tmpPrjFile, tmpDataFile)
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
