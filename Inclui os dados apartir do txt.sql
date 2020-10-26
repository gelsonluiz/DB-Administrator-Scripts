--Cria tabela para inclusão dos dados
CREATE TABLE #Tmp1(
Acao_curso char(1),
Codigo_curso Int,
CodigoTituloEquivalente_curso	Int,
TituloCategoria_curso VarChar(150),
Titulo_curso VarChar(150),
DataInicio_curso	SmallDateTime,
DataFinal_curso SmallDatetime,
TipoEnsino	VarChar(15),
Regional	VarChar(2),
ContaUnidade_curso Int,
Unidade	VarChar(150),
TipoCurso	VarChar(150),
CodigoCursoRegional_curso VarChar(15),	
CHTotal_curso	Int,
CHSenacAnterior_curso	 Int,
CHSenacExercicio_curso	Int,
CHEExecutadaMes	Int,
CHEfetivaMes	Int,
Status_curso	VarChar(15),
Chave_curso	VarChar(15),
MesReferencia_curso	Int,
AnoReferencia_curso	Int,
MesApuracao_curso	Int,
AnoApuracao_curso	Int,
ContaUnidadeAnterior_curso	Int,
CodigoAnterior_curso	Int,
CodigoTituloEquivalenteAnterior	Int,
DataInicioAnterior_curso	SmallDatetime,
DataFinalAnterior_curso	SmallDateTime,
TipoEnsinoAnterior_curso	Int,
Acao_aluno	VarChar(1),
ReferencialCurso_aluno	VarChar(150),
Codigo_aluno Int,
CPF_aluno VarChar(15),
Nome_aluno	VarChar(150),
DataNascimento_aluno	SmallDateTime,
NomeMae_aluno	VarChar(150),
Sexo_aluno	VarChar(15),
Raca_aluno	VarChar(15),
Deficiencia_aluno	VarChar(15),
SiglaRegional_aluno	VarChar(2),
StatusMatricula_aluno	VarChar(15),
CodigoTurma_aluno	VarChar(15),
ModalidadePagamento_codigo	VarChar(15),
ModalidadePagamento_aluno	VarChar(150),
EstadoCivil_aluno	VarChar(15),
Escolaridade_aluno	VarChar(150),
MunicipioResidencia_aluno	VarChar(30),
MesReferencia_aluno	Int,
AnoReferencia_aluno	Int,
MesApuracao_aluno	Int,
AnoApuracao_aluno	Int,
Origem	VarChar(15),
Justificativa	VarChar(150),
UO VarChar(2))

 
--inclui os dados apartir do txt
BULK INSERT DBO.#Tmp1 -- Tabela onde dados serão inceridos
FROM 'C:\janeiro.txt'-- caminho onde estão dos dados a serem inseridos
WITH
(
FIELDTERMINATOR = ';',  -- caractere separador dos campos
ROWTERMINATOR = '\n'  -- referencia par afim de linha
)
GO
 
SELECT * FROM #Tmp1


drop table #Tmp1