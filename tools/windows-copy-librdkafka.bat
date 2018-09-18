rem Copy librdkafka headers and libs to Python paths for later use when building the module

set librdkafka_version=%1
set pypath=%2

copy stdint.h %pypath%\include\ || exit /b 1
copy inttypes.h %pypath%\include\ || exit /b 1
copy stdint.h %pypath%-x64\include\ || exit /b 1
copy inttypes.h %pypath%-x64\include\ || exit /b 1

findstr /V inttypes.h dest\librdkafka.redist.%librdkafka_version%\build\native\include\rdkafka.h > %pypath%\include\rdkafka.h
findstr /V inttypes.h dest\librdkafka.redist.%librdkafka_version%\build\native\include\rdkafka.h > %pypath%-x64\include\rdkafka.h

rem echo A|xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\build\native\include\* %pypath%\include || exit /b 1
rem echo A|xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\build\native\include\* %pypath%-x64\include || exit /b 1

rem Copy x86 libs and dlls
xcopy /F dest\librdkafka.redist.%librdkafka_version%\build\native\lib\win\x86\win-x86-Release\v120\librdkafka.lib %pypath%\libs\* || exit /b 1
xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x86\native\* %pypath%\libs || exit /b 1

rem Copy x64 libs and dlls
xcopy /F dest\librdkafka.redist.%librdkafka_version%\build\native\lib\win\x64\win-x64-Release\v120\librdkafka.lib %pypath%-x64\libs\* || exit /b 1
xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x64\native\* %pypath%-x64\libs || exit /b 1


