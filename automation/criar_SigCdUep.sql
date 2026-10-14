/*==============================================================================
  SigCdUep - Usuarios Fixos Por Empresa  (tela SIGCDUEP / FormUep)

  POR QUE ESTE SCRIPT EXISTE
  --------------------------
  A tabela NAO existe no DB_MBAHIA, e por isso a tela nao abre nem grava:
      "Nome de objeto 'SigCdUep' invalido."   (Erro202 / Erro203)

  Nao eh defeito de migracao: o SCX legado usa exatamente o mesmo nome
  (AddCursor([SigCdUep],[cIdChaves],[crSigCdUep]...) e
   Select Usuarios From SigCdUep), com as mesmas 3 colunas. A tela LEGADA
  quebra igual neste banco. O que falta eh a tabela.

  DE ONDE VEIO ESTA DEFINICAO
  ---------------------------
  NAO foi inventada. Foi extraida do proprio servidor 192.168.200.10: a tabela
  existe em 16 outros bancos de cliente, com definicao IDENTICA nos 16
  (conferido coluna a coluna em 2026-10-13):

    CORLUIZ, DB_3M, DB_4C_FAB, DB_4C_LJ, DB_ALB, DB_ALBERTINI, DB_CALCCE,
    DB_CORAZON, DB_FABCORAZON, DB_GARCIA, DB_HORAD, DB_IRANI, DB_JB,
    DB_MALLORCA71, DB_MLLC_NEW, DB_PALADINI

  COLLATE EXPLICITO - NAO REMOVER
  -------------------------------
  O default do DB_MBAHIA eh Latin1_General_CI_AS, mas nos 16 bancos estas
  colunas estao em SQL_Latin1_General_CP1_CI_AS - e as tabelas com que esta
  conversa neste banco tambem estao:
      SigCdUsu.usuarios -> SQL_Latin1_General_CP1_CI_AS
      SigCdEmp.cemps    -> SQL_Latin1_General_CP1_CI_AS
  Criar sem o COLLATE explicito daria a collation default e qualquer JOIN com
  essas tabelas passaria a falhar com "conflito de ordenacao ... equal to"
  (a mesma classe do Erro201). Ver CLAUDE.md regra #52.

  SEGURANCA
  ---------
  Idempotente: nao faz nada se a tabela ja existir. Apenas CRIA - nao altera
  nem remove objeto nenhum. Para desfazer: DROP TABLE dbo.SigCdUep.
==============================================================================*/

USE DB_MBAHIA;
GO

IF OBJECT_ID('dbo.SigCdUep', 'U') IS NOT NULL
BEGIN
    PRINT 'SigCdUep ja existe - nada a fazer.';
END
ELSE
BEGIN
    CREATE TABLE dbo.SigCdUep
    (
        cidchaves char(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        usuarios  char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        emps      char(3)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        CONSTRAINT sigcduep_cidchaves PRIMARY KEY CLUSTERED (cidchaves)
    );

    ALTER TABLE dbo.SigCdUep ADD DEFAULT (' ') FOR cidchaves;
    ALTER TABLE dbo.SigCdUep ADD DEFAULT (' ') FOR usuarios;
    ALTER TABLE dbo.SigCdUep ADD DEFAULT (' ') FOR emps;

    PRINT 'SigCdUep criada.';
END
GO

/*-- conferencia ------------------------------------------------------------*/
SELECT c.name AS coluna, t.name AS tipo, c.max_length, c.is_nullable, c.collation_name
FROM sys.columns c
JOIN sys.types   t ON t.user_type_id = c.user_type_id
WHERE c.object_id = OBJECT_ID('dbo.SigCdUep')
ORDER BY c.column_id;
GO
