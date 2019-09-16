function []=VBS_creation_coupling(Antenna,tmpPrjFile, tmpDataFile)

% Variable Antenna.PEC : 1 if Antenna.PEC, 0 if Finite conductivity

%lecture points
 lambda = 1000*3e8/Antenna.fC; % in mm
 
 tmpRadFile = [pwd, '\tmpRad.m'];

%creation fichier

fid= fopen('mobile.vbs', 'w+');
fprintf(fid,'Dim oHfssApp\nDim oDesktop\nDim oProject\nDim oDesign\nDim oEditor\nDim oModule\n');
fprintf(fid,'Set oHfssApp = CreateObject("AnsoftHfss.HfssScriptInterface")\n');
fprintf(fid, 'Set oDesktop = oHfssApp.GetAppDesktop()\n');
fprintf(fid, 'oDesktop.NewProject\n');
fprintf(fid,'Set oProject = oDesktop.GetActiveProject()\n');
fprintf(fid,'oProject.InsertDesign "HFSS", "dessin", "DrivenModal", ""\n');
fprintf(fid,'Set oDesign = oProject.SetActiveDesign("dessin")\n');
fprintf(fid,'Set oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
fprintf(fid,'\n');


%GND plane
fprintf(fid,'oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _\n');
fprintf(fid,'  "-%fmm", "YStart:=", "%dmm", "ZStart:=", "0mm", "Width:=", "%fmm", "Height:=",  _\n',Antenna.gndx/2,Antenna.gnd_clearance,Antenna.gndx);
fprintf(fid,'  "%fmm", "WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "Ground", "Flags:=",  _\n',Antenna.gndy-Antenna.gnd_clearance);
fprintf(fid,'  "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _\n');
fprintf(fid,'  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _\n');
fprintf(fid,'  true)\n');

fprintf(fid,'Set oModule = oDesign.GetModule("BoundarySetup")\n');
if(Antenna.PEC==1)
fprintf(fid,'oModule.AssignPerfectE Array("NAME:PerfE1", "Objects:=", Array("Ground"  _\n');
fprintf(fid,' ), "InfGroundPlane:=", false)\n');
else
fprintf(fid,'oModule.AssignFiniteCond Array("NAME:FiniteCond1", "Objects:=", Array("Ground"), "UseMaterial:=", false,  _\n');
fprintf(fid,'  "Conductivity:=", "58000000", "Permeability:=", "1", "UseThickness:=", _\n');
fprintf(fid,'false, "Roughness:=", "0um", "InfGroundPlane:=", false) \n');    
end    

%patch1
fprintf(fid,'oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _\n');
fprintf(fid,'  "%fmm", "YStart:=", "%dmm", "ZStart:=", "%dmm", "Width:=", "%fmm", "Height:=",  _\n',-Antenna.gndx/2,0,Antenna.patchh+0.5, Antenna.gndx);
fprintf(fid,'  "%fmm", "WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "Patch1", "Flags:=",  _\n',Antenna.patchy);
fprintf(fid,'  "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _\n');
fprintf(fid,'  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _\n');
fprintf(fid,'  true)\n');

fprintf(fid,'Set oModule = oDesign.GetModule("BoundarySetup")\n');
if(Antenna.PEC==1)
fprintf(fid,'oModule.AssignPerfectE Array("NAME:PerfE2", "Objects:=", Array("Patch1"  _\n');
fprintf(fid,' ), "InfGroundPlane:=", false)\n');
else
fprintf(fid,'oModule.AssignFiniteCond Array("NAME:FiniteCond2", "Objects:=", Array("Patch1"), "UseMaterial:=", false,  _\n');
fprintf(fid,'  "Conductivity:=", "58000000", "Permeability:=", "1", "UseThickness:=", _\n');
fprintf(fid,'false, "Roughness:=", "0um", "InfGroundPlane:=", false) \n');    
end  

%gap
fprintf(fid,'oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _\n');
fprintf(fid,'  "%fmm", "YStart:=", "%dmm", "ZStart:=", "%dmm", "Width:=", "%fmm", "Height:=",  _\n',Antenna.gap_pos - Antenna.gapw/2,0,Antenna.patchh+0.5, Antenna.gapw);
fprintf(fid,'  "%fmm", "WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "Gap", "Flags:=",  _\n',Antenna.patchy);
fprintf(fid,'  "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _\n');
fprintf(fid,'  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _\n');
fprintf(fid,'  true)\n');

hfssSubtract(fid, {'Patch1'}, {'Gap'});

%Vertical line 1
fprintf(fid,'oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _\n');
fprintf(fid,'  "%fmm", "YStart:=", "%dmm", "ZStart:=", "%dmm", "Width:=", "%fmm", "Height:=",  _\n',Antenna.feed_pos1 - Antenna.feed_linew/2,Antenna.gnd_clearance,0.5, Antenna.patchh);
fprintf(fid,'  "%fmm", "WhichAxis:=", "Y"), Array("NAME:Attributes", "Name:=", "Verline1", "Flags:=",  _\n',Antenna.feed_linew);
fprintf(fid,'  "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _\n');
fprintf(fid,'  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _\n');
fprintf(fid,'  true)\n');

fprintf(fid,'Set oModule = oDesign.GetModule("BoundarySetup")\n');
if(Antenna.PEC==1)
fprintf(fid,'oModule.AssignPerfectE Array("NAME:PerfE4", "Objects:=", Array("Verline1"  _\n');
fprintf(fid,' ), "InfGroundPlane:=", false)\n');
else
fprintf(fid,'oModule.AssignFiniteCond Array("NAME:FiniteCond4", "Objects:=", Array("Verline1"), "UseMaterial:=", false,  _\n');
fprintf(fid,'  "Conductivity:=", "58000000", "Permeability:=", "1", "UseThickness:=", _\n');
fprintf(fid,'false, "Roughness:=", "0um", "InfGroundPlane:=", false) \n');    
end  

%Vertical line 2
fprintf(fid,'oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _\n');
fprintf(fid,'  "%fmm", "YStart:=", "%dmm", "ZStart:=", "%dmm", "Width:=", "%fmm", "Height:=",  _\n',Antenna.feed_pos2 - Antenna.feed_linew/2,Antenna.gnd_clearance,0.5, Antenna.patchh);
fprintf(fid,'  "%fmm", "WhichAxis:=", "Y"), Array("NAME:Attributes", "Name:=", "Verline2", "Flags:=",  _\n',Antenna.feed_linew);
fprintf(fid,'  "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _\n');
fprintf(fid,'  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _\n');
fprintf(fid,'  true)\n');

fprintf(fid,'Set oModule = oDesign.GetModule("BoundarySetup")\n');
if(Antenna.PEC==1)
fprintf(fid,'oModule.AssignPerfectE Array("NAME:PerfE5", "Objects:=", Array("Verline2"  _\n');
fprintf(fid,' ), "InfGroundPlane:=", false)\n');
else
fprintf(fid,'oModule.AssignFiniteCond Array("NAME:FiniteCond5", "Objects:=", Array("Verline2"), "UseMaterial:=", false,  _\n');
fprintf(fid,'  "Conductivity:=", "58000000", "Permeability:=", "1", "UseThickness:=", _\n');
fprintf(fid,'false, "Roughness:=", "0um", "InfGroundPlane:=", false) \n');    
end 

%Port 1
fprintf(fid,'oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _\n');
fprintf(fid,'  "%fmm", "YStart:=", "%dmm", "ZStart:=", "%fmm", "Width:=", "%fmm", "Height:=",  _\n',Antenna.feed_pos1 - Antenna.feed_linew/2,Antenna.gnd_clearance,0,0.5);
fprintf(fid,'  "%fmm", "WhichAxis:=", "Y"), Array("NAME:Attributes", "Name:=", "Feed1", "Flags:=",  _\n',Antenna.feed_linew);
fprintf(fid,'  "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _\n');
fprintf(fid,'  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _\n');
fprintf(fid,'  true)\n');


fprintf(fid,'oModule.AssignLumpedPort Array("NAME:1", "Objects:=", Array("Feed1"), "RenormalizeAllTerminals:=",  _\n');
fprintf(fid,'  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _\n');
fprintf(fid,'  true, Array("NAME:IntLine", "Start:=", Array("%fmm", "%dmm", "0mm"), "End:=", Array( _\n',Antenna.feed_pos1,Antenna.gnd_clearance);
fprintf(fid,'  "%fmm", "%dmm", "%fmm")), "CharImp:=", "Zpi", "AlignmentGroup:=", 0)), "ShowReporterFilter:=",  _\n',Antenna.feed_pos1,Antenna.gnd_clearance,0.5);
fprintf(fid,'  false, "ReporterFilter:=", Array(true), "FullResistance:=", "50ohm", "FullReactance:=",  _\n');
fprintf(fid,'  "0ohm")\n');

%Port 2
fprintf(fid,'oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _\n');
fprintf(fid,'  "%fmm", "YStart:=", "%dmm", "ZStart:=", "%fmm", "Width:=", "%fmm", "Height:=",  _\n',Antenna.feed_pos2 - Antenna.feed_linew/2,Antenna.gnd_clearance,0,0.5);
fprintf(fid,'  "%fmm", "WhichAxis:=", "Y"), Array("NAME:Attributes", "Name:=", "Feed2", "Flags:=",  _\n',Antenna.feed_linew);
fprintf(fid,'  "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _\n');
fprintf(fid,'  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _\n');
fprintf(fid,'  true)\n');


fprintf(fid,'oModule.AssignLumpedPort Array("NAME:2", "Objects:=", Array("Feed2"), "RenormalizeAllTerminals:=",  _\n');
fprintf(fid,'  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _\n');
fprintf(fid,'  true, Array("NAME:IntLine", "Start:=", Array("%fmm", "%dmm", "0mm"), "End:=", Array( _\n',Antenna.feed_pos2,Antenna.gnd_clearance);
fprintf(fid,'  "%fmm", "%dmm", "%fmm")), "CharImp:=", "Zpi", "AlignmentGroup:=", 0)), "ShowReporterFilter:=",  _\n',Antenna.feed_pos2,Antenna.gnd_clearance, 0.5);
fprintf(fid,'  false, "ReporterFilter:=", Array(true), "FullResistance:=", "50ohm", "FullReactance:=",  _\n');
fprintf(fid,'  "0ohm")\n');

% NF box
fprintf(fid,'oEditor.CreateBox Array("NAME:BoxParameters", "XPosition:=", "-%dmm", "YPosition:=",  _\n',Antenna.gndx/2+lambda/8);
fprintf(fid,'  "-%dmm", "ZPosition:=", "-%dmm", "XSize:=", "%dmm", "YSize:=", "%dmm", "ZSize:=",  _\n',lambda/8,lambda/16,Antenna.gndx+lambda/4,Antenna.gndy+lambda/4);
fprintf(fid,'  "%dmm"), Array("NAME:Attributes", "Name:=", "Box_NF", "Flags:=", "", "Color:=",  _\n',lambda/8+Antenna.patchh+0.5);
fprintf(fid,'  "(132 132 193)", "Transparency:=", 0.9, "PartCoordinateSystem:=", "Global", "UDMId:=",  _\n');
fprintf(fid,'  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _\n');
fprintf(fid,'  true)\n');

%Radiating box
fprintf(fid,'oEditor.CreateBox Array("NAME:BoxParameters", "XPosition:=", "-%dmm", "YPosition:=",  _\n',Antenna.gndx/2+lambda/4);
fprintf(fid,'  "-%dmm", "ZPosition:=", "-%dmm", "XSize:=", "%dmm", "YSize:=", "%dmm", "ZSize:=",  _\n',lambda/4,lambda/4,Antenna.gndx+lambda/2,Antenna.gndy+lambda/2);
fprintf(fid,'  "%dmm"), Array("NAME:Attributes", "Name:=", "Rad_Box", "Flags:=", "", "Color:=",  _\n',lambda/2+Antenna.patchh+0.5);
fprintf(fid,'  "(132 132 193)", "Transparency:=", 0.9, "PartCoordinateSystem:=", "Global", "UDMId:=",  _\n');
fprintf(fid,'  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _\n');
fprintf(fid,'  true)\n');
fprintf(fid,'Set oModule = oDesign.GetModule("BoundarySetup")\n');
fprintf(fid,'oModule.AssignRadiation Array("NAME:Rad1", "Objects:=", Array("Rad_Box"), "IsIncidentField:=",  _\n');
fprintf(fid,'  false, "IsEnforcedField:=", false, "IsFssReference:=", false, "IsForPML:=",  _\n');
fprintf(fid,'  false, "UseAdaptiveIE:=", false, "IncludeInPostproc:=", true)\n');


% Add a Solution Setup.
    hfssInsertSolution(fid, 'Setup', Antenna.fC/1e9);
    hfssInterpolatingSweep(fid, 'Sweep', 'Setup', ...
        Antenna.fLow/1e9, Antenna.fHigh/1e9, Antenna.nPoints);
    
    
  fprintf(fid,'  oModule.EditSetup "Setup", Array("NAME:Setup", "Frequency:=", "%dGHz", "PortsOnly:=",  _\n',Antenna.fC/1e9);
  fprintf(fid,'false, "MaxDeltaS:=", 0.02, "UseMatrixConv:=", false, "MaximumPasses:=", 25, "MinimumPasses:=",  _\n'); % Max Number of Passes
  fprintf(fid,'2, "MinimumConvergedPasses:=", 2, "PercentRefinement:=", 20, "IsEnabled:=",  _\n'); % Min Number of Passes
  fprintf(fid,'true, "BasisOrder:=", 1, "UseIterativeSolver:=", false, "DoLambdaRefine:=",  _\n');
  fprintf(fid,'true, "DoMaterialLambda:=", true, "SetLambdaTarget:=", false, "Target:=",  _\n');
  fprintf(fid,'0.3333, "UseMaxTetIncrease:=", false, "PortAccuracy:=", 2, "UseABCOnPort:=",  _\n');
  fprintf(fid,'false, "SetPortMinMaxTri:=", false, "EnableSolverDomains:=", false, "SaveRadFieldsOnly:=",  _\n');
  fprintf(fid,'false, "SaveAnyFields:=", true, "NoAdditionalRefinementOnImport:=", false)_\n');
  
  
 % Radiation parameters 
 
 hfssInsertFarFieldSphereSetup(fid, 'Radiation', [0, 180, 10], [0, 360, 10]);
 hfssCreateReport(fid, '3Drad', 5, 6, 'Setup', [],'Radiation', [], {'Theta', 'Phi', 'Freq'},{'Theta', 'Phi', 'dB(RadiationEfficiency)'});
 
    % Save the project to a temporary file and solve it.
    hfssSaveProject(fid, tmpPrjFile, true);
    hfssSolveSetup(fid, 'Setup');
    
    % Export the Network data as an m-file.
    hfssExportNetworkData(fid, tmpDataFile, 'Setup', ...
        'Sweep','s');
    
    % Export Field
   hfssExportToFile(fid, '3Drad', 'RadEff', 'csv'); % Saves in the same dir.

fclose(fid);
