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
{title:Título}

{phang}
{bf:classes_pnad} {hline 2} Classificações ocupacionais nas PNADs

{marker syntax}{...}
{title:Syntaxe}

{p 8 17 2}
{cmdab:classes_pnad} {it:classificação}{cmd:,} {cmd:ano}({it:integer}) [{cmdab:mob:ilidade}]


{synoptline}
{synoptset 20 tabbed}{...}
{p2coldent :{cmdab:classificação}} Uma ou mais das seguintes  {help classes_pnad##remarks:classificações}: {p_end}
{p2coldent :       }{cmd: {it:egp12} } {p_end}
{p2coldent :       }{cmd: {it:nvs} } {p_end}
{p2coldent :       }{cmd: {it:egps} } {p_end}

{p2coldent :{cmdab:ano(}{it:integer}{cmd:)}} Ano da pesquisa (formato AAAA). As PNADs de 1981 a 2015 são suportadas. {p_end}

{p2coldent : {cmdab:mobilidade}} Cria a(s) classificação(ões) selecionada(s) também para o suplemento de mobilidade ocupacional. Disponível para os anos de 1982, 1988, 1996 e 2014.   {p_end}
{synoptline}

{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Descrição}

{phang}
{cmd:classes_pnad} constrói várias classificações ocupacionais (ou esquemas de classe) para a ocupação principal do respondente em todas as PNADs entre 1981 e 2015. A opção {cmd:mobilidade} gera as classificações selecionadas também para os suplementos de mobilidade ocupacional dos anos de 1982, 1988, 1996 e 2014, em que estão disponíveis a primeira ocupação, ocupação do pai e ocupação da mãe. Todas as classificações são feitas a partir 

{phang}
O comando necessita das seguintes variáveis, que podem estar em letras maiúsculas ou minúsculas:

      Pesquisa Básica                                
            1981-1990: 
            1992-2001: {it:v9906, v9907}
            2002-2015: {it:v9906, v9907, v4706, v4808, v4809}
      Suplemento de mobilidade
            1982:
            1988:
            1996:
            2014:         
       
{marker remarks}{...}
{title:Classificações ocupacionais disponíveis}

{it:egp12}
{phang}
Versão com 12 categorias do EGP, ou CASMIN, amplamente utilizado em estudos de estratificação ao redor do mundo (Erikson, Goldthorpe e Portocarrero, 1979; Erikson e Goldthorpe, 1993). também como conhecido como CASMIN, sigla do projeto {it: Comparative Analysis of Social Mobility in Industrial Nations} - é amplamente utilizado em pesquisas internacionais. Ver ainda Contant flux


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
O esquema EGP - de Erikson, Goldthorpe e Portocarrero (1979), também como conhecido como CASMIN, sigla do projeto {it: Comparative Analysis of Social Mobility in Industrial Nations} - é amplamente utilizado em pesquisas internacionais. Ver ainda Contant flux

            (1)  Profissionais liberais
            (2)  Dirigentes e administradores de alto nível
            (3)  Profissionais
            (4)  Funções administrativas execução
            (5)  Não-manual de rotina e funções de escritório
            (6)  Proprietários empregador na ind, com e serv
            (7)  Empresários por conta própria sem empregados
            (8)  Técnicos, artistas e superv do trabalho manual
            (9)  Trabalhadores manuais em indústrias modernas
            (10) Traba manuais em indústrias tradicionais
            (11) Trabalhadores manuais em serviços em geral
            (12) Trabalhadores no serviço doméstico
            (13) Vendedores ambulantes
            (14) Artesãos
            (15) Proprietários empregadores no setor primário
            (16) Técnicos e administradores no setor primário
            (17) Produtores agrícolas autônomos
            (18) Trabalhadores rurais

{it:egps}
{phang}
Expansão do esquema EGP com algumas distinções presentes no NVS, visando maior detalhamento das ocupações manuais (Ribeiro, 2007). Possui 16 categorias:

            (100) I - Prof e Adm, nível alto
            (200) II - Prof e Adm, nível baixo
            (311) IIIa1 - Não-manual rotina, nível alto escritório
            (312) IIIa2 - Não-manual rotina, nível alto supervisão
            (321) IIIb1 - Não-manual rotina, nível baixo escritório
            (322) IIIb2 - Não-manual rotina, nível baixo serviços
            (410) IVa - Pequenos Propriet., empregadores
            (420) IVb - Pequenos Propriet., sem empregados
            (430) IVc2 - Pequenos Prop. rurais, sem empregados
            (440) IVc1 - Pequenos Prop. rurais, com empregados
            (500) V - Técnicos e supervisores do Trab. Manual
            (601) VIa - Trabalhadores Manuais Qualif., Ind. Moderna
            (602) VIb - Trabalhadores Manuais Qualif., Ind. Tradicional
            (603) VIc - Trabalhadores Manuais Qualif., Serviços
            (711) VIIa1 - Trabalhadores Manuais Não-qualif., Industria
            (712) VIIa2 - Trabalhadores Manuais Não-qualif., Serviços
            (713) VIIa3 - Trabalhadores Manuais Não-qualif., Serv Domest
            (714) VIIa4 - Trabalhadores Manuais Não-qualif., Ambulantes
            (720) VIIb - Trabalhadores Manuais Rurais



{marker examples}{...}
{title:Exemplos}

{phang} classes_pnad nvs, ano(1988) 

{phang} classes_pnad egp12 nvs egps, ano(2014) mobilidade

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
{browse "http://ceres.iesp.uerj.br":ceres.iesp.uerj.br}
{browse "mailto:ceres@ceres.iesp.uerj.br":ceres@ceres.iesp.uerj.br}

Ver também: {help datazoom_ecinf}
