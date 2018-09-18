
set librdkafka_version=%1
set python_version=%2

nuget install librdkafka.redist -version %librdkafka_version% -OutputDirectory dest

rem Copy files for x86 and x64 respectively

rem
rem x86
rem

rem where /r c:\ inttypes.h

curl -s https://raw.githubusercontent.com/chemeris/msinttypes/master/inttypes.h -o c:\\python%python_version%\\include\\inttypes.h
curl -s https://raw.githubusercontent.com/chemeris/msinttypes/master/stdint.h -o c:\\python%python_version%\\include\\stdint.h


xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\build\native\include\* C:\python%python_version%\include

xcopy /F dest\librdkafka.redist.%librdkafka_version%\build\native\lib\win\x86\win-x86-Release\v120\librdkafka.lib C:\python%python_version%\libs\librdkafka.lib*
xcopy /F dest\librdkafka.redist.%librdkafka_version%\build\native\lib\win\x86\win-x86-Release\v120\librdkafka.lib C:\python%python_version%\libs\rdkafka.lib*
xcopy /F dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x86\native\librdkafka.dll C:\python%python_version%\libs\rdkafka.dll*
rem xcopy /F dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x86\native\*.dll %CD%
xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x86\native\* C:\python%python_version%\libs


rem
rem x64
rem

copy c:\python%python_version%\include\inttypes.h c:\python%python_version%-x64\include\
copy c:\python%python_version%\include\stdint.h c:\python%python_version%-x64\include\

xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\build\native\include\* C:\python%python_version%-x64\include

xcopy /F dest\librdkafka.redist.%librdkafka_version%\build\native\lib\win\x64\win-x64-Release\v120\librdkafka.lib C:\python%python_version%-x64\libs\librdkafka.lib*
xcopy /F dest\librdkafka.redist.%librdkafka_version%\build\native\lib\win\x64\win-x64-Release\v120\librdkafka.lib C:\python%python_version%-x64\libs\rdkafka.lib*
xcopy /F dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x64\native\librdkafka.dll C:\python%python_version%-x64\libs\rdkafka.dll*
rem xcopy /F dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x64\native\*.dll %CD%
xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x64\native\* C:\python%python_version%-x64\libs
