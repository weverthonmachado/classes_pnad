{smcl}
{* *! version 0.9 01may2016}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "Install command2" "ssc install command2"}{...}
{vieweralsosee "Help command2 (if installed)" "help command2"}{...}
{viewerjumpto "Syntax" "classes_pnad##syntax"}{...}
{viewerjumpto "Description" "classes_pnad##description"}{...}
{viewerjumpto "Options" "classes_pnad##options"}{...}
{viewerjumpto "Examples" "classes_pnad##examples"}{...}
{viewerjumpto "References" "classes_pnad##references"}{...}
{title:T�tulo}

{phang}
{bf:classes_pnad} {hline 2} Classifica��es ocupacionais nas PNADs

{marker syntax}{...}
{title:Syntaxe}

{p 8 17 2}
{cmdab:classes_pnad} {it:classifica��o}{cmd:,} {cmd:ano}({it:integer}) [{cmdab:mob:ilidade}]


{synoptline}
{synoptset 20 tabbed}{...}
{p2coldent :{cmdab:classifica��o}} Uma ou mais das seguintes  {help classes_pnad##remarks:classifica��es}: {p_end}
{p2coldent :       }{cmd: {it:egp12} } {p_end}
{p2coldent :       }{cmd: {it:nvs} } {p_end}
{p2coldent :       }{cmd: {it:egps} } {p_end}

{p2coldent :{cmdab:ano(}{it:integer}{cmd:)}} Ano da pesquisa (formato AAAA). As PNADs de 1981 a 2015 s�o suportadas. {p_end}

{p2coldent : {cmdab:mobilidade}} Cria a(s) classifica��o(�es) selecionada(s) tamb�m para o suplemento de mobilidade ocupacional. Dispon�vel para os anos de 1982, 1988, 1996 e 2014.   {p_end}
{synoptline}

{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Descri��o}

{phang}
{cmd:classes_pnad} constr�i v�rias classifica��es ocupacionais (ou esquemas de classe) para a ocupa��o principal do respondente em todas as PNADs entre 1981 e 2015. A op��o {cmd:mobilidade} gera as classifica��es selecionadas tamb�m para os suplementos de mobilidade ocupacional dos anos de 1982, 1988, 1996 e 2014, em que est�o dispon�veis a primeira ocupa��o, ocupa��o do pai e ocupa��o da m�e. Todas as classifica��es s�o feitas a partir 

{phang}
O comando necessita das seguintes vari�veis, que podem estar em letras mai�sculas ou min�sculas:

      Pesquisa B�sica                                
            1981-1990: 
            1992-2001: {it:v9906, v9907}
            2002-2015: {it:v9906, v9907, v4706, v4808, v4809}
      Suplemento de mobilidade
            1982:
            1988:
            1996:
            2014:         
       
{marker remarks}{...}
{title:Classifica��es ocupacionais dispon�veis}

{it:egp12}
{phang}
Vers�o com 12 categorias do EGP, ou CASMIN, amplamente utilizado em estudos de estratifica��o ao redor do mundo (Erikson, Goldthorpe e Portocarrero, 1979; Erikson e Goldthorpe, 1993). tamb�m como conhecido como CASMIN, sigla do projeto {it: Comparative Analysis of Social Mobility in Industrial Nations} - � amplamente utilizado em pesquisas internacionais. Ver ainda Contant flux


            (10) I  - Higher-grade Profs & Adm "
            (20) II - Lower-grade Prof & Adm "
            (31) IIIa - Higher-grade Routine non-manual"
            (32) IIIb - Lower-grade Routine non-manual work"                                  
            (41) IVa - Small proprietors, with employees"
            (42) IVb - Small proprietors, without employees"
            (43) IVc2 - Rural Self-employed" 
            (44) IVc - Rural employers"
            (50) V - Technicians and superv. manual work"
            (60) VI - Skilled manual workers"
            (71) VIIa - Semi- & unskilled manual workers"     
            (72) VIIb - Agricultural Workers"

{it:nvs}
{phang}
O esquema EGP - de Erikson, Goldthorpe e Portocarrero (1979), tamb�m como conhecido como CASMIN, sigla do projeto {it: Comparative Analysis of Social Mobility in Industrial Nations} - � amplamente utilizado em pesquisas internacionais. Ver ainda Contant flux

            (1)  Profissionais liberais
            (2)  Dirigentes e administradores de alto n�vel
            (3)  Profissionais
            (4)  Fun��es administrativas execu��o
            (5)  N�o-manual de rotina e fun��es de escrit�rio
            (6)  Propriet�rios empregador na ind, com e serv
            (7)  Empres�rios por conta pr�pria sem empregados
            (8)  T�cnicos, artistas e superv do trabalho manual
            (9)  Trabalhadores manuais em ind�strias modernas
            (10) Traba manuais em ind�strias tradicionais
            (11) Trabalhadores manuais em servi�os em geral
            (12) Trabalhadores no servi�o dom�stico
            (13) Vendedores ambulantes
            (14) Artes�os
            (15) Propriet�rios empregadores no setor prim�rio
            (16) T�cnicos e administradores no setor prim�rio
            (17) Produtores agr�colas aut�nomos
            (18) Trabalhadores rurais

{it:egps}
{phang}
Expans�o do esquema EGP com algumas distin��es presentes no NVS, visando maior detalhamento das ocupa��es manuais (Ribeiro, 2007). Possui 16 categorias:

            (100) I - Prof e Adm, n�vel alto
            (200) II - Prof e Adm, n�vel baixo
            (311) IIIa1 - N�o-manual rotina, n�vel alto escrit�rio
            (312) IIIa2 - N�o-manual rotina, n�vel alto supervis�o
            (321) IIIb1 - N�o-manual rotina, n�vel baixo escrit�rio
            (322) IIIb2 - N�o-manual rotina, n�vel baixo servi�os
            (410) IVa - Pequenos Propriet., empregadores
            (420) IVb - Pequenos Propriet., sem empregados
            (430) IVc2 - Pequenos Prop. rurais, sem empregados
            (440) IVc1 - Pequenos Prop. rurais, com empregados
            (500) V - T�cnicos e supervisores do Trab. Manual
            (601) VIa - Trabalhadores Manuais Qualif., Ind. Moderna
            (602) VIb - Trabalhadores Manuais Qualif., Ind. Tradicional
            (603) VIc - Trabalhadores Manuais Qualif., Servi�os
            (711) VIIa1 - Trabalhadores Manuais N�o-qualif., Industria
            (712) VIIa2 - Trabalhadores Manuais N�o-qualif., Servi�os
            (713) VIIa3 - Trabalhadores Manuais N�o-qualif., Serv Domest
            (714) VIIa4 - Trabalhadores Manuais N�o-qualif., Ambulantes
            (720) VIIb - Trabalhadores Manuais Rurais



{marker examples}{...}
{title:Exemplos}

{phang} classes_pnad nvs, ano(1988) 

{phang} classes_pnad egp12 nvs egps, ano(2014) mobilidade

{marker references}{...}
{title:Refer�ncias}

{phang}
ERIKSON, Robert; GOLDTHORPE, John H.; PORTOCARERO, Lucienne. Intergenerational Class Mobility in Three Western European Societies: England, France and Sweden. {it:The British Journal of Sociology}, v. 30, n. 4, 1979. 

{phang}
ERIKSON, Robert; GOLDTHORPE, John H. {it:The Constant Flux: A Study of Class Mobility in Industrial Societies}. Oxford: Oxford University Press, 1992. 

{phang}
RIBEIRO, Carlos Antonio Costa. {it:Estrutura de Classe e Mobilidade Social no Brasil}. Bauru: EDUSC, 2007. 

{title:Autor}
{p}

CERES - Centro para o Estudo da Riqueza e Estratifica��o Social
IESP/UERJ - Instituto de Estudos Sociais e Pol�ticos / Universidade do Estado do Rio de Janeiro
{browse "http://ceres.iesp.uerj.br":ceres.iesp.uerj.br}
{browse "mailto:ceres@ceres.iesp.uerj.br":ceres@ceres.iesp.uerj.br}

Ver tamb�m: {help datazoom_ecinf}
