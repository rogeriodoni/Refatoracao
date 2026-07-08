@echo off
echo ======================================
echo   TESTE AUTOMATIZADO - FormProduto
echo ======================================
echo.

echo 1. Deletando arquivos .fxp...
del /s /q C:\4c\projeto\app\*.fxp >nul 2>&1

echo 2. Executando teste automatizado...
"C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe" -t -cC:\temp\config.fpw

echo 3. Aguardando conclusão...
timeout /t 5 /nobreak >nul

echo.
echo ======================================
echo   RESULTADO DO TESTE
echo ======================================
echo.

if exist C:\temp\test_result.txt (
    type C:\temp\test_result.txt
    echo.
    echo ======================================
    echo Resultado salvo em: C:\temp\test_result.txt

    if exist C:\temp\screenshot_page1.txt (
        echo Screenshot Page1: C:\temp\screenshot_page1.txt
    )

    if exist C:\temp\screenshot_page2.txt (
        echo Screenshot Page2: C:\temp\screenshot_page2.txt
    )
) else (
    echo ERRO: Arquivo de resultado nao encontrado!
)

echo.
echo Pressione qualquer tecla para sair...
pause >nul
