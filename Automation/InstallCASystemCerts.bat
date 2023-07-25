REM This simple script supports installing both Burp Certificate and MITMProxy Certificate
REM in as System CA certs. It assumes you have already generated hash and copied certificates
REM for both Burp and MITMProxy. You need to modify the paths & your AVD. If you aren't using an
REM emulator, hash out the avd section.

@echo off

echo Starting Android emulator...
emulator -avd your_avd_name -writable-system
timeout 60

echo Waiting for emulator to fully start...
adb wait-for-device

echo Rooting device...
adb root
adb wait-for-device

echo Remounting system partition...
adb remount
adb wait-for-device

echo Pushing Burp Certificate to /system/etc/security/cacerts...
adb push "path\to\your\burp_certificate_file\9a5ba575.0" /system/etc/security/cacerts
adb wait-for-device

echo Pushing MITMProxy Certificate to /system/etc/security/cacerts...
adb push "path\to\your\mitmproxy_certificate_file\c8750f0d.0" /system/etc/security/cacerts
adb wait-for-device

echo Setting permissions...
adb shell chmod 664 /system/etc/security/cacerts/9a5ba575.0
adb shell chmod 664 /system/etc/security/cacerts/c8750f0d.0
adb wait-for-device

REM If you're not using an emulator, you can comment out the following line.
echo Rebooting device...
adb reboot
