* ProbeOcoBusca775.prg - prova o CAMINHO DE CONFIGURACAO do picker de
* ocorrencias (task775, Fase 6) sem chamar Show(), que eh MODAL e penduraria
* o processo headless. Confere que DefinirCursor + os dois mAddColuna montam
* as colunas com a mascara e os titulos do dump legado, e que ConfigurarGrid
* (chamado por Show) liga a grade ao cursor ja populado.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE LOG "C:\4c\automation\probe_ocobusca775.txt"

LOCAL loc_oBusca, loc_nI
PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_ocobusca775.txt"

STRTOFILE("B01 inicio" + CHR(13) + CHR(10), LOG)

CD C:\4c\projeto\app\start
DO config.prg
SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
STRTOFILE("B02 setup OK" + CHR(13) + CHR(10), LOG, 1)

*-- Cursor que o BO popularia (SELECT * FROM SigBaOco WHERE Tipos='O' AND Autos<>'S')
IF USED("cursor_4c_Ocorrencias")
    USE IN cursor_4c_Ocorrencias
ENDIF
CREATE CURSOR cursor_4c_Ocorrencias (codigos C(10), descrs C(40), tipos C(1), autos C(1))
INSERT INTO cursor_4c_Ocorrencias VALUES ("OC01", "AVARIA NA EMBALAGEM", "O", "N")
INSERT INTO cursor_4c_Ocorrencias VALUES ("OC02", "ETIQUETA ILEGIVEL",   "O", "N")
INDEX ON Codigos TAG Codigos
INDEX ON Descrs  TAG Descrs
SET ORDER TO TAG Codigos
GO TOP
STRTOFILE("B03 cursor_4c_Ocorrencias reccount=" + ;
          TRANSFORM(RECCOUNT("cursor_4c_Ocorrencias")) + CHR(13) + CHR(10), LOG, 1)

*-- Exatamente a sequencia de AbrirBuscaOcorrencia, menos o Show()
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
STRTOFILE("B04 CREATEOBJECT = [" + VARTYPE(loc_oBusca) + "]" + CHR(13) + CHR(10), LOG, 1)

loc_oBusca.DefinirCursor("cursor_4c_Ocorrencias", "codigos", "descrs", ;
                         "Ocorr" + CHR(234) + "ncias")
STRTOFILE("B05 apos DefinirCursor: nColunas=" + TRANSFORM(loc_oBusca.this_nColunas) + ;
          " cursor=[" + loc_oBusca.this_cCursorDestino + "]" + ;
          " campoCod=[" + loc_oBusca.this_cCampoCodigo + "]" + ;
          " campoDesc=[" + loc_oBusca.this_cCampoDescricao + "]" + ;
          " titulo=[" + loc_oBusca.this_cTitulo + "]" + CHR(13) + CHR(10), LOG, 1)

loc_oBusca.this_nColunas = 0
loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
STRTOFILE("B06 apos mAddColuna: nColunas=" + TRANSFORM(loc_oBusca.this_nColunas) + ;
          CHR(13) + CHR(10), LOG, 1)

FOR loc_nI = 1 TO loc_oBusca.this_nColunas
    STRTOFILE("    col" + TRANSFORM(loc_nI) + " campo=[" + ;
              loc_oBusca.this_aColunas[loc_nI, 1] + "] mascara=[" + ;
              loc_oBusca.this_aColunas[loc_nI, 2] + "] titulo=[" + ;
              loc_oBusca.this_aColunas[loc_nI, 3] + "]" + CHR(13) + CHR(10), LOG, 1)
ENDFOR

*-- ConfigurarGrid eh PROTECTED (roda dentro de Show). Prova indireta: o grid
*-- do picker tem as colunas e o cursor esta posicionado para Mostrar() ler.
STRTOFILE("B07 grid do picker ColumnCount=" + ;
          TRANSFORM(loc_oBusca.grd_4c_Lista.ColumnCount) + CHR(13) + CHR(10), LOG, 1)

*-- NAO chamar Mostrar(): ele faz Show(), que eh MODAL e penduraria o probe.
*-- Em vez disso, reproduz o que Mostrar() le DEPOIS do Show - o EVALUATE
*-- sobre this_cCampoCodigo/this_cCampoDescricao na linha corrente - provando
*-- que os nomes de campo configurados resolvem contra o cursor de verdade.
SELECT cursor_4c_Ocorrencias
GO BOTTOM
STRTOFILE("B08 leitura como Mostrar() faz: codigo=[" + ;
          ALLTRIM(EVALUATE(loc_oBusca.this_cCampoCodigo)) + "] descricao=[" + ;
          ALLTRIM(EVALUATE(loc_oBusca.this_cCampoDescricao)) + "]" + ;
          CHR(13) + CHR(10), LOG, 1)

loc_oBusca.Release()
loc_oBusca = .NULL.
STRTOFILE("B09 Release OK - FIM" + CHR(13) + CHR(10), LOG, 1)

QUIT
