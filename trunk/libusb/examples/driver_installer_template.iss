; This examples demonstrates how libusb's drivers
; can be installed automatically using an installer.
;
; Requirements: Inno Setup (http://www.jrsoftware.org/isdl.php)
;
; To test this script do the following
; - copy libusb's driver (libusb0.sys, libusb0.dll) to this folder
; - copy your .inf file to this folder and replace <your_inf_file.inf>
;   with the name of your .inf file in this script
; - open this scipt with Inno Setup
; - compile and run

[Setup]
AppName=TestDrivers
AppVerName=TestDrivers 1.1.3
AppPublisher=TestDrivers
AppPublisherURL=http://test.url.com/
AppVersion=1.2.3
DefaultDirName={pf}\TestApp
DefaultGroupName=TestDrivers
Compression=lzma
SolidCompression=yes
; Win2k and higher
MinVersion=5,5
PrivilegesRequired=admin

[Files]
; copy the file to the App folder
Source: "*.sys"; DestDir: "{app}\driver"
Source: "*.dll"; DestDir: "{app}\driver"
Source: "<your_inf_file.inf>"; DestDir: "{app}\driver"

; also copy the DLL to the system folders so that rundll32.exe will find it
Source: "*.dll"; DestDir: "{sys}"; FLags: replacesameversion restartreplace

[Icons]
Name: "{group}\Uninstall TestDrivers"; Filename: "{uninstallexe}"

[Run]
; invoke libusb's DLL to install the .inf file
Filename: "rundll32"; Parameters: "libusb0.dll,usb_install_driver_rundll {app}\driver\<your_inf_file.inf>"; StatusMsg: "Installing driver (this may take a few seconds) ..."
