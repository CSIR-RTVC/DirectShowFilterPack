@echo off

IF EXIST "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\" (
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\vsmsbuildcmd.bat"
goto BUILD_INSTALLER
) ELSE (
  echo Could not locate VS vars bat file
)

:BUILD_INSTALLER

echo "Building DirectShowFilterPack"
cd DirectShowFilterPack
"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv" /Build "Release" DirectShowFilterPack.sln
set BUILD_STATUS=%ERRORLEVEL% 
if not %BUILD_STATUS%==0 goto FAILED 
cd ..

echo "Installer built - copying installers to setup dir"
@rem read version number from version file
set /p Build=<version

copy DirectShowFilterPack\DirectShowFilterPack\Release\DirectShowFilterPack.msi .\Setup_DirectShowFilterPack_%Build%.msi

@rem exit 0
