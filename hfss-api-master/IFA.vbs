Dim oHfssApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule
Set oHfssApp = CreateObject("AnsoftHfss.HfssScriptInterface")
Set oDesktop = oHfssApp.GetAppDesktop()
oDesktop.NewProject
Set oProject = oDesktop.GetActiveProject()
oProject.InsertDesign "HFSS", "dessin", "DrivenModal", ""
Set oDesign = oProject.SetActiveDesign("dessin")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")

oEditor.CreatePolyline _
Array("NAME:PolylineParameters", _
"IsPolylineCovered:=", true, _
"IsPolylineClosed:=", true, _
Array("NAME:PolylinePoints", _
Array("NAME:PLPoint", "X:=","0.000000mm", "Y:=","8.700000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","0.287500mm", "Y:=","8.700000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","1.087500mm", "Y:=","8.700000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","1.087500mm", "Y:=","-7.900000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","1.375000mm", "Y:=","-7.900000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","1.375000mm", "Y:=","8.700000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","3.262500mm", "Y:=","8.700000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","3.262500mm", "Y:=","-7.900000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","3.550000mm", "Y:=","-7.900000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","3.550000mm", "Y:=","8.700000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","4.350000mm", "Y:=","8.700000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","4.350000mm", "Y:=","7.900000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","4.350000mm", "Y:=","-8.700000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","2.462500mm", "Y:=","-8.700000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","2.462500mm", "Y:=","7.900000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","2.175000mm", "Y:=","7.900000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","2.175000mm", "Y:=","-8.700000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","0.287500mm", "Y:=","-8.700000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","0.287500mm", "Y:=","7.900000mm", "Z:=","0.000000mm"), _
Array("NAME:PLPoint", "X:=","0.000000mm", "Y:=","7.900000mm", "Z:=","0.000000mm")), _
Array("NAME:PolylineSegments", _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",0,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",1,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",2,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",3,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",4,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",5,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",6,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",7,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",8,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",9,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",10,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",11,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",12,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",13,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",14,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",15,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",16,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",17,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",18,"NoOfPoints:=",2), _
Array("NAME:PLSegment", "SegmentType:=","Line","StartIndex:=",19,"NoOfPoints:=",2))), _
Array("NAME:Attributes", _
"Name:=","polyline20", _
"Flags:=","", _
"Color:=","(125 125 195)", _
"Transparency:=",0, _
"PartCoordinateSystem:=","Global", _
"MaterialName:=","vacuum", _
"SolveInside:=",true)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignPerfectE Array("NAME:PerfE1", "Objects:=", Array("polyline20"  _
 ), "InfGroundPlane:=", false)
oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _
  "-0.000000mm", "YStart:=", "8.700000e+00mm", "ZStart:=", "0mm", "Width:=", "-13.050000mm", "Height:=",  _
  "-17.400000mm", "WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "Ground", "Flags:=",  _
  "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignPerfectE Array("NAME:PerfE2", "Objects:=", Array("Ground"  _
 ), "InfGroundPlane:=", false)
oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _
  "0.100000mm", "YStart:=", "3.700000e+00mm", "ZStart:=", "0mm", "Width:=", "0.187500mm", "Height:=",  _
  "-0.800000mm", "WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "Short", "Flags:=",  _
  "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignPerfectE Array("NAME:PerfE3", "Objects:=", Array("Short"  _
 ), "InfGroundPlane:=", false)
oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _
  "-0.000000mm", "YStart:=", "3.700000e+00mm", "ZStart:=", "0mm", "Width:=", "0.100000mm", "Height:=",  _
  "-0.800000mm", "WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "Feed", "Flags:=",  _
  "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
oModule.AssignLumpedPort Array("NAME:1", "Objects:=", Array("Feed"), "RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true, Array("NAME:IntLine", "Start:=", Array("0mm", "3.700000mm", "0mm"), "End:=", Array( _
  "0.050000mm", "3.700000mm", "0mm")), "CharImp:=", "Zpi", "AlignmentGroup:=", 0)), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true), "FullResistance:=", "50ohm", "FullReactance:=",  _
  "0ohm")
oEditor.CreateBox Array("NAME:BoxParameters", "XPosition:=", "-5.625276e+01mm", "YPosition:=",  _
  "-5.190276e+01mm", "ZPosition:=", "-2.160138e+01mm", "XSize:=", "1.038055e+02mm", "YSize:=", "1.038055e+02mm", "ZSize:=",  _
  "4.320276e+01mm"), Array("NAME:Attributes", "Name:=", "Box_NF", "Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0.9, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
oEditor.CreateBox Array("NAME:BoxParameters", "XPosition:=", "-9.945553e+01mm", "YPosition:=",  _
  "-9.510553e+01mm", "ZPosition:=", "-8.640553e+01mm", "XSize:=", "1.902111e+02mm", "YSize:=", "1.902111e+02mm", "ZSize:=",  _
  "1.728111e+02mm"), Array("NAME:Attributes", "Name:=", "Rad_Box", "Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0.9, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignRadiation Array("NAME:Rad1", "Objects:=", Array("Rad_Box"), "IsIncidentField:=",  _
  false, "IsEnforcedField:=", false, "IsFssReference:=", false, "IsForPML:=",  _
  false, "UseAdaptiveIE:=", false, "IncludeInPostproc:=", true)
