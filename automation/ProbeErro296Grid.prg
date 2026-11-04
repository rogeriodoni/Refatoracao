*==============================================================================
* ProbeErro296Grid.prg - Prova as 3 mecanicas alteradas no Formmtz (Erro296):
*   1) Column.ControlSource com CheckBox como CurrentControl (o que estourava)
*   2) chk.ControlSource (deve ESTOURAR - confirma o diagnostico)
*   3) ColumnOrder atribuido na ordem da posicao de destino
* Regra #6: SET SAFETY OFF + SET RESOURCE OFF (execucao unattended).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut, loc_oFrm, loc_oGrid, loc_nI, loc_cOrdem
loc_cOut = "=== PROBE Erro296 ===" + CHR(13) + CHR(10)

CREATE CURSOR cur_mti (Grupos C(10), Contas C(10), ChkValida L)
FOR loc_nI = 1 TO 3
    INSERT INTO cur_mti VALUES ("G" + TRANSFORM(loc_nI), "C" + TRANSFORM(loc_nI), .F.)
ENDFOR
GO TOP

loc_oFrm = CREATEOBJECT("Form")
loc_oFrm.AddObject("grd", "Grid")
loc_oGrid = loc_oFrm.grd
loc_oGrid.ColumnCount  = 3
loc_oGrid.RecordSource = "cur_mti"
loc_oGrid.Column1.ControlSource = "cur_mti.Grupos"
loc_oGrid.Column2.ControlSource = "cur_mti.Contas"

loc_oGrid.Column3.AddObject("chk_4c_Check1", "CheckBox")
loc_oGrid.Column3.chk_4c_Check1.Caption  = ""
loc_oGrid.Column3.chk_4c_Check1.Centered = .T.
loc_oGrid.Column3.chk_4c_Check1.Width    = 60
loc_oGrid.Column3.CurrentControl = "chk_4c_Check1"
loc_oGrid.Column3.Sparse         = .F.

*-- 1) FORMA CERTA: ControlSource na COLUNA
TRY
    loc_oGrid.Column3.ControlSource = "cur_mti.ChkValida"
    loc_cOut = loc_cOut + "1) Column3.ControlSource         -> OK  [" + ;
        loc_oGrid.Column3.ControlSource + "]" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "1) Column3.ControlSource         -> ERRO: " + ;
        loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY

*-- 2) FORMA ERRADA (a que estava no Formmtz): ControlSource no CheckBox
TRY
    loc_oGrid.Column3.chk_4c_Check1.ControlSource = "cur_mti.ChkValida"
    loc_cOut = loc_cOut + "2) chk.ControlSource             -> OK (inesperado)" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "2) chk.ControlSource             -> ERRO: " + ;
        loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY

*-- 3) CurrentControl/Sparse sobreviveram ao bind?
loc_cOut = loc_cOut + "3) CurrentControl = [" + loc_oGrid.Column3.CurrentControl + ;
    "]  Sparse = " + TRANSFORM(loc_oGrid.Column3.Sparse) + CHR(13) + CHR(10)

*-- 4) ColumnOrder: permutar 6 colunas atribuindo na ordem do DESTINO
loc_oFrm.AddObject("grd2", "Grid")
loc_oFrm.grd2.ColumnCount = 6
loc_oFrm.grd2.Column1.Header1.Caption = "A"
loc_oFrm.grd2.Column2.Header1.Caption = "B"
loc_oFrm.grd2.Column3.Header1.Caption = "C"
loc_oFrm.grd2.Column4.Header1.Caption = "D"
loc_oFrm.grd2.Column5.Header1.Caption = "E"
loc_oFrm.grd2.Column6.Header1.Caption = "F"
*-- alvo visual: A B F C E D  (imita o intercalado Val/Acm do legado)
loc_oFrm.grd2.Column1.ColumnOrder = 1
loc_oFrm.grd2.Column2.ColumnOrder = 2
loc_oFrm.grd2.Column6.ColumnOrder = 3
loc_oFrm.grd2.Column3.ColumnOrder = 4
loc_oFrm.grd2.Column5.ColumnOrder = 5
loc_oFrm.grd2.Column4.ColumnOrder = 6

loc_cOrdem = ""
FOR loc_nI = 1 TO 6
    loc_cOrdem = loc_cOrdem + "Column" + TRANSFORM(loc_nI) + "=" + ;
        TRANSFORM(EVALUATE("loc_oFrm.grd2.Column" + TRANSFORM(loc_nI) + ".ColumnOrder")) + " "
ENDFOR
loc_cOut = loc_cOut + "4) ColumnOrder final: " + loc_cOrdem + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "   esperado: Column1=1 Column2=2 Column3=4 Column4=6 Column5=5 Column6=3" + CHR(13) + CHR(10)

*-- 5) Column.InputMask aceito?
TRY
    loc_oGrid.Column1.InputMask = "999,999,999.99"
    loc_cOut = loc_cOut + "5) Column.InputMask             -> OK  [" + ;
        loc_oGrid.Column1.InputMask + "]" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "5) Column.InputMask             -> ERRO: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY

*-- 6) CheckBox.Centered aceito dentro de Column?
loc_cOut = loc_cOut + "6) chk.Centered = " + ;
    TRANSFORM(loc_oGrid.Column3.chk_4c_Check1.Centered) + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\probe_erro296_grid.txt")
QUIT
