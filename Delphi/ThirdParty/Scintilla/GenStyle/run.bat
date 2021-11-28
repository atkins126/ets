set path=E:\Tool\bin

cd /d "%~dp0"

.\Release\GenStyle.exe "%~1" 1>Style.json

sed -i "s/$(style.\([^.]\+\).\([0-9]\+\))/$(lexers.\1.style.\2)/" Style.json

pause
