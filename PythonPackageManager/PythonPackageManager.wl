BeginPackage["PythonPackageManager`"]

PythonVersion::usage = "Gives the version of Python (python --version)"
PythonPackageVersion::usage = "Gives the version of pip (pip --version)"
PythonPackageInformation::usage = "PythonPackageInformation[name] gives the package information for 'name' (pip show name)"
PythonPackageList::usage = "PythonPackageList[] lists all known packages (pip list)"
PythonPackageInstalledQ::usage = "PythonPackageInstalledQ[name] gives True if 'name' is installed, False otherwise"
PythonPackageInstall::usage = "PythonPackageInstall[name] installs 'name' (pip install name)"
PythonPackageUninstall::usage = "PythonPackageUninstall[name] uninstalls 'name' (pip uninstall name)"

Begin["`Private`"]

PythonVersion[] := StringTrim[RunProcess[{"python", "-V"}, "StandardOutput"]]
PythonPackageVersion[] := StringTrim[RunProcess[{"pip", "-V"}, "StandardOutput"]]

PythonPackageInformation[name_String] := Module[{lines, rules},
  lines = ImportString[RunProcess[{"pip", "show", name}, "StandardOutput"], "Lines"];
  rules = Map[Rule @@ StringSplit[#, ": ", 2] &, lines];
  Association @@ rules
]

PythonPackageList[]:=Module[{lines,rules},
  lines=ImportString[RunProcess[{"pip","list"},"StandardOutput"],"Lines"];
  rules=Map[Rule@@(StringTrim/@StringSplit[#,WhitespaceCharacter..,2])&,Part[lines,3;;-1]];
  Association@@rules
]

PythonPackageInstalledQ[name_String] := TrueQ[RunProcess[{"pip", "show", name}, "StandardOutput"] =!= ""]

PythonPackageInstall::alreadyinstalled="The Python package \"``\" is already installed on this machine.";
PythonPackageInstall[name_String]:=Module[{},
  If[
    PythonPackageInstalledQ[name],
    Message[PythonPackageInstall::alreadyinstalled,name],
    RunProcess[{"pip","--quiet","install",name},"StandardOutput"];
    If[
      PythonPackageInstalledQ[name],
        Success["InstallationComplete",<|"MessageTemplate":>"The installation of \"`name`\" is complete.","MessageParameters"-><|"name"->name|>|>],
        Failure["InstallationFailed",<|"MessageTemplate":>"The installation of \"`name`\" failed.","MessageParameters"-><|"name"->name|>|>]
    ]
  ]
]

PythonPackageUninstall[name_String, OptionsPattern[]] := Module[{},
  If[
    PythonPackageInstalledQ[name],
    RunProcess[{"pip", "--quiet", "uninstall", "--yes", name}, "StandardOutput"];
    If[
      PythonPackageInstalledQ[name],
      Failure["UninstallationFailed", <|"MessageTemplate" :> "The uninstallation of \"`name`\" failed.","MessageParameters" -> <|"name" -> name|>|>],
      Success["UninstallationComplete", <|"MessageTemplate" :> "The uninstallation of \"`name`\" is complete.", "MessageParameters" -> <|"name" -> name|>|>]
    ]
    ,
    Message[PythonPackageUninstall::notfound, name]
  ]
]


End[]

EndPackage[]
