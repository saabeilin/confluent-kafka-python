set PATH=%PATH%;c:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin
set
dumpbin /?
call tools\windows-install-librdkafka.bat %LIBRDKAFKA_NUGET_VERSION% 27
pip install cibuildwheel
cibuildwheel --output-dir wheelhouse
dir wheelhouse
dir c:\python27
dir c:\python27\scripts
unzip -l wheelhouse\confluent_kafka-0.11.5-cp27-cp27m-win32.whl
unzip wheelhouse\confluent_kafka-0.11.5-cp27-cp27m-win32.whl confluent_kafka/cimpl.pyd
dumpbin /exports confluent_kafka\cimpl.pyd
#md confluent_kafka\.libs
rem copy dest\librdkafka.redist.%LIBRDKAFKA_VERSION%\runtimes\win-x86\native\*.dll confluent_kafka\
rem 7z a -r wheelhouse\confluent_kafka-0.11.5-cp27-cp27m-win32.whl confluent_kafka\*.dll
xcopy /I /F /S dest confluent_kafka
7z a -r wheelhouse\confluent_kafka-0.11.5-cp27-cp27m-win32.whl dest
unzip -l wheelhouse\confluent_kafka-0.11.5-cp27-cp27m-win32.whl

pip install wheelhouse/confluent_kafka-0.11.5-cp27-cp27m-win32.whl
pytest --import-mode=append

