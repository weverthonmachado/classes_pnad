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
{title:Title}

{phang}
{bf:classes_pnad} {hline 2} Classificações ocupacionais nas PNADs

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:classes_pnad} {it:classificação}{cmd:,} ano({it:integer})


{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{p2coldent :* {cmdab:classificação}} As seguintes classificações ocupacionais podem ser especificadas: {p_end}
{p2coldent :.       {it:egp12}}{cmd: EGP-12: }Esquema de classes Erikson, Goldthorpe e Portocarrero, ou CASMIN, em 12 categorias {p_end}
{p2coldent :.      {it:egp7}}{cmd: EGP-7: }Esquema de classes Erikson, Goldthorpe e Portocarrero, ou CASMIN, em 7 categorias {p_end}
{p2coldent :.      {it:nvs18}}{cmd:  NVS-18: }Esquema de Nelson do Valle Silva em 18 categorias {p_end}

{p2coldent :* {cmdab:ano(}{it:integer}{cmd:)}} Ano da PNAD {p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Descrição}

{phang}
{cmd:classes_pnad} constrói classficações ocupacionais.... Apenas o trabalho principal. Variáveis auxiliares. PNADs 1992-2014. 


{marker remarks}{...}
{title:Classificações ocupacionais}

{it:egp12 egp7}
{phang}
O esquema EGP - de Erikson, Goldthorpe e Portocarrero (1979), também como conhecido como CASMIN, sigla do projeto {it: Comparative Analysis of Social Mobility in Industrial Nations} - é amplamente utilizado em pesquisas internacionais. Ver ainda Contant flux


      10 = "I - Higher-grade Profs & Adm "
      20 = "II - Lower-grade Prof & Adm "
      31 = "IIIa - Higher-grade Routine non-manual"
      32 = "IIIb -Lower-grade Routine non-manual work"                                  
      41 = "IVa - Small proprietors, with employees"
      42 = "IVb - Small proprietors, without employees"
      43 = "IVc2 - Rural Self-employed" 
      44 = "IVc - Rural employers"
      50 = "V - Technicians and superv. manual work"
      60 = "VI - Skilled manual workers"
      71 = "VIIa -Semi- & unskilled manual workers"     
      72 = "VIIb - Agricultural Workers"

{it:nvs}
{phang}
O esquema EGP - de Erikson, Goldthorpe e Portocarrero (1979), também como conhecido como CASMIN, sigla do projeto {it: Comparative Analysis of Social Mobility in Industrial Nations} - é amplamente utilizado em pesquisas internacionais. Ver ainda Contant flux

{it:egps}
{phang}
O esquema EGPS é uma combinação do EGP e do NVS desenvolvida por Ribeiro (2007). Ela parte de 12 classes EGP e distingue indústria tradicional e moderna. 


{marker examples}{...}
{title:Exemplos}

{phang} classes_pnad egp7, ano(2014)

{phang} classes_pnad egp12 nvs egps, ano(1992)


{pstd} Quatro bases de dados serão geradas, uma para cada ano selecionado.


{marker references}{...}
{title:Referências}

{phang}
ERIKSON, Robert; GOLDTHORPE, John H.; PORTOCARERO, Lucienne. Intergenerational Class Mobility in Three Western European Societies: England, France and Sweden. {it:The British Journal of Sociology}, v. 30, n. 4, 1979. 

{phang}
ERIKSON, Robert; GOLDTHORPE, John H. {it:The Constant Flux: A Study of Class Mobility in Industrial Societies}. Oxford: Oxford University Press, 1992. 

{phang}
RIBEIRO, Carlos Antonio Costa. {it:Estrutura de Classe e Mobilidade Social no Brasil}. Bauru: EDUSC, 2007. 

{title:Autor}
{p}

CERES - Centro para o Estudo da Riqueza e Estratificação Social
IESP/UERJ - Instituto de Estudos Sociais e Políticos / Universidade do Estado do Rio de Janeiro
Site {browse "ceres.iesp.uerj.br":ceres.iesp.uerj.br}

{help datazoom_ecinf}
