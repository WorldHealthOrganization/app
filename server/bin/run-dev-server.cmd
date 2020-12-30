@REM Build app and run dev-appserver on Windows.
setlocal
cd /d %~dp0..

call ./gradlew.bat build || exit /b

echo on
java_dev_appserver --address=0.0.0.0  ^
 --jvm_flag=-Duser.timezone=America/Los_Angeles ^
 --jvm_flag=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 ^
 appengine/build/war/
