; JTSDK v2 INSTALLER UPDATEW :
#define SvnPrefix "D:\JTSDK-KI7MT"
#define BuildPrefix "D:\JTSDK-Build"
#define MyAppPublisher "Greg Beam, KI7MT"
#define MyAppVersion "2.0.0-u1"

; ******************************************************
;    NO FURTHER EDITS REQUIRED BELOW THIS LINE
; ******************************************************

; DEFINE Variables
#define AppCopyright "Copyright (C) 2014-2015 Joe Taylor, K1JT"
#define MyAppName "JTSDK"

[Setup]
AppId={{AC8097AE-0F66-45D3-97C0-436AAE4965FC}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppCopyright={#AppCopyright}
MinVersion=6.0.6002
VersionInfoVersion=2.0
DefaultDirName=C:\JTSDK
DisableDirPage=yes
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir={#BuildPrefix}
OutputBaseFilename={#MyAppName}-{#MyAppVersion}-win32
LicenseFile={#SvnPrefix}\trunk\installers\common-licenses\GPL-3
SetupIconFile={#SvnPrefix}\trunk\installers\icons\wsjt.ico
SourceDir={#SvnPrefix}\trunk\installers
Compression=lzma2/ultra
LZMAUseSeparateProcess=yes
LZMANumBlockThreads=4
SolidCompression=yes
DisableReadyPage=yes
WizardImageBackColor=clBlue
ExtraDiskSpaceRequired=3972844748

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "{#BuildPrefix}\python27\*"; DestDir: "{app}\python27"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#BuildPrefix}\asciidoc\*"; DestDir: "{app}\asciidoc"; Flags: ignoreversion recursesubdirs createallsubdirs

[Messages]
WelcomeLabel1=Starting [name] Update Wizard
SetupAppTitle=Setup Update
SetupWindowTitle=Setup - %1 Update
FinishedHeadingLabel=Finished [name] Update Wizard

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
