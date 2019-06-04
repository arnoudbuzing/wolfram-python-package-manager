BeginPackage["PythonPackageManager`"]

PythonVersion::usage = "Gives the version of Python (python --version)"
PythonPackageVersion::usage = "Gives the version of pip (pip --version)"
PythonPackageInformation::usage = "PythonPackageInformation[name] gives the package information for 'name' (pip show name)"
PythonPackageList::usage = "PythonPackageList[] lists all known packages (pip list)"
PythonPackageInstalledQ::usage = "PythonPackageInstalledQ[name] gives True if 'name' is installed, False otherwise"
PythonPackageInstall::usage = "PythonPackageInstall[name] installs 'name' (pip install name)"
PythonPackageUninstall::usage = "PythonPackageUninstall[name] uninstalls 'name' (pip uninstall name)"

Begin["`Private`"]

$tag = "7c704567-e2f5-49a4-ba2e-cba67952b169";

runProcess[args__] := Module[{res = RunProcess[args]},
	If[StringQ[res], res, Throw[$Failed,$tag]]
]

PythonVersion[] := Catch[StringTrim[runProcess[{"python", "-V"}, "StandardOutput"]],$tag]
PythonPackageVersion[] := Catch[StringTrim[runProcess[{"pip", "-V"}, "StandardOutput"]],$tag]

PythonPackageInformation[name_String] := Catch[Module[{lines, rules},
  lines = ImportString[runProcess[{"pip", "show", name}, "StandardOutput"], "Lines"];
  rules = Map[Rule @@ StringSplit[#, ": ", 2] &, lines];
  Association @@ rules
], $tag]

PythonPackageList[]:= Catch[Module[{lines,rules},
  lines=ImportString[runProcess[{"pip","list"},"StandardOutput"],"Lines"];
  rules=Map[Rule@@(StringTrim/@StringSplit[#,WhitespaceCharacter..,2])&,Part[lines,3;;-1]];
  Association@@rules
],$tag]

PythonPackageInstalledQ[name_String] := Function[{res}, res =!= $Failed && res =!= ""] @
	Catch[runProcess[{"pip", "show", name}, "StandardOutput"],$tag]

PythonPackageInstall::alreadyinstalled="The Python package \"``\" is already installed on this machine.";
PythonPackageInstall[name_String]:= Catch[Module[{},
  If[
    PythonPackageInstalledQ[name],
    Message[PythonPackageInstall::alreadyinstalled,name],
    runProcess[{"pip","--quiet","install",name},"StandardOutput"];
    If[
      PythonPackageInstalledQ[name],
        Success["InstallationComplete",<|"MessageTemplate":>"The installation of \"`name`\" is complete.","MessageParameters"-><|"name"->name|>|>],
        Failure["InstallationFailed",<|"MessageTemplate":>"The installation of \"`name`\" failed.","MessageParameters"-><|"name"->name|>|>]
    ]
  ]
],$tag]

PythonPackageUninstall[name_String, OptionsPattern[]] := Catch[Module[{},
  If[
    PythonPackageInstalledQ[name],
    runProcess[{"pip", "--quiet", "uninstall", "--yes", name}, "StandardOutput"];
    If[
      PythonPackageInstalledQ[name],
      Failure["UninstallationFailed", <|"MessageTemplate" :> "The uninstallation of \"`name`\" failed.","MessageParameters" -> <|"name" -> name|>|>],
      Success["UninstallationComplete", <|"MessageTemplate" :> "The uninstallation of \"`name`\" is complete.", "MessageParameters" -> <|"name" -> name|>|>]
    ]
    ,
    Message[PythonPackageUninstall::notfound, name]
  ]
],$tag]


End[]

EndPackage[]
