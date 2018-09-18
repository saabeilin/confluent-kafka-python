echo on

rem For dumpbin
set PATH=%PATH%;c:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin
set

rem Download and install librdkafka from NuGet.
call tools\windows-install-librdkafka.bat %LIBRDKAFKA_NUGET_VERSION% dest

pip install cibuildwheel

rem Build wheels (without tests)
cibuildwheel --output-dir wheelhouse

dir wheelhouse

rem cibuildwheel installs the generated packages, but they're not ready yet,
rem so remove them.
rem FIXME: this only covers python27 (default)
pip uninstall -y confluent_kafka


rem Copy the librdkafka DLLs to a path structure that is identical to cimpl.pyd's location
md stage\x86\confluent_kafka
copy dest\librdkafka.redist.%LIBRDKAFKA_VERSION%\runtimes\win-x86\native\*.dll stage\x86\confluent_kafka\

md stage\x64\confluent_kafka
copy dest\librdkafka.redist.%LIBRDKAFKA_VERSION%\runtimes\win-x64\native\*.dll stage\x64\confluent_kafka\

rem For each wheel, add the corresponding x86 or x64 dlls to the wheel zip file
cd stage\x86
for %%W in (..\..\wheelhouse\*win32.whl) do (
    7z a -r %%~W confluent_kafka\*.dll
    unzip -l %%~W
)

cd ..\x64
for %%W in (..\..\wheelhouse\*amd64.whl) do (
    7z a -r %%~W confluent_kafka\*.dll
    unzip -l %%~W
)

cd ..\..


pip install wheelhouse/confluent_kafka-*cp27*win32.whl

python -c "from confluent_kafka import libversion ; print libversion()"

pytest --import-mode=append
pip uninstall confluent_kafka

