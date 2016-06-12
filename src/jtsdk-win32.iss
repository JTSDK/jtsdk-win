; JTSDK v2 INSTALLER BUILD:

; REQUIRMENTS
;  a). You must have InnoSetup and Subversion on your system

; USER CONFIGURABLE VARIABLES
;  SvnPrefix = Location of SVN checkout
;  BuildPrefix = Location of packages from Sourceforge
;  MyAppPublisher = Your Name and Callsign
;  MyAppVersion = Whatever you want to call the build version: 2.0.0-x
#define SvnPrefix "D:\JTSDK-KI7MT"
#define BuildPrefix "D:\JTSDK-Build"
#define MyAppPublisher "Greg Beam, KI7MT"
#define MyAppVersion "2.0.0"

; ******************************************************
;    NO FURTHER EDITS REQUIRED BELOW THIS LINE
; ******************************************************

; DEFINE Variables
#define AppCopyright "Copyright (C) 2014-2015 Joe Taylor, K1JT"
#define MyAppName "JTSDK"
#define MyAppURL "http://physics.princeton.edu/pulsar/K1JT/wsjtx-doc/dev-guide-main.html"
#define WsjtHome "http://physics.princeton.edu/pulsar/k1jt/"
#define WsjtGroup "https://groups.yahoo.com/neo/groups/wsjtgroup/info"
#define WsjtSF "http://sourceforge.net/projects/wsjt/"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{AC8097AE-0F66-45D3-97C0-436AAE4965FC}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppCopyright={#AppCopyright}
AppMutex=myVFPApp

; Minimum Windows Version Settings
MinVersion=6.0.6002
VersionInfoVersion=2.0

; Install and Group Settings
; DO NOT change DefautDirName as it will break the installation!!!
DefaultDirName=C:\JTSDK
DisableDirPage=yes
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes

; License Settings
LicenseFile={#SvnPrefix}\trunk\installers\common-licenses\kvasd_eula.txt
InfoBeforeFile={#SvnPrefix}\trunk\installers\common-licenses\GPL-3
InfoAfterFile=jtsdk_info_after_install.txt

; Build Directory Settings
OutputDir={#BuildPrefix}
OutputBaseFilename={#MyAppName}-{#MyAppVersion}-win32
SetupIconFile={#SvnPrefix}\trunk\installers\icons\wsjt.ico
SourceDir={#SvnPrefix}\trunk\installers

; InnoSetup Compression Settings
; Use lzma/fast for test builds
; Use lzma2/ultra for production builds
Compression=lzma2/ultra
LZMAUseSeparateProcess=yes
LZMANumBlockThreads=4
SolidCompression=yes

; Misc Options
DisableReadyPage=yes
WizardImageBackColor=clBlue
ExtraDiskSpaceRequired=3972844748

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "{#SvnPrefix}\trunk\installers\common-licenses\kvasd_eula.txt"; DestDir: {app}; Flags: ignoreversion
Source: "{#SvnPrefix}\trunk\installers\common-licenses\*"; DestDir: "{app}\common-licenses"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SvnPrefix}\trunk\installers\icons\*"; DestDir: "{app}\icons"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SvnPrefix}\trunk\installers\jtsdk_info_before_install.txt"; DestDir: "{app}"; Flags: ignoreversion dontcopy
Source: "{#SvnPrefix}\trunk\installers\jtsdk_info_after_install.txt"; DestDir: "{app}"; Flags: ignoreversion dontcopy
Source: "{#SvnPrefix}\trunk\installers\docenv.lnk"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SvnPrefix}\trunk\installers\msysenv.lnk"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SvnPrefix}\trunk\installers\postinstall.cmd"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#BuildPrefix}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; The order is an attempt to make Windows do what it should, but does not normally do.
; You can use Reg-Keys or just do it manually. Manually is easier :-)
; Folders first, then links within each folder from A ~ Z

; Docs and Resources
Name: "{group}\Documentation\JTSDK Dev-Guide"; Filename: "{#MyAppURL}"
Name: "{group}\Resources\WSJT Homepage"; Filename: "{#WsjtHome}"
Name: "{group}\Resources\WSJT Discussion"; Filename: "{#WsjtGroup}"
Name: "{group}\Resources\WSJT SourceForge"; Filename: "{#WsjtSF}"

; Tools
Name: "{group}\Tools\QT5\QtCreator"; Filename: "{app}\qt5\Tools\QtCreator\bin\qtcreator.exe"; WorkingDir: {app}; Comment: "Launch QtCreator"; IconFileName: "{app}\icons\qtcreator.ico"
Name: "{group}\Tools\QT5\QtDesigner"; Filename: "{app}\qt5\5.2.1\mingw48_32\bin\designer.exe"; WorkingDir: {app}; Comment: "Launch QtDesigner"; IconFileName: "{app}\icons\designer.ico"
Name: "{group}\Tools\QT5\QtAssistant"; Filename: "{app}\qt5\5.2.1\mingw48_32\bin\assistant.exe"; WorkingDir: {app}; Comment: "Launch QtAssistant"; IconFileName: "{app}\icons\assistant.ico"
Name: "{group}\Tools\Cmake-GUI"; Filename: "{app}\cmake\bin\cmake-gui.exe"; WorkingDir: {app}\src\wsjtx; Comment: "Cmake GUI"; IconFileName: "{app}\icons\cmake.ico"
Name: "{group}\Tools\JTSDK Maintenance"; Filename: "{app}\maint.cmd"; WorkingDir: {app}; Comment: "General Maintenance Environment"; IconFileName: "{app}\icons\wsjt.ico"
Name: "{group}\Tools\InnoSetup"; Filename: "{app}\inno5\Compil32.exe"; WorkingDir: {app}; Comment: "Launch InnoSetup"; IconFileName: "{app}\icons\inno-setup.ico"
Name: "{group}\Tools\NSIS"; Filename: "{app}\nsis\NSIS.exe"; WorkingDir: {app}; Comment: "Launch NSIS"; IconFileName: "{app}\icons\nsis.ico"
Name: "{group}\Tools\RapidEE"; Filename: "{app}\tools\bin\rapidee.exe"; WorkingDir: {app}; Comment: "Windows Environment Editor"; IconFileName: "{app}\icons\rapidee.ico"
Name: "{group}\Tools\SciTE"; Filename: "{app}\tools\bin\Sc351.exe"; WorkingDir: {app}; Comment: "SciTE Test Editor"; IconFileName: "{app}\icons\sc351.ico"
Name: "{group}\Tools\SQLite3"; Filename: "{app}\tools\bin\sqlite3.exe"; WorkingDir: {app}; Comment: "SQLite3 Terminal"; IconFileName: "{app}\icons\sqlite.ico"

; Uninstall Group
Name: "{group}\Uninstall\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; Comment: "Uninstall JTSDK-2.0.0";

; Post Install Run Options
Name: "{group}\JTSDK-DOC"; Filename: "{app}\docenv.lnk"; WorkingDir: {app}; Comment: "Launch JTSDK-DOC"; IconFileName: "{app}\icons\cygwin.ico"
Name: "{group}\JTSDK-MSYS"; Filename: "{app}\msysenv.lnk"; WorkingDir: {app}; Comment: "Launch JTSDK-MSYS"; IconFileName: "{app}\icons\msys.ico"
Name: "{group}\JTSDK-PY"; Filename: "{app}\pyenv.cmd"; WorkingDir: {app}; Comment: "Launch JTSDK-PY"; IconFileName: "{app}\icons\\python.ico"
Name: "{group}\JTSDK-QT"; Filename: "{app}\qtenv.cmd"; WorkingDir: {app}; Comment: "Launch JTSDK-QT"; IconFileName: "{app}\icons\qtcreator.ico"
Name: "{group}\JTSDK Update"; Filename: "{app}\update.cmd"; WorkingDir: {app}; Comment: "Update TSDK"; IconFileName: "{app}\icons\win-install.ico"

; Only Add the 4 main Environment Icons to the Users Desktop
Name: "{userdesktop}\JTSDK-DOC"; Filename: "{app}\docenv.lnk"; WorkingDir: "{app}"; IconFileName: "{app}\icons\cygwin.ico"
Name: "{userdesktop}\JTSDK-MSYS"; Filename: "{app}\msysenv.lnk"; WorkingDir: "{app}"; IconFileName: "{app}\icons\msys.ico"
Name: "{userdesktop}\JTSDK-PY"; Filename: "{app}\pyenv.cmd"; WorkingDir: "{app}"; IconFileName: "{app}\icons\python.ico"
Name: "{userdesktop}\JTSDK-QT"; Filename: "{app}\qtenv.cmd"; WorkingDir: "{app}"; IconFileName: "{app}\icons\qtcreator.ico"

; IMPORTANT postinstall must be run "BEFORE" docenv or msysenv
; This should be moved to [Code] section because, if it fails, 
; the installer will try to finish anyway.

[Run]
Filename: "{app}\postinstall.cmd"
; Filename: "{app}\docenv.lnk";   Description: "JTSDK-DOC Finish User Setup";  Flags: shellexec waituntilterminated
; Filename: "{app}\msysenv.lnk";  Description: "JTSDK-MSYS Finish User Setup"; Flags: shellexec waituntilterminated
Filename: "{app}\docenv.lnk"; Description: "Launch - JTSDK-DOC"; Flags: shellexec postinstall nowait skipifsilent unchecked
Filename: "{app}\msysenv.lnk"; Description: "Launch - JTSDK-MSYS"; Flags: shellexec postinstall nowait skipifsilent unchecked
Filename: "{app}\pyenv.cmd"; Description: "Launch - JTSDK-PY"; Flags: shellexec postinstall nowait skipifsilent unchecked
Filename: "{app}\qtenv.cmd"; Description: "Launch - JTSDK-QT"; Flags: shellexec postinstall nowait skipifsilent unchecked

; These are items that the batch files downloads, installs or otherwise
; adds to the installation outside the confines of the installer itself.
; Note, It does not remove any Applications Builds ( WSJT, WSJT-X etc ),
; everything else goes away. BACKUP what you want before uninstalling !!.

[UninstallDelete]
Type: filesandordirs; Name: "{app}\.svn"
Type: filesandordirs; Name: "{app}\cyg32"
Type: filesandordirs; Name: "{app}\msys"
Type: filesandordirs; Name: "{app}\hamlib3"
Type: filesandordirs; Name: "{app}\Python33"
Type: filesandordirs; Name: "{app}\scripts"
Type: files;          Name: "{app}\*.lnk"
Type: files;          Name: "{app}\*.bat"
Type: files;          Name: "{app}\*.cmd"
Type: files;          Name: "{app}\*.txt"
Type: files;          Name: "{app}\*.log"
Type: files;          Name: "{app}\*.md"
Type: files;          Name: "{app}\AUTHORS"
Type: files;          Name: "{app}\ChangeLog"
Type: files;          Name: "{app}\COPYING"
Type: files;          Name: "{app}\CREDITS"
Type: files;          Name: "{app}\THANKS"

[Messages]
ConfirmUninstall=**WARNING** Backup anything you do not want to loose.%n%nIs it OK uninstall %1?
UninstalledMost=%1 uninstall complete.%n%nUser added files and builds do not get removed. Remove them manually.

[Code]
// This code is complements from TLama on Stackoverflow:
// Post: http://stackoverflow.com/questions/20092779/how-to-show-percent-done-elapsed-time-and-estimated-time-progress
// Install Counter
function GetTickCount: DWORD;
  external 'GetTickCount@kernel32.dll stdcall';

var
  StartTick: DWORD;
  PercentLabel: TNewStaticText;
  ElapsedLabel: TNewStaticText;
  RemainingLabel: TNewStaticText;

function TicksToStr(Value: DWORD): string;
var
  I: DWORD;
  Hours, Minutes, Seconds: Integer;
begin
  I := Value div 1000;
  Seconds := I mod 60;
  I := I div 60;
  Minutes := I mod 60;
  I := I div 60;
  Hours := I mod 24;
  Result := Format('%.2d:%.2d:%.2d', [Hours, Minutes, Seconds]);
end;

procedure InitializeWizard;
begin
  PercentLabel := TNewStaticText.Create(WizardForm);
  PercentLabel.Parent := WizardForm.ProgressGauge.Parent;
  PercentLabel.Left := 0;
  PercentLabel.Top := WizardForm.ProgressGauge.Top +
  WizardForm.ProgressGauge.Height + 12;

  ElapsedLabel := TNewStaticText.Create(WizardForm);
  ElapsedLabel.Parent := WizardForm.ProgressGauge.Parent;
  ElapsedLabel.Left := 0;
  ElapsedLabel.Top := PercentLabel.Top + PercentLabel.Height + 4;

  RemainingLabel := TNewStaticText.Create(WizardForm);
  RemainingLabel.Parent := WizardForm.ProgressGauge.Parent;
  RemainingLabel.Left := 0;
  RemainingLabel.Top := ElapsedLabel.Top + ElapsedLabel.Height + 4;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpInstalling then
    StartTick := GetTickCount;
end;

procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
  if CurPageID = wpInstalling then
  begin
    Cancel := False;
    if ExitSetupMsgBox then
    begin
      Cancel := True;
      Confirm := False;
      PercentLabel.Visible := False;
      ElapsedLabel.Visible := False;
      RemainingLabel.Visible := False;
    end;
  end;
end;

procedure CurInstallProgressChanged(CurProgress, MaxProgress: Integer);
var
  CurTick: DWORD;
begin
  CurTick := GetTickCount;
  PercentLabel.Caption :=
    Format('Done........: %.2f %%', [(CurProgress * 100.0) / MaxProgress]);
  ElapsedLabel.Caption := 
    Format('Elapsed.....: %s', [TicksToStr(CurTick - StartTick)]);
  if CurProgress > 0 then
  begin
    RemainingLabel.Caption :=
      Format('Remaining..: %s', [TicksToStr(
        ((CurTick - StartTick) / CurProgress) * (MaxProgress - CurProgress))]);
  end;
end;
