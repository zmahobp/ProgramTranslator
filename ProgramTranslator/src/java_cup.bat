@echo off
REM ********   SETTINGS - TO BE CHANGED BY STUDENT *********
set JCUP_HOME="C:\Users\Stefan\Desktop\VII-Semestar\Programski Prevodioci\Alati\java_cup_v10k"
set JAVA_HOME="C:\Program Files\Java\jre1.8.0_311"
set PARSER_CLASS_NAME="MPParser"
set CUP_SPEC_NAME="MPParser.cup"


REM ********   CALLING JAVA CUP APPLICATION  ***********
echo vrednost : %JCUP_HOME%
%JAVA_HOME%\bin\java -classpath %JCUP_HOME% java_cup.Main -parser %PARSER_CLASS_NAME% -symbols sym < %CUP_SPEC_NAME%

PAUSE
