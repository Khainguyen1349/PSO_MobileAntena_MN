function genMatch

matchfile = strcat(pwd, '\optenni\matchfile.xml');

match = fopen(strrep(matchfile,'\','\\'), 'w');
fprintf(match,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(match,'<matching type="multiport" returntype="curves">\n');

l2 = strcat('    <settingsfile>', pwd,'\optenni\settingfile.mps</settingsfile>');
l3 = strcat('    <outputfile>', pwd,'\optenni\outputMobile_ant.xml</outputfile>');
l4 = strcat('    <projectoutputfile>', pwd,'\optenni\Mobile_ant.opr</projectoutputfile>');
link2 = strcat(strrep(l2,'\','\\'), '\n');
link3 = strcat(strrep(l3,'\','\\'), '\n');
link4 = strcat(strrep(l4,'\','\\'), '\n');

fprintf(match,link2);
fprintf(match,link3);
fprintf(match,link4);
fprintf(match,'</matching>');
fclose(match);