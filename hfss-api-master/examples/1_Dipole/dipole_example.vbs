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

oProject.InsertDesign "HFSS", "without_balun", "DrivenModal", ""
Set oDesign = oProject.SetActiveDesign("without_balun")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")

oEditor.CreateCylinder _
Array("NAME:CylinderParameters", _
"XCenter:=", "0.025000meter", _
"YCenter:=", "0.000000meter", _
"ZCenter:=", "0.000000meter", _
"Radius:=", "0.020000meter", _
"Height:=", "0.475000meter", _
"WhichAxis:=", "X"), _
Array("NAME:Attributes", _
"Name:=", "Dipole1", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)


oEditor.CreateCylinder _
Array("NAME:CylinderParameters", _
"XCenter:=", "-0.025000meter", _
"YCenter:=", "0.000000meter", _
"ZCenter:=", "0.000000meter", _
"Radius:=", "0.020000meter", _
"Height:=", "-0.475000meter", _
"WhichAxis:=", "X"), _
Array("NAME:Attributes", _
"Name:=", "Dipole2", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

