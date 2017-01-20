/*---------------------------------------------------------------------		
/// Define classes EGP e NVS

/// Weverthon Machado

- Este arquivo define o programa, processa argumentos e cria as macros 
(locals) que contem os nomes reais das variaveis. A conversão e codificacao 
sao feitas atraves do arquivo classes_pnad_base.do

Versão 0.9.9
Última alteração: 04/12/2016
---------------------------------------------------------------------*/
capture program drop classes_pnad
program define classes_pnad
version 12

syntax [namelist], ANO(integer) [MOBilidade INTermediaria] 


/*********************************************************************
* 0 - Configurações e labels
**********************************************************************/

	/*--------------------------------------------------------------------
	- Processando argumentos
	---------------------------------------------------------------------*/

	if "`namelist'" == "" {  /* Se nenhuma especificada, gera todas */
		local egp12 egp12
		local egp7 egp7
		local nvs nvs
		local egps egps
	}

	if "`namelist'" != "" {
		tokenize `namelist'
		
		* Argumento é válido?
		local validos "egp egp7 egp12 egps nvs nvs18"
		local nargs: list sizeof namelist
		forvalues x = 1/`nargs' {
			if `: list `x' in validos'{
			}
			else {
				di as error "Erro: '``x''' não é uma classificação válida."
				exit
			}
		} 

		local `1' `1'
		capture {
			local `2' `2'
			local `3' `3'
			local `4' `4'
			local `5' `5'
			local `6' `6'
		}
	}

	if "`mobilidade'" != "" & `ano'!=2014 {
		di as error "Erro: a opcao mobilidade e valida apenas para o ano de 2014. Apenas a ocupacao principal sera considerada"
	}

	quietly findfile classes_pnad_base.do
	local classes_pnad_base = r(fn)


	/*--------------------------------------------------------------------
	- Labels
	---------------------------------------------------------------------*/
	*EGP
	if "`egp12'" != ""  |  "`egp'" != "" | "`egp7'" != ""{
		#delimit ;
		capture label define egp12
		10 "I - Higher-grade Profs & Adm "
		20 "II - Lower-grade Prof & Adm "
		31 "IIIa - Higher-grade Routine non-manual"
		41 "IVa - Small proprietors, with employees"
		42 "IVb - Small proprietors, without employees"
		32 "IIIb -Lower-grade Routine non-manual work"                                  
		50 "V - Technicians and superv. manual work"
		60 "VI - Skilled manual workers"
		71 "VIIa -Semi- & unskilled manual workers"
		44 "IVc - Rural employers"
		43 "IVc2 - Rural Self-employed"      	
		72 "VIIb - Agricultural Workers"
		;
		#delimit cr
	}

	*NVS
	if "`nvs'" != "" | "`nvs18'" != ""{
		#delimit ;
		capture label define nvs
		1 "1 - Profissionais liberais"  
		2 "2 - Dirigentes e administradores de alto nível"
		3 "3 - Profissionais"
		4 "4 - Funções administrativas execução"
		5 "5 - Não-manual de rotina e funções de escritório"
		6 "6 - Proprietários empregador na ind, com e serv"
		7 "7 - Empresários por conta própria sem empregados"
		8 "8 - Técnicos, artistas e superv do trabalho manual"
		9 "9 - Trabalhadores manuais em indústrias modernas"
		10 "10 - Traba manuais em indústrias tradicionais"
		11 "11 - Trabalhadores manuais em serviços em geral"
		12 "12 - Trabalhadores no serviço doméstico"
		13 "13 - Vendedores ambulantes"
		14 "14 - Artesãos"
		15 "15 - Proprietários empregadores no setor primário"
		16 "16 - Técnicos e administradores no setor primário"
		17 "17 - Produtores agrícolas autônomos"
		18 "18 - Trabalhadores rurais"
		;
		#delimit cr
	}

	* EGPS
	if "`egps'" != "" {
		#delimit ;
		capture label define egps
		100 "I - Prof e Adm, nível alto"
		200 "II - Prof e Adm, nível baixo"
		311 "IIIa1 - Não-manual rotina, nível alto escritório"
		312 "IIIa2 - Não-manual rotina, nível alto supervisão"
		321 "IIIb1 - Não-manual rotina, nível baixo escritório"
		322 "IIIb2 - Não-manual rotina, nível baixo serviços"
		410 "IVa - Pequenos Propriet., empregadores"
		420 "IVb - Pequenos Propriet., sem empregados"
		430 "IVc2 - Pequenos Prop. rurais, sem empregados"
		440 "IVc1 - Pequenos Prop. rurais, com empregados"
		500 "V - Técnicos e supervisores do Trab. Manual"
		601 "VIa - Trabalhadores Manuais Qualif., Ind. Moderna"
		602 "VIb - Trabalhadores Manuais Qualif., Ind. Tradicional"
		603 "VIc - Trabalhadores Manuais Qualif., Serviços"
		711 "VIIa1 - Trabalhadores Manuais Não-qualif., Industria"
		712 "VIIa2 - Trabalhadores Manuais Não-qualif., Serviços"
		713 "VIIa3 - Trabalhadores Manuais Não-qualif., Serv Domest"
		714 "VIIa4 - Trabalhadores Manuais Não-qualif., Ambulantes"
		720 "VIIb - Trabalhadores Manuais Rurais"
		;
		#delimit cr
	}

/*********************************************************************
* 1 - Pesquisa basica (ocupacao principal)
**********************************************************************/

* Dando conta de letras maiusculas e minusculas
if `ano'>1990 & `ano'<2002{
	capture confirm variable v9906, exact
	if _rc!=0 {
		capture confirm variable V9906, exact
		if _rc==0 {
			local ocupacao V9906
		}
	} 
	else {
		local ocupacao v9906
	}
}

if `ano'>2001 {
	capture confirm variable v9906 v9907 v4706 v4808 v4809, exact
	if _rc!=0 {
		capture confirm variable V9906 V9907 V4706 V4808 V4809, exact
		if _rc==0 {
			local cbo 		V9906
			local codativ 	V9907
			local posocup 	V4706
			local ativagr 	V4808
			local grupoativ 	V4809
		}
		else {
			di as error "Erro: Variaveis auxiliares nao encontradas. Verifique o ano da pesquisa e os nomes das variaveis."
			exit
		}
	} 
	else {
			local cbo 		v9906
			local codativ 	v9907
			local posocup 	v4706
			local ativagr 	v4808
			local grupoativ 	v4809
	}
}

* Nomes das variaveis a serem criadas
local egp12Name	egp12
local nvsName 	nvs
local egpsName 	egps
local ibge90Name ibge90
local complabel "Ocupação principal"

* Chama o arquivo base 
local supl 0
quietly include "`classes_pnad_base'"

/*********************************************************************
* 2 - Suplemento Mobilidade
**********************************************************************/

if "`mobilidade'" != "" & `ano'==2014 {

	/*--------------------------------------------------------------------
	- Primeira ocupacao
	---------------------------------------------------------------------*/

	capture confirm variable v32005 v32006 v32007 v32008, exact
	if _rc!=0 {
		capture confirm variable V32005 V32006 V32007 V32008, exact
		if _rc==0 {
			local cbo 			V32005
			local codativ 		V32006
			local posocup_supl 	V32007
			local mil_fp 		V32008

		}
		else {
			di as error "Erro: Variaveis auxiliares nao encontradas. Verifique o ano da pesquisa e os nomes das variaveis."
			exit
		}
	} 
	else {
			local cbo 			v32005
			local codativ 		v32006
			local posocup_supl 	v32007
			local mil_fp 		v32008
	}


	* Nomes das variaveis a serem criadas
	local egp12Name	egp12_ocup1
	local nvsName 	nvs_ocup1
	local egpsName 	egps_ocup1
	local ibge90Name ibge90_ocup1
	local complabel "Primeira ocupação"

	* Esvazia locals que serao recriada para suplemento
	local posocup 	
	local ativagr 	
	local grupoativ 

	* Chama o arquivo base 
	local supl 1
	quietly include "`classes_pnad_base'"


	/*--------------------------------------------------------------------
	- Pai
	---------------------------------------------------------------------*/

	capture confirm variable v32019 v32020 v32021 v32022, exact
	if _rc!=0 {
		capture confirm variable V32019 V32020 V32021 V32022, exact
		if _rc==0 {
			local cbo 			V32019
			local codativ 		V32020
			local posocup_supl 	V32021
			local mil_fp 		V32022

		}
		else {
			di as error "Erro: Variaveis auxiliares nao encontradas. Verifique o ano da pesquisa e os nomes das variaveis."
			exit
		}
	} 
	else {
			local cbo 			v32019
			local codativ 		v32020
			local posocup_supl 	v32021
			local mil_fp 		v32022
	}


	* Nomes das variaveis a serem criadas
	local egp12Name	egp12_pai
	local nvsName 	nvs_pai
	local egpsName 	egps_pai
	local ibge90Name ibge90_pai
	local complabel "Pai"

	* Esvazia locals que serao recriada para suplemento
	local posocup 	
	local ativagr 	
	local grupoativ 

	* Chama o arquivo base 
	local supl 1
	quietly include "`classes_pnad_base'"

	/*--------------------------------------------------------------------
	- Mae
	---------------------------------------------------------------------*/

	capture confirm variable v32033 v32034 v32035 v32036, exact
	if _rc!=0 {
		capture confirm variable V32033 V32034 V32035 V32036, exact
		if _rc==0 {
			local cbo 			V32033
			local codativ 		V32034
			local posocup_supl 	V32035
			local mil_fp 		V32036

		}
		else {
			di as error "Erro: Variaveis auxiliares nao encontradas. Verifique o ano da pesquisa e os nomes das variaveis."
			exit
		}
	} 
	else {
			local cbo 			v32033
			local codativ 		v32034
			local posocup_supl 	v32035
			local mil_fp 		v32036
	}


	* Nomes das variaveis a serem criadas
	local egp12Name	egp12_mae
	local nvsName 	nvs_mae
	local egpsName 	egps_mae
	local ibge90Name ibge90_mae
	local complabel "Mãe"

	* Esvazia locals que serao recriada para suplemento
	local posocup 	
	local ativagr 	
	local grupoativ 
	
	* Chama o arquivo base 
	local supl 1
	quietly include "`classes_pnad_base'"
}

end
