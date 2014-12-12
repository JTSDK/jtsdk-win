; Main App Information
#define MyAppName "WSJT-Suite"
#define MyAppVersion "1.0.9"
#define MyAppPublisher "Greg Beam, KI7MT"
#define MyAppURL "http://physics.princeton.edu/pulsar/k1jt/"
#define WsjtSF "http://sourceforge.net/projects/wsjt/"

; Resource Links
#define WsjtGroup "https://groups.yahoo.com/neo/groups/wsjtgroup/info"
#define WsjtxGroup "https://groups.yahoo.com/neo/groups/WSJTX/info"
#define WsjtURL "http://physics.princeton.edu/pulsar/k1jt/wsjt.html"
#define WsjtxURL "http://physics.princeton.edu/pulsar/k1jt/wsjtx.html"
#define WsprURL "http://physics.princeton.edu/pulsar/k1jt/wspr.html"
#define Map65URL "http://physics.princeton.edu/pulsar/k1jt/map65.html"
#define WsjtDevURL "http://physics.princeton.edu/pulsar/k1jt/devel.html"
#define TechRefURL "http://physics.princeton.edu/pulsar/k1jt/refs.html"

[Setup]
AppId={#MyAppName}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\WSJT-Suite
DisableDirPage=yes
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=D:\JTSDK-Build-Suite\common-licenses\KVASD_EULA.txt
OutputDir=D:\JTSDK-Build-Suite
OutputBaseFilename={#MyAppName}-{#MyAppVersion}-Win32
SetupIconFile=D:\JTSDK-Build-Suite\icons\wsjt.ico
LZMANumBlockThreads=2
LZMAUseSeparateProcess=yes
; Compression=lzma2/fast        <-- Use this for quick dev builds
Compression=lzma/max
SolidCompression=yes
SourceDir=D:\JTSDK-Build-Suite
WizardImageBackColor=clBlue
DisableReadyPage=yes
InfoBeforeFile=build-info.txt
InfoAfterFile=README.txt
VersionInfoVersion={#MyAppVersion}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "D:\JTSDK-Build-Suite\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\JTSDK\wsjt\install\*"; DestDir: "{app}\WSJT"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\JTSDK\wsjtx\install\Release\*"; DestDir: "{app}\WSJTX"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\JTSDK\wsjtx-1.4\install\Release\*"; DestDir: "{app}\WSJTX-RC"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\JTSDK\wspr\install\*"; DestDir: "{app}\WSPR"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\JTSDK\wsprx\install\Release\*"; DestDir: "{app}\WSPRX"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\JTSDK\map65\install\Release\*"; DestDir: "{app}\MAP65"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\JTSDK\resources\wsjtx-util.bat"; DestDir: "{app}\WSJTX\bin"; Flags: ignoreversion

[Icons]
Name: "{group}\Resources\WSJT Homepage"; Filename: "{#MyAppURL}"
Name: "{group}\Resources\WSJT Discussion Group"; Filename: "{#WsjtGroup}"
Name: "{group}\Resources\WSJT Web Page"; Filename: "{#WsjtURL}"
Name: "{group}\Resources\WSJT-X Discussion Group"; Filename: "{#WsjtxGroup}"
Name: "{group}\Resources\WSJT-X Web Page"; Filename: "{#WsjtxURL}"
Name: "{group}\Resources\WSPR Web Page"; Filename: "{#WsprURL}"
Name: "{group}\Resources\WSPR-X Web Page"; Filename: "{#WsprURL}"
Name: "{group}\Resources\MAP65 Web Page"; Filename: "{#Map65URL}"
Name: "{group}\Resources\Development"; Filename: "{#WsjtDevURL}"
Name: "{group}\Technical References\K1JT Technical Papers"; Filename: "{#TechRefURL}"
Name: "{group}\Tools\FMT Tool"; Filename: "{app}\WSPR\fmt-env.bat"; WorkingDir: {app}\WSPR; IconFileName: "{app}\icons\wsjt.ico"
Name: "{group}\Tools\WSPR Code"; Filename: "{app}\WSPR\fmt-env.bat"; WorkingDir: {app}\WSPR; IconFileName: "{app}\icons\wsjt.ico"
Name: "{group}\Tools\WSJTX Utils"; Filename: "{app}\WSJTX\bin\wsjtx-util.bat"; WorkingDir: {app}\WSJTX\bin; IconFileName: "{app}\icons\wsjt.ico"
Name: "{group}\Tools\MAP65 Wisdom-1"; Filename: "{app}\MAP65\bin\wisdom1.bat"; WorkingDir: {app}\MAP65\bin; IconFileName: "{app}\icons\wsjt.ico"
Name: "{group}\Tools\MAP65 Wisdom-2"; Filename: "{app}\MAP65\bin\wisdom2.bat"; WorkingDir: {app}\MAP65\bin; IconFileName: "{app}\icons\wsjt.ico"
Name: "{group}\Uninstall\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; Comment: "Uninstall WSJT-Suite";
Name: "{group}\WSJT  v10.0"; Filename: "{app}\WSJT\wsjt.bat"; WorkingDir: {app}\WSJT; IconFileName: "{app}\icons\wsjt.ico"
Name: "{group}\WSPR  v4.0"; Filename: "{app}\WSPR\wspr.bat"; WorkingDir: {app}\WSPR; IconFileName: "{app}\icons\wsjt.ico"
Name: "{group}\WSJTX v1.4-RC"; Filename: "{app}\WSJTX-RC\bin\wsjtx.exe"; WorkingDir: {app}\WSJTX-RC\bin; IconFileName: "{app}\icons\wsjtx.ico"
Name: "{group}\WSJTX v1.5"; Filename: "{app}\WSJTX\bin\wsjtx.exe"; WorkingDir: {app}\WSJTX\bin; IconFileName: "{app}\icons\wsjtx.ico"
Name: "{group}\WSPRX v0.9"; Filename: "{app}\WSPRX\bin\wsprx.exe"; WorkingDir: {app}\WSPRX\bin; IconFileName: "{app}\icons\wsjt.ico"
Name: "{group}\MAP65 v2.5"; Filename: "{app}\MAP65\bin\map65.exe"; WorkingDir: {app}\MAP65\bin; IconFileName: "{app}\icons\wsjt.ico"

[Run]
Filename: "{app}\MAP65\bin\wisdom1.bat"; Description: "MAP65 Optimize plans for FFTs (takes a few minutes)"; Flags: postinstall
Filename: "{app}\MAP65\bin\wisdom2.bat"; Description: "MAP65 Patiently optimize plans for FFTs (up to one hour)"; Flags: postinstall unchecked

; This code is complements from TLama on Stackoverflow:
; Post: http://stackoverflow.com/questions/20092779/how-to-show-percent-done-elapsed-time-and-estimated-time-progress
[Code]
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
    Format('Done: %.2f %%', [(CurProgress * 100.0) / MaxProgress]);
  ElapsedLabel.Caption := 
    Format('Elapsed: %s', [TicksToStr(CurTick - StartTick)]);
  if CurProgress > 0 then
  begin
    RemainingLabel.Caption :=
      Format('Remaining: %s', [TicksToStr(
        ((CurTick - StartTick) / CurProgress) * (MaxProgress - CurProgress))]);
  end;
end;
