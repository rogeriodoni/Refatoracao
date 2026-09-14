*============================================================================
* TEST_EXTRACT_MANUAL.PRG
* Teste manual do ExtractSCXCode com variaveis PUBLIC
*============================================================================

CLEAR
SET TALK ON
SET CONSOLE ON

? "=== TESTE MANUAL ExtractSCXCode ==="
? ""

*-- Declara variaveis PUBLIC (simula automacao)
PUBLIC _TASK_DIR, _SCX_FILE

_TASK_DIR = "C:\4c\tasks\task006"
_SCX_FILE = "SigCdTam"

? "Variaveis PUBLIC declaradas:"
? "  _TASK_DIR = [" + _TASK_DIR + "]"
? "  _SCX_FILE = [" + _SCX_FILE + "]"
? ""

*-- Executa ExtractSCXCode
? "Executando ExtractSCXCode.prg..."
? ""

ON ERROR ? "ERRO VFP: ", ERROR(), MESSAGE()

DO C:\4c\projeto\app\utils\ExtractSCXCode.prg

? ""
? "=== FIM DO TESTE ==="
? ""

*-- Verifica se arquivo foi gerado
LOCAL lcArquivoEsperado
lcArquivoEsperado = "C:\4c\tasks\task006\SigCdTam_form_codigo_fonte.txt"

IF FILE(lcArquivoEsperado)
    ? "SUCESSO: Arquivo gerado!"
    ? "Localizacao: " + lcArquivoEsperado
ELSE
    ? "FALHA: Arquivo NAO foi gerado!"
    ? "Esperado: " + lcArquivoEsperado
ENDIF

? ""
? "Pressione qualquer tecla para sair..."
INKEY(0)

QUIT
