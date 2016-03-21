/*---------------------------------------------------------------------		
/// Define classes EGP e NVS

/// Weverthon Machado

Versão 0.9
Última alteração: 20/03/2016
---------------------------------------------------------------------*/
capture program drop classes_pnad
program define classes_pnad
version 12

syntax [namelist], ANO(integer)


*********************************************************************
* 0 - Configurações
*********************************************************************

* Processando argumentos
if "`namelist'" == "" {  /* Se nenhuma especificada, gera todas */
	local egp12 egp12
	local egp7 egp7
	local nvs18 nvs18
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
			di "Erro: ``x'' não é uma classificação válida."
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



* Dando conta de letras maiusculas e minusculas
if `ano'>1990 {
	capture confirm variable v9906, exact
	if _rc!=0 {
		capture confirm variable V9906, exact
		if _rc==0 {
			local v9906 V9906
		}
	} 
	else {
		local v9906 v9906
	}
}

if `ano'>2001 {
	capture confirm variable v9907 v4706 v4808 v4809, exact
	if _rc!=0 {
		capture confirm variable V9907 V4706 V4808 V4809, exact
		if _rc==0 {
			local v9907 V9907
			local v4706 V4706
			local v4808 V4808
			local v4809 V4809
		}
		else {
			di "Erro: Variáveis auxiliares não encontradas. Verifique o ano da pesquisa."
		}
	} 
	else {
			local v9907 v9907
			local v4706 v4706
			local v4808 v4808
			local v4809 v4809
	}
}


*********************************************************************
* 1 - Pós-2002
*********************************************************************

if `ano'>2001 {
	quietly {

	/*--------------------------------------------------------------------
	- 1.1 Atividade econômica do empreendimento
	---------------------------------------------------------------------*/
	
	tempvar ind
	gen `ind'=`v9907'

	replace `ind' = 7 if `v9907' >= 1101 & `v9907' <= 1500		
	replace `ind' = 7 if `v9907' == 2001 | `v9907' == 2002		
	replace `ind' = 7 if `v9907' == 5001 | `v9907' == 5002		
	replace `ind' = 2 if `v9907' >= 15010 & `v9907' <= 15055 // modificação: troquei 15050 por 15055, incluindo `ind'. de bebidas - WM
	replace `ind' = 2 if `v9907' >= 45005 & `v9907' <= 45999
	replace `ind' = 2 if `v9907' >= 40010 & `v9907' <= 40020
	replace `ind' = 2 if `v9907' == 41000		
	replace `ind' = 2 if `v9907' == 16000		
	replace `ind' = 2 if `v9907' >= 17001 & `v9907' <= 17002		
	replace `ind' = 2 if `v9907' >= 18001 & `v9907' <= 18002		
	replace `ind' = 2 if `v9907' >= 19011 & `v9907' <= 19020		
	replace `ind' = 2 if `v9907' == 20000		
	replace `ind' = 2 if `v9907' == 22000		
	replace `ind' = 2 if `v9907' >= 21001 & `v9907' <= 21002		
	replace `ind' = 2 if `v9907' >= 28001 & `v9907' <= 28002		
	replace `ind' = 2 if `v9907' >= 36010 & `v9907' <= 36090		
	replace `ind' = 1 if `v9907' >= 23010 & `v9907' <= 23400		
	replace `ind' = 1 if `v9907' >= 24010 & `v9907' <= 24090
	replace `ind' = 1 if `v9907' >= 25010 & `v9907' <= 25020
	replace `ind' = 1 if `v9907' >= 27001 & `v9907' <= 27003
	replace `ind' = 1 if `v9907' >= 29001 & `v9907' <= 29002
	replace `ind' = 1 if `v9907' == 30000
	replace `ind' = 1 if `v9907' == 32000
	replace `ind' = 1 if `v9907' >= 31001 & `v9907' <= 31002
	replace `ind' = 1 if `v9907' >= 33001 & `v9907' <= 33005
	replace `ind' = 1 if `v9907' >= 34001 & `v9907' <= 34003
	replace `ind' = 6 if `v9907' >= 26010 & `v9907' <= 26092
	replace `ind' = 6 if `v9907' >= 13001 & `v9907' <= 13002
	replace `ind' = 6 if `v9907' == 10000
	replace `ind' = 6 if `v9907' == 11000
	replace `ind' = 6 if `v9907' == 12000
	replace `ind' = 6 if `v9907' >= 130010 & `v9907' <= 13002
	replace `ind' = 6 if `v9907' >= 14001 & `v9907' <= 14004
	replace `ind' = 5 if `v9907' >= 75011 & `v9907' <= 75020
	replace `ind' = 4 if `v9907' == 95000
	replace `ind' = 3 if `v9907' >= 35010 & `v9907' <= 35090
	replace `ind' = 3 if `v9907' == 37000
	replace `ind' = 3 if `v9907' == 61000
	replace `ind' = 3 if `v9907' == 62000
	replace `ind' = 3 if `v9907' == 90000
	replace `ind' = 3 if `v9907' == 65000
	replace `ind' = 3 if `v9907' == 66000
	replace `ind' = 3 if `v9907' == 99000
	replace `ind' = 3 if `v9907' == 73000
	replace `ind' = 3 if `v9907' >= 50010 & `v9907' <= 50050
	replace `ind' = 3 if `v9907' >= 53010 & `v9907' <= 53113
	replace `ind' = 3 if `v9907' >= 55010 & `v9907' <= 55030
	replace `ind' = 3 if `v9907' >= 60010 & `v9907' <= 60092
	replace `ind' = 3 if `v9907' >= 63010 & `v9907' <= 63030
	replace `ind' = 3 if `v9907' >= 64010 & `v9907' <= 64020
	replace `ind' = 3 if `v9907' >= 80011 & `v9907' <= 80090
	replace `ind' = 3 if `v9907' >= 85011 & `v9907' <= 85030
	replace `ind' = 3 if `v9907' >= 91010 & `v9907' <= 91092
	replace `ind' = 3 if `v9907' >= 92010 & `v9907' <= 92040
	replace `ind' = 3 if `v9907' >= 93010 & `v9907' <= 93092
	replace `ind' = 3 if `v9907' >= 67010 & `v9907' <= 67020
	replace `ind' = 3 if `v9907' >= 70001 & `v9907' <= 70002
	replace `ind' = 3 if `v9907' >= 71010 & `v9907' <= 71030
	replace `ind' = 3 if `v9907' >= 72010 & `v9907' <= 72020
	replace `ind' = 3 if `v9907' >= 74011 & `v9907' <= 74090
	replace `ind' = .a if `v9907' == 99888   // alternativa a colocar 99 como user missing 
	replace `ind' = .a if `v9907' == 99999

	#delimit ;
	capture label define industria
	1 "industria moderna"
	2 "industria tradicional"
	3 "serviços"
	4 "serviço doméstico"
	5 "administração pública"
	6 "extração mineral"
	7 "agricultura e pesca."
	;
	#delimit cr

	lab val `ind' industria


	/*--------------------------------------------------------------------
	- 1.2 Conversão CBO-Domiciliar > `ibge90'
	---------------------------------------------------------------------*/
	tempvar ibge90
	gen `ibge90'=.

	replace `ibge90' = 861 if `v9906' == 401                                                                       
	replace `ibge90' = 861 if `v9906' == 402                                                                       
	replace `ibge90' = 861 if `v9906' == 403                                                                       
	replace `ibge90' = 861 if `v9906' == 411                                                                       
	replace `ibge90' = 862 if `v9906' == 413                                                                       
	replace `ibge90' = 863 if `v9906' == 501                                                                       
	replace `ibge90' = 863 if `v9906' == 502                                                                       
	replace `ibge90' = 863 if `v9906' == 503                                                                       
	replace `ibge90' = 863 if `v9906' == 511                                                                       
	replace `ibge90' = 863 if `v9906' == 512                                                                       
	replace `ibge90' = 863 if `v9906' == 513                                                                       
	replace `ibge90' = 20 if `v9906' == 1111                                                                       
	replace `ibge90' = 20 if `v9906' == 1112                                                                       
	replace `ibge90' = 231 if `v9906' == 1113                                                                       
	replace `ibge90' = 20 if `v9906' == 1122
	replace `ibge90' = 21 if `v9906' == 1123
	replace `ibge90' = 927 if `v9906' == 1130
	replace `ibge90' = 39 if `v9906' == 1140
	replace `ibge90' = 64 if `v9906' == 2012
	replace `ibge90' = 101 if `v9906' == 2021
	replace `ibge90' = 173 if `v9906' == 2121
	replace `ibge90' = 173 if `v9906' == 2122
	replace `ibge90' = 173 if `v9906' == 2124
	replace `ibge90' = 173 if `v9906' == 2125
	replace `ibge90' = 123 if `v9906' == 2131
	replace `ibge90' = 101 if `v9906' == 2140
	replace `ibge90' = 102 if `v9906' == 2141
	replace `ibge90' = 101 if `v9906' == 2142
	replace `ibge90' = 101 if `v9906' == 2143
	replace `ibge90' = 101 if `v9906' == 2144
	replace `ibge90' = 101 if `v9906' == 2149
	replace `ibge90' = 721 if `v9906' == 2152
	replace `ibge90' = 151 if `v9906' == 2231
	replace `ibge90' = 152 if `v9906' == 2232
	replace `ibge90' = 144 if `v9906' == 2233
	replace `ibge90' = 153 if `v9906' == 2235
	replace `ibge90' = 154 if `v9906' == 2237
	replace `ibge90' = 217 if `v9906' == 2311
	replace `ibge90' = 214 if `v9906' == 2313
	replace `ibge90' = 213 if `v9906' == 2321
	replace `ibge90' = 834 if `v9906' == 2391
	replace `ibge90' = 219 if `v9906' == 2392
	replace `ibge90' = 221 if `v9906' == 2394
	replace `ibge90' = 233 if `v9906' == 2410
	replace `ibge90' = 232 if `v9906' == 2412
	replace `ibge90' = 293 if `v9906' == 2419
	replace `ibge90' = 864 if `v9906' == 2423
	replace `ibge90' = 201 if `v9906' == 2511
	replace `ibge90' = 205 if `v9906' == 2514
	replace `ibge90' = 202 if `v9906' == 2515
	replace `ibge90' = 59 if `v9906' == 2523
	replace `ibge90' = 64 if `v9906' == 2524
	replace `ibge90' = 64 if `v9906' == 2525
	replace `ibge90' = 291 if `v9906' == 2612
	replace `ibge90' = 276 if `v9906' == 2622
	replace `ibge90' = 273 if `v9906' == 2627
	replace `ibge90' = 402 if `v9906' == 3001
	replace `ibge90' = 402 if `v9906' == 3003
	replace `ibge90' = 402 if `v9906' == 3012
	replace `ibge90' = 131 if `v9906' == 3112
	replace `ibge90' = 402 if `v9906' == 3113
	replace `ibge90' = 131 if `v9906' == 3114
	replace `ibge90' = 112 if `v9906' == 3122
	replace `ibge90' = 503 if `v9906' == 3132
	replace `ibge90' = 402 if `v9906' == 3136
	replace `ibge90' = 402 if `v9906' == 3137
	replace `ibge90' = 402 if `v9906' == 3142
	replace `ibge90' = 425 if `v9906' == 3144
	replace `ibge90' = 113 if `v9906' == 3162
	replace `ibge90' = 58 if `v9906' == 3171
	replace `ibge90' = 403 if `v9906' == 3191
	replace `ibge90' = 402 if `v9906' == 3192
	replace `ibge90' = 402 if `v9906' == 3201
	replace `ibge90' = 302 if `v9906' == 3210
	replace `ibge90' = 302 if `v9906' == 3212
	replace `ibge90' = 302 if `v9906' == 3213
	replace `ibge90' = 302 if `v9906' == 3214
	replace `ibge90' = 164 if `v9906' == 3223
	replace `ibge90' = 167 if `v9906' == 3224
	replace `ibge90' = 144 if `v9906' == 3231
	replace `ibge90' = 144 if `v9906' == 3232
	replace `ibge90' = 165 if `v9906' == 3241
	replace `ibge90' = 168 if `v9906' == 3242
	replace `ibge90' = 927 if `v9906' == 3281
	replace `ibge90' = 218 if `v9906' == 3313
	replace `ibge90' = 218 if `v9906' == 3322
	replace `ibge90' = 711 if `v9906' == 3411
	replace `ibge90' = 402 if `v9906' == 3421
	replace `ibge90' = 64 if `v9906' == 3422
	replace `ibge90' = 643 if `v9906' == 3531
	replace `ibge90' = 53 if `v9906' == 3532
	replace `ibge90' = 644 if `v9906' == 3544
	replace `ibge90' = 641 if `v9906' == 3545
	replace `ibge90' = 642 if `v9906' == 3546
	replace `ibge90' = 643 if `v9906' == 3547
	replace `ibge90' = 645 if `v9906' == 3548
	replace `ibge90' = 402 if `v9906' == 3713
	replace `ibge90' = 280 if `v9906' == 3721
	replace `ibge90' = 274 if `v9906' == 3722
	replace `ibge90' = 282 if `v9906' == 3731
	replace `ibge90' = 282 if `v9906' == 3732
	replace `ibge90' = 281 if `v9906' == 3741
	replace `ibge90' = 283 if `v9906' == 3743
	replace `ibge90' = 276 if `v9906' == 3761
	replace `ibge90' = 834 if `v9906' == 3771
	replace `ibge90' = 833 if `v9906' == 3773
	replace `ibge90' = 845 if `v9906' == 4123
	replace `ibge90' = 64 if `v9906' == 4214
	replace `ibge90' = 774 if `v9906' == 4222
	replace `ibge90' = 774 if `v9906' == 4223
	replace `ibge90' = 64 if `v9906' == 4231
	replace `ibge90' = 825 if `v9906' == 5102
	replace `ibge90' = 741 if `v9906' == 5112
	replace `ibge90' = 801 if `v9906' == 5121
	replace `ibge90' = 927 if `v9906' == 5166
	replace `ibge90' = 927 if `v9906' == 5191
	replace `ibge90' = 927 if `v9906' == 5198
	replace `ibge90' = 604 if `v9906' == 5221
	replace `ibge90' = 304 if `v9906' == 6210
	replace `ibge90' = 331 if `v9906' == 6329
	replace `ibge90' = 303 if `v9906' == 6410
	replace `ibge90' = 303 if `v9906' == 6420
	replace `ibge90' = 303 if `v9906' == 6430
	replace `ibge90' = 521 if `v9906' == 7151
	replace `ibge90' = 521 if `v9906' == 7154
	replace `ibge90' = 482 if `v9906' == 7155
	replace `ibge90' = 518 if `v9906' == 7163
	replace `ibge90' = 516 if `v9906' == 7165
	replace `ibge90' = 402 if `v9906' == 7202
	replace `ibge90' = 413 if `v9906' == 7224
	replace `ibge90' = 411 if `v9906' == 7231
	replace `ibge90' = 427 if `v9906' == 7242
	replace `ibge90' = 426 if `v9906' == 7243
	replace `ibge90' = 927 if `v9906' == 7246
	replace `ibge90' = 423 if `v9906' == 7252
	replace `ibge90' = 423 if `v9906' == 7253
	replace `ibge90' = 423 if `v9906' == 7254
	replace `ibge90' = 423 if `v9906' == 7255
	replace `ibge90' = 423 if `v9906' == 7257
	replace `ibge90' = 503 if `v9906' == 7301
	replace `ibge90' = 402 if `v9906' == 7401
	replace `ibge90' = 589 if `v9906' == 7421
	replace `ibge90' = 402 if `v9906' == 7501
	replace `ibge90' = 402 if `v9906' == 7502
	replace `ibge90' = 561 if `v9906' == 7521
	replace `ibge90' = 561 if `v9906' == 7522
	replace `ibge90' = 562 if `v9906' == 7523
	replace `ibge90' = 402 if `v9906' == 7602
	replace `ibge90' = 402 if `v9906' == 7604
	replace `ibge90' = 462 if `v9906' == 7620
	replace `ibge90' = 462 if `v9906' == 7621
	replace `ibge90' = 462 if `v9906' == 7623
	replace `ibge90' = 478 if `v9906' == 7642
	replace `ibge90' = 478 if `v9906' == 7643
	replace `ibge90' = 461 if `v9906' == 7651
	replace `ibge90' = 589 if `v9906' == 7654
	replace `ibge90' = 554 if `v9906' == 7660
	replace `ibge90' = 274 if `v9906' == 7664
	replace `ibge90' = 474 if `v9906' == 7682
	replace `ibge90' = 486 if `v9906' == 7732
	replace `ibge90' = 484 if `v9906' == 7735
	replace `ibge90' = 482 if `v9906' == 7771
	replace `ibge90' = 482 if `v9906' == 7772
	replace `ibge90' = 589 if `v9906' == 7811
	replace `ibge90' = 589 if `v9906' == 7813
	replace `ibge90' = 927 if `v9906' == 7817
	replace `ibge90' = 751 if `v9906' == 7820
	replace `ibge90' = 751 if `v9906' == 7824
	replace `ibge90' = 402 if `v9906' == 8101
	replace `ibge90' = 402 if `v9906' == 8102
	replace `ibge90' = 402 if `v9906' == 8103
	replace `ibge90' = 589 if `v9906' == 8110
	replace `ibge90' = 589 if `v9906' == 8114
	replace `ibge90' = 589 if `v9906' == 8115
	replace `ibge90' = 927 if `v9906' == 8131
	replace `ibge90' = 402 if `v9906' == 8201
	replace `ibge90' = 402 if `v9906' == 8202
	replace `ibge90' = 402 if `v9906' == 8301
	replace `ibge90' = 585 if `v9906' == 8321
	replace `ibge90' = 585 if `v9906' == 8339
	replace `ibge90' = 545 if `v9906' == 8401
	replace `ibge90' = 545 if `v9906' == 8412
	replace `ibge90' = 539 if `v9906' == 8413
	replace `ibge90' = 580 if `v9906' == 8423
	replace `ibge90' = 580 if `v9906' == 8429
	replace `ibge90' = 509 if `v9906' == 8611
	replace `ibge90' = 509 if `v9906' == 8612
	replace `ibge90' = 922 if `v9906' == 8622
	replace `ibge90' = 923 if `v9906' == 8624
	replace `ibge90' = 923 if `v9906' == 8625
	replace `ibge90' = 927 if `v9906' == 8711
	replace `ibge90' = 402 if `v9906' == 9109
	replace `ibge90' = 425 if `v9906' == 9111
	replace `ibge90' = 425 if `v9906' == 9112
	replace `ibge90' = 424 if `v9906' == 9141
	replace `ibge90' = 425 if `v9906' == 9142
	replace `ibge90' = 424 if `v9906' == 9143
	replace `ibge90' = 425 if `v9906' == 9151
	replace `ibge90' = 589 if `v9906' == 9152
	replace `ibge90' = 425 if `v9906' == 9153
	replace `ibge90' = 425 if `v9906' == 9154
	replace `ibge90' = 921 if `v9906' == 9191
	replace `ibge90' = 425 if `v9906' == 9192
	replace `ibge90' = 402 if `v9906' == 9501
	replace `ibge90' = 402 if `v9906' == 9502
	replace `ibge90' = 402 if `v9906' == 9503
	replace `ibge90' = 506 if `v9906' == 9513                                                                                                                                                       
	replace `ibge90' = 506 if `v9906' == 9531                                                                                                                                                       
	replace `ibge90' = 503 if `v9906' == 9541                                                                                                                                                       
	replace `ibge90' = 425 if `v9906' == 9543                                                                                                                                                       
	replace `ibge90' = 762 if `v9906' == 9911                                                                                                                                                       
	replace `ibge90' = 425 if `v9906' == 9912                                                                                                                                                       
	replace `ibge90' = 521 if `v9906' == 9914                                                                                                                                                       
	replace `ibge90' = 574 if `v9906' == 9921                                                                                                                                                       
	replace `ibge90' = 925 if `v9906' == 9922                                                                                                                                                       
	replace `ibge90' = 928 if `v9906' == 9988                                                                                                                                                       
	replace `ibge90' = 928 if `v9906' == 9999                                                                                                                                                                                                                                                                                                                       
	replace `ibge90' = 861 if `v9906' == 100                                                                                                                                                       
	replace `ibge90' = 862 if `v9906' == 200                                                                                                                                                       
	replace `ibge90' = 861 if `v9906' == 300                                                                                                                                                       
	replace `ibge90' = 862 if `v9906' == 412                                                                                                                                                       
	replace `ibge90' = 21 if `v9906' == 1210
	replace `ibge90' = 8 if `v9906' == 1219
	replace `ibge90' = 21 if `v9906' == 1220
	replace `ibge90' = 34 if `v9906' == 1230
	replace `ibge90' = 33 if `v9906' == 1310
	replace `ibge90' = 33 if `v9906' == 1320
	replace `ibge90' = 101 if `v9906' == 2011
	replace `ibge90' = 171 if `v9906' == 2111
	replace `ibge90' = 172 if `v9906' == 2112
	replace `ibge90' = 173 if `v9906' == 2123
	replace `ibge90' = 121 if `v9906' == 2132
	replace `ibge90' = 125 if `v9906' == 2133
	replace `ibge90' = 124 if `v9906' == 2134
	replace `ibge90' = 101 if `v9906' == 2145
	replace `ibge90' = 101 if `v9906' == 2146
	replace `ibge90' = 124 if `v9906' == 2147
	replace `ibge90' = 103 if `v9906' == 2148
	replace `ibge90' = 721 if `v9906' == 2151
	replace `ibge90' = 711 if `v9906' == 2153
	replace `ibge90' = 143 if `v9906' == 2211
	replace `ibge90' = 141 if `v9906' == 2221
	replace `ibge90' = 122 if `v9906' == 2234
	replace `ibge90' = 163 if `v9906' == 2236
	replace `ibge90' = 215 if `v9906' == 2312
	replace `ibge90' = 218 if `v9906' == 2330
	replace `ibge90' = 211 if `v9906' == 2340
	replace `ibge90' = 231 if `v9906' == 2421
	replace `ibge90' = 233 if `v9906' == 2422
	replace `ibge90' = 181 if `v9906' == 2512
	replace `ibge90' = 205 if `v9906' == 2513
	replace `ibge90' = 204 if `v9906' == 2516
	replace `ibge90' = 183 if `v9906' == 2521
	replace `ibge90' = 182 if `v9906' == 2522
	replace `ibge90' = 645 if `v9906' == 2531
	replace `ibge90' = 261 if `v9906' == 2611
	replace `ibge90' = 292 if `v9906' == 2613
	replace `ibge90' = 293 if `v9906' == 2614
	replace `ibge90' = 261 if `v9906' == 2615
	replace `ibge90' = 261 if `v9906' == 2616
	replace `ibge90' = 278 if `v9906' == 2617
	replace `ibge90' = 279 if `v9906' == 2621
	replace `ibge90' = 276 if `v9906' == 2623
	replace `ibge90' = 275 if `v9906' == 2624
	replace `ibge90' = 271 if `v9906' == 2625
	replace `ibge90' = 251 if `v9906' == 2631
	replace `ibge90' = 131 if `v9906' == 3011
	replace `ibge90' = 131 if `v9906' == 3111
	replace `ibge90' = 405 if `v9906' == 3115
	replace `ibge90' = 403 if `v9906' == 3116
	replace `ibge90' = 403 if `v9906' == 3117
	replace `ibge90' = 112 if `v9906' == 3121
	replace `ibge90' = 113 if `v9906' == 3123
	replace `ibge90' = 503 if `v9906' == 3131
	replace `ibge90' = 505 if `v9906' == 3134
	replace `ibge90' = 507 if `v9906' == 3135
	replace `ibge90' = 425 if `v9906' == 3141
	replace `ibge90' = 425 if `v9906' == 3143
	replace `ibge90' = 402 if `v9906' == 3146
	replace `ibge90' = 402 if `v9906' == 3147
	replace `ibge90' = 401 if `v9906' == 3161
	replace `ibge90' = 401 if `v9906' == 3163
	replace `ibge90' = 58 if `v9906' == 3172
	replace `ibge90' = 111 if `v9906' == 3189
	replace `ibge90' = 302 if `v9906' == 3211
	replace `ibge90' = 154 if `v9906' == 3221                                                       
	replace `ibge90' = 162 if `v9906' == 3222                                                       
	replace `ibge90' = 163 if `v9906' == 3225                                                       
	replace `ibge90' = 121 if `v9906' == 3250                                                       
	replace `ibge90' = 132 if `v9906' == 3251                                                       
	replace `ibge90' = 402 if `v9906' == 3252                                                       
	replace `ibge90' = 168 if `v9906' == 3253                                                       
	replace `ibge90' = 217 if `v9906' == 3311                                                       
	replace `ibge90' = 217 if `v9906' == 3312                                                       
	replace `ibge90' = 217 if `v9906' == 3321                                                       
	replace `ibge90' = 219 if `v9906' == 3331                                                       
	replace `ibge90' = 222 if `v9906' == 3341                                                       
	replace `ibge90' = 722 if `v9906' == 3412                                                       
	replace `ibge90' = 506 if `v9906' == 3413                                                       
	replace `ibge90' = 761 if `v9906' == 3423                                                       
	replace `ibge90' = 741 if `v9906' == 3424                                                       
	replace `ibge90' = 761 if `v9906' == 3425                                                                       
	replace `ibge90' = 721 if `v9906' == 3426                                                                       
	replace `ibge90' = 182 if `v9906' == 3511                                                                       
	replace `ibge90' = 192 if `v9906' == 3512                                                                       
	replace `ibge90' = 183 if `v9906' == 3513                                                                       
	replace `ibge90' = 242 if `v9906' == 3514                                                                       
	replace `ibge90' = 50 if `v9906' == 3515                                                                       
	replace `ibge90' = 51 if `v9906' == 3516                                                                       
	replace `ibge90' = 641 if `v9906' == 3517                                                                       
	replace `ibge90' = 864 if `v9906' == 3518                                                                       
	replace `ibge90' = 917 if `v9906' == 3522                                                                       
	replace `ibge90' = 918 if `v9906' == 3523                                                                       
	replace `ibge90' = 64 if `v9906' == 3524                                                                       
	replace `ibge90' = 51 if `v9906' == 3525                                                                       
	replace `ibge90' = 645 if `v9906' == 3541                                                                       
	replace `ibge90' = 646 if `v9906' == 3542                                                                       
	replace `ibge90' = 632 if `v9906' == 3543                                                                       
	replace `ibge90' = 291 if `v9906' == 3711                                                                       
	replace `ibge90' = 292 if `v9906' == 3712                                                                       
	replace `ibge90' = 773 if `v9906' == 3723                                                                       
	replace `ibge90' = 281 if `v9906' == 3742                                                                       
	replace `ibge90' = 273 if `v9906' == 3751                                                                       
	replace `ibge90' = 275 if `v9906' == 3762                                                                       
	replace `ibge90' = 277 if `v9906' == 3763                                                                       
	replace `ibge90' = 276 if `v9906' == 3764                                                                       
	replace `ibge90' = 927 if `v9906' == 3765                                                                       
	replace `ibge90' = 831 if `v9906' == 3772                                                                       
	replace `ibge90' = 571 if `v9906' == 3911                                                                       
	replace `ibge90' = 571 if `v9906' == 3912                                                                       
	replace `ibge90' = 40 if `v9906' == 4101                                                                       
	replace `ibge90' = 40 if `v9906' == 4102                                                                       
	replace `ibge90' = 64 if `v9906' == 4110                                                                       
	replace `ibge90' = 59 if `v9906' == 4121                                                                       
	replace `ibge90' = 56 if `v9906' == 4122                                                                       
	replace `ibge90' = 64 if `v9906' == 4131                                                                       
	replace `ibge90' = 64 if `v9906' == 4132                                                                       
	replace `ibge90' = 54 if `v9906' == 4141                                                                       
	replace `ibge90' = 64 if `v9906' == 4142                                                                       
	replace `ibge90' = 64 if `v9906' == 4151                                                                       
	replace `ibge90' = 775 if `v9906' == 4152                                                                       
	replace `ibge90' = 193 if `v9906' == 4201                                                                       
	replace `ibge90' = 603 if `v9906' == 4211                                                                       
	replace `ibge90' = 53 if `v9906' == 4212                                                                       
	replace `ibge90' = 927 if `v9906' == 4213                                                                       
	replace `ibge90' = 63 if `v9906' == 4221                                                                       
	replace `ibge90' = 192 if `v9906' == 4241                                                                       
	replace `ibge90' = 841 if `v9906' == 5101                                                                       
	replace `ibge90' = 913 if `v9906' == 5103                                                                       
	replace `ibge90' = 712 if `v9906' == 5111                                                                       
	*replace `ibge90' = 752 if `v9906' == 5112    cód. 5112 já convertido pra 741 acima, dá no mesmo - WM                                                                 
	replace `ibge90' = 927 if `v9906' == 5114                                                                       
	replace `ibge90' = 801 if `v9906' == 5121                                                                       
	replace `ibge90' = 816 if `v9906' == 5131                                                                       
	replace `ibge90' = 813 if `v9906' == 5132                                                                       
	replace `ibge90' = 816 if `v9906' == 5133                                                                       
	replace `ibge90' = 815 if `v9906' == 5134                                                                       
	replace `ibge90' = 844 if `v9906' == 5141                                                                       
	replace `ibge90' = 844 if `v9906' == 5142                                                                       
	replace `ibge90' = 166 if `v9906' == 5151                                                                       
	replace `ibge90' = 162 if `v9906' == 5152                                                                       
	replace `ibge90' = 821 if `v9906' == 5161                                                                       
	replace `ibge90' = 926 if `v9906' == 5162                                                                       
	replace `ibge90' = 802 if `v9906' == 5165                                                                       
	replace `ibge90' = 927 if `v9906' == 5167                                                                       
	replace `ibge90' = 825 if `v9906' == 5169                                                                       
	replace `ibge90' = 913 if `v9906' == 5171                                                                       
	replace `ibge90' = 866 if `v9906' == 5172                                                                       
	replace `ibge90' = 869 if `v9906' == 5173                                                                       
	replace `ibge90' = 843 if `v9906' == 5174                                                                       
	replace `ibge90' = 927 if `v9906' == 5192                                                                       
	replace `ibge90' = 927 if `v9906' == 5199                                                                       
	replace `ibge90' = 35 if `v9906' == 5201                                                                       
	replace `ibge90' = 602 if `v9906' == 5211                                                                       
	replace `ibge90' = 506 if `v9906' == 5231                                                                       
	replace `ibge90' = 617 if `v9906' == 5241                                                                       
	replace `ibge90' = 611 if `v9906' == 5242                                                                       
	replace `ibge90' = 613 if `v9906' == 5243                                                                       
	replace `ibge90' = 301 if `v9906' == 6110                                                                       
	replace `ibge90' = 304 if `v9906' == 6129                                                                       
	replace `ibge90' = 301 if `v9906' == 6139                                                                       
	replace `ibge90' = 304 if `v9906' == 6201                                                       
	replace `ibge90' = 304 if `v9906' == 6229                                                       
	replace `ibge90' = 304 if `v9906' == 6239                                                       
	replace `ibge90' = 331 if `v9906' == 6301                                                       
	replace `ibge90' = 305 if `v9906' == 6319                                                       
	replace `ibge90' = 401 if `v9906' == 7101                                                       
	replace `ibge90' = 404 if `v9906' == 7102                                                       
	replace `ibge90' = 341 if `v9906' == 7111                                                       
	replace `ibge90' = 351 if `v9906' == 7112                                                       
	replace `ibge90' = 391 if `v9906' == 7113                                                       
	replace `ibge90' = 381 if `v9906' == 7114                                                       
	replace `ibge90' = 351 if `v9906' == 7121                                                       
	replace `ibge90' = 578 if `v9906' == 7122                                                       
	replace `ibge90' = 512 if `v9906' == 7152                                                       
	replace `ibge90' = 511 if `v9906' == 7153                                                       
	replace `ibge90' = 506 if `v9906' == 7156                                                       
	replace `ibge90' = 519 if `v9906' == 7157                                                       
	replace `ibge90' = 512 if `v9906' == 7161                                                       
	replace `ibge90' = 519 if `v9906' == 7162                                                       
	replace `ibge90' = 515 if `v9906' == 7164                                                       
	replace `ibge90' = 514 if `v9906' == 7166                                                       
	replace `ibge90' = 513 if `v9906' == 7170                                                       
	replace `ibge90' = 402 if `v9906' == 7201                                                       
	replace `ibge90' = 418 if `v9906' == 7211                                                       
	replace `ibge90' = 417 if `v9906' == 7212                                                       
	replace `ibge90' = 417 if `v9906' == 7213                                                       
	replace `ibge90' = 416 if `v9906' == 7214                                                       
	replace `ibge90' = 422 if `v9906' == 7215                                                       
	replace `ibge90' = 429 if `v9906' == 7221                                                       
	replace `ibge90' = 411 if `v9906' == 7222                                                       
	replace `ibge90' = 414 if `v9906' == 7223                                                       
	replace `ibge90' = 415 if `v9906' == 7232                                                       
	replace `ibge90' = 581 if `v9906' == 7233                                                       
	replace `ibge90' = 517 if `v9906' == 7241                                                       
	replace `ibge90' = 428 if `v9906' == 7244                                                       
	replace `ibge90' = 428 if `v9906' == 7245                                                       
	replace `ibge90' = 423 if `v9906' == 7250                                                       
	replace `ibge90' = 423 if `v9906' == 7251                                                       
	replace `ibge90' = 423 if `v9906' == 7256                                                       
	replace `ibge90' = 501 if `v9906' == 7311                                                       
	replace `ibge90' = 504 if `v9906' == 7312                                                       
	replace `ibge90' = 507 if `v9906' == 7313                                                       
	replace `ibge90' = 501 if `v9906' == 7321                                                       
	replace `ibge90' = 423 if `v9906' == 7411                                                       
	replace `ibge90' = 572 if `v9906' == 7519                                                       
	replace `ibge90' = 561 if `v9906' == 7524                                                       
	replace `ibge90' = 403 if `v9906' == 7601                                                       
	replace `ibge90' = 470 if `v9906' == 7603                                                       
	replace `ibge90' = 402 if `v9906' == 7605                                                       
	replace `ibge90' = 402 if `v9906' == 7606                                                       
	replace `ibge90' = 441 if `v9906' == 7610                                                       
	replace `ibge90' = 441 if `v9906' == 7611                                                       
	replace `ibge90' = 441 if `v9906' == 7612                                                       
	replace `ibge90' = 441 if `v9906' == 7613                                                       
	replace `ibge90' = 450 if `v9906' == 7614                                                       
	replace `ibge90' = 451 if `v9906' == 7618                                                       
	replace `ibge90' = 462 if `v9906' == 7622                                                       
	replace `ibge90' = 470 if `v9906' == 7630                                                       
	replace `ibge90' = 473 if `v9906' == 7631                                                       
	replace `ibge90' = 470 if `v9906' == 7632                                                       
	replace `ibge90' = 470 if `v9906' == 7633                                                       
	replace `ibge90' = 478 if `v9906' == 7640                                                       
	replace `ibge90' = 477 if `v9906' == 7641                                                       
	replace `ibge90' = 476 if `v9906' == 7650                                                       
	replace `ibge90' = 470 if `v9906' == 7652                                                       
	replace `ibge90' = 461 if `v9906' == 7653                                                       
	replace `ibge90' = 551 if `v9906' == 7661                                                       
	replace `ibge90' = 554 if `v9906' == 7662                                                       
	replace `ibge90' = 552 if `v9906' == 7663                                                       
	replace `ibge90' = 448 if `v9906' == 7681                                                       
	replace `ibge90' = 461 if `v9906' == 7683                                                       
	replace `ibge90' = 551 if `v9906' == 7686                                                       
	replace `ibge90' = 556 if `v9906' == 7687                                                       
	replace `ibge90' = 482 if `v9906' == 7701                                                       
	replace `ibge90' = 481 if `v9906' == 7711                                                       
	replace `ibge90' = 585 if `v9906' == 7721                                                       
	replace `ibge90' = 485 if `v9906' == 7731                                                       
	replace `ibge90' = 481 if `v9906' == 7733                                                       
	replace `ibge90' = 484 if `v9906' == 7734                                                       
	replace `ibge90' = 481 if `v9906' == 7741                                                       
	replace `ibge90' = 481 if `v9906' == 7751
	replace `ibge90' = 490 if `v9906' == 7764
	replace `ibge90' = 584 if `v9906' == 7801
	replace `ibge90' = 731 if `v9906' == 7821
	replace `ibge90' = 731 if `v9906' == 7822
	replace `ibge90' = 751 if `v9906' == 7823
	replace `ibge90' = 751 if `v9906' == 7825
	replace `ibge90' = 743 if `v9906' == 7826
	replace `ibge90' = 727 if `v9906' == 7827
	replace `ibge90' = 753 if `v9906' == 7828
	replace `ibge90' = 746 if `v9906' == 7831
	replace `ibge90' = 924 if `v9906' == 7832
	replace `ibge90' = 584 if `v9906' == 7841
	replace `ibge90' = 583 if `v9906' == 7842
	replace `ibge90' = 589 if `v9906' == 8111
	replace `ibge90' = 589 if `v9906' == 8112
	replace `ibge90' = 589 if `v9906' == 8113
	replace `ibge90' = 589 if `v9906' == 8116
	replace `ibge90' = 586 if `v9906' == 8117
	replace `ibge90' = 589 if `v9906' == 8118
	replace `ibge90' = 576 if `v9906' == 8121
	replace `ibge90' = 927 if `v9906' == 8181
	replace `ibge90' = 589 if `v9906' == 8211
	replace `ibge90' = 411 if `v9906' == 8212
	replace `ibge90' = 412 if `v9906' == 8213
	replace `ibge90' = 427 if `v9906' == 8214
	replace `ibge90' = 414 if `v9906' == 8221
	replace `ibge90' = 589 if `v9906' == 8231
	replace `ibge90' = 562 if `v9906' == 8232
	replace `ibge90' = 587 if `v9906' == 8233
	replace `ibge90' = 564 if `v9906' == 8281
	replace `ibge90' = 585 if `v9906' == 8311
	replace `ibge90' = 545 if `v9906' == 8411
	replace `ibge90' = 543 if `v9906' == 8416
	replace `ibge90' = 545 if `v9906' == 8417
	replace `ibge90' = 579 if `v9906' == 8421
	replace `ibge90' = 540 if `v9906' == 8484
	replace `ibge90' = 533 if `v9906' == 8485
	replace `ibge90' = 584 if `v9906' == 8491
	replace `ibge90' = 545 if `v9906' == 8492
	replace `ibge90' = 535 if `v9906' == 8493
	replace `ibge90' = 405 if `v9906' == 8601
	replace `ibge90' = 583 if `v9906' == 8621
	replace `ibge90' = 583 if `v9906' == 8623
	replace `ibge90' = 403 if `v9906' == 9101
	replace `ibge90' = 402 if `v9906' == 9102
	replace `ibge90' = 425 if `v9906' == 9113
	replace `ibge90' = 425 if `v9906' == 9131
	replace `ibge90' = 425 if `v9906' == 9144                                                                                                       
	replace `ibge90' = 425 if `v9906' == 9193                                                                                                       
	replace `ibge90' = 506 if `v9906' == 9511                                                                                                       
	replace `ibge90' = 503 if `v9906' == 9542                                                                                                       
	replace `ibge90' = 581 if `v9906' == 9913                                                                                                       


	** sintaxe para refinar as ocupações que não têm equivalência perfeita

	replace `ibge90' = 7 if `v4706'==10 & `v9906'==1310 & `ind'==6
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==1310 & `ind'==3
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==1310 & `ind'==2
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==1310 & `ind'==1
	replace `ibge90' = 301 if `v4706'==9 & `v9906'==1310
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==2616
	replace `ibge90' = 15 if `v4706'==10 & `v9906'==2621
	replace `ibge90' = 852 if `v4706'==9 & `v9906'==2621
	replace `ibge90' = 10 if `v4706'==10 & `v9906'==3331



	***************   if            (       `v4706'   =       9               and             `v9906'   =       3331    )               `ibge90'  =       852     . <- linha comentada na sintaxe original
	replace `ibge90' = 15 if `v4706'==10 & `v9906'==3541
	replace `ibge90' = 601 if `v4706'==9 & `v9906'==3541 & `v9907' < 65000
	replace `ibge90' = 601 if `v4706'==9 & `v9906'==3543
	replace `ibge90' = 10 if `v4706'==10 & `v9906'==5134
	replace `ibge90' = 15 if `v4706'==10 & `v9906'==5165
	replace `ibge90' = 601 if `v4706'==9 & `v9906'==5165
	replace `ibge90' = 15 if `v4706'==10 & `v9906'==5169
	replace `ibge90' = 601 if `v4706'==9 & `v9906'==5169
	replace `ibge90' = 10 if `v4706'==10 & `v9906'==5201
	replace `ibge90' = 601 if `v4706'==9 & `v9906'==5211
	replace `ibge90' = 601 if `v4706'==10 & `v9906'==5241
	replace `ibge90' = 14 if `v4706'==10 & `v9906'==5242
	replace `ibge90' = 601 if `v4706'==9 & `v9906'==5242
	replace `ibge90' = 13 if `v4706'==10 & `v9906'==5243
	replace `ibge90' = 1 if `v4706'==10 & `v9906'==6110
	replace `ibge90' = 301 if `v4706'==9 & `v9906'==6110
	replace `ibge90' = 1 if `v4706'==10 & `v9906'==6129
	replace `ibge90' = 301 if `v4706'==9 & `v9906'==6129
	replace `ibge90' = 2 if `v4706'==10 & `v9906'==6139
	replace `ibge90' = 301 if `v4706'==9 & `v9906'==6139
	replace `ibge90' = 1 if `v4706'==10 & `v9906'==6229
	replace `ibge90' = 301 if `v4706'==9 & `v9906'==6229
	replace `ibge90' = 1 if `v4706'==10 & `v9906'==6319
	replace `ibge90' = 301 if `v4706'==9 & `v9906'==6319
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==7221
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==7519
	replace `ibge90' = 601 if `v4706'==9 & `v9906'==7519
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==7622
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==7683
	replace `ibge90' = 601 if `v4706'==9 & `v9906'==7683
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==8281
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==8411
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==8485
	replace `ibge90' = 601 if `v4706'==9 & `v9906'==8485
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==8491
	replace `ibge90' = 8 if `v4706'==10 & `v9906'==8493


	replace `ibge90' = 39 if (`v9906' == 1220 | `v9906' == 1230 | `v9906' == 1310 | `v9906' == 1320) & `v4809' == 9 & (`v9907' > 85010 & `v9907' < 85015) & `v4706' ~= 10
	replace `ibge90' = 10 if `v9906' == 1320 & `v4706' == 10 & (`v4809' == 2 | `v4809' == 3 | `v4809' == 4 | `v4809' == 5 | `v4809' == 6 | `v4809' == 7)
	replace `ibge90' = 10 if `v9906' == 1210 & `v4706' == 10 & (`v4809' == 2 | `v4809' == 3 | `v4809' == 4 | `v4809' == 5 | `v4809' == 6 | `v4809' == 7)
	replace `ibge90' = 5 if (`v9906' == 1219 | `v9906' == 6301 | `v9906' == 6329) & `v4809' == 1 & `v4808' == 1 & `v4706' == 10


	replace `ibge90' = 741 if `v9906' == 4211 & (`v9907' > 60009 & `v9907' < 60021)
	replace `ibge90' = 752 if `v9906' == 4211 & `v9907' == 60040
	replace `ibge90' = 772 if `v9906' == 4211 & `v9907' == 64010
	replace `ibge90' = 912 if `v9906' == 4211 & (`v9907' == 92012 | `v9907' == 92015 | `v9907' == 92040)
	replace `ibge90' = 351 if `v9906' == 7821 & (`v9907' > 9999 & `v9907' < 15000)
	replace `ibge90' = 351 if `v9906' == 8621 & (`v9907' > 9999 & `v9907' < 15000)
	replace `ibge90' = 15  if `v9906' == 5161 & `v4706' == 10
	replace `ibge90' = 9   if `v9906' == 7102 & `v4706' == 10
	replace `ibge90' = 272 if `v9906' == 2625 & (`v9907' > 18000 & `v9907' < 20001)
	replace `ibge90' = 272 if `v9906' == 2625 & `v9907' == 20000
	replace `ibge90' = 272 if `v9906' == 2625 & `v9907' == 26091
	replace `ibge90' = 303 if `v9906' == 7825 & `v4808' == 1 & `v9907' < 1402

	/*--------------------------------------------------------------------
	- 1.3 EGP
	---------------------------------------------------------------------*/

	if "`egp12'" != ""  |  "`egp7'" != "" |  "`egp'" != ""{

		noisily di "Criando classes EGP..."		
		gen egp12=.
		lab var egp12 "EGP com 12 classes"

		replace egp12 = 10 if `ibge90' == 20
		replace egp12 = 10 if `ibge90' == 21
		replace egp12 = 10 if `ibge90' == 33
		replace egp12 = 10 if `ibge90' == 38
		replace egp12 = 10 if `ibge90' == 101
		replace egp12 = 10 if `ibge90' == 102
		replace egp12 = 10 if `ibge90' == 121
		replace egp12 = 10 if `ibge90' == 122
		replace egp12 = 10 if `ibge90' == 123
		replace egp12 = 10 if `ibge90' == 124
		replace egp12 = 10 if `ibge90' == 141
		replace egp12 = 10 if `ibge90' == 142
		replace egp12 = 10 if `ibge90' == 143
		replace egp12 = 10 if `ibge90' == 144
		replace egp12 = 10 if `ibge90' == 151
		replace egp12 = 10 if `ibge90' == 152
		replace egp12 = 10 if `ibge90' == 171
		replace egp12 = 10 if `ibge90' == 181
		replace egp12 = 10 if `ibge90' == 183
		replace egp12 = 10 if `ibge90' == 201
		replace egp12 = 10 if `ibge90' == 202
		replace egp12 = 10 if `ibge90' == 203
		replace egp12 = 10 if `ibge90' == 205
		replace egp12 = 10 if `ibge90' == 211
		replace egp12 = 10 if `ibge90' == 212
		replace egp12 = 10 if `ibge90' == 231
		replace egp12 = 10 if `ibge90' == 232
		replace egp12 = 10 if `ibge90' == 233
		replace egp12 = 10 if `ibge90' == 292
		replace egp12 = 10 if `ibge90' == 711

		replace egp12 = 20 if `ibge90' == 32
		replace egp12 = 20 if `ibge90' == 34
		replace egp12 = 20 if `ibge90' == 35
		replace egp12 = 20 if `ibge90' == 36
		replace egp12 = 20 if `ibge90' == 37
		replace egp12 = 20 if `ibge90' == 39
		replace egp12 = 20 if `ibge90' == 40
		replace egp12 = 20 if `ibge90' == 50
		replace egp12 = 20 if `ibge90' == 52
		replace egp12 = 20 if `ibge90' == 153
		replace egp12 = 20 if `ibge90' == 154
		replace egp12 = 20 if `ibge90' == 182
		replace egp12 = 20 if `ibge90' == 204
		replace egp12 = 20 if `ibge90' == 213
		replace egp12 = 20 if `ibge90' == 241
		replace egp12 = 20 if `ibge90' == 252
		replace egp12 = 20 if `ibge90' == 291
		replace egp12 = 20 if `ibge90' == 641
		replace egp12 = 20 if `ibge90' == 643
		replace egp12 = 20 if `ibge90' == 644
		replace egp12 = 20 if `ibge90' == 721

		replace egp12 = 31 if `ibge90' == 54
		replace egp12 = 31 if `ibge90' == 55
		replace egp12 = 31 if `ibge90' == 56
		replace egp12 = 31 if `ibge90' == 57
		replace egp12 = 31 if `ibge90' == 58
		replace egp12 = 31 if `ibge90' == 59
		replace egp12 = 31 if `ibge90' == 60
		replace egp12 = 31 if `ibge90' == 61
		replace egp12 = 31 if `ibge90' == 62
		replace egp12 = 31 if `ibge90' == 64
		replace egp12 = 31 if `ibge90' == 191
		replace egp12 = 31 if `ibge90' == 192
		replace egp12 = 31 if `ibge90' == 193
		replace egp12 = 31 if `ibge90' == 194
		replace egp12 = 31 if `ibge90' == 214
		replace egp12 = 31 if `ibge90' == 215
		replace egp12 = 31 if `ibge90' == 216
		replace egp12 = 31 if `ibge90' == 217
		replace egp12 = 31 if `ibge90' == 218
		replace egp12 = 31 if `ibge90' == 219
		replace egp12 = 31 if `ibge90' == 221
		replace egp12 = 31 if `ibge90' == 222
		replace egp12 = 31 if `ibge90' == 242
		replace egp12 = 31 if `ibge90' == 243
		replace egp12 = 31 if `ibge90' == 244
		replace egp12 = 31 if `ibge90' == 251
		replace egp12 = 31 if `ibge90' == 261
		replace egp12 = 31 if `ibge90' == 275
		replace egp12 = 31 if `ibge90' == 276
		replace egp12 = 31 if `ibge90' == 277
		replace egp12 = 31 if `ibge90' == 278
		replace egp12 = 31 if `ibge90' == 279
		replace egp12 = 31 if `ibge90' == 631
		replace egp12 = 31 if `ibge90' == 632
		replace egp12 = 31 if `ibge90' == 633
		replace egp12 = 31 if `ibge90' == 642
		replace egp12 = 31 if `ibge90' == 645
		replace egp12 = 31 if `ibge90' == 831
		replace egp12 = 31 if `ibge90' == 832
		replace egp12 = 31 if `ibge90' == 833
		replace egp12 = 31 if `ibge90' == 834
		replace egp12 = 31 if `ibge90' == 863
		replace egp12 = 31 if `ibge90' == 864
		replace egp12 = 31 if `ibge90' == 865

		replace egp12 = 32 if `ibge90' == 53
		replace egp12 = 32 if `ibge90' == 63
		replace egp12 = 32 if `ibge90' == 132
		replace egp12 = 32 if `ibge90' == 162
		replace egp12 = 32 if `ibge90' == 163
		replace egp12 = 32 if `ibge90' == 602
		replace egp12 = 32 if `ibge90' == 603
		replace egp12 = 32 if `ibge90' == 604
		replace egp12 = 32 if `ibge90' == 605
		replace egp12 = 32 if `ibge90' == 646
		replace egp12 = 32 if `ibge90' == 712
		replace egp12 = 32 if `ibge90' == 771
		replace egp12 = 32 if `ibge90' == 772
		replace egp12 = 32 if `ibge90' == 773
		replace egp12 = 32 if `ibge90' == 774
		replace egp12 = 32 if `ibge90' == 814
		replace egp12 = 32 if `ibge90' == 815
		replace egp12 = 32 if `ibge90' == 816
		replace egp12 = 32 if `ibge90' == 817
		replace egp12 = 32 if `ibge90' == 818
		replace egp12 = 32 if `ibge90' == 845
		replace egp12 = 32 if `ibge90' == 869
		replace egp12 = 32 if `ibge90' == 911
		replace egp12 = 32 if `ibge90' == 912

		replace egp12 = 41 if `ibge90' == 7
		replace egp12 = 41 if `ibge90' == 8
		replace egp12 = 41 if `ibge90' == 9
		replace egp12 = 41 if `ibge90' == 10
		replace egp12 = 41 if `ibge90' == 11
		replace egp12 = 41 if `ibge90' == 12
		replace egp12 = 41 if `ibge90' == 13
		replace egp12 = 41 if `ibge90' == 14
		replace egp12 = 41 if `ibge90' == 15

		replace egp12 = 42 if `ibge90' == 601
		replace egp12 = 42 if `ibge90' == 811
		replace egp12 = 42 if `ibge90' == 852

		replace egp12 = 43 if `ibge90' == 301

		replace egp12 = 44 if `ibge90' == 1
		replace egp12 = 44 if `ibge90' == 2
		replace egp12 = 44 if `ibge90' == 3
		replace egp12 = 44 if `ibge90' == 4
		replace egp12 = 44 if `ibge90' == 5
		replace egp12 = 44 if `ibge90' == 6
		replace egp12 = 50 if `ibge90' == 30

		replace egp12 = 50 if `ibge90' == 51
		replace egp12 = 50 if `ibge90' == 103
		replace egp12 = 50 if `ibge90' == 104
		replace egp12 = 50 if `ibge90' == 111
		replace egp12 = 50 if `ibge90' == 112
		replace egp12 = 50 if `ibge90' == 113
		replace egp12 = 50 if `ibge90' == 131
		replace egp12 = 50 if `ibge90' == 164
		replace egp12 = 50 if `ibge90' == 165
		replace egp12 = 50 if `ibge90' == 166
		replace egp12 = 50 if `ibge90' == 167
		replace egp12 = 50 if `ibge90' == 168
		replace egp12 = 50 if `ibge90' == 271
		replace egp12 = 50 if `ibge90' == 273
		replace egp12 = 50 if `ibge90' == 274
		replace egp12 = 50 if `ibge90' == 280
		replace egp12 = 50 if `ibge90' == 281
		replace egp12 = 50 if `ibge90' == 282
		replace egp12 = 50 if `ibge90' == 283
		replace egp12 = 50 if `ibge90' == 293
		replace egp12 = 50 if `ibge90' == 401
		replace egp12 = 50 if `ibge90' == 402
		replace egp12 = 50 if `ibge90' == 403
		replace egp12 = 50 if `ibge90' == 404
		replace egp12 = 50 if `ibge90' == 405
		replace egp12 = 50 if `ibge90' == 406
		replace egp12 = 50 if `ibge90' == 571
		replace egp12 = 50 if `ibge90' == 588
		replace egp12 = 50 if `ibge90' == 722
		replace egp12 = 50 if `ibge90' == 761
		replace egp12 = 50 if `ibge90' == 914
		replace egp12 = 50 if `ibge90' == 918

		replace egp12 = 60 if `ibge90' == 411
		replace egp12 = 60 if `ibge90' == 412
		replace egp12 = 60 if `ibge90' == 413
		replace egp12 = 60 if `ibge90' == 414
		replace egp12 = 60 if `ibge90' == 415
		replace egp12 = 60 if `ibge90' == 416
		replace egp12 = 60 if `ibge90' == 417
		replace egp12 = 60 if `ibge90' == 418
		replace egp12 = 60 if `ibge90' == 419
		replace egp12 = 60 if `ibge90' == 420
		replace egp12 = 60 if `ibge90' == 421
		replace egp12 = 60 if `ibge90' == 422
		replace egp12 = 60 if `ibge90' == 423
		replace egp12 = 60 if `ibge90' == 424
		replace egp12 = 60 if `ibge90' == 425
		replace egp12 = 60 if `ibge90' == 426
		replace egp12 = 60 if `ibge90' == 427
		replace egp12 = 60 if `ibge90' == 428
		replace egp12 = 60 if `ibge90' == 429
		replace egp12 = 60 if `ibge90' == 430
		replace egp12 = 60 if `ibge90' == 431
		replace egp12 = 60 if `ibge90' == 470
		replace egp12 = 60 if `ibge90' == 471
		replace egp12 = 60 if `ibge90' == 472
		replace egp12 = 60 if `ibge90' == 473
		replace egp12 = 60 if `ibge90' == 474
		replace egp12 = 60 if `ibge90' == 477
		replace egp12 = 60 if `ibge90' == 478
		replace egp12 = 60 if `ibge90' == 479
		replace egp12 = 60 if `ibge90' == 481
		replace egp12 = 60 if `ibge90' == 482
		replace egp12 = 60 if `ibge90' == 484
		replace egp12 = 60 if `ibge90' == 485
		replace egp12 = 60 if `ibge90' == 487
		replace egp12 = 60 if `ibge90' == 488
		replace egp12 = 60 if `ibge90' == 489
		replace egp12 = 60 if `ibge90' == 501
		replace egp12 = 60 if `ibge90' == 502
		replace egp12 = 60 if `ibge90' == 503
		replace egp12 = 60 if `ibge90' == 504
		replace egp12 = 60 if `ibge90' == 505
		replace egp12 = 60 if `ibge90' == 506
		replace egp12 = 60 if `ibge90' == 507
		replace egp12 = 60 if `ibge90' == 508
		replace egp12 = 60 if `ibge90' == 509
		replace egp12 = 60 if `ibge90' == 511
		replace egp12 = 60 if `ibge90' == 512
		replace egp12 = 60 if `ibge90' == 516
		replace egp12 = 60 if `ibge90' == 517
		replace egp12 = 60 if `ibge90' == 518
		replace egp12 = 60 if `ibge90' == 551
		replace egp12 = 60 if `ibge90' == 552
		replace egp12 = 60 if `ibge90' == 553
		replace egp12 = 60 if `ibge90' == 554
		replace egp12 = 60 if `ibge90' == 555
		replace egp12 = 60 if `ibge90' == 556
		replace egp12 = 60 if `ibge90' == 557
		replace egp12 = 60 if `ibge90' == 561
		replace egp12 = 60 if `ibge90' == 562
		replace egp12 = 60 if `ibge90' == 563
		replace egp12 = 60 if `ibge90' == 572
		replace egp12 = 60 if `ibge90' == 573
		replace egp12 = 60 if `ibge90' == 581
		replace egp12 = 60 if `ibge90' == 731
		replace egp12 = 60 if `ibge90' == 741
		replace egp12 = 60 if `ibge90' == 743
		replace egp12 = 60 if `ibge90' == 745
		replace egp12 = 60 if `ibge90' == 746
		replace egp12 = 60 if `ibge90' == 813
		replace egp12 = 60 if `ibge90' == 822
		replace egp12 = 60 if `ibge90' == 823
		replace egp12 = 60 if `ibge90' == 824
		replace egp12 = 60 if `ibge90' == 866
		replace egp12 = 60 if `ibge90' == 867
		replace egp12 = 60 if `ibge90' == 868
		replace egp12 = 60 if `ibge90' == 913
		replace egp12 = 60 if `ibge90' == 915
		replace egp12 = 60 if `ibge90' == 917
		replace egp12 = 60 if `ibge90' == 921
		replace egp12 = 60 if `ibge90' == 922

		replace egp12 = 71 if `ibge90' == 272
		replace egp12 = 71 if `ibge90' == 333
		replace egp12 = 71 if `ibge90' == 341
		replace egp12 = 71 if `ibge90' == 351
		replace egp12 = 71 if `ibge90' == 361
		replace egp12 = 71 if `ibge90' == 371
		replace egp12 = 71 if `ibge90' == 391
		replace egp12 = 71 if `ibge90' == 441
		replace egp12 = 71 if `ibge90' == 442
		replace egp12 = 71 if `ibge90' == 443
		replace egp12 = 71 if `ibge90' == 444
		replace egp12 = 71 if `ibge90' == 445
		replace egp12 = 71 if `ibge90' == 446
		replace egp12 = 71 if `ibge90' == 447
		replace egp12 = 71 if `ibge90' == 448
		replace egp12 = 71 if `ibge90' == 449
		replace egp12 = 71 if `ibge90' == 450
		replace egp12 = 71 if `ibge90' == 451
		replace egp12 = 71 if `ibge90' == 452
		replace egp12 = 71 if `ibge90' == 461
		replace egp12 = 71 if `ibge90' == 462
		replace egp12 = 71 if `ibge90' == 475
		replace egp12 = 71 if `ibge90' == 483
		replace egp12 = 71 if `ibge90' == 486
		replace egp12 = 71 if `ibge90' == 490
		replace egp12 = 71 if `ibge90' == 513
		replace egp12 = 71 if `ibge90' == 514
		replace egp12 = 71 if `ibge90' == 515
		replace egp12 = 71 if `ibge90' == 519
		replace egp12 = 71 if `ibge90' == 520
		replace egp12 = 71 if `ibge90' == 521
		replace egp12 = 71 if `ibge90' == 531
		replace egp12 = 71 if `ibge90' == 532
		replace egp12 = 71 if `ibge90' == 533
		replace egp12 = 71 if `ibge90' == 534
		replace egp12 = 71 if `ibge90' == 535
		replace egp12 = 71 if `ibge90' == 536
		replace egp12 = 71 if `ibge90' == 537
		replace egp12 = 71 if `ibge90' == 538
		replace egp12 = 71 if `ibge90' == 539
		replace egp12 = 71 if `ibge90' == 540
		replace egp12 = 71 if `ibge90' == 541
		replace egp12 = 71 if `ibge90' == 542
		replace egp12 = 71 if `ibge90' == 543
		replace egp12 = 71 if `ibge90' == 544
		replace egp12 = 71 if `ibge90' == 545
		replace egp12 = 71 if `ibge90' == 564
		replace egp12 = 71 if `ibge90' == 574
		replace egp12 = 71 if `ibge90' == 575
		replace egp12 = 71 if `ibge90' == 576
		replace egp12 = 71 if `ibge90' == 577
		replace egp12 = 71 if `ibge90' == 578
		replace egp12 = 71 if `ibge90' == 579
		replace egp12 = 71 if `ibge90' == 580
		replace egp12 = 71 if `ibge90' == 582
		replace egp12 = 71 if `ibge90' == 583
		replace egp12 = 71 if `ibge90' == 584
		replace egp12 = 71 if `ibge90' == 585
		replace egp12 = 71 if `ibge90' == 586
		replace egp12 = 71 if `ibge90' == 587
		replace egp12 = 71 if `ibge90' == 589
		replace egp12 = 71 if `ibge90' == 611
		replace egp12 = 71 if `ibge90' == 612
		replace egp12 = 71 if `ibge90' == 613
		replace egp12 = 71 if `ibge90' == 614
		replace egp12 = 71 if `ibge90' == 615
		replace egp12 = 71 if `ibge90' == 616
		replace egp12 = 71 if `ibge90' == 617
		replace egp12 = 71 if `ibge90' == 621
		replace egp12 = 71 if `ibge90' == 723
		replace egp12 = 71 if `ibge90' == 724
		replace egp12 = 71 if `ibge90' == 725
		replace egp12 = 71 if `ibge90' == 726
		replace egp12 = 71 if `ibge90' == 727
		replace egp12 = 71 if `ibge90' == 732
		replace egp12 = 71 if `ibge90' == 751
		replace egp12 = 71 if `ibge90' == 752
		replace egp12 = 71 if `ibge90' == 762
		replace egp12 = 71 if `ibge90' == 775
		replace egp12 = 71 if `ibge90' == 801
		replace egp12 = 71 if `ibge90' == 802
		replace egp12 = 71 if `ibge90' == 803
		replace egp12 = 71 if `ibge90' == 804
		replace egp12 = 71 if `ibge90' == 805
		replace egp12 = 71 if `ibge90' == 806
		replace egp12 = 71 if `ibge90' == 807
		replace egp12 = 71 if `ibge90' == 808
		replace egp12 = 71 if `ibge90' == 812
		replace egp12 = 71 if `ibge90' == 825
		replace egp12 = 71 if `ibge90' == 826
		replace egp12 = 71 if `ibge90' == 841
		replace egp12 = 71 if `ibge90' == 842
		replace egp12 = 71 if `ibge90' == 843
		replace egp12 = 71 if `ibge90' == 844
		replace egp12 = 71 if `ibge90' == 916
		replace egp12 = 71 if `ibge90' == 919
		replace egp12 = 71 if `ibge90' == 920
		replace egp12 = 71 if `ibge90' == 923
		replace egp12 = 71 if `ibge90' == 924
		replace egp12 = 71 if `ibge90' == 925
		replace egp12 = 71 if `ibge90' == 926

		replace egp12 = 72 if `ibge90' == 302
		replace egp12 = 72 if `ibge90' == 303
		replace egp12 = 72 if `ibge90' == 304
		replace egp12 = 72 if `ibge90' == 305
		replace egp12 = 72 if `ibge90' == 321
		replace egp12 = 72 if `ibge90' == 322
		replace egp12 = 72 if `ibge90' == 331
		replace egp12 = 72 if `ibge90' == 332
		replace egp12 = 72 if `ibge90' == 334
		replace egp12 = 72 if `ibge90' == 336
		replace egp12 = 72 if `ibge90' == 345
		replace egp12 = 72 if `ibge90' == 381
		replace egp12 = 72 if `ibge90' == 753


		replace egp12 = 50 if `ibge90' == 125
		replace egp12 = 20 if `ibge90' == 173
		replace egp12 = 60 if `ibge90' == 821
		replace egp12 = 44 if `ibge90' == 851

		replace egp12 = 60 if `ibge90' == 741
		replace egp12 = 60 if `ibge90' == 742

		replace egp12 = 72 if `ibge90' == 300

		replace egp12 = 60 if `ibge90' == 744

		replace egp12 = 71 if `ibge90' == 476
		replace egp12 = 20 if `ibge90' == 172

		/* missing */
		replace egp12 = .  if `ibge90' ==928
		replace egp12 = .  if `ibge90' ==927

		/* adicionando ocupação 133 (técnicos em meteorologia)*/

		replace egp12 = 32 if `ibge90' == 133

		/* adicionando ocupação 161 (acadêmicos de hospital)*/

		replace egp12 = 20 if `ibge90' == 161

		/* adicionando ocupação 31 (administração na extração ve>=tal e pesca)*/

		replace egp12 = 50 if `ibge90' == 31

		/* adicionando ocupação 335 (ervateiros)*/

		replace egp12 = 72 if `ibge90' == 335

		/* para classificar militares*/

		replace egp12 = 31 if `ibge90' == 861
		replace egp12 = 71 if `ibge90' == 862

		* ajustes 

		replace egp12 = 41 if `v9906' == 1310 & `v4808' == 2 & `v4706' == 10	
		replace egp12 = 44 if `v9906' == 1310 & `v4808' == 1 & `v4706' == 10																	
		replace egp12 = 44 if `v9906' == 2512 & `v4808' == 1 & `v4706' == 10																
		replace egp12 = 44 if `v9906' == 3147 & `v4808' == 1 & `v4706' == 10
		replace egp12 = 71 if `v9906' == 5134 & `v4809' == 10																	
		replace egp12 = 41 if `v9906' == 7256 & `v4706' == 10																	
		replace egp12 = 41 if `v9906' == 7650 & `v4706' == 10
		replace egp12 = 71 if `v9906' == 5173 & `v4809' == 10
		replace egp12 = 71 if `v9906' == 3189 & `v4809' >= 2 & `v4809' <= 4
		replace egp12 = 71 if `v9906' == 7828 & `v4809' >= 2 & `v4809' <= 4
		replace egp12 = 20 if `v9906' == 3518 & `v4706' >= 2 & `v4706' <= 3
		replace egp12 = 20 if `v9906' == 3518 & `v4809' == 8
		replace egp12 = 10 if `v9906' == 5131 & `v4809' == 8
		replace egp12 = 10 if `v9906' == 5131 & `v4706' == 2
		replace egp12 = 10 if `v9906' == 5131 & `v4706' == 3
		replace egp12 = 71 if `v9906' == 8214 & `v4809' >= 5 & `v4809' <= 9
		replace egp12 = 71 if `v9906' == 8214 & `v4809' == 11
		replace egp12 = 71 if `v9906' == 8412 & `v4809' >= 5 & `v4809' <= 9
		replace egp12 = 71 if `v9906' == 8412 & `v4809' == 11
		replace egp12 = 71 if `v9906' == 8485 & `v4809' >= 5 & `v4809' <= 9
		replace egp12 = 71 if `v9906' == 8485 & `v4809' == 11

		replace egp12 = 71 if `v9906' == 8491 & `v4809' >= 5 & `v4809' <= 9
		replace egp12 = 71 if `v9906' == 8491 & `v4809' == 11
		replace egp12 = 71 if `v9906' == 8621 & `v4809' >= 5 & `v4809' <= 9
		replace egp12 = 71 if `v9906' == 8621 & `v4809' == 11
		replace egp12 = 71 if `v9906' == 8621 & `v4809' >= 5 & `v4809' <= 9
		replace egp12 = 71 if `v9906' == 8621 & `v4809' == 11
		replace egp12 = 71 if `v9906' == 8623 & `v4809' >= 5 & `v4809' <= 9
		replace egp12 = 71 if `v9906' == 8623 & `v4809' == 11
		replace egp12 = 71 if `v9906' == 9113 & `v4809' >= 5 & `v4809' <= 9
		replace egp12 = 71 if `v9906' == 9113 & `v4809' == 11


		* ajustes (incluindo quem ficou de fora)

		replace egp12 = 71 if `v9906'==5199
		replace egp12 = 71 if `v9906'==7832

		replace egp12 = 50 if `v9906'==5101
		replace egp12 = 50 if `v9906'==5102

		replace egp12 = 42 if `v9906'==2621 & `v4706'==9
		replace egp12 = 42 if `v9906'==3331 & `v4706'==9

		* 
		replace egp12 = 20 if `v9906'==3513


		* ver os 1310 que sao tecnicos agricolas e tao na 10
		replace egp12 = 20 if (`v9906' == 1220 | `v9906' == 1230 | `v9906' == 1310 | `v9906' == 1320) & `v4809' > 3 & `v4809' < 8 & `v4706' != 10
		replace egp12 = 20 if (`v9906' == 1220 | `v9906' == 1230 | `v9906' == 1310 | `v9906' == 1320) & `v4809' == 12 & (`v9907' > 71019 & `v9907' < 72025) & `v4706' != 10
		replace egp12 = 20 if (`v9906' == 1220 | `v9906' == 1230 | `v9906' == 1310 | `v9906' == 1320) & `v4809' == 12 & (`v9907' > 74049 & `v9907' < 74091) & `v4706' != 10
		replace egp12 = 20 if (`v9906' == 1220 | `v9906' == 1230 | `v9906' == 1310 | `v9906' == 1320) & `v4809' == 9 & (`v9907' > 80011 & `v9907' < 80091) & `v4706' != 10
		replace egp12 = 20 if (`v9906' == 1220 | `v9906' == 1230 | `v9906' == 1310 | `v9906' == 1320) & (`ind' == 2 | `ind' == 6 | `ind' == 7) & `v4706' != 10 

		replace egp12 = 71 if `v9906' == 5131 & `v4809' == 10
		replace egp12 = 42 if `v9906' == 5134 & `v4706' == 9

		replace egp12 = 10 if `v9906' == 2122
		replace egp12 = 20 if `v9906' == 2631 & `v4706' == 9

		replace egp12 = 60  if `v9906' == 5151
		replace egp12 = 32  if `v9906' == 5103
		replace egp12 = 71  if `v9906' == 3123
		replace egp12 = 60  if `v9906' == 3142


		replace egp12 = 41 if `v9906' == 7152 & `v4706' == 10

		replace egp12 = 44 if `v9906' == 6301 & `v4706' == 10
		replace egp12 = 44 if `v9906' == 6410 & `v4706' == 10 & `v4808' == 1
		replace egp12 = 32 if `v9906' == 3541 & `ibge90' != 15 & `ibge90' != 601
	}
	
	}
}

*********************************************************************
* 2 - Pré-2002
*********************************************************************

if `ano'<2002 {
	quietly {

	/*--------------------------------------------------------------------
	- 2.1 EGP
	---------------------------------------------------------------------*/
	if "`egp12'" != ""  |  "`egp7'" != "" |  "`egp'" != ""{

		noisily di "Criando classes EGP..."		
		gen egp12=.
		lab var egp12 "EGP com 12 classes"

		replace egp12 = 10 if `v9906' == 20
		replace egp12 = 10 if `v9906' == 21
		replace egp12 = 10 if `v9906' == 33
		replace egp12 = 10 if `v9906' == 38
		replace egp12 = 10 if `v9906' == 101
		replace egp12 = 10 if `v9906' == 102
		replace egp12 = 10 if `v9906' == 121
		replace egp12 = 10 if `v9906' == 122
		replace egp12 = 10 if `v9906' == 123
		replace egp12 = 10 if `v9906' == 124
		replace egp12 = 10 if `v9906' == 141
		replace egp12 = 10 if `v9906' == 142
		replace egp12 = 10 if `v9906' == 143
		replace egp12 = 10 if `v9906' == 144
		replace egp12 = 10 if `v9906' == 151
		replace egp12 = 10 if `v9906' == 152
		replace egp12 = 10 if `v9906' == 171
		replace egp12 = 10 if `v9906' == 181
		replace egp12 = 10 if `v9906' == 183
		replace egp12 = 10 if `v9906' == 201
		replace egp12 = 10 if `v9906' == 202
		replace egp12 = 10 if `v9906' == 203
		replace egp12 = 10 if `v9906' == 205
		replace egp12 = 10 if `v9906' == 211
		replace egp12 = 10 if `v9906' == 212
		replace egp12 = 10 if `v9906' == 231
		replace egp12 = 10 if `v9906' == 232
		replace egp12 = 10 if `v9906' == 233
		replace egp12 = 10 if `v9906' == 292
		replace egp12 = 10 if `v9906' == 711

		replace egp12 = 20 if `v9906' == 32
		replace egp12 = 20 if `v9906' == 34
		replace egp12 = 20 if `v9906' == 35
		replace egp12 = 20 if `v9906' == 36
		replace egp12 = 20 if `v9906' == 37
		replace egp12 = 20 if `v9906' == 39
		replace egp12 = 20 if `v9906' == 40
		replace egp12 = 20 if `v9906' == 50
		replace egp12 = 20 if `v9906' == 52
		replace egp12 = 20 if `v9906' == 153
		replace egp12 = 20 if `v9906' == 154
		replace egp12 = 20 if `v9906' == 182
		replace egp12 = 20 if `v9906' == 204
		replace egp12 = 20 if `v9906' == 213
		replace egp12 = 20 if `v9906' == 241
		replace egp12 = 20 if `v9906' == 252
		replace egp12 = 20 if `v9906' == 291
		replace egp12 = 20 if `v9906' == 641
		replace egp12 = 20 if `v9906' == 643
		replace egp12 = 20 if `v9906' == 644
		replace egp12 = 20 if `v9906' == 721

		replace egp12 = 31 if `v9906' == 54
		replace egp12 = 31 if `v9906' == 55
		replace egp12 = 31 if `v9906' == 56
		replace egp12 = 31 if `v9906' == 57
		replace egp12 = 31 if `v9906' == 58
		replace egp12 = 31 if `v9906' == 59
		replace egp12 = 31 if `v9906' == 60
		replace egp12 = 31 if `v9906' == 61
		replace egp12 = 31 if `v9906' == 62
		replace egp12 = 31 if `v9906' == 64
		replace egp12 = 31 if `v9906' == 191
		replace egp12 = 31 if `v9906' == 192
		replace egp12 = 31 if `v9906' == 193
		replace egp12 = 31 if `v9906' == 194
		replace egp12 = 31 if `v9906' == 214
		replace egp12 = 31 if `v9906' == 215
		replace egp12 = 31 if `v9906' == 216
		replace egp12 = 31 if `v9906' == 217
		replace egp12 = 31 if `v9906' == 218
		replace egp12 = 31 if `v9906' == 219
		replace egp12 = 31 if `v9906' == 221
		replace egp12 = 31 if `v9906' == 222
		replace egp12 = 31 if `v9906' == 242
		replace egp12 = 31 if `v9906' == 243
		replace egp12 = 31 if `v9906' == 244
		replace egp12 = 31 if `v9906' == 251
		replace egp12 = 31 if `v9906' == 261
		replace egp12 = 31 if `v9906' == 275
		replace egp12 = 31 if `v9906' == 276
		replace egp12 = 31 if `v9906' == 277
		replace egp12 = 31 if `v9906' == 278
		replace egp12 = 31 if `v9906' == 279
		replace egp12 = 31 if `v9906' == 631
		replace egp12 = 31 if `v9906' == 632
		replace egp12 = 31 if `v9906' == 633
		replace egp12 = 31 if `v9906' == 642
		replace egp12 = 31 if `v9906' == 645
		replace egp12 = 31 if `v9906' == 831
		replace egp12 = 31 if `v9906' == 832
		replace egp12 = 31 if `v9906' == 833
		replace egp12 = 31 if `v9906' == 834
		replace egp12 = 31 if `v9906' == 863
		replace egp12 = 31 if `v9906' == 864
		replace egp12 = 31 if `v9906' == 865

		replace egp12 = 32 if `v9906' == 53
		replace egp12 = 32 if `v9906' == 63
		replace egp12 = 32 if `v9906' == 132
		replace egp12 = 32 if `v9906' == 162
		replace egp12 = 32 if `v9906' == 163
		replace egp12 = 32 if `v9906' == 602
		replace egp12 = 32 if `v9906' == 603
		replace egp12 = 32 if `v9906' == 604
		replace egp12 = 32 if `v9906' == 605
		replace egp12 = 32 if `v9906' == 646
		replace egp12 = 32 if `v9906' == 712
		replace egp12 = 32 if `v9906' == 771
		replace egp12 = 32 if `v9906' == 772
		replace egp12 = 32 if `v9906' == 773
		replace egp12 = 32 if `v9906' == 774
		replace egp12 = 32 if `v9906' == 814
		replace egp12 = 32 if `v9906' == 815
		replace egp12 = 32 if `v9906' == 816
		replace egp12 = 32 if `v9906' == 817
		replace egp12 = 32 if `v9906' == 818
		replace egp12 = 32 if `v9906' == 845
		replace egp12 = 32 if `v9906' == 869
		replace egp12 = 32 if `v9906' == 911
		replace egp12 = 32 if `v9906' == 912

		replace egp12 = 41 if `v9906' == 7
		replace egp12 = 41 if `v9906' == 8
		replace egp12 = 41 if `v9906' == 9
		replace egp12 = 41 if `v9906' == 10
		replace egp12 = 41 if `v9906' == 11
		replace egp12 = 41 if `v9906' == 12
		replace egp12 = 41 if `v9906' == 13
		replace egp12 = 41 if `v9906' == 14
		replace egp12 = 41 if `v9906' == 15

		replace egp12 = 42 if `v9906' == 601
		replace egp12 = 42 if `v9906' == 811
		replace egp12 = 42 if `v9906' == 852

		replace egp12 = 43 if `v9906' == 301

		replace egp12 = 44 if `v9906' == 1
		replace egp12 = 44 if `v9906' == 2
		replace egp12 = 44 if `v9906' == 3
		replace egp12 = 44 if `v9906' == 4
		replace egp12 = 44 if `v9906' == 5
		replace egp12 = 44 if `v9906' == 6
		replace egp12 = 50 if `v9906' == 30

		replace egp12 = 50 if `v9906' == 51
		replace egp12 = 50 if `v9906' == 103
		replace egp12 = 50 if `v9906' == 104
		replace egp12 = 50 if `v9906' == 111
		replace egp12 = 50 if `v9906' == 112
		replace egp12 = 50 if `v9906' == 113
		replace egp12 = 50 if `v9906' == 131
		replace egp12 = 50 if `v9906' == 164
		replace egp12 = 50 if `v9906' == 165
		replace egp12 = 50 if `v9906' == 166
		replace egp12 = 50 if `v9906' == 167
		replace egp12 = 50 if `v9906' == 168
		replace egp12 = 50 if `v9906' == 271
		replace egp12 = 50 if `v9906' == 273
		replace egp12 = 50 if `v9906' == 274
		replace egp12 = 50 if `v9906' == 280
		replace egp12 = 50 if `v9906' == 281
		replace egp12 = 50 if `v9906' == 282
		replace egp12 = 50 if `v9906' == 283
		replace egp12 = 50 if `v9906' == 293
		replace egp12 = 50 if `v9906' == 401
		replace egp12 = 50 if `v9906' == 402
		replace egp12 = 50 if `v9906' == 403
		replace egp12 = 50 if `v9906' == 404
		replace egp12 = 50 if `v9906' == 405
		replace egp12 = 50 if `v9906' == 406
		replace egp12 = 50 if `v9906' == 571
		replace egp12 = 50 if `v9906' == 588
		replace egp12 = 50 if `v9906' == 722
		replace egp12 = 50 if `v9906' == 761
		replace egp12 = 50 if `v9906' == 914
		replace egp12 = 50 if `v9906' == 918

		replace egp12 = 60 if `v9906' == 411
		replace egp12 = 60 if `v9906' == 412
		replace egp12 = 60 if `v9906' == 413
		replace egp12 = 60 if `v9906' == 414
		replace egp12 = 60 if `v9906' == 415
		replace egp12 = 60 if `v9906' == 416
		replace egp12 = 60 if `v9906' == 417
		replace egp12 = 60 if `v9906' == 418
		replace egp12 = 60 if `v9906' == 419
		replace egp12 = 60 if `v9906' == 420
		replace egp12 = 60 if `v9906' == 421
		replace egp12 = 60 if `v9906' == 422
		replace egp12 = 60 if `v9906' == 423
		replace egp12 = 60 if `v9906' == 424
		replace egp12 = 60 if `v9906' == 425
		replace egp12 = 60 if `v9906' == 426
		replace egp12 = 60 if `v9906' == 427
		replace egp12 = 60 if `v9906' == 428
		replace egp12 = 60 if `v9906' == 429
		replace egp12 = 60 if `v9906' == 430
		replace egp12 = 60 if `v9906' == 431
		replace egp12 = 60 if `v9906' == 470
		replace egp12 = 60 if `v9906' == 471
		replace egp12 = 60 if `v9906' == 472
		replace egp12 = 60 if `v9906' == 473
		replace egp12 = 60 if `v9906' == 474
		replace egp12 = 60 if `v9906' == 477
		replace egp12 = 60 if `v9906' == 478
		replace egp12 = 60 if `v9906' == 479
		replace egp12 = 60 if `v9906' == 481
		replace egp12 = 60 if `v9906' == 482
		replace egp12 = 60 if `v9906' == 484
		replace egp12 = 60 if `v9906' == 485
		replace egp12 = 60 if `v9906' == 487
		replace egp12 = 60 if `v9906' == 488
		replace egp12 = 60 if `v9906' == 489
		replace egp12 = 60 if `v9906' == 501
		replace egp12 = 60 if `v9906' == 502
		replace egp12 = 60 if `v9906' == 503
		replace egp12 = 60 if `v9906' == 504
		replace egp12 = 60 if `v9906' == 505
		replace egp12 = 60 if `v9906' == 506
		replace egp12 = 60 if `v9906' == 507
		replace egp12 = 60 if `v9906' == 508
		replace egp12 = 60 if `v9906' == 509
		replace egp12 = 60 if `v9906' == 511
		replace egp12 = 60 if `v9906' == 512
		replace egp12 = 60 if `v9906' == 516
		replace egp12 = 60 if `v9906' == 517
		replace egp12 = 60 if `v9906' == 518
		replace egp12 = 60 if `v9906' == 551
		replace egp12 = 60 if `v9906' == 552
		replace egp12 = 60 if `v9906' == 553
		replace egp12 = 60 if `v9906' == 554
		replace egp12 = 60 if `v9906' == 555
		replace egp12 = 60 if `v9906' == 556
		replace egp12 = 60 if `v9906' == 557
		replace egp12 = 60 if `v9906' == 561
		replace egp12 = 60 if `v9906' == 562
		replace egp12 = 60 if `v9906' == 563
		replace egp12 = 60 if `v9906' == 572
		replace egp12 = 60 if `v9906' == 573
		replace egp12 = 60 if `v9906' == 581
		replace egp12 = 60 if `v9906' == 731
		replace egp12 = 60 if `v9906' == 741
		replace egp12 = 60 if `v9906' == 743
		replace egp12 = 60 if `v9906' == 745
		replace egp12 = 60 if `v9906' == 746
		replace egp12 = 60 if `v9906' == 813
		replace egp12 = 60 if `v9906' == 822
		replace egp12 = 60 if `v9906' == 823
		replace egp12 = 60 if `v9906' == 824
		replace egp12 = 60 if `v9906' == 866
		replace egp12 = 60 if `v9906' == 867
		replace egp12 = 60 if `v9906' == 868
		replace egp12 = 60 if `v9906' == 913
		replace egp12 = 60 if `v9906' == 915
		replace egp12 = 60 if `v9906' == 917
		replace egp12 = 60 if `v9906' == 921
		replace egp12 = 60 if `v9906' == 922

		replace egp12 = 71 if `v9906' == 272
		replace egp12 = 71 if `v9906' == 333
		replace egp12 = 71 if `v9906' == 341
		replace egp12 = 71 if `v9906' == 351
		replace egp12 = 71 if `v9906' == 361
		replace egp12 = 71 if `v9906' == 371
		replace egp12 = 71 if `v9906' == 391
		replace egp12 = 71 if `v9906' == 441
		replace egp12 = 71 if `v9906' == 442
		replace egp12 = 71 if `v9906' == 443
		replace egp12 = 71 if `v9906' == 444
		replace egp12 = 71 if `v9906' == 445
		replace egp12 = 71 if `v9906' == 446
		replace egp12 = 71 if `v9906' == 447
		replace egp12 = 71 if `v9906' == 448
		replace egp12 = 71 if `v9906' == 449
		replace egp12 = 71 if `v9906' == 450
		replace egp12 = 71 if `v9906' == 451
		replace egp12 = 71 if `v9906' == 452
		replace egp12 = 71 if `v9906' == 461
		replace egp12 = 71 if `v9906' == 462
		replace egp12 = 71 if `v9906' == 475
		replace egp12 = 71 if `v9906' == 483
		replace egp12 = 71 if `v9906' == 486
		replace egp12 = 71 if `v9906' == 490
		replace egp12 = 71 if `v9906' == 513
		replace egp12 = 71 if `v9906' == 514
		replace egp12 = 71 if `v9906' == 515
		replace egp12 = 71 if `v9906' == 519
		replace egp12 = 71 if `v9906' == 520
		replace egp12 = 71 if `v9906' == 521
		replace egp12 = 71 if `v9906' == 531
		replace egp12 = 71 if `v9906' == 532
		replace egp12 = 71 if `v9906' == 533
		replace egp12 = 71 if `v9906' == 534
		replace egp12 = 71 if `v9906' == 535
		replace egp12 = 71 if `v9906' == 536
		replace egp12 = 71 if `v9906' == 537
		replace egp12 = 71 if `v9906' == 538
		replace egp12 = 71 if `v9906' == 539
		replace egp12 = 71 if `v9906' == 540
		replace egp12 = 71 if `v9906' == 541
		replace egp12 = 71 if `v9906' == 542
		replace egp12 = 71 if `v9906' == 543
		replace egp12 = 71 if `v9906' == 544
		replace egp12 = 71 if `v9906' == 545
		replace egp12 = 71 if `v9906' == 564
		replace egp12 = 71 if `v9906' == 574
		replace egp12 = 71 if `v9906' == 575
		replace egp12 = 71 if `v9906' == 576
		replace egp12 = 71 if `v9906' == 577
		replace egp12 = 71 if `v9906' == 578
		replace egp12 = 71 if `v9906' == 579
		replace egp12 = 71 if `v9906' == 580
		replace egp12 = 71 if `v9906' == 582
		replace egp12 = 71 if `v9906' == 583
		replace egp12 = 71 if `v9906' == 584
		replace egp12 = 71 if `v9906' == 585
		replace egp12 = 71 if `v9906' == 586
		replace egp12 = 71 if `v9906' == 587
		replace egp12 = 71 if `v9906' == 589
		replace egp12 = 71 if `v9906' == 611
		replace egp12 = 71 if `v9906' == 612
		replace egp12 = 71 if `v9906' == 613
		replace egp12 = 71 if `v9906' == 614
		replace egp12 = 71 if `v9906' == 615
		replace egp12 = 71 if `v9906' == 616
		replace egp12 = 71 if `v9906' == 617
		replace egp12 = 71 if `v9906' == 621
		replace egp12 = 71 if `v9906' == 723
		replace egp12 = 71 if `v9906' == 724
		replace egp12 = 71 if `v9906' == 725
		replace egp12 = 71 if `v9906' == 726
		replace egp12 = 71 if `v9906' == 727
		replace egp12 = 71 if `v9906' == 732
		replace egp12 = 71 if `v9906' == 751
		replace egp12 = 71 if `v9906' == 752
		replace egp12 = 71 if `v9906' == 762
		replace egp12 = 71 if `v9906' == 775
		replace egp12 = 71 if `v9906' == 801
		replace egp12 = 71 if `v9906' == 802
		replace egp12 = 71 if `v9906' == 803
		replace egp12 = 71 if `v9906' == 804
		replace egp12 = 71 if `v9906' == 805
		replace egp12 = 71 if `v9906' == 806
		replace egp12 = 71 if `v9906' == 807
		replace egp12 = 71 if `v9906' == 808
		replace egp12 = 71 if `v9906' == 812
		replace egp12 = 71 if `v9906' == 825
		replace egp12 = 71 if `v9906' == 826
		replace egp12 = 71 if `v9906' == 841
		replace egp12 = 71 if `v9906' == 842
		replace egp12 = 71 if `v9906' == 843
		replace egp12 = 71 if `v9906' == 844
		replace egp12 = 71 if `v9906' == 916
		replace egp12 = 71 if `v9906' == 919
		replace egp12 = 71 if `v9906' == 920
		replace egp12 = 71 if `v9906' == 923
		replace egp12 = 71 if `v9906' == 924
		replace egp12 = 71 if `v9906' == 925
		replace egp12 = 71 if `v9906' == 926

		replace egp12 = 72 if `v9906' == 302
		replace egp12 = 72 if `v9906' == 303
		replace egp12 = 72 if `v9906' == 304
		replace egp12 = 72 if `v9906' == 305
		replace egp12 = 72 if `v9906' == 321
		replace egp12 = 72 if `v9906' == 322
		replace egp12 = 72 if `v9906' == 331
		replace egp12 = 72 if `v9906' == 332
		replace egp12 = 72 if `v9906' == 334
		replace egp12 = 72 if `v9906' == 336
		replace egp12 = 72 if `v9906' == 345
		replace egp12 = 72 if `v9906' == 381
		replace egp12 = 72 if `v9906' == 753


		replace egp12 = 50 if `v9906' == 125
		replace egp12 = 20 if `v9906' == 173
		replace egp12 = 60 if `v9906' == 821
		replace egp12 = 44 if `v9906' == 851

		replace egp12 = 60 if `v9906' == 741
		replace egp12 = 60 if `v9906' == 742

		replace egp12 = 72 if `v9906' == 300

		replace egp12 = 60 if `v9906' == 744

		replace egp12 = 71 if `v9906' == 476
		replace egp12 = 20 if `v9906' == 172

		/* adicionando ocupação 133 (técnicos em meteorologia)  -- WM, copiado de pós-2002*/ 

		replace egp12 = 32 if `v9906' == 133

		* adicionando ocupação 161 (acadêmicos de hospital)

		replace egp12 = 20 if `v9906' == 161

		* adicionando ocupação 31 (administração na extração vegetal e pesca)

		replace egp12 = 50 if `v9906' == 31

		* adicionando ocupação 335 (ervateiros)

		replace egp12 = 72 if `v9906' == 335


		*******
		* para classificar militares

		replace egp12 = 31 if `v9906' == 861
		replace egp12 = 71 if `v9906' == 862
	}


	}
}

*********************************************************************
* 3 - Labels e recodes
*********************************************************************

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

	lab val egp12 egp12
}

end
