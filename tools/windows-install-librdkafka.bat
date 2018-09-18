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

for %%V in (27, 36, 37) do (
    pypath=c:\Python%%~V
    call windows-copy-librdkafka.bat %librdkafka_version% %pypath
)

