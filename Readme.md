#  A template GBDK2020 project

(For windows) compile.bat makes compilation of GBDK2020 projects much easier, as it automaically scans for .c files and compiles them to asm files.
It also only compiles the .c files if changes are made, therefore not recompiling those huge maps every single time!
  
## Setup
The only input needed from you is to open the compile.bat file and change the variables
- lccDir : The directory to lcc.exe in GBDK2020
- exportName : The name of the exported rom; [name].gb
##
You'll also need to setup the c/c++ properties to direct to the GBDK2020 include folder!

### For a complete recompile of everything (a cleanup), delete the directory `/out/asm/` and delete `src_hashes.txt`