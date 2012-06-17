set JAVA_HOME=C:\Apps\java\jdk1.6.0_27
set ANT_HOME=C:\Apps\Tools\apache-ant-1.8.2
set M2_HOME=C:\Apps\Tools\apache-maven-2.2.1
set classpath=%JAVA_HOME%/bin;%M2_HOME%/bin;%ANT_HOME%/bin;%classpath%
set path=%JAVA_HOME%/bin;%M2_HOME%/bin;%ORACLE_HOME%/bin;%ANT_HOME%/bin;%path%

cd workspace/test
call ant init
cd build
call helloworld.love
cmd
pause