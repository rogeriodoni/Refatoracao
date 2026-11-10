*==============================================================================
* fxmltocursor.prg - Wrapper de compatibilidade para funcao GLOBAL do legado
*                    Fortyus (regra #27 do CLAUDE.md).
*
* fXmlToCursor() eh funcao global da aplicacao legado (sig.prg / SIGFUNCS.PRG)
* que NAO veio no acervo. Nome desconhecido seguido de "(" NAO eh erro de
* compilacao em VFP9 (regra #13): o interpretador procura <nome>.prg no PATH e
* so estoura em RUNTIME - aqui, dentro do laco que expande a hierarquia de
* localizacao, com "File 'fxmltocursor.prg' does not exist".
*
* CONTRATO (reproduzido, nao so o nome - regra #27):
*     fXmlToCursor(cXML, cCursor, lUsarCursorExistente)
*
* Carrega o XML <cXML> (STRING, nao arquivo) no cursor de nome <cCursor>.
*
*------------------------------------------------------------------------------
* O 3o ARGUMENTO E O FLAG - e os dois unicos call sites do legado passam .F.
*
* O legado chama sempre assim, com o cursor destino JA declarado com estrutura
* e esvaziado por ZAP logo antes:
*
*     Select cidchaves, Cods, Descs, 0 as Marcas, Space(4) as Codigo ;
*            From <nivel> Where 1=0 Into Cursor CrAux ReadWrite
*     ...
*     Zap in CrAux
*     = fXmlToCursor(lcXML, [CrAux], .f.)
*     Scan For CrAux.Marcas <> 0      && LE Marcas/Cods/CidChaves
*
* Ou seja: as colunas Marcas/Cods/CidChaves TEM de existir depois da chamada.
*
* MEDIDO no VFP9 em 2026-11-08 (automation\medir_xmltocursor.prg), com o XML
* gerado por CURSORTOXML de um cursor com as 5 colunas - que eh exatamente
* como a tela de manutencao de localizacao grava a coluna <nivel>:
*
*   destino JA EXISTE, flags = 0  -> 2 regs, 5 campos, Marcas e Codigo PRESENTES
*   destino JA EXISTE, flags = 2  -> 2 regs, 5 campos, Marcas e Codigo PRESENTES
*   destino NAO existe, flags = 0 -> 2 regs, 5 campos, Marcas PRESENTE
*
* Os dois flags dao o MESMO resultado. Isso elimina a ambiguidade do 3o
* argumento: as duas leituras possiveis (lEhArquivo / lAnexar) convergem em
* nFlags = 0 para .F., e o resultado nao muda. Mapeamento adotado:
*
*   .F. / ausente -> 0  (XML eh STRING; cursor recriado a partir do schema)
*   .T.           -> 2  (anexa ao cursor existente, preservando a estrutura)
*   NUMERICO      -> repassado cru como nFlags nativo (forward-safe)
*
* NUNCA devolver valor de calculo inventado (regra #27): havendo erro, o
* retorno eh -1 e o laco chamador simplesmente nao acha linha marcada - o
* mesmo efeito de um <nivel> vazio, que o legado ja trata.
*
*------------------------------------------------------------------------------
* O XML TEM DE TRAZER SCHEMA XSD - senao os TIPOS sao inferidos e estragados
*
* XMLTOCURSOR DESTROI e RECRIA o cursor de destino (medido: acontece com
* flags 0 E com flags 2), tipando as colunas a partir do XML. Sem schema
* embutido ele CHUTA pelo conteudo. MEDIDO no VFP9 em 2026-11-08
* (automation\medir_xml_schema.prg), origem Cods C(2)="01" / Marcas N(1)=1:
*
*   XML COM schema -> Marcas = N , Cods = C "01" , Codigo = C "0001"   fiel
*   XML SEM schema -> Marcas = L , Cods = N  1   , Codigo = N  1       perdeu
*                                                   os zeros a esquerda
*
* Com o XML SEM schema, "Scan For CrAux.Marcas <> 0" (como o legado escreve)
* estoura "Operator/operand type mismatch". Como o legado roda esse Scan ha
* anos, o XML gravado na coluna <nivel> em producao TRAZ schema - quem grava
* tem de continuar chamando CURSORTOXML com cSchemaName preenchido.
*
* Nao cabe "consertar" isso aqui: reconstruir o zero a esquerda a partir de
* um numero exigiria adivinhar a largura da coluna, e inventar valor eh o que
* a regra #27 proibe. O SigOpLclBO.ReverterXML absorve a variacao de TIPO
* (helpers MarcaComoNumero/ComoTexto) para que um registro assim nao aborte a
* expansao inteira - mas o dado continua sendo o que o XML trouxe.
*==============================================================================
LPARAMETERS par_cXML, par_cCursor, par_uFlag

LOCAL loc_nFlags, loc_nRetorno

loc_nRetorno = -1

*-- Guardas de contrato ANTES de delegar: XML vazio/nulo ou nome de cursor
*-- ausente nao sao erro - o legado ja envolve a chamada em
*-- "If Not Empty(lcXML)", e o cursor fica como estava (vazio pelo ZAP).
IF VARTYPE(par_cCursor) != "C" OR EMPTY(ALLTRIM(NVL(par_cCursor, "")))
    RETURN loc_nRetorno
ENDIF

IF ISNULL(par_cXML) OR VARTYPE(par_cXML) != "C" OR EMPTY(par_cXML)
    RETURN loc_nRetorno
ENDIF

*-- Traducao do 3o argumento para o nFlags da XMLTOCURSOR nativa
DO CASE
    CASE PCOUNT() < 3 OR ISNULL(par_uFlag)
        loc_nFlags = 0
    CASE VARTYPE(par_uFlag) = "N"
        loc_nFlags = par_uFlag
    CASE VARTYPE(par_uFlag) = "L"
        loc_nFlags = IIF(par_uFlag, 2, 0)
    OTHERWISE
        loc_nFlags = 0
ENDCASE

TRY
    loc_nRetorno = XMLTOCURSOR(par_cXML, par_cCursor, loc_nFlags)
CATCH TO loc_oErro
    *-- CATCH nunca silencioso (regra #9), mas tambem nao pode travar o laco:
    *-- XML corrompido numa linha da hierarquia nao deve impedir as outras.
    MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel interpretar o XML do n" + ;
             CHR(237) + "vel de localiza" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
             "Cursor: " + ALLTRIM(par_cCursor) + CHR(13) + ;
             "Erro: " + loc_oErro.Message, ;
             "Aten" + CHR(231) + CHR(227) + "o")
    loc_nRetorno = -1
ENDTRY

RETURN loc_nRetorno
