*==============================================================================
* GERARRELPLANOCONTAS.PRG
* Script para gerar o relatorio de Plano de Contas usando GeradorRelatorio
*
* Executar: DO GerarRelPlanoContas.prg
* Resultado: Cria RelPlanoContas.frx
*==============================================================================

LOCAL loc_oGerador
LOCAL loc_cArquivoFRX, loc_cArquivoClasse

loc_cArquivoFRX = "C:\4c\projeto\app\reports\RelPlanoContas.frx"
loc_cArquivoClasse = "C:\4c\projeto\app\classes\GeradorRelatorio.prg"

IF !FILE(loc_cArquivoClasse)
    MESSAGEBOX("Arquivo nao encontrado:" + CHR(13) + loc_cArquivoClasse, 16, "Erro")
    RETURN
ENDIF

SET PROCEDURE TO (loc_cArquivoClasse) ADDITIVE

IF TYPE("gc_4c_UsuarioLogado") # "C"
    PUBLIC gc_4c_UsuarioLogado
    gc_4c_UsuarioLogado = "SISTEMA"
ENDIF

IF TYPE("gc_4c_CabecalhoRelatorio") # "C"
    PUBLIC gc_4c_CabecalhoRelatorio
    gc_4c_CabecalhoRelatorio = "EMPRESA"
ENDIF

WAIT WINDOW "Gerando relat" + CHR(243) + "rio..." NOWAIT

loc_oGerador = CREATEOBJECT("GeradorRelatorio", loc_cArquivoFRX, "Plano de Contas", "cPlConta")

loc_oGerador.Criar()

*======================================================================
* PAGE HEADER
*======================================================================
loc_oGerador.AdicionarPageHeader(1.200)
loc_oGerador.AdicionarLabel([gc_4c_CabecalhoRelatorio], 0, 0.100, 0.100, 5.000, "Arial", 14, 1)
loc_oGerador.AdicionarLabel(["Plano de Contas"], 0, 0.500, 0.100, 4.000, "Arial", 12, 1)
loc_oGerador.AdicionarLabel(["Data: " + DTOC(DATE())], 0, 0.100, 7.500, 2.000, "Arial", 8, 0)
loc_oGerador.AdicionarLabel(["Hora: " + TIME()], 0, 0.350, 7.500, 2.000, "Arial", 8, 0)
loc_oGerador.AdicionarLabel(["Usu" + CHR(225) + "rio: " + gc_4c_UsuarioLogado], 0, 0.600, 7.500, 2.000, "Arial", 8, 0)
loc_oGerador.AdicionarLinha(0, 1.050, 0.000, 10.000, 1)

*======================================================================
* COLUMN HEADER
*======================================================================
loc_oGerador.AdicionarColHeader(0.350)
loc_oGerador.AdicionarLabel(["Conta"], 1, 0.080, 0.100, 1.500, "Arial", 9, 1)
loc_oGerador.AdicionarLabel(["Descri" + CHR(231) + CHR(227) + "o"], 1, 0.080, 1.800, 6.000, "Arial", 9, 1)
loc_oGerador.AdicionarLinha(1, 0.300, 0.000, 10.000, 1)

*======================================================================
* DETAIL
*======================================================================
loc_oGerador.AdicionarDetail(0.280)
loc_oGerador.AdicionarCampo("cContas", 4, 0.040, 0.100, 1.500, "Arial", 9, 0)
loc_oGerador.AdicionarCampo("cDcontas", 4, 0.040, 1.800, 6.000, "Arial", 9, 0)

*======================================================================
* PAGE FOOTER
*======================================================================
loc_oGerador.AdicionarPageFooter(0.400)
loc_oGerador.AdicionarLinha(7, 0.050, 0.000, 10.000, 1)
loc_oGerador.AdicionarLabel(["P" + CHR(225) + "gina " + ALLTRIM(STR(_PAGENO))], 7, 0.150, 4.500, 1.500, "Arial", 8, 0)

loc_oGerador.Finalizar()

WAIT CLEAR
MESSAGEBOX("Relat" + CHR(243) + "rio gerado com sucesso!" + CHR(13) + CHR(13) + "Arquivo: " + loc_cArquivoFRX, 64, "Sucesso")

RETURN
