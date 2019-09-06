Dim oHfssApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule

Set oHfssApp  = CreateObject("AnsoftHfss.HfssScriptInterface")
Set oDesktop = oHfssApp.GetAppDesktop()
oDesktop.RestoreWindow
oDesktop.NewProject
Set oProject = oDesktop.GetActiveProject

oProject.InsertDesign "HFSS", "folded_dipole", "DrivenModal", ""
Set oDesign = oProject.SetActiveDesign("folded_dipole")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")
oEditor.CreateCircle _
Array("NAME:CircleParameters", _
"IsCovered:=", true, _
"XCenter:=", "0.000000meter", _
"YCenter:=", "0.000000meter", _
"ZCenter:=", "0.057150meter", _
"Radius:=", "0.012700meter", _
"WhichAxis:=", "Y"), _
Array("NAME:Attributes", _
"Name:=", "SemiCircle1", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.SweepAroundAxis _
	Array("NAME:Selections", "Selections:=", "SemiCircle1"), _
	Array("NAME:AxisSweepParameters", _
		"DraftAngle:=", "0.000000deg", _
		"DraftType:=", "Round", _
		"SweepAxis:=", "X", _
		"SweepAngle:=", "-180.000000deg")

oEditor.Move _
Array("NAME:Selections", _
"Selections:=", "SemiCircle1"), _
Array("NAME:TranslateParameters", _
"TranslateVectorX:=", "0.000000meter", _
"TranslateVectorY:=", "0.387350meter", _
"TranslateVectorZ:=", "0.000000meter")
oEditor.CreateCircle _
Array("NAME:CircleParameters", _
"IsCovered:=", true, _
"XCenter:=", "0.000000meter", _
"YCenter:=", "0.000000meter", _
"ZCenter:=", "0.057150meter", _
"Radius:=", "0.012700meter", _
"WhichAxis:=", "Y"), _
Array("NAME:Attributes", _
"Name:=", "SemiCircle2", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.SweepAroundAxis _
	Array("NAME:Selections", "Selections:=", "SemiCircle2"), _
	Array("NAME:AxisSweepParameters", _
		"DraftAngle:=", "0.000000deg", _
		"DraftType:=", "Round", _
		"SweepAxis:=", "X", _
		"SweepAngle:=", "180.000000deg")

oEditor.Move _
Array("NAME:Selections", _
"Selections:=", "SemiCircle2"), _
Array("NAME:TranslateParameters", _
"TranslateVectorX:=", "0.000000meter", _
"TranslateVectorY:=", "-0.387350meter", _
"TranslateVectorZ:=", "0.000000meter")

oEditor.CreateCylinder _
Array("NAME:CylinderParameters", _
"XCenter:=", "0.000000meter", _
"YCenter:=", "-0.387350meter", _
"ZCenter:=", "0.057150meter", _
"Radius:=", "0.012700meter", _
"Height:=", "0.774700meter", _
"WhichAxis:=", "Y"), _
Array("NAME:Attributes", _
"Name:=", "TopCylinder", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)


oEditor.CreateCylinder _
Array("NAME:CylinderParameters", _
"XCenter:=", "0.000000meter", _
"YCenter:=", "-0.387350meter", _
"ZCenter:=", "-0.057150meter", _
"Radius:=", "0.012700meter", _
"Height:=", "0.371856meter", _
"WhichAxis:=", "Y"), _
Array("NAME:Attributes", _
"Name:=", "BottomCylinder1", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)


oEditor.CreateCylinder _
Array("NAME:CylinderParameters", _
"XCenter:=", "0.000000meter", _
"YCenter:=", "0.387350meter", _
"ZCenter:=", "-0.057150meter", _
"Radius:=", "0.012700meter", _
"Height:=", "-0.371856meter", _
"WhichAxis:=", "Y"), _
Array("NAME:Attributes", _
"Name:=", "BottomCylinder2", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)


oEditor.Unite  _
Array("NAME:Selections", _
"Selections:=", "TopCylinder,SemiCircle1,BottomCylinder1,BottomCylinder2,SemiCircle2"), _
Array("NAME:UniteParameters", "KeepOriginals:=", false)

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
Array("NAME:Geometry3DAttributeTab", _
Array("NAME:PropServers", "TopCylinder"), _
Array("NAME:ChangedProps", _
Array("NAME:Name", _
"Value:=", "FoldedDipole"))))

oEditor.AssignMaterial _
	Array("NAME:Selections", _
		"Selections:=", "FoldedDipole"), _
	Array("NAME:Attributes", _
		"MaterialName:=", "copper", _
		"SolveInside:=", false)

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "0.000000meter", _
"YStart:=", "-0.015494meter", _
"ZStart:=", "-0.069850meter", _
"Width:=", "0.030988meter", _
"Height:=", "0.025400meter", _
"WhichAxis:=", "X"), _
Array("NAME:Attributes", _
"Name:=", "GapSource", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-001, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignLumpedPort _
Array("NAME:Port", _
      Array("NAME:Modes", _
             Array("NAME:Mode1", _
                   "ModeNum:=", 1, _
                   "UseIntLine:=", true, _
                   Array("NAME:IntLine", _
                          "Start:=", Array("0.000000meter", "-0.015494meter", "-0.057150meter"), _
                          "End:=",   Array("0.000000meter", "0.015494meter", "-0.057150meter") _
                         ), _
                   "CharImp:=", "Zpi" _
                   ) _
            ), _
      "Resistance:=", "200.000000Ohm", _
      "Reactance:=", "0.000000Ohm", _
      "Objects:=", Array("GapSource") _
      )

oEditor.Move _
Array("NAME:Selections", _
"Selections:=", "FoldedDipole,GapSource"), _
Array("NAME:TranslateParameters", _
"TranslateVectorX:=", "-2.550000meter", _
"TranslateVectorY:=", "0.000000meter", _
"TranslateVectorZ:=", "0.000000meter")

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "FoldedDipole,GapSource"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "1.700000meter", _
"YComponent:=", "0.000000meter", _
"ZComponent:=", "0.000000meter", _
"NumClones:=", 4), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

oEditor.CreateBox _
Array("NAME:BoxParameters", _
"XPosition:=", "-3.050000meter", _
"YPosition:=", "-0.915925meter", _
"ZPosition:=", "0.442850meter", _
"XSize:=", "6.100000meter", _
"YSize:=", "1.831850meter", _
"ZSize:=", "-1.000000meter"), _
Array("NAME:Attributes", _
"Name:=", "AirBox", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0.75, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignRadiation _
Array("NAME:ABC", _
"Objects:=", Array("AirBox"), _
"UseAdaptiveIE:=", false)

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-3.050000meter", _
"YStart:=", "-0.915925meter", _
"ZStart:=", "0.442850meter", _
"Width:=", "6.100000meter", _
"Height:=", "1.831850meter", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "GroundPlane", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-001, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)
