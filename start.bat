:: TITULO CMD
@echo off
for %%I in (.) do set CurrDirName=%%~nxI
title %CurrDirName%
chcp 65001 >nul
color c
cls

:: TELA INICIAL
echo ██████╗░███████╗░██████╗██╗░░░░░██╗░██████╗░░█████╗░██████╗░░█████╗░
echo ██╔══██╗██╔════╝██╔════╝██║░░░░░██║██╔════╝░██╔══██╗██╔══██╗██╔══██╗
echo ██║░░██║█████╗░░╚█████╗░██║░░░░░██║██║░░██╗░███████║██║░░██║██║░░██║
echo ██║░░██║██╔══╝░░░╚═══██╗██║░░░░░██║██║░░╚██╗██╔══██║██║░░██║██║░░██║
echo ██████╔╝███████╗██████╔╝███████╗██║╚██████╔╝██║░░██║██████╔╝╚█████╔╝
echo ╚═════╝░╚══════╝╚═════╝░╚══════╝╚═╝░╚═════╝░╚═╝░░╚═╝╚═════╝░░╚════╝░
echo.
echo Pressione ENTER para ligar o servidor.
pause >nul

:: SEGUNDA TELA
cls
color 6
echo ░█████╗░░█████╗░██████╗░██████╗░███████╗░██████╗░░█████╗░███╗░░██╗██████╗░░█████╗░░░░░░░░░░
echo ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝░██╔══██╗████╗░██║██╔══██╗██╔══██╗░░░░░░░░░
echo ██║░░╚═╝███████║██████╔╝██████╔╝█████╗░░██║░░██╗░███████║██╔██╗██║██║░░██║██║░░██║░░░░░░░░░
echo ██║░░██╗██╔══██║██╔══██╗██╔══██╗██╔══╝░░██║░░╚██╗██╔══██║██║╚████║██║░░██║██║░░██║░░░░░░░░░
echo ╚█████╔╝██║░░██║██║░░██║██║░░██║███████╗╚██████╔╝██║░░██║██║░╚███║██████╔╝╚█████╔╝██╗██╗██╗
echo ░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝░╚═════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░░╚════╝░╚═╝╚═╝╚═╝
echo.
echo Carregando Arquivos Necessários...
timeout /t 5 /nobreak >nul

:: TERCEIRA TELA
cls
color 2
echo ██╗███╗░░██╗██╗░█████╗░██╗░█████╗░██████╗░░█████╗░
echo ██║████╗░██║██║██╔══██╗██║██╔══██╗██╔══██╗██╔══██╗
echo ██║██╔██╗██║██║██║░░╚═╝██║███████║██║░░██║██║░░██║
echo ██║██║╚████║██║██║░░██╗██║██╔══██║██║░░██║██║░░██║
echo ██║██║░╚███║██║╚█████╔╝██║██║░░██║██████╔╝╚█████╔╝
echo ╚═╝╚═╝░░╚══╝╚═╝░╚════╝░╚═╝╚═╝░░╚═╝╚═════╝░░╚════╝░
echo.

:: COLETA IP e PORTA
set IP=127.0.0.1
for /f "tokens=2 delims==" %%A in ('findstr /b "server-port=" server.properties') do set PORT=%%A

:: COLETA ONLINE MODE
set ONLINE=
for /f "tokens=2 delims==" %%A in ('findstr /b /i "online-mode=" server.properties') do set ONLINE=%%A

:: COLETA BUNGEECORD
set BUNGEE=
for /f "tokens=2 delims=:" %%A in ('findstr /i "bungeecord:" spigot.yml') do set BUNGEE=%%A
set BUNGEE=%BUNGEE: =%

:: MENSAGENS INFOS
set ONLINE_STATUS=Desconhecido
set BUNGEE_STATUS=Desconhecido
if /i "%ONLINE%"=="true" set ONLINE_STATUS=Ativado
if /i "%ONLINE%"=="false" set ONLINE_STATUS=Desativado
if /i "%BUNGEE%"=="true" set BUNGEE_STATUS=Ativado
if /i "%BUNGEE%"=="false" set BUNGEE_STATUS=Desativado

:: INFORMAÇÕES
echo IP do servidor:         %IP%:%PORT% (Copiado para área de transferência)
echo Online Mode:            %ONLINE_STATUS%
echo BungeeCord:             %BUNGEE_STATUS%
timeout /t 12 /nobreak >nul

:: TELA CARREGAMENTO PLUGINS
cls
color f
echo ███████╗██████╗░██╗░░░██╗███████╗██████╗░
echo ██╔════╝██╔══██╗██║░░░██║╚════██║██╔══██╗
echo █████╗░░██║░░██║██║░░░██║░░███╔═╝██████╔╝
echo ██╔══╝░░██║░░██║██║░░░██║██╔══╝░░██╔═══╝░
echo ███████╗██████╔╝╚██████╔╝███████╗██║░░░░░
echo ╚══════╝╚═════╝░░╚═════╝░╚══════╝╚═╝░░░░░
echo.
:: DETECÇÃO AUTOMÁTICA DO ARQUIVO .JAR
set JAR=
for %%i in (paper*.jar spigot*.jar server*.jar *.jar) do (
    if not defined JAR set JAR=%%i
)

if not defined JAR (
    echo Nenhum arquivo .jar de servidor encontrado!
    pause
    exit /b
)
echo BOOT SERVER: %JAR%
echo Carregando Plugins...
timeout /t 3 /nobreak >nul
echo %IP%:%PORT% | clip

java -Xms4G -Xmx4G -Dfile.encoding=UTF-8 -jar "%JAR%"



::ANOTAÇÕES
::@echo off - mostrar apenas as saidas
::echo - saida de texto na tela
::for - salvar variaveis pré-definidas
::title - alterar titulo da janela
::chcp - estabalidade no uso de texto ascii
::color - implementar cores aos textos
::cls - limpeza do cmd
::pause - pausa até a interação do usuário
::timeout - tempo de aguardo para o próximo comando
::nobreak - bloqueia interação do usuário com o cmd
::null - não permite a visualização da contagem
::set - definir variável
::if/else - se, caso contrário (básico de lógica)
::%example% - o nome entre % seria o chamado da variável ao echo



:: MADE BY: @EDUZP
:: https://github.com/eduzp