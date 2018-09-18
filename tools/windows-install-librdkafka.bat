rem Download and install librdkafka.redist from NuGet.
rem
rem For each available Python version copy headers and libs.

echo on
set librdkafka_version=%1
set outdir=%2

nuget install librdkafka.redist -version %librdkafka_version% -OutputDirectory %outdir%


rem Download required (but missing) system includes
curl -s https://raw.githubusercontent.com/chemeris/msinttypes/master/inttypes.h -o inttypes.h
curl -s https://raw.githubusercontent.com/chemeris/msinttypes/master/stdint.h -o stdint.h

setlocal enabledelayedexpansion
for %%V in (27, 36, 37) do (
    pypath=c:\Python%%~V
    echo pypath: !pypath!
    copy /I /F /S inttypes.h stdint.h !pypath!\include\*
    echo A|xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\build\native\include\* !pypath!\include

    rem Copy x86 libs and dlls
    xcopy /F dest\librdkafka.redist.%librdkafka_version%\build\native\lib\win\x86\win-x86-Release\v120\librdkafka.lib !pypath!\libs\*
    xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x86\native\* !pypath!\libs

    rem Copy x64 libs and dlls
    xcopy /F dest\librdkafka.redist.%librdkafka_version%\build\native\lib\win\x64\win-x64-Release\v120\librdkafka.lib !pypath!-x64\libs\*
    xcopy /I /F /S dest\librdkafka.redist.%librdkafka_version%\runtimes\win-x64\native\* !pypath!-x64\libs
)

