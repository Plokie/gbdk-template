@echo off
setlocal EnableDelayedExpansion


@REM USER SETUP VARIABLES ------------------

@REM The name of the exported rom .gb
set exportName=game

@REM The path to the lcc.exe of gbdk2020
set lccDir=..\..\gbdk-win\gbdk\bin\lcc.exe

@REM ---------------------------------------


set ff=
set sourcefiles=
set currentPath=%~dp0
for /r %%i in (*) do (
    if %%~xi == .c (
        set ff=%%i
        set ff=!ff:%currentPath%=!
        set sourcefiles=!sourcefiles! !ff!
    )
    if %%~xi == .s (
        set ff=%%i
        set ff=!ff:%currentPath%=!
        set sourcefiles=!sourcefiles! !ff!
    )
)

if not exist %currentPath%%lccDir% (
    echo Could not find lcc.exe at directory %lccDir%
    echo Make sure to edit the compile.bat file and set lccDir to the path of GBDK's lcc executable

    EXIT /B 0
)

if not exist "%currentPath%/out/" mkdir "%currentPath%/out/"
if not exist "%currentPath%/out/asm/" mkdir "%currentPath%/out/asm/"
if not exist "%currentPath%/out/rom/" mkdir "%currentPath%/out/rom/"
if not exist "%currentPath%/src_hashes.txt" echo .>src_hashes.txt

set objs=
set md5=
set newHashes=

(for %%a in (%sourcefiles%) do ( 
    set str=%%a
    for %%F in (!str!) do set file=%%~nxF
    
    set strTrunc=!file:~0,-1!

    set objs=!objs! out/asm/!strTrunc!o

    for /f "skip=1" %%z in ('certutil -hashfile %%a MD5') do (
        if %%z NEQ CertUtil: set md5=%%z
    )

    set newHashes=!newHashes! !md5!
    
    set hasHash=0
    for /f %%h in (src_hashes.txt) do if !md5! == %%h set hasHash=1

    if !hasHash! NEQ 1 (
        %lccDir% -Wa-l -Wl-m -Wl-j -c -o out/asm/!strTrunc!o %%a
        echo Built !strTrunc!c
    )
    if !hasHash! == 1 (
        echo Already built !strTrunc!c
    )

))

echo .>src_hashes.txt
for %%a in (!newHashes!) do (
    echo %%a>>src_hashes.txt
)

%lccDir% -Wl-yt0x1B -Wm-yC -Wa-l -Wl-m -Wl-j -Wm-yoA -Wm-ya4 -autobank -Wb-ext=.rel -Wb-v -o out/rom/%exportName%.gb %objs%