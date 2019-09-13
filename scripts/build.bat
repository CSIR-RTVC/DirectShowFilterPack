git submodule update --init

if not exist ..\build mkdir ..\build
if not exist ..\build\Release mkdir ..\build\Release
if not exist ..\build\Debug mkdir ..\build\Debug


cd ..\baseclasses\scripts
call build.bat

cd ..\..\DirectShowExt\scripts
call build.bat

cd ..\..\vpp\scripts
call build.bat

cd ..\..\H264v2\scripts
call build.bat
copy ..\build\Release\*.dll ..\..\build\Release\
copy ..\build\Debug\*.dll ..\..\build\Debug\

cd ..\..\H264EncoderFilter\scripts
call build.bat
copy ..\build\Release\*.dll ..\..\build\Release\
copy ..\build\Debug\*.dll ..\..\build\Debug\

::cd ..\..\Opus\
::mkdir build
::cd build
::cmake ..
::if %ERRORLEVEL% EQU 0 (
::  @rem ECHO "Building Release version"
::  cmake --build . --config Release 
::  @rem ECHO "Building Debug version"
::  cmake --build . --config Debug 
::  @rem copy CMakeFiles\Export\lib\cmake\Opus\OpusTargets.cmake .
::) else (
::  @rem ECHO "Error generating build files"
::)

::cd ..\..\OpusCodec\scripts
::call build.bat


::cd ..\..\OpusEncoderFilter\scripts
::call build.bat

