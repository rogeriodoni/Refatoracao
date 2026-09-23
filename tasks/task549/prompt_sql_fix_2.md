CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1143: Tabela 'SigCdUep' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1356: Tabela 'SigCdUep' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1391: Tabela 'SigCdUep' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1425: Tabela 'SigCdUep' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormUep.prg):

--- Linhas 1124 a 1164 ---
1124:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1125:             IF EMPTY(loc_cUsuarios)
1126:                 MsgAviso("Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
1127:                 loc_oPagina.txt_4c_Usuarios.SetFocus()
1128:                 loc_lProsseguir = .F.
1129:             ENDIF
1130: 
1131:             IF loc_lProsseguir AND EMPTY(loc_cEmpresa)
1132:                 MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
1133:                 loc_oPagina.txt_4c_Empresa.SetFocus()
1134:                 loc_lProsseguir = .F.
1135:             ENDIF
1136: 
1137:             IF loc_lProsseguir AND THIS.this_cModoAtual == "INCLUIR"
1138:                 TRY
1139:                     IF USED("cursor_4c_VerificaUep")
1140:                         USE IN cursor_4c_VerificaUep
1141:                     ENDIF
1142: 
1143:                     loc_cSQL = "SELECT Usuarios FROM SigCdUep WHERE Usuarios = " + ;
1144:                         EscaparSQL(PADR(loc_cUsuarios, 3))
1145: 
1146:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaUep")
1147: 
1148:                     IF loc_nResultado < 0
1149:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o")
1150:                         loc_lProsseguir = .F.
1151:                     ELSE
1152:                         IF USED("cursor_4c_VerificaUep")
1153:                             GO TOP IN cursor_4c_VerificaUep
1154:                             IF !EOF("cursor_4c_VerificaUep")
1155:                                 MsgAviso("Usu" + CHR(225) + "rio J" + CHR(225) + " Cadastrado!!!", ;
1156:                                     "Aten" + CHR(231) + CHR(227) + "o!!!")
1157:                                 loc_oPagina.txt_4c_Usuarios.SetFocus()
1158:                                 loc_lProsseguir = .F.
1159:                             ENDIF
1160:                         ENDIF
1161:                     ENDIF
1162: 
1163:                     IF USED("cursor_4c_VerificaUep")
1164:                         USE IN cursor_4c_VerificaUep



## Trechos relevantes do BO (C:\4c\projeto\app\classes\UepBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormUep.prg
- BO: C:\4c\projeto\app\classes\UepBO.prg
