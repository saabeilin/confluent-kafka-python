rem Copy librdkafka headers and libs to Python paths for later use when building the module

set librdkafka_version=%1
set pypath=%2

copy /I /F /S inttypes.h stdint.h %pypath%\include\*
echo A|xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\build\native\include\* %pypath%\include

rem Copy x86 libs and dlls
xcopy /F dest\librdkafka.redist.%librdkafka_version%\build\native\lib\win\x86\win-x86-Release\v120\librdkafka.lib %pypath%\libs\*
xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x86\native\* %pypath%\libs

rem Copy x64 libs and dlls
xcopy /F dest\librdkafka.redist.%librdkafka_version%\build\native\lib\win\x64\win-x64-Release\v120\librdkafka.lib %pypath%-x64\libs\*
xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x64\native\* %pypath%-x64\libs

