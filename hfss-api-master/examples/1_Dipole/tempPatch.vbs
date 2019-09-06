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

oProject.InsertDesign "HFSS", "NxN_uStrip_Patch", "DrivenModal", ""
Set oDesign = oProject.SetActiveDesign("NxN_uStrip_Patch")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-0.012000meter", _
"YStart:=", "-0.012000meter", _
"ZStart:=", "0.000000meter", _
"Width:=", "0.024000meter", _
"Height:=", "0.024000meter", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "Patch", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-001, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "-0.012000meter", _
"YStart:=", "-0.002540meter", _
"ZStart:=", "0.000000meter", _
"Width:=", "-0.004000meter", _
"Height:=", "0.005080meter", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "Feed", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 7.500000e-001, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.Unite  _
Array("NAME:Selections", _
"Selections:=", "Patch,Feed"), _
Array("NAME:UniteParameters", "KeepOriginals:=", false)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignPerfectE _
Array("NAME:PatchMetal", _
