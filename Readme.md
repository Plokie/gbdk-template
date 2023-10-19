A template GBDK2020 project. 

(Windows) Use compile.bat to easily compile the entire project automatically. Automatically scans for .c files and compiles them to asm/.o files.
Only compiles .c files that have changed, doesn't recompile .c files that haven't changed since the last build

The only input needed from you is to open the compile.bat file and change the variables
- exportName    : The name of the exported rom
- lccDir        : The directory to lcc.exe in GBDK2020


For a complete recompile of everything (a cleanup), delete the directory /out/asm/ and delete src_hashes.txt