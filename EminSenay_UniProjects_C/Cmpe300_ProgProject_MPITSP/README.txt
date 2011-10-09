MPICH2 must be installed into your system in order to build and execute the project.
After installing, try executing one of the examples delivered with the package. 

You may encounter these problems (I did):

C:\Users\Emin\Documents\Visual Studio 2010\Projects\EminSenay_UniProjects_C\Debug>mpiexec -n 4 Cmpe300_ProgProject_MPITSP.exe 4
launch failed: CreateProcess(Cmpe300_ProgProject_MPITSP.exe 4) on '...' failed, error 2 - The system cannot find the file specified.

To solve this, you must copy the executable under a non-mapped directory (such as C:\mpitemp). 
Check http://thitiv.blogspot.com/2005/12/mpich2-on-windows-xp-launch-failed.html for more information.

smpd related problems:
Try installing smpd as a service with the smpd password (from setup) in an administrator command line:

c:\mpitemp>smpd -install -phrase behappy