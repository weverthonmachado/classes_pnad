/*---------------------------------------------------------------------		
/// Arquivo base para codificação classes_pnad

- Macros definidas no arquivo principal classes_pnad.ado

Última alteração: 04/12/2016
--------------------------------------------------------------------*/

/*********************************************************************
* 0 - Cria/recod. variáveis auxiliares do suplemento mobilidade 2014
**********************************************************************/

if "`mobilidade'" != "" & `ano'==2014 & `supl'==1 {

	* Posição na ocupação
	tempvar posocup
	gen `posocup' = `posocup_supl'
	recode `posocup' 3=9 4=10 .=. else=1
	replace `posocup' = 2 if `mil_fp' == 1

	* Agrícola ou não
	tempvar ativagr
	gen `ativagr' = `codativ'
	recode `ativagr' 1/5002=1  .=.  else=2

	* Grupamentos de atividade
	tempvar grupoativ
	gen `grupoativ' = `codativ'
	#delimit ;
	recode `grupoativ'  1/5002=1  
						10000 11000 12000 13001 13002 14001 14002 14003 14004 40010 40020 41000=2
						15010/37000 = 3
						45000/45999 = 4
						50000/53999 = 5
						55000/55999 = 6
						60000/64999 = 7
						75000/75999 = 8
						80000/85999 = 9
						95000 		= 10
						90000/93999 = 11
						65000/74999 99000 = 12
						99888		=13
	;
	#delimit cr

}

/*********************************************************************
* 1 - Conversão para CBO-Domiciliar
**********************************************************************/

if `ano'>2001 {
	quietly {

	/*--------------------------------------------------------------------
	- 1.1 Atividade econômica do empreendimento
	---------------------------------------------------------------------*/
	
	tempvar ind
	gen `ind'=`codativ'

	replace `ind' = 7 if `codativ' >= 1101 & `codativ' <= 1500		
	replace `ind' = 7 if `codativ' == 2001 | `codativ' == 2002		
	replace `ind' = 7 if `codativ' == 5001 | `codativ' == 5002		
	replace `ind' = 2 if `codativ' >= 15010 & `codativ' <= 15055 // modificação: troquei 15050 por 15055, incluindo `ind'. de bebidas - WM
	replace `ind' = 2 if `codativ' >= 45005 & `codativ' <= 45999
	replace `ind' = 2 if `codativ' >= 40010 & `codativ' <= 40020
	replace `ind' = 2 if `codativ' == 41000		
	replace `ind' = 2 if `codativ' == 16000		
	replace `ind' = 2 if `codativ' >= 17001 & `codativ' <= 17002		
	replace `ind' = 2 if `codativ' >= 18001 & `codativ' <= 18002		
	replace `ind' = 2 if `codativ' >= 19011 & `codativ' <= 19020		
	replace `ind' = 2 if `codativ' == 20000		
	replace `ind' = 2 if `codativ' == 22000		
	replace `ind' = 2 if `codativ' >= 21001 & `codativ' <= 21002		
	replace `ind' = 2 if `codativ' >= 28001 & `codativ' <= 28002		
	replace `ind' = 2 if `codativ' >= 36010 & `codativ' <= 36090		
	replace `ind' = 1 if `codativ' >= 23010 & `codativ' <= 23400		
	replace `ind' = 1 if `codativ' >= 24010 & `codativ' <= 24090
	replace `ind' = 1 if `codativ' >= 25010 & `codativ' <= 25020
	replace `ind' = 1 if `codativ' >= 27001 & `codativ' <= 27003
	replace `ind' = 1 if `codativ' >= 29001 & `codativ' <= 29002
	replace `ind' = 1 if `codativ' == 30000
	replace `ind' = 1 if `codativ' == 32000
	replace `ind' = 1 if `codativ' >= 31001 & `codativ' <= 31002
	replace `ind' = 1 if `codativ' >= 33001 & `codativ' <= 33005
	replace `ind' = 1 if `codativ' >= 34001 & `codativ' <= 34003
	replace `ind' = 6 if `codativ' >= 26010 & `codativ' <= 26092
	replace `ind' = 6 if `codativ' >= 13001 & `codativ' <= 13002
	replace `ind' = 6 if `codativ' == 10000
	replace `ind' = 6 if `codativ' == 11000
	replace `ind' = 6 if `codativ' == 12000
	replace `ind' = 6 if `codativ' >= 130010 & `codativ' <= 13002
	replace `ind' = 6 if `codativ' >= 14001 & `codativ' <= 14004
	replace `ind' = 5 if `codativ' >= 75011 & `codativ' <= 75020
	replace `ind' = 4 if `codativ' == 95000
	replace `ind' = 3 if `codativ' >= 35010 & `codativ' <= 35090
	replace `ind' = 3 if `codativ' == 37000
	replace `ind' = 3 if `codativ' == 61000
	replace `ind' = 3 if `codativ' == 62000
	replace `ind' = 3 if `codativ' == 90000
	replace `ind' = 3 if `codativ' == 65000
	replace `ind' = 3 if `codativ' == 66000
	replace `ind' = 3 if `codativ' == 99000
	replace `ind' = 3 if `codativ' == 73000
	replace `ind' = 3 if `codativ' >= 50010 & `codativ' <= 50050
	replace `ind' = 3 if `codativ' >= 53010 & `codativ' <= 53113
	replace `ind' = 3 if `codativ' >= 55010 & `codativ' <= 55030
	replace `ind' = 3 if `codativ' >= 60010 & `codativ' <= 60092
	replace `ind' = 3 if `codativ' >= 63010 & `codativ' <= 63030
	replace `ind' = 3 if `codativ' >= 64010 & `codativ' <= 64020
	replace `ind' = 3 if `codativ' >= 80011 & `codativ' <= 80090
	replace `ind' = 3 if `codativ' >= 85011 & `codativ' <= 85030
	replace `ind' = 3 if `codativ' >= 91010 & `codativ' <= 91092
	replace `ind' = 3 if `codativ' >= 92010 & `codativ' <= 92040
	replace `ind' = 3 if `codativ' >= 93010 & `codativ' <= 93092
	replace `ind' = 3 if `codativ' >= 67010 & `codativ' <= 67020
	replace `ind' = 3 if `codativ' >= 70001 & `codativ' <= 70002
	replace `ind' = 3 if `codativ' >= 71010 & `codativ' <= 71030
	replace `ind' = 3 if `codativ' >= 72010 & `codativ' <= 72020
	replace `ind' = 3 if `codativ' >= 74011 & `codativ' <= 74090
	replace `ind' = .a if `codativ' == 99888   // alternativa a colocar 99 como user missing 
	replace `ind' = .a if `codativ' == 99999

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

	replace `ibge90' = 861 if `cbo' == 401                                                                       
	replace `ibge90' = 861 if `cbo' == 402                                                                       
	replace `ibge90' = 861 if `cbo' == 403                                                                       
	replace `ibge90' = 861 if `cbo' == 411                                                                       
	replace `ibge90' = 862 if `cbo' == 413                                                                       
	replace `ibge90' = 863 if `cbo' == 501                                                                       
	replace `ibge90' = 863 if `cbo' == 502                                                                       
	replace `ibge90' = 863 if `cbo' == 503                                                                       
	replace `ibge90' = 863 if `cbo' == 511                                                                       
	replace `ibge90' = 863 if `cbo' == 512                                                                       
	replace `ibge90' = 863 if `cbo' == 513                                                                       
	replace `ibge90' = 20 if `cbo' == 1111                                                                       
	replace `ibge90' = 20 if `cbo' == 1112                                                                       
	replace `ibge90' = 231 if `cbo' == 1113                                                                       
	replace `ibge90' = 20 if `cbo' == 1122
	replace `ibge90' = 21 if `cbo' == 1123
	replace `ibge90' = 927 if `cbo' == 1130
	replace `ibge90' = 39 if `cbo' == 1140
	replace `ibge90' = 64 if `cbo' == 2012
	replace `ibge90' = 101 if `cbo' == 2021
	replace `ibge90' = 173 if `cbo' == 2121
	replace `ibge90' = 173 if `cbo' == 2122
	replace `ibge90' = 173 if `cbo' == 2124
	replace `ibge90' = 173 if `cbo' == 2125
	replace `ibge90' = 123 if `cbo' == 2131
	replace `ibge90' = 101 if `cbo' == 2140
	replace `ibge90' = 102 if `cbo' == 2141
	replace `ibge90' = 101 if `cbo' == 2142
	replace `ibge90' = 101 if `cbo' == 2143
	replace `ibge90' = 101 if `cbo' == 2144
	replace `ibge90' = 101 if `cbo' == 2149
	replace `ibge90' = 721 if `cbo' == 2152
	replace `ibge90' = 151 if `cbo' == 2231
	replace `ibge90' = 152 if `cbo' == 2232
	replace `ibge90' = 144 if `cbo' == 2233
	replace `ibge90' = 153 if `cbo' == 2235
	replace `ibge90' = 154 if `cbo' == 2237
	replace `ibge90' = 217 if `cbo' == 2311
	replace `ibge90' = 214 if `cbo' == 2313
	replace `ibge90' = 213 if `cbo' == 2321
	replace `ibge90' = 834 if `cbo' == 2391
	replace `ibge90' = 219 if `cbo' == 2392
	replace `ibge90' = 221 if `cbo' == 2394
	replace `ibge90' = 233 if `cbo' == 2410
	replace `ibge90' = 232 if `cbo' == 2412
	replace `ibge90' = 293 if `cbo' == 2419
	replace `ibge90' = 864 if `cbo' == 2423
	replace `ibge90' = 201 if `cbo' == 2511
	replace `ibge90' = 205 if `cbo' == 2514
	replace `ibge90' = 202 if `cbo' == 2515
	replace `ibge90' = 59 if `cbo' == 2523
	replace `ibge90' = 64 if `cbo' == 2524
	replace `ibge90' = 64 if `cbo' == 2525
	replace `ibge90' = 291 if `cbo' == 2612
	replace `ibge90' = 276 if `cbo' == 2622
	replace `ibge90' = 273 if `cbo' == 2627
	replace `ibge90' = 402 if `cbo' == 3001
	replace `ibge90' = 402 if `cbo' == 3003
	replace `ibge90' = 402 if `cbo' == 3012
	replace `ibge90' = 131 if `cbo' == 3112
	replace `ibge90' = 402 if `cbo' == 3113
	replace `ibge90' = 131 if `cbo' == 3114
	replace `ibge90' = 112 if `cbo' == 3122
	replace `ibge90' = 503 if `cbo' == 3132
	replace `ibge90' = 402 if `cbo' == 3136
	replace `ibge90' = 402 if `cbo' == 3137
	replace `ibge90' = 402 if `cbo' == 3142
	replace `ibge90' = 425 if `cbo' == 3144
	replace `ibge90' = 113 if `cbo' == 3162
	replace `ibge90' = 58 if `cbo' == 3171
	replace `ibge90' = 403 if `cbo' == 3191
	replace `ibge90' = 402 if `cbo' == 3192
	replace `ibge90' = 402 if `cbo' == 3201
	replace `ibge90' = 302 if `cbo' == 3210
	replace `ibge90' = 302 if `cbo' == 3212
	replace `ibge90' = 302 if `cbo' == 3213
	replace `ibge90' = 302 if `cbo' == 3214
	replace `ibge90' = 164 if `cbo' == 3223
	replace `ibge90' = 167 if `cbo' == 3224
	replace `ibge90' = 144 if `cbo' == 3231
	replace `ibge90' = 144 if `cbo' == 3232
	replace `ibge90' = 165 if `cbo' == 3241
	replace `ibge90' = 168 if `cbo' == 3242
	replace `ibge90' = 927 if `cbo' == 3281
	replace `ibge90' = 218 if `cbo' == 3313
	replace `ibge90' = 218 if `cbo' == 3322
	replace `ibge90' = 711 if `cbo' == 3411
	replace `ibge90' = 402 if `cbo' == 3421
	replace `ibge90' = 64 if `cbo' == 3422
	replace `ibge90' = 643 if `cbo' == 3531
	replace `ibge90' = 53 if `cbo' == 3532
	replace `ibge90' = 644 if `cbo' == 3544
	replace `ibge90' = 641 if `cbo' == 3545
	replace `ibge90' = 642 if `cbo' == 3546
	replace `ibge90' = 643 if `cbo' == 3547
	replace `ibge90' = 645 if `cbo' == 3548
	replace `ibge90' = 402 if `cbo' == 3713
	replace `ibge90' = 280 if `cbo' == 3721
	replace `ibge90' = 274 if `cbo' == 3722
	replace `ibge90' = 282 if `cbo' == 3731
	replace `ibge90' = 282 if `cbo' == 3732
	replace `ibge90' = 281 if `cbo' == 3741
	replace `ibge90' = 283 if `cbo' == 3743
	replace `ibge90' = 276 if `cbo' == 3761
	replace `ibge90' = 834 if `cbo' == 3771
	replace `ibge90' = 833 if `cbo' == 3773
	replace `ibge90' = 845 if `cbo' == 4123
	replace `ibge90' = 64 if `cbo' == 4214
	replace `ibge90' = 774 if `cbo' == 4222
	replace `ibge90' = 774 if `cbo' == 4223
	replace `ibge90' = 64 if `cbo' == 4231
	replace `ibge90' = 825 if `cbo' == 5102
	replace `ibge90' = 741 if `cbo' == 5112
	replace `ibge90' = 801 if `cbo' == 5121
	replace `ibge90' = 927 if `cbo' == 5166
	replace `ibge90' = 927 if `cbo' == 5191
	replace `ibge90' = 927 if `cbo' == 5198
	replace `ibge90' = 604 if `cbo' == 5221
	replace `ibge90' = 304 if `cbo' == 6210
	replace `ibge90' = 331 if `cbo' == 6329
	replace `ibge90' = 303 if `cbo' == 6410
	replace `ibge90' = 303 if `cbo' == 6420
	replace `ibge90' = 303 if `cbo' == 6430
	replace `ibge90' = 521 if `cbo' == 7151
	replace `ibge90' = 521 if `cbo' == 7154
	replace `ibge90' = 482 if `cbo' == 7155
	replace `ibge90' = 518 if `cbo' == 7163
	replace `ibge90' = 516 if `cbo' == 7165
	replace `ibge90' = 402 if `cbo' == 7202
	replace `ibge90' = 413 if `cbo' == 7224
	replace `ibge90' = 411 if `cbo' == 7231
	replace `ibge90' = 427 if `cbo' == 7242
	replace `ibge90' = 426 if `cbo' == 7243
	replace `ibge90' = 927 if `cbo' == 7246
	replace `ibge90' = 423 if `cbo' == 7252
	replace `ibge90' = 423 if `cbo' == 7253
	replace `ibge90' = 423 if `cbo' == 7254
	replace `ibge90' = 423 if `cbo' == 7255
	replace `ibge90' = 423 if `cbo' == 7257
	replace `ibge90' = 503 if `cbo' == 7301
	replace `ibge90' = 402 if `cbo' == 7401
	replace `ibge90' = 589 if `cbo' == 7421
	replace `ibge90' = 402 if `cbo' == 7501
	replace `ibge90' = 402 if `cbo' == 7502
	replace `ibge90' = 561 if `cbo' == 7521
	replace `ibge90' = 561 if `cbo' == 7522
	replace `ibge90' = 562 if `cbo' == 7523
	replace `ibge90' = 402 if `cbo' == 7602
	replace `ibge90' = 402 if `cbo' == 7604
	replace `ibge90' = 462 if `cbo' == 7620
	replace `ibge90' = 462 if `cbo' == 7621
	replace `ibge90' = 462 if `cbo' == 7623
	replace `ibge90' = 478 if `cbo' == 7642
	replace `ibge90' = 478 if `cbo' == 7643
	replace `ibge90' = 461 if `cbo' == 7651
	replace `ibge90' = 589 if `cbo' == 7654
	replace `ibge90' = 554 if `cbo' == 7660
	replace `ibge90' = 274 if `cbo' == 7664
	replace `ibge90' = 474 if `cbo' == 7682
	replace `ibge90' = 486 if `cbo' == 7732
	replace `ibge90' = 484 if `cbo' == 7735
	replace `ibge90' = 482 if `cbo' == 7771
	replace `ibge90' = 482 if `cbo' == 7772
	replace `ibge90' = 589 if `cbo' == 7811
	replace `ibge90' = 589 if `cbo' == 7813
	replace `ibge90' = 927 if `cbo' == 7817
	replace `ibge90' = 751 if `cbo' == 7820
	replace `ibge90' = 751 if `cbo' == 7824
	replace `ibge90' = 402 if `cbo' == 8101
	replace `ibge90' = 402 if `cbo' == 8102
	replace `ibge90' = 402 if `cbo' == 8103
	replace `ibge90' = 589 if `cbo' == 8110
	replace `ibge90' = 589 if `cbo' == 8114
	replace `ibge90' = 589 if `cbo' == 8115
	replace `ibge90' = 927 if `cbo' == 8131
	replace `ibge90' = 402 if `cbo' == 8201
	replace `ibge90' = 402 if `cbo' == 8202
	replace `ibge90' = 402 if `cbo' == 8301
	replace `ibge90' = 585 if `cbo' == 8321
	replace `ibge90' = 585 if `cbo' == 8339
	replace `ibge90' = 545 if `cbo' == 8401
	replace `ibge90' = 545 if `cbo' == 8412
	replace `ibge90' = 539 if `cbo' == 8413
	replace `ibge90' = 580 if `cbo' == 8423
	replace `ibge90' = 580 if `cbo' == 8429
	replace `ibge90' = 509 if `cbo' == 8611
	replace `ibge90' = 509 if `cbo' == 8612
	replace `ibge90' = 922 if `cbo' == 8622
	replace `ibge90' = 923 if `cbo' == 8624
	replace `ibge90' = 923 if `cbo' == 8625
	replace `ibge90' = 927 if `cbo' == 8711
	replace `ibge90' = 402 if `cbo' == 9109
	replace `ibge90' = 425 if `cbo' == 9111
	replace `ibge90' = 425 if `cbo' == 9112
	replace `ibge90' = 424 if `cbo' == 9141
	replace `ibge90' = 425 if `cbo' == 9142
	replace `ibge90' = 424 if `cbo' == 9143
	replace `ibge90' = 425 if `cbo' == 9151
	replace `ibge90' = 589 if `cbo' == 9152
	replace `ibge90' = 425 if `cbo' == 9153
	replace `ibge90' = 425 if `cbo' == 9154
	replace `ibge90' = 921 if `cbo' == 9191
	replace `ibge90' = 425 if `cbo' == 9192
	replace `ibge90' = 402 if `cbo' == 9501
	replace `ibge90' = 402 if `cbo' == 9502
	replace `ibge90' = 402 if `cbo' == 9503
	replace `ibge90' = 506 if `cbo' == 9513                                                                                                                                                       
	replace `ibge90' = 506 if `cbo' == 9531                                                                                                                                                       
	replace `ibge90' = 503 if `cbo' == 9541                                                                                                                                                       
	replace `ibge90' = 425 if `cbo' == 9543                                                                                                                                                       
	replace `ibge90' = 762 if `cbo' == 9911                                                                                                                                                       
	replace `ibge90' = 425 if `cbo' == 9912                                                                                                                                                       
	replace `ibge90' = 521 if `cbo' == 9914                                                                                                                                                       
	replace `ibge90' = 574 if `cbo' == 9921                                                                                                                                                       
	replace `ibge90' = 925 if `cbo' == 9922                                                                                                                                                       
	replace `ibge90' = 928 if `cbo' == 9988                                                                                                                                                       
	replace `ibge90' = 928 if `cbo' == 9999                                                                                                                                                                                                                                                                                                                       
	replace `ibge90' = 861 if `cbo' == 100                                                                                                                                                       
	replace `ibge90' = 862 if `cbo' == 200                                                                                                                                                       
	replace `ibge90' = 861 if `cbo' == 300                                                                                                                                                       
	replace `ibge90' = 862 if `cbo' == 412                                                                                                                                                       
	replace `ibge90' = 21 if `cbo' == 1210
	replace `ibge90' = 8 if `cbo' == 1219
	replace `ibge90' = 21 if `cbo' == 1220
	replace `ibge90' = 34 if `cbo' == 1230
	replace `ibge90' = 33 if `cbo' == 1310
	replace `ibge90' = 33 if `cbo' == 1320
	replace `ibge90' = 101 if `cbo' == 2011
	replace `ibge90' = 171 if `cbo' == 2111
	replace `ibge90' = 172 if `cbo' == 2112
	replace `ibge90' = 173 if `cbo' == 2123
	replace `ibge90' = 121 if `cbo' == 2132
	replace `ibge90' = 125 if `cbo' == 2133
	replace `ibge90' = 124 if `cbo' == 2134
	replace `ibge90' = 101 if `cbo' == 2145
	replace `ibge90' = 101 if `cbo' == 2146
	replace `ibge90' = 124 if `cbo' == 2147
	replace `ibge90' = 103 if `cbo' == 2148
	replace `ibge90' = 721 if `cbo' == 2151
	replace `ibge90' = 711 if `cbo' == 2153
	replace `ibge90' = 143 if `cbo' == 2211
	replace `ibge90' = 141 if `cbo' == 2221
	replace `ibge90' = 122 if `cbo' == 2234
	replace `ibge90' = 163 if `cbo' == 2236
	replace `ibge90' = 215 if `cbo' == 2312
	replace `ibge90' = 218 if `cbo' == 2330
	replace `ibge90' = 211 if `cbo' == 2340
	replace `ibge90' = 231 if `cbo' == 2421
	replace `ibge90' = 233 if `cbo' == 2422
	replace `ibge90' = 181 if `cbo' == 2512
	replace `ibge90' = 205 if `cbo' == 2513
	replace `ibge90' = 204 if `cbo' == 2516
	replace `ibge90' = 183 if `cbo' == 2521
	replace `ibge90' = 182 if `cbo' == 2522
	replace `ibge90' = 645 if `cbo' == 2531
	replace `ibge90' = 261 if `cbo' == 2611
	replace `ibge90' = 292 if `cbo' == 2613
	replace `ibge90' = 293 if `cbo' == 2614
	replace `ibge90' = 261 if `cbo' == 2615
	replace `ibge90' = 261 if `cbo' == 2616
	replace `ibge90' = 278 if `cbo' == 2617
	replace `ibge90' = 279 if `cbo' == 2621
	replace `ibge90' = 276 if `cbo' == 2623
	replace `ibge90' = 275 if `cbo' == 2624
	replace `ibge90' = 271 if `cbo' == 2625
	replace `ibge90' = 251 if `cbo' == 2631
	replace `ibge90' = 131 if `cbo' == 3011
	replace `ibge90' = 131 if `cbo' == 3111
	replace `ibge90' = 405 if `cbo' == 3115
	replace `ibge90' = 403 if `cbo' == 3116
	replace `ibge90' = 403 if `cbo' == 3117
	replace `ibge90' = 112 if `cbo' == 3121
	replace `ibge90' = 113 if `cbo' == 3123
	replace `ibge90' = 503 if `cbo' == 3131
	replace `ibge90' = 505 if `cbo' == 3134
	replace `ibge90' = 507 if `cbo' == 3135
	replace `ibge90' = 425 if `cbo' == 3141
	replace `ibge90' = 425 if `cbo' == 3143
	replace `ibge90' = 402 if `cbo' == 3146
	replace `ibge90' = 402 if `cbo' == 3147
	replace `ibge90' = 401 if `cbo' == 3161
	replace `ibge90' = 401 if `cbo' == 3163
	replace `ibge90' = 58 if `cbo' == 3172
	replace `ibge90' = 111 if `cbo' == 3189
	replace `ibge90' = 302 if `cbo' == 3211
	replace `ibge90' = 154 if `cbo' == 3221                                                       
	replace `ibge90' = 162 if `cbo' == 3222                                                       
	replace `ibge90' = 163 if `cbo' == 3225                                                       
	replace `ibge90' = 121 if `cbo' == 3250                                                       
	replace `ibge90' = 132 if `cbo' == 3251                                                       
	replace `ibge90' = 402 if `cbo' == 3252                                                       
	replace `ibge90' = 168 if `cbo' == 3253                                                       
	replace `ibge90' = 217 if `cbo' == 3311                                                       
	replace `ibge90' = 217 if `cbo' == 3312                                                       
	replace `ibge90' = 217 if `cbo' == 3321                                                       
	replace `ibge90' = 219 if `cbo' == 3331                                                       
	replace `ibge90' = 222 if `cbo' == 3341                                                       
	replace `ibge90' = 722 if `cbo' == 3412                                                       
	replace `ibge90' = 506 if `cbo' == 3413                                                       
	replace `ibge90' = 761 if `cbo' == 3423                                                       
	replace `ibge90' = 741 if `cbo' == 3424                                                       
	replace `ibge90' = 761 if `cbo' == 3425                                                                       
	replace `ibge90' = 721 if `cbo' == 3426                                                                       
	replace `ibge90' = 182 if `cbo' == 3511                                                                       
	replace `ibge90' = 192 if `cbo' == 3512                                                                       
	replace `ibge90' = 183 if `cbo' == 3513                                                                       
	replace `ibge90' = 242 if `cbo' == 3514                                                                       
	replace `ibge90' = 50 if `cbo' == 3515                                                                       
	replace `ibge90' = 51 if `cbo' == 3516                                                                       
	replace `ibge90' = 641 if `cbo' == 3517                                                                       
	replace `ibge90' = 864 if `cbo' == 3518                                                                       
	replace `ibge90' = 917 if `cbo' == 3522                                                                       
	replace `ibge90' = 918 if `cbo' == 3523                                                                       
	replace `ibge90' = 64 if `cbo' == 3524                                                                       
	replace `ibge90' = 51 if `cbo' == 3525                                                                       
	replace `ibge90' = 645 if `cbo' == 3541                                                                       
	replace `ibge90' = 646 if `cbo' == 3542                                                                       
	replace `ibge90' = 632 if `cbo' == 3543                                                                       
	replace `ibge90' = 291 if `cbo' == 3711                                                                       
	replace `ibge90' = 292 if `cbo' == 3712                                                                       
	replace `ibge90' = 773 if `cbo' == 3723                                                                       
	replace `ibge90' = 281 if `cbo' == 3742                                                                       
	replace `ibge90' = 273 if `cbo' == 3751                                                                       
	replace `ibge90' = 275 if `cbo' == 3762                                                                       
	replace `ibge90' = 277 if `cbo' == 3763                                                                       
	replace `ibge90' = 276 if `cbo' == 3764                                                                       
	replace `ibge90' = 927 if `cbo' == 3765                                                                       
	replace `ibge90' = 831 if `cbo' == 3772                                                                       
	replace `ibge90' = 571 if `cbo' == 3911                                                                       
	replace `ibge90' = 571 if `cbo' == 3912                                                                       
	replace `ibge90' = 40 if `cbo' == 4101                                                                       
	replace `ibge90' = 40 if `cbo' == 4102                                                                       
	replace `ibge90' = 64 if `cbo' == 4110                                                                       
	replace `ibge90' = 59 if `cbo' == 4121                                                                       
	replace `ibge90' = 56 if `cbo' == 4122                                                                       
	replace `ibge90' = 64 if `cbo' == 4131                                                                       
	replace `ibge90' = 64 if `cbo' == 4132                                                                       
	replace `ibge90' = 54 if `cbo' == 4141                                                                       
	replace `ibge90' = 64 if `cbo' == 4142                                                                       
	replace `ibge90' = 64 if `cbo' == 4151                                                                       
	replace `ibge90' = 775 if `cbo' == 4152                                                                       
	replace `ibge90' = 193 if `cbo' == 4201                                                                       
	replace `ibge90' = 603 if `cbo' == 4211                                                                       
	replace `ibge90' = 53 if `cbo' == 4212                                                                       
	replace `ibge90' = 927 if `cbo' == 4213                                                                       
	replace `ibge90' = 63 if `cbo' == 4221                                                                       
	replace `ibge90' = 192 if `cbo' == 4241                                                                       
	replace `ibge90' = 841 if `cbo' == 5101                                                                       
	replace `ibge90' = 913 if `cbo' == 5103                                                                       
	replace `ibge90' = 712 if `cbo' == 5111                                                                       
	*replace `ibge90' = 752 if `cbo' == 5112    cód. 5112 já convertido pra 741 acima, dá no mesmo - WM                                                                 
	replace `ibge90' = 927 if `cbo' == 5114                                                                       
	replace `ibge90' = 801 if `cbo' == 5121                                                                       
	replace `ibge90' = 816 if `cbo' == 5131                                                                       
	replace `ibge90' = 813 if `cbo' == 5132                                                                       
	replace `ibge90' = 816 if `cbo' == 5133                                                                       
	replace `ibge90' = 815 if `cbo' == 5134                                                                       
	replace `ibge90' = 844 if `cbo' == 5141                                                                       
	replace `ibge90' = 844 if `cbo' == 5142                                                                       
	replace `ibge90' = 166 if `cbo' == 5151                                                                       
	replace `ibge90' = 162 if `cbo' == 5152                                                                       
	replace `ibge90' = 821 if `cbo' == 5161                                                                       
	replace `ibge90' = 926 if `cbo' == 5162                                                                       
	replace `ibge90' = 802 if `cbo' == 5165                                                                       
	replace `ibge90' = 927 if `cbo' == 5167                                                                       
	replace `ibge90' = 825 if `cbo' == 5169                                                                       
	replace `ibge90' = 913 if `cbo' == 5171                                                                       
	replace `ibge90' = 866 if `cbo' == 5172                                                                       
	replace `ibge90' = 869 if `cbo' == 5173                                                                       
	replace `ibge90' = 843 if `cbo' == 5174                                                                       
	replace `ibge90' = 927 if `cbo' == 5192                                                                       
	replace `ibge90' = 927 if `cbo' == 5199                                                                       
	replace `ibge90' = 35 if `cbo' == 5201                                                                       
	replace `ibge90' = 602 if `cbo' == 5211                                                                       
	replace `ibge90' = 506 if `cbo' == 5231                                                                       
	replace `ibge90' = 617 if `cbo' == 5241                                                                       
	replace `ibge90' = 611 if `cbo' == 5242                                                                       
	replace `ibge90' = 613 if `cbo' == 5243                                                                       
	replace `ibge90' = 301 if `cbo' == 6110                                                                       
	replace `ibge90' = 304 if `cbo' == 6129                                                                       
	replace `ibge90' = 301 if `cbo' == 6139                                                                       
	replace `ibge90' = 304 if `cbo' == 6201                                                       
	replace `ibge90' = 304 if `cbo' == 6229                                                       
	replace `ibge90' = 304 if `cbo' == 6239                                                       
	replace `ibge90' = 331 if `cbo' == 6301                                                       
	replace `ibge90' = 305 if `cbo' == 6319                                                       
	replace `ibge90' = 401 if `cbo' == 7101                                                       
	replace `ibge90' = 404 if `cbo' == 7102                                                       
	replace `ibge90' = 341 if `cbo' == 7111                                                       
	replace `ibge90' = 351 if `cbo' == 7112                                                       
	replace `ibge90' = 391 if `cbo' == 7113                                                       
	replace `ibge90' = 381 if `cbo' == 7114                                                       
	replace `ibge90' = 351 if `cbo' == 7121                                                       
	replace `ibge90' = 578 if `cbo' == 7122                                                       
	replace `ibge90' = 512 if `cbo' == 7152                                                       
	replace `ibge90' = 511 if `cbo' == 7153                                                       
	replace `ibge90' = 506 if `cbo' == 7156                                                       
	replace `ibge90' = 519 if `cbo' == 7157                                                       
	replace `ibge90' = 512 if `cbo' == 7161                                                       
	replace `ibge90' = 519 if `cbo' == 7162                                                       
	replace `ibge90' = 515 if `cbo' == 7164                                                       
	replace `ibge90' = 514 if `cbo' == 7166                                                       
	replace `ibge90' = 513 if `cbo' == 7170                                                       
	replace `ibge90' = 402 if `cbo' == 7201                                                       
	replace `ibge90' = 418 if `cbo' == 7211                                                       
	replace `ibge90' = 417 if `cbo' == 7212                                                       
	replace `ibge90' = 417 if `cbo' == 7213                                                       
	replace `ibge90' = 416 if `cbo' == 7214                                                       
	replace `ibge90' = 422 if `cbo' == 7215                                                       
	replace `ibge90' = 429 if `cbo' == 7221                                                       
	replace `ibge90' = 411 if `cbo' == 7222                                                       
	replace `ibge90' = 414 if `cbo' == 7223                                                       
	replace `ibge90' = 415 if `cbo' == 7232                                                       
	replace `ibge90' = 581 if `cbo' == 7233                                                       
	replace `ibge90' = 517 if `cbo' == 7241                                                       
	replace `ibge90' = 428 if `cbo' == 7244                                                       
	replace `ibge90' = 428 if `cbo' == 7245                                                       
	replace `ibge90' = 423 if `cbo' == 7250                                                       
	replace `ibge90' = 423 if `cbo' == 7251                                                       
	replace `ibge90' = 423 if `cbo' == 7256                                                       
	replace `ibge90' = 501 if `cbo' == 7311                                                       
	replace `ibge90' = 504 if `cbo' == 7312                                                       
	replace `ibge90' = 507 if `cbo' == 7313                                                       
	replace `ibge90' = 501 if `cbo' == 7321                                                       
	replace `ibge90' = 423 if `cbo' == 7411                                                       
	replace `ibge90' = 572 if `cbo' == 7519                                                       
	replace `ibge90' = 561 if `cbo' == 7524                                                       
	replace `ibge90' = 403 if `cbo' == 7601                                                       
	replace `ibge90' = 470 if `cbo' == 7603                                                       
	replace `ibge90' = 402 if `cbo' == 7605                                                       
	replace `ibge90' = 402 if `cbo' == 7606                                                       
	replace `ibge90' = 441 if `cbo' == 7610                                                       
	replace `ibge90' = 441 if `cbo' == 7611                                                       
	replace `ibge90' = 441 if `cbo' == 7612                                                       
	replace `ibge90' = 441 if `cbo' == 7613                                                       
	replace `ibge90' = 450 if `cbo' == 7614                                                       
	replace `ibge90' = 451 if `cbo' == 7618                                                       
	replace `ibge90' = 462 if `cbo' == 7622                                                       
	replace `ibge90' = 470 if `cbo' == 7630                                                       
	replace `ibge90' = 473 if `cbo' == 7631                                                       
	replace `ibge90' = 470 if `cbo' == 7632                                                       
	replace `ibge90' = 470 if `cbo' == 7633                                                       
	replace `ibge90' = 478 if `cbo' == 7640                                                       
	replace `ibge90' = 477 if `cbo' == 7641                                                       
	replace `ibge90' = 476 if `cbo' == 7650                                                       
	replace `ibge90' = 470 if `cbo' == 7652                                                       
	replace `ibge90' = 461 if `cbo' == 7653                                                       
	replace `ibge90' = 551 if `cbo' == 7661                                                       
	replace `ibge90' = 554 if `cbo' == 7662                                                       
	replace `ibge90' = 552 if `cbo' == 7663                                                       
	replace `ibge90' = 448 if `cbo' == 7681                                                       
	replace `ibge90' = 461 if `cbo' == 7683                                                       
	replace `ibge90' = 551 if `cbo' == 7686                                                       
	replace `ibge90' = 556 if `cbo' == 7687                                                       
	replace `ibge90' = 482 if `cbo' == 7701                                                       
	replace `ibge90' = 481 if `cbo' == 7711                                                       
	replace `ibge90' = 585 if `cbo' == 7721                                                       
	replace `ibge90' = 485 if `cbo' == 7731                                                       
	replace `ibge90' = 481 if `cbo' == 7733                                                       
	replace `ibge90' = 484 if `cbo' == 7734                                                       
	replace `ibge90' = 481 if `cbo' == 7741                                                       
	replace `ibge90' = 481 if `cbo' == 7751
	replace `ibge90' = 490 if `cbo' == 7764
	replace `ibge90' = 584 if `cbo' == 7801
	replace `ibge90' = 731 if `cbo' == 7821
	replace `ibge90' = 731 if `cbo' == 7822
	replace `ibge90' = 751 if `cbo' == 7823
	replace `ibge90' = 751 if `cbo' == 7825
	replace `ibge90' = 743 if `cbo' == 7826
	replace `ibge90' = 727 if `cbo' == 7827
	replace `ibge90' = 753 if `cbo' == 7828
	replace `ibge90' = 746 if `cbo' == 7831
	replace `ibge90' = 924 if `cbo' == 7832
	replace `ibge90' = 584 if `cbo' == 7841
	replace `ibge90' = 583 if `cbo' == 7842
	replace `ibge90' = 589 if `cbo' == 8111
	replace `ibge90' = 589 if `cbo' == 8112
	replace `ibge90' = 589 if `cbo' == 8113
	replace `ibge90' = 589 if `cbo' == 8116
	replace `ibge90' = 586 if `cbo' == 8117
	replace `ibge90' = 589 if `cbo' == 8118
	replace `ibge90' = 576 if `cbo' == 8121
	replace `ibge90' = 927 if `cbo' == 8181
	replace `ibge90' = 589 if `cbo' == 8211
	replace `ibge90' = 411 if `cbo' == 8212
	replace `ibge90' = 412 if `cbo' == 8213
	replace `ibge90' = 427 if `cbo' == 8214
	replace `ibge90' = 414 if `cbo' == 8221
	replace `ibge90' = 589 if `cbo' == 8231
	replace `ibge90' = 562 if `cbo' == 8232
	replace `ibge90' = 587 if `cbo' == 8233
	replace `ibge90' = 564 if `cbo' == 8281
	replace `ibge90' = 585 if `cbo' == 8311
	replace `ibge90' = 545 if `cbo' == 8411
	replace `ibge90' = 543 if `cbo' == 8416
	replace `ibge90' = 545 if `cbo' == 8417
	replace `ibge90' = 579 if `cbo' == 8421
	replace `ibge90' = 540 if `cbo' == 8484
	replace `ibge90' = 533 if `cbo' == 8485
	replace `ibge90' = 584 if `cbo' == 8491
	replace `ibge90' = 545 if `cbo' == 8492
	replace `ibge90' = 535 if `cbo' == 8493
	replace `ibge90' = 405 if `cbo' == 8601
	replace `ibge90' = 583 if `cbo' == 8621
	replace `ibge90' = 583 if `cbo' == 8623
	replace `ibge90' = 403 if `cbo' == 9101
	replace `ibge90' = 402 if `cbo' == 9102
	replace `ibge90' = 425 if `cbo' == 9113
	replace `ibge90' = 425 if `cbo' == 9131
	replace `ibge90' = 425 if `cbo' == 9144                                                                                                       
	replace `ibge90' = 425 if `cbo' == 9193                                                                                                       
	replace `ibge90' = 506 if `cbo' == 9511                                                                                                       
	replace `ibge90' = 503 if `cbo' == 9542                                                                                                       
	replace `ibge90' = 581 if `cbo' == 9913                                                                                                       


	** sintaxe para refinar as ocupações que não têm equivalência perfeita

	replace `ibge90' = 7 if `posocup'==10 & `cbo'==1310 & `ind'==6
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==1310 & `ind'==3
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==1310 & `ind'==2
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==1310 & `ind'==1
	replace `ibge90' = 301 if `posocup'==9 & `cbo'==1310
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==2616
	replace `ibge90' = 15 if `posocup'==10 & `cbo'==2621
	replace `ibge90' = 852 if `posocup'==9 & `cbo'==2621
	replace `ibge90' = 10 if `posocup'==10 & `cbo'==3331



	***************   if            (       `posocup'   =       9               and             `cbo'   =       3331    )               `ibge90'  =       852     . <- linha comentada na sintaxe original
	replace `ibge90' = 15 if `posocup'==10 & `cbo'==3541
	replace `ibge90' = 601 if `posocup'==9 & `cbo'==3541 & `codativ' < 65000
	replace `ibge90' = 601 if `posocup'==9 & `cbo'==3543
	replace `ibge90' = 10 if `posocup'==10 & `cbo'==5134
	replace `ibge90' = 15 if `posocup'==10 & `cbo'==5165
	replace `ibge90' = 601 if `posocup'==9 & `cbo'==5165
	replace `ibge90' = 15 if `posocup'==10 & `cbo'==5169
	replace `ibge90' = 601 if `posocup'==9 & `cbo'==5169
	replace `ibge90' = 10 if `posocup'==10 & `cbo'==5201
	replace `ibge90' = 601 if `posocup'==9 & `cbo'==5211
	replace `ibge90' = 601 if `posocup'==10 & `cbo'==5241
	replace `ibge90' = 14 if `posocup'==10 & `cbo'==5242
	replace `ibge90' = 601 if `posocup'==9 & `cbo'==5242
	replace `ibge90' = 13 if `posocup'==10 & `cbo'==5243
	replace `ibge90' = 1 if `posocup'==10 & `cbo'==6110
	replace `ibge90' = 301 if `posocup'==9 & `cbo'==6110
	replace `ibge90' = 1 if `posocup'==10 & `cbo'==6129
	replace `ibge90' = 301 if `posocup'==9 & `cbo'==6129
	replace `ibge90' = 2 if `posocup'==10 & `cbo'==6139
	replace `ibge90' = 301 if `posocup'==9 & `cbo'==6139
	replace `ibge90' = 1 if `posocup'==10 & `cbo'==6229
	replace `ibge90' = 301 if `posocup'==9 & `cbo'==6229
	replace `ibge90' = 1 if `posocup'==10 & `cbo'==6319
	replace `ibge90' = 301 if `posocup'==9 & `cbo'==6319
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==7221
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==7519
	replace `ibge90' = 601 if `posocup'==9 & `cbo'==7519
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==7622
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==7683
	replace `ibge90' = 601 if `posocup'==9 & `cbo'==7683
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==8281
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==8411
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==8485
	replace `ibge90' = 601 if `posocup'==9 & `cbo'==8485
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==8491
	replace `ibge90' = 8 if `posocup'==10 & `cbo'==8493


	replace `ibge90' = 39 if (`cbo' == 1220 | `cbo' == 1230 | `cbo' == 1310 | `cbo' == 1320) & `grupoativ' == 9 & (`codativ' > 85010 & `codativ' < 85015) & `posocup' ~= 10
	replace `ibge90' = 10 if `cbo' == 1320 & `posocup' == 10 & (`grupoativ' == 2 | `grupoativ' == 3 | `grupoativ' == 4 | `grupoativ' == 5 | `grupoativ' == 6 | `grupoativ' == 7)
	replace `ibge90' = 10 if `cbo' == 1210 & `posocup' == 10 & (`grupoativ' == 2 | `grupoativ' == 3 | `grupoativ' == 4 | `grupoativ' == 5 | `grupoativ' == 6 | `grupoativ' == 7)
	replace `ibge90' = 5 if (`cbo' == 1219 | `cbo' == 6301 | `cbo' == 6329) & `grupoativ' == 1 & `ativagr' == 1 & `posocup' == 10


	replace `ibge90' = 741 if `cbo' == 4211 & (`codativ' > 60009 & `codativ' < 60021)
	replace `ibge90' = 752 if `cbo' == 4211 & `codativ' == 60040
	replace `ibge90' = 772 if `cbo' == 4211 & `codativ' == 64010
	replace `ibge90' = 912 if `cbo' == 4211 & (`codativ' == 92012 | `codativ' == 92015 | `codativ' == 92040)
	replace `ibge90' = 351 if `cbo' == 7821 & (`codativ' > 9999 & `codativ' < 15000)
	replace `ibge90' = 351 if `cbo' == 8621 & (`codativ' > 9999 & `codativ' < 15000)
	replace `ibge90' = 15  if `cbo' == 5161 & `posocup' == 10
	replace `ibge90' = 9   if `cbo' == 7102 & `posocup' == 10
	replace `ibge90' = 272 if `cbo' == 2625 & (`codativ' > 18000 & `codativ' < 20001)
	replace `ibge90' = 272 if `cbo' == 2625 & `codativ' == 20000
	replace `ibge90' = 272 if `cbo' == 2625 & `codativ' == 26091
	replace `ibge90' = 303 if `cbo' == 7825 & `ativagr' == 1 & `codativ' < 1402

	* Dezemmbro de 2016:

		*ocupações sem equivalência até aqui

	replace `ibge90' = 276 if `cbo' == 3765
	replace `ibge90' = 912 if `cbo' == 4213
	replace `ibge90' = 645 if `cbo' == 5114
	replace `ibge90' = 802 if `cbo' == 5166
	replace `ibge90' = 293 if `cbo' == 5167
	replace `ibge90' = 613 if `cbo' == 5191
	replace `ibge90' = 613 if `cbo' == 5192
	replace `ibge90' = 843 if `cbo' == 5198
	replace `ibge90' = 843 if `cbo' == 5199
	replace `ibge90' = 428 if `cbo' == 7246
	replace `ibge90' = 589 if `cbo' == 7817
	replace `ibge90' = 589 if `cbo' == 8181
	replace `ibge90' = 583 if `cbo' == 8711

		*militares (retiramos da sintaxe original, na qual a correspondencia no ibge90_ocup1 era 863 e não conseguia correspondencia no isei)

	replace `ibge90' = 861 if `cbo' == 501
	replace `ibge90' = 861 if `cbo' == 502
	replace `ibge90' = 864 if `cbo' == 503
	replace `ibge90' = 864 if `cbo' == 511
	replace `ibge90' = 864 if `cbo' == 512
	replace `ibge90' = 869 if `cbo' == 513
	

	/*--------------------------------------------------------------------
	- 1.3 - Local ocupacao e mantem var ibge90
	---------------------------------------------------------------------*/
	tempvar ocupacao
	gen `ocupacao'= `ibge90'

	}

	if "`intermediaria'" != "" {
	gen `ibge90Name' = `ibge90'
	label var  `ibge90Name' "IBGE-90: `complabel'"
	}
}



/*********************************************************************
* 2 - EGP
**********************************************************************/

if "`egp12'" != ""  |  "`egp7'" != "" |  "`egp'" != "" |  "`egps'" != ""{
	quietly {

	noisily di "Criando classes EGP - `complabel' ..."		
	gen `egp12Name'=.
	lab var `egp12Name' "EGP12: `complabel'"

	replace `egp12Name' = 10 if `ocupacao' == 20
	replace `egp12Name' = 10 if `ocupacao' == 21
	replace `egp12Name' = 10 if `ocupacao' == 33
	replace `egp12Name' = 10 if `ocupacao' == 38
	replace `egp12Name' = 10 if `ocupacao' == 101
	replace `egp12Name' = 10 if `ocupacao' == 102
	replace `egp12Name' = 10 if `ocupacao' == 121
	replace `egp12Name' = 10 if `ocupacao' == 122
	replace `egp12Name' = 10 if `ocupacao' == 123
	replace `egp12Name' = 10 if `ocupacao' == 124
	replace `egp12Name' = 10 if `ocupacao' == 141
	replace `egp12Name' = 10 if `ocupacao' == 142
	replace `egp12Name' = 10 if `ocupacao' == 143
	replace `egp12Name' = 10 if `ocupacao' == 144
	replace `egp12Name' = 10 if `ocupacao' == 151
	replace `egp12Name' = 10 if `ocupacao' == 152
	replace `egp12Name' = 10 if `ocupacao' == 171
	replace `egp12Name' = 10 if `ocupacao' == 181
	replace `egp12Name' = 10 if `ocupacao' == 183
	replace `egp12Name' = 10 if `ocupacao' == 201
	replace `egp12Name' = 10 if `ocupacao' == 202
	replace `egp12Name' = 10 if `ocupacao' == 203
	replace `egp12Name' = 10 if `ocupacao' == 205
	replace `egp12Name' = 10 if `ocupacao' == 211
	replace `egp12Name' = 10 if `ocupacao' == 212
	replace `egp12Name' = 10 if `ocupacao' == 231
	replace `egp12Name' = 10 if `ocupacao' == 232
	replace `egp12Name' = 10 if `ocupacao' == 233
	replace `egp12Name' = 10 if `ocupacao' == 292
	replace `egp12Name' = 10 if `ocupacao' == 711

	replace `egp12Name' = 20 if `ocupacao' == 32
	replace `egp12Name' = 20 if `ocupacao' == 34
	replace `egp12Name' = 20 if `ocupacao' == 35
	replace `egp12Name' = 20 if `ocupacao' == 36
	replace `egp12Name' = 20 if `ocupacao' == 37
	replace `egp12Name' = 20 if `ocupacao' == 39
	replace `egp12Name' = 20 if `ocupacao' == 40
	replace `egp12Name' = 20 if `ocupacao' == 50
	replace `egp12Name' = 20 if `ocupacao' == 52
	replace `egp12Name' = 20 if `ocupacao' == 153
	replace `egp12Name' = 20 if `ocupacao' == 154
	replace `egp12Name' = 20 if `ocupacao' == 182
	replace `egp12Name' = 20 if `ocupacao' == 204
	replace `egp12Name' = 20 if `ocupacao' == 213
	replace `egp12Name' = 20 if `ocupacao' == 241
	replace `egp12Name' = 20 if `ocupacao' == 252
	replace `egp12Name' = 20 if `ocupacao' == 291
	replace `egp12Name' = 20 if `ocupacao' == 641
	replace `egp12Name' = 20 if `ocupacao' == 643
	replace `egp12Name' = 20 if `ocupacao' == 644
	replace `egp12Name' = 20 if `ocupacao' == 721

	replace `egp12Name' = 31 if `ocupacao' == 54
	replace `egp12Name' = 31 if `ocupacao' == 55
	replace `egp12Name' = 31 if `ocupacao' == 56
	replace `egp12Name' = 31 if `ocupacao' == 57
	replace `egp12Name' = 31 if `ocupacao' == 58
	replace `egp12Name' = 31 if `ocupacao' == 59
	replace `egp12Name' = 31 if `ocupacao' == 60
	replace `egp12Name' = 31 if `ocupacao' == 61
	replace `egp12Name' = 31 if `ocupacao' == 62
	replace `egp12Name' = 31 if `ocupacao' == 64
	replace `egp12Name' = 31 if `ocupacao' == 191
	replace `egp12Name' = 31 if `ocupacao' == 192
	replace `egp12Name' = 31 if `ocupacao' == 193
	replace `egp12Name' = 31 if `ocupacao' == 194
	replace `egp12Name' = 31 if `ocupacao' == 214
	replace `egp12Name' = 31 if `ocupacao' == 215
	replace `egp12Name' = 31 if `ocupacao' == 216
	replace `egp12Name' = 31 if `ocupacao' == 217
	replace `egp12Name' = 31 if `ocupacao' == 218
	replace `egp12Name' = 31 if `ocupacao' == 219
	replace `egp12Name' = 31 if `ocupacao' == 221
	replace `egp12Name' = 31 if `ocupacao' == 222
	replace `egp12Name' = 31 if `ocupacao' == 242
	replace `egp12Name' = 31 if `ocupacao' == 243
	replace `egp12Name' = 31 if `ocupacao' == 244
	replace `egp12Name' = 31 if `ocupacao' == 251
	replace `egp12Name' = 31 if `ocupacao' == 261
	replace `egp12Name' = 31 if `ocupacao' == 275
	replace `egp12Name' = 31 if `ocupacao' == 276
	replace `egp12Name' = 31 if `ocupacao' == 277
	replace `egp12Name' = 31 if `ocupacao' == 278
	replace `egp12Name' = 31 if `ocupacao' == 279
	replace `egp12Name' = 31 if `ocupacao' == 631
	replace `egp12Name' = 31 if `ocupacao' == 632
	replace `egp12Name' = 31 if `ocupacao' == 633
	replace `egp12Name' = 31 if `ocupacao' == 642
	replace `egp12Name' = 31 if `ocupacao' == 645
	replace `egp12Name' = 31 if `ocupacao' == 831
	replace `egp12Name' = 31 if `ocupacao' == 832
	replace `egp12Name' = 31 if `ocupacao' == 833
	replace `egp12Name' = 31 if `ocupacao' == 834
	replace `egp12Name' = 31 if `ocupacao' == 863
	replace `egp12Name' = 31 if `ocupacao' == 864
	replace `egp12Name' = 31 if `ocupacao' == 865

	replace `egp12Name' = 32 if `ocupacao' == 53
	replace `egp12Name' = 32 if `ocupacao' == 63
	replace `egp12Name' = 32 if `ocupacao' == 132
	replace `egp12Name' = 32 if `ocupacao' == 162
	replace `egp12Name' = 32 if `ocupacao' == 163
	replace `egp12Name' = 32 if `ocupacao' == 602
	replace `egp12Name' = 32 if `ocupacao' == 603
	replace `egp12Name' = 32 if `ocupacao' == 604
	replace `egp12Name' = 32 if `ocupacao' == 605
	replace `egp12Name' = 32 if `ocupacao' == 646
	replace `egp12Name' = 32 if `ocupacao' == 712
	replace `egp12Name' = 32 if `ocupacao' == 771
	replace `egp12Name' = 32 if `ocupacao' == 772
	replace `egp12Name' = 32 if `ocupacao' == 773
	replace `egp12Name' = 32 if `ocupacao' == 774
	replace `egp12Name' = 32 if `ocupacao' == 814
	replace `egp12Name' = 32 if `ocupacao' == 815
	replace `egp12Name' = 32 if `ocupacao' == 816
	replace `egp12Name' = 32 if `ocupacao' == 817
	replace `egp12Name' = 32 if `ocupacao' == 818
	replace `egp12Name' = 32 if `ocupacao' == 845
	replace `egp12Name' = 32 if `ocupacao' == 869
	replace `egp12Name' = 32 if `ocupacao' == 911
	replace `egp12Name' = 32 if `ocupacao' == 912

	replace `egp12Name' = 41 if `ocupacao' == 7
	replace `egp12Name' = 41 if `ocupacao' == 8
	replace `egp12Name' = 41 if `ocupacao' == 9
	replace `egp12Name' = 41 if `ocupacao' == 10
	replace `egp12Name' = 41 if `ocupacao' == 11
	replace `egp12Name' = 41 if `ocupacao' == 12
	replace `egp12Name' = 41 if `ocupacao' == 13
	replace `egp12Name' = 41 if `ocupacao' == 14
	replace `egp12Name' = 41 if `ocupacao' == 15

	replace `egp12Name' = 42 if `ocupacao' == 601
	replace `egp12Name' = 42 if `ocupacao' == 811
	replace `egp12Name' = 42 if `ocupacao' == 852

	replace `egp12Name' = 43 if `ocupacao' == 301

	replace `egp12Name' = 44 if `ocupacao' == 1
	replace `egp12Name' = 44 if `ocupacao' == 2
	replace `egp12Name' = 44 if `ocupacao' == 3
	replace `egp12Name' = 44 if `ocupacao' == 4
	replace `egp12Name' = 44 if `ocupacao' == 5
	replace `egp12Name' = 44 if `ocupacao' == 6
	replace `egp12Name' = 50 if `ocupacao' == 30

	replace `egp12Name' = 50 if `ocupacao' == 51
	replace `egp12Name' = 50 if `ocupacao' == 103
	replace `egp12Name' = 50 if `ocupacao' == 104
	replace `egp12Name' = 50 if `ocupacao' == 111
	replace `egp12Name' = 50 if `ocupacao' == 112
	replace `egp12Name' = 50 if `ocupacao' == 113
	replace `egp12Name' = 50 if `ocupacao' == 131
	replace `egp12Name' = 50 if `ocupacao' == 164
	replace `egp12Name' = 50 if `ocupacao' == 165
	replace `egp12Name' = 50 if `ocupacao' == 166
	replace `egp12Name' = 50 if `ocupacao' == 167
	replace `egp12Name' = 50 if `ocupacao' == 168
	replace `egp12Name' = 50 if `ocupacao' == 271
	replace `egp12Name' = 50 if `ocupacao' == 273
	replace `egp12Name' = 50 if `ocupacao' == 274
	replace `egp12Name' = 50 if `ocupacao' == 280
	replace `egp12Name' = 50 if `ocupacao' == 281
	replace `egp12Name' = 50 if `ocupacao' == 282
	replace `egp12Name' = 50 if `ocupacao' == 283
	replace `egp12Name' = 50 if `ocupacao' == 293
	replace `egp12Name' = 50 if `ocupacao' == 401
	replace `egp12Name' = 50 if `ocupacao' == 402
	replace `egp12Name' = 50 if `ocupacao' == 403
	replace `egp12Name' = 50 if `ocupacao' == 404
	replace `egp12Name' = 50 if `ocupacao' == 405
	replace `egp12Name' = 50 if `ocupacao' == 406
	replace `egp12Name' = 50 if `ocupacao' == 571
	replace `egp12Name' = 50 if `ocupacao' == 588
	replace `egp12Name' = 50 if `ocupacao' == 722
	replace `egp12Name' = 50 if `ocupacao' == 761
	replace `egp12Name' = 50 if `ocupacao' == 914
	replace `egp12Name' = 50 if `ocupacao' == 918

	replace `egp12Name' = 60 if `ocupacao' == 411
	replace `egp12Name' = 60 if `ocupacao' == 412
	replace `egp12Name' = 60 if `ocupacao' == 413
	replace `egp12Name' = 60 if `ocupacao' == 414
	replace `egp12Name' = 60 if `ocupacao' == 415
	replace `egp12Name' = 60 if `ocupacao' == 416
	replace `egp12Name' = 60 if `ocupacao' == 417
	replace `egp12Name' = 60 if `ocupacao' == 418
	replace `egp12Name' = 60 if `ocupacao' == 419
	replace `egp12Name' = 60 if `ocupacao' == 420
	replace `egp12Name' = 60 if `ocupacao' == 421
	replace `egp12Name' = 60 if `ocupacao' == 422
	replace `egp12Name' = 60 if `ocupacao' == 423
	replace `egp12Name' = 60 if `ocupacao' == 424
	replace `egp12Name' = 60 if `ocupacao' == 425
	replace `egp12Name' = 60 if `ocupacao' == 426
	replace `egp12Name' = 60 if `ocupacao' == 427
	replace `egp12Name' = 60 if `ocupacao' == 428
	replace `egp12Name' = 60 if `ocupacao' == 429
	replace `egp12Name' = 60 if `ocupacao' == 430
	replace `egp12Name' = 60 if `ocupacao' == 431
	replace `egp12Name' = 60 if `ocupacao' == 470
	replace `egp12Name' = 60 if `ocupacao' == 471
	replace `egp12Name' = 60 if `ocupacao' == 472
	replace `egp12Name' = 60 if `ocupacao' == 473
	replace `egp12Name' = 60 if `ocupacao' == 474
	replace `egp12Name' = 60 if `ocupacao' == 477
	replace `egp12Name' = 60 if `ocupacao' == 478
	replace `egp12Name' = 60 if `ocupacao' == 479
	replace `egp12Name' = 60 if `ocupacao' == 481
	replace `egp12Name' = 60 if `ocupacao' == 482
	replace `egp12Name' = 60 if `ocupacao' == 484
	replace `egp12Name' = 60 if `ocupacao' == 485
	replace `egp12Name' = 60 if `ocupacao' == 487
	replace `egp12Name' = 60 if `ocupacao' == 488
	replace `egp12Name' = 60 if `ocupacao' == 489
	replace `egp12Name' = 60 if `ocupacao' == 501
	replace `egp12Name' = 60 if `ocupacao' == 502
	replace `egp12Name' = 60 if `ocupacao' == 503
	replace `egp12Name' = 60 if `ocupacao' == 504
	replace `egp12Name' = 60 if `ocupacao' == 505
	replace `egp12Name' = 60 if `ocupacao' == 506
	replace `egp12Name' = 60 if `ocupacao' == 507
	replace `egp12Name' = 60 if `ocupacao' == 508
	replace `egp12Name' = 60 if `ocupacao' == 509
	replace `egp12Name' = 60 if `ocupacao' == 511
	replace `egp12Name' = 60 if `ocupacao' == 512
	replace `egp12Name' = 60 if `ocupacao' == 516
	replace `egp12Name' = 60 if `ocupacao' == 517
	replace `egp12Name' = 60 if `ocupacao' == 518
	replace `egp12Name' = 60 if `ocupacao' == 551
	replace `egp12Name' = 60 if `ocupacao' == 552
	replace `egp12Name' = 60 if `ocupacao' == 553
	replace `egp12Name' = 60 if `ocupacao' == 554
	replace `egp12Name' = 60 if `ocupacao' == 555
	replace `egp12Name' = 60 if `ocupacao' == 556
	replace `egp12Name' = 60 if `ocupacao' == 557
	replace `egp12Name' = 60 if `ocupacao' == 561
	replace `egp12Name' = 60 if `ocupacao' == 562
	replace `egp12Name' = 60 if `ocupacao' == 563
	replace `egp12Name' = 60 if `ocupacao' == 572
	replace `egp12Name' = 60 if `ocupacao' == 573
	replace `egp12Name' = 60 if `ocupacao' == 581
	replace `egp12Name' = 60 if `ocupacao' == 731
	replace `egp12Name' = 60 if `ocupacao' == 741
	replace `egp12Name' = 60 if `ocupacao' == 743
	replace `egp12Name' = 60 if `ocupacao' == 745
	replace `egp12Name' = 60 if `ocupacao' == 746
	replace `egp12Name' = 60 if `ocupacao' == 813
	replace `egp12Name' = 60 if `ocupacao' == 822
	replace `egp12Name' = 60 if `ocupacao' == 823
	replace `egp12Name' = 60 if `ocupacao' == 824
	replace `egp12Name' = 60 if `ocupacao' == 866
	replace `egp12Name' = 60 if `ocupacao' == 867
	replace `egp12Name' = 60 if `ocupacao' == 868
	replace `egp12Name' = 60 if `ocupacao' == 913
	replace `egp12Name' = 60 if `ocupacao' == 915
	replace `egp12Name' = 60 if `ocupacao' == 917
	replace `egp12Name' = 60 if `ocupacao' == 921
	replace `egp12Name' = 60 if `ocupacao' == 922

	replace `egp12Name' = 71 if `ocupacao' == 272
	replace `egp12Name' = 71 if `ocupacao' == 333
	replace `egp12Name' = 71 if `ocupacao' == 341
	replace `egp12Name' = 71 if `ocupacao' == 351
	replace `egp12Name' = 71 if `ocupacao' == 361
	replace `egp12Name' = 71 if `ocupacao' == 371
	replace `egp12Name' = 71 if `ocupacao' == 391
	replace `egp12Name' = 71 if `ocupacao' == 441
	replace `egp12Name' = 71 if `ocupacao' == 442
	replace `egp12Name' = 71 if `ocupacao' == 443
	replace `egp12Name' = 71 if `ocupacao' == 444
	replace `egp12Name' = 71 if `ocupacao' == 445
	replace `egp12Name' = 71 if `ocupacao' == 446
	replace `egp12Name' = 71 if `ocupacao' == 447
	replace `egp12Name' = 71 if `ocupacao' == 448
	replace `egp12Name' = 71 if `ocupacao' == 449
	replace `egp12Name' = 71 if `ocupacao' == 450
	replace `egp12Name' = 71 if `ocupacao' == 451
	replace `egp12Name' = 71 if `ocupacao' == 452
	replace `egp12Name' = 71 if `ocupacao' == 461
	replace `egp12Name' = 71 if `ocupacao' == 462
	replace `egp12Name' = 71 if `ocupacao' == 475
	replace `egp12Name' = 71 if `ocupacao' == 483
	replace `egp12Name' = 71 if `ocupacao' == 486
	replace `egp12Name' = 71 if `ocupacao' == 490
	replace `egp12Name' = 71 if `ocupacao' == 513
	replace `egp12Name' = 71 if `ocupacao' == 514
	replace `egp12Name' = 71 if `ocupacao' == 515
	replace `egp12Name' = 71 if `ocupacao' == 519
	replace `egp12Name' = 71 if `ocupacao' == 520
	replace `egp12Name' = 71 if `ocupacao' == 521
	replace `egp12Name' = 71 if `ocupacao' == 531
	replace `egp12Name' = 71 if `ocupacao' == 532
	replace `egp12Name' = 71 if `ocupacao' == 533
	replace `egp12Name' = 71 if `ocupacao' == 534
	replace `egp12Name' = 71 if `ocupacao' == 535
	replace `egp12Name' = 71 if `ocupacao' == 536
	replace `egp12Name' = 71 if `ocupacao' == 537
	replace `egp12Name' = 71 if `ocupacao' == 538
	replace `egp12Name' = 71 if `ocupacao' == 539
	replace `egp12Name' = 71 if `ocupacao' == 540
	replace `egp12Name' = 71 if `ocupacao' == 541
	replace `egp12Name' = 71 if `ocupacao' == 542
	replace `egp12Name' = 71 if `ocupacao' == 543
	replace `egp12Name' = 71 if `ocupacao' == 544
	replace `egp12Name' = 71 if `ocupacao' == 545
	replace `egp12Name' = 71 if `ocupacao' == 564
	replace `egp12Name' = 71 if `ocupacao' == 574
	replace `egp12Name' = 71 if `ocupacao' == 575
	replace `egp12Name' = 71 if `ocupacao' == 576
	replace `egp12Name' = 71 if `ocupacao' == 577
	replace `egp12Name' = 71 if `ocupacao' == 578
	replace `egp12Name' = 71 if `ocupacao' == 579
	replace `egp12Name' = 71 if `ocupacao' == 580
	replace `egp12Name' = 71 if `ocupacao' == 582
	replace `egp12Name' = 71 if `ocupacao' == 583
	replace `egp12Name' = 71 if `ocupacao' == 584
	replace `egp12Name' = 71 if `ocupacao' == 585
	replace `egp12Name' = 71 if `ocupacao' == 586
	replace `egp12Name' = 71 if `ocupacao' == 587
	replace `egp12Name' = 71 if `ocupacao' == 589
	replace `egp12Name' = 71 if `ocupacao' == 611
	replace `egp12Name' = 71 if `ocupacao' == 612
	replace `egp12Name' = 71 if `ocupacao' == 613
	replace `egp12Name' = 71 if `ocupacao' == 614
	replace `egp12Name' = 71 if `ocupacao' == 615
	replace `egp12Name' = 71 if `ocupacao' == 616
	replace `egp12Name' = 71 if `ocupacao' == 617
	replace `egp12Name' = 71 if `ocupacao' == 621
	replace `egp12Name' = 71 if `ocupacao' == 723
	replace `egp12Name' = 71 if `ocupacao' == 724
	replace `egp12Name' = 71 if `ocupacao' == 725
	replace `egp12Name' = 71 if `ocupacao' == 726
	replace `egp12Name' = 71 if `ocupacao' == 727
	replace `egp12Name' = 71 if `ocupacao' == 732
	replace `egp12Name' = 71 if `ocupacao' == 751
	replace `egp12Name' = 71 if `ocupacao' == 752
	replace `egp12Name' = 71 if `ocupacao' == 762
	replace `egp12Name' = 71 if `ocupacao' == 775
	replace `egp12Name' = 71 if `ocupacao' == 801
	replace `egp12Name' = 71 if `ocupacao' == 802
	replace `egp12Name' = 71 if `ocupacao' == 803
	replace `egp12Name' = 71 if `ocupacao' == 804
	replace `egp12Name' = 71 if `ocupacao' == 805
	replace `egp12Name' = 71 if `ocupacao' == 806
	replace `egp12Name' = 71 if `ocupacao' == 807
	replace `egp12Name' = 71 if `ocupacao' == 808
	replace `egp12Name' = 71 if `ocupacao' == 812
	replace `egp12Name' = 71 if `ocupacao' == 825
	replace `egp12Name' = 71 if `ocupacao' == 826
	replace `egp12Name' = 71 if `ocupacao' == 841
	replace `egp12Name' = 71 if `ocupacao' == 842
	replace `egp12Name' = 71 if `ocupacao' == 843
	replace `egp12Name' = 71 if `ocupacao' == 844
	replace `egp12Name' = 71 if `ocupacao' == 916
	replace `egp12Name' = 71 if `ocupacao' == 919
	replace `egp12Name' = 71 if `ocupacao' == 920
	replace `egp12Name' = 71 if `ocupacao' == 923
	replace `egp12Name' = 71 if `ocupacao' == 924
	replace `egp12Name' = 71 if `ocupacao' == 925
	replace `egp12Name' = 71 if `ocupacao' == 926

	replace `egp12Name' = 72 if `ocupacao' == 302
	replace `egp12Name' = 72 if `ocupacao' == 303
	replace `egp12Name' = 72 if `ocupacao' == 304
	replace `egp12Name' = 72 if `ocupacao' == 305
	replace `egp12Name' = 72 if `ocupacao' == 321
	replace `egp12Name' = 72 if `ocupacao' == 322
	replace `egp12Name' = 72 if `ocupacao' == 331
	replace `egp12Name' = 72 if `ocupacao' == 332
	replace `egp12Name' = 72 if `ocupacao' == 334
	replace `egp12Name' = 72 if `ocupacao' == 336
	replace `egp12Name' = 72 if `ocupacao' == 345
	replace `egp12Name' = 72 if `ocupacao' == 381
	replace `egp12Name' = 72 if `ocupacao' == 753


	replace `egp12Name' = 50 if `ocupacao' == 125
	replace `egp12Name' = 20 if `ocupacao' == 173
	replace `egp12Name' = 60 if `ocupacao' == 821
	replace `egp12Name' = 44 if `ocupacao' == 851

	replace `egp12Name' = 60 if `ocupacao' == 741
	replace `egp12Name' = 60 if `ocupacao' == 742

	replace `egp12Name' = 72 if `ocupacao' == 300

	replace `egp12Name' = 60 if `ocupacao' == 744

	replace `egp12Name' = 71 if `ocupacao' == 476
	replace `egp12Name' = 20 if `ocupacao' == 172

	/* missing */
	replace `egp12Name' = .  if `ocupacao' ==928
	replace `egp12Name' = .  if `ocupacao' ==927

	/* adicionando ocupação 133 (técnicos em meteorologia)*/

	replace `egp12Name' = 32 if `ocupacao' == 133

	/* adicionando ocupação 161 (acadêmicos de hospital)*/

	replace `egp12Name' = 20 if `ocupacao' == 161

	/* adicionando ocupação 31 (administração na extração ve>=tal e pesca)*/

	replace `egp12Name' = 50 if `ocupacao' == 31

	/* adicionando ocupação 335 (ervateiros)*/

	replace `egp12Name' = 72 if `ocupacao' == 335

	/* para classificar militares*/

	replace `egp12Name' = 31 if `ocupacao' == 861
	replace `egp12Name' = 71 if `ocupacao' == 862


	/*--------------------------------------------------------------------
	- 2.1 - Ajustes EGP para ano>2001
	---------------------------------------------------------------------*/
	if `ano'>2001 {
		* ajustes 

		replace `egp12Name' = 41 if `cbo' == 1310 & `ativagr' == 2 & `posocup' == 10	
		replace `egp12Name' = 44 if `cbo' == 1310 & `ativagr' == 1 & `posocup' == 10																	
		replace `egp12Name' = 44 if `cbo' == 2512 & `ativagr' == 1 & `posocup' == 10																
		replace `egp12Name' = 44 if `cbo' == 3147 & `ativagr' == 1 & `posocup' == 10
		replace `egp12Name' = 71 if `cbo' == 5134 & `grupoativ' == 10																	
		replace `egp12Name' = 41 if `cbo' == 7256 & `posocup' == 10																	
		replace `egp12Name' = 41 if `cbo' == 7650 & `posocup' == 10
		replace `egp12Name' = 71 if `cbo' == 5173 & `grupoativ' == 10
		replace `egp12Name' = 71 if `cbo' == 3189 & `grupoativ' >= 2 & `grupoativ' <= 4
		replace `egp12Name' = 71 if `cbo' == 7828 & `grupoativ' >= 2 & `grupoativ' <= 4
		replace `egp12Name' = 20 if `cbo' == 3518 & `posocup' >= 2 & `posocup' <= 3
		replace `egp12Name' = 20 if `cbo' == 3518 & `grupoativ' == 8
		replace `egp12Name' = 10 if `cbo' == 5131 & `grupoativ' == 8
		replace `egp12Name' = 10 if `cbo' == 5131 & `posocup' == 2
		replace `egp12Name' = 10 if `cbo' == 5131 & `posocup' == 3
		replace `egp12Name' = 71 if `cbo' == 8214 & `grupoativ' >= 5 & `grupoativ' <= 9
		replace `egp12Name' = 71 if `cbo' == 8214 & `grupoativ' == 11
		replace `egp12Name' = 71 if `cbo' == 8412 & `grupoativ' >= 5 & `grupoativ' <= 9
		replace `egp12Name' = 71 if `cbo' == 8412 & `grupoativ' == 11
		replace `egp12Name' = 71 if `cbo' == 8485 & `grupoativ' >= 5 & `grupoativ' <= 9
		replace `egp12Name' = 71 if `cbo' == 8485 & `grupoativ' == 11

		replace `egp12Name' = 71 if `cbo' == 8491 & `grupoativ' >= 5 & `grupoativ' <= 9
		replace `egp12Name' = 71 if `cbo' == 8491 & `grupoativ' == 11
		replace `egp12Name' = 71 if `cbo' == 8621 & `grupoativ' >= 5 & `grupoativ' <= 9
		replace `egp12Name' = 71 if `cbo' == 8621 & `grupoativ' == 11
		replace `egp12Name' = 71 if `cbo' == 8621 & `grupoativ' >= 5 & `grupoativ' <= 9
		replace `egp12Name' = 71 if `cbo' == 8621 & `grupoativ' == 11
		replace `egp12Name' = 71 if `cbo' == 8623 & `grupoativ' >= 5 & `grupoativ' <= 9
		replace `egp12Name' = 71 if `cbo' == 8623 & `grupoativ' == 11
		replace `egp12Name' = 71 if `cbo' == 9113 & `grupoativ' >= 5 & `grupoativ' <= 9
		replace `egp12Name' = 71 if `cbo' == 9113 & `grupoativ' == 11


		* ajustes (incluindo quem ficou de fora)

		replace `egp12Name' = 71 if `cbo'==5199
		replace `egp12Name' = 71 if `cbo'==7832

		replace `egp12Name' = 50 if `cbo'==5101
		replace `egp12Name' = 50 if `cbo'==5102

		replace `egp12Name' = 42 if `cbo'==2621 & `posocup'==9
		replace `egp12Name' = 42 if `cbo'==3331 & `posocup'==9

		* 
		replace `egp12Name' = 20 if `cbo'==3513


		* ver os 1310 que sao tecnicos agricolas e tao na 10
		replace `egp12Name' = 20 if (`cbo' == 1220 | `cbo' == 1230 | `cbo' == 1310 | `cbo' == 1320) & `grupoativ' > 3 & `grupoativ' < 8 & `posocup' != 10
		replace `egp12Name' = 20 if (`cbo' == 1220 | `cbo' == 1230 | `cbo' == 1310 | `cbo' == 1320) & `grupoativ' == 12 & (`codativ' > 71019 & `codativ' < 72025) & `posocup' != 10
		replace `egp12Name' = 20 if (`cbo' == 1220 | `cbo' == 1230 | `cbo' == 1310 | `cbo' == 1320) & `grupoativ' == 12 & (`codativ' > 74049 & `codativ' < 74091) & `posocup' != 10
		replace `egp12Name' = 20 if (`cbo' == 1220 | `cbo' == 1230 | `cbo' == 1310 | `cbo' == 1320) & `grupoativ' == 9 & (`codativ' > 80011 & `codativ' < 80091) & `posocup' != 10
		replace `egp12Name' = 20 if (`cbo' == 1220 | `cbo' == 1230 | `cbo' == 1310 | `cbo' == 1320) & (`ind' == 2 | `ind' == 6 | `ind' == 7) & `posocup' != 10 

		replace `egp12Name' = 71 if `cbo' == 5131 & `grupoativ' == 10
		replace `egp12Name' = 42 if `cbo' == 5134 & `posocup' == 9

		replace `egp12Name' = 10 if `cbo' == 2122
		replace `egp12Name' = 20 if `cbo' == 2631 & `posocup' == 9

		replace `egp12Name' = 60  if `cbo' == 5151
		replace `egp12Name' = 32  if `cbo' == 5103
		replace `egp12Name' = 71  if `cbo' == 3123
		replace `egp12Name' = 60  if `cbo' == 3142


		replace `egp12Name' = 41 if `cbo' == 7152 & `posocup' == 10

		replace `egp12Name' = 44 if `cbo' == 6301 & `posocup' == 10
		replace `egp12Name' = 44 if `cbo' == 6410 & `posocup' == 10 & `ativagr' == 1
		replace `egp12Name' = 32 if `cbo' == 3541 & `ocupacao' != 15 & `ocupacao' != 601
	}
	}
	label val `egp12Name' egp12
}

/*********************************************************************
* 3 - NVS
**********************************************************************/

if "`nvs'" != ""  |  "`nvs18'" != "" |  "`egps'" != "" {
	 {

	noisily di "Criando classes NVS - `complabel'..."		
	gen  `nvsName'=.
	lab var  `nvsName' "NVS18:  `complabel'"


	replace `nvsName' = 1 if `ocupacao' == 101
	replace `nvsName' = 1 if `ocupacao' == 102
	replace `nvsName' = 1 if `ocupacao' == 151
	replace `nvsName' = 1 if `ocupacao' == 181
	replace `nvsName' = 1 if `ocupacao' == 211
	replace `nvsName' = 1 if `ocupacao' == 212
	replace `nvsName' = 1 if `ocupacao' == 231
	replace `nvsName' = 1 if `ocupacao' == 232
	replace `nvsName' = 1 if `ocupacao' == 233

	replace `nvsName' = 2 if `ocupacao' == 20
	replace `nvsName' = 2 if `ocupacao' == 21
	replace `nvsName' = 2 if `ocupacao' == 33
	replace `nvsName' = 2 if `ocupacao' == 34
	replace `nvsName' = 2 if `ocupacao' == 35
	replace `nvsName' = 2 if `ocupacao' == 36
	replace `nvsName' = 2 if `ocupacao' == 37
	replace `nvsName' = 2 if `ocupacao' == 38
	replace `nvsName' = 2 if `ocupacao' == 39
	replace `nvsName' = 2 if `ocupacao' == 40

	replace `nvsName' = 3 if `ocupacao' == 121
	replace `nvsName' = 3 if `ocupacao' == 122
	replace `nvsName' = 3 if `ocupacao' == 123
	replace `nvsName' = 3 if `ocupacao' == 124
	replace `nvsName' = 3 if `ocupacao' == 141
	replace `nvsName' = 3 if `ocupacao' == 142
	replace `nvsName' = 3 if `ocupacao' == 143
	replace `nvsName' = 3 if `ocupacao' == 144
	replace `nvsName' = 3 if `ocupacao' == 152
	replace `nvsName' = 3 if `ocupacao' == 153
	replace `nvsName' = 3 if `ocupacao' == 154
	replace `nvsName' = 3 if `ocupacao' == 173
	replace `nvsName' = 3 if `ocupacao' == 182
	replace `nvsName' = 3 if `ocupacao' == 183
	replace `nvsName' = 3 if `ocupacao' == 201
	replace `nvsName' = 3 if `ocupacao' == 202
	replace `nvsName' = 3 if `ocupacao' == 203
	replace `nvsName' = 3 if `ocupacao' == 204
	replace `nvsName' = 3 if `ocupacao' == 205
	replace `nvsName' = 3 if `ocupacao' == 213
	replace `nvsName' = 3 if `ocupacao' == 214
	replace `nvsName' = 3 if `ocupacao' == 291
	replace `nvsName' = 3 if `ocupacao' == 292
	replace `nvsName' = 3 if `ocupacao' == 711
	replace `nvsName' = 3 if `ocupacao' == 864

	replace `nvsName' = 4 if `ocupacao' == 50
	replace `nvsName' = 4 if `ocupacao' == 51
	replace `nvsName' = 4 if `ocupacao' == 52
	replace `nvsName' = 4 if `ocupacao' == 241
	replace `nvsName' = 4 if `ocupacao' == 242
	replace `nvsName' = 4 if `ocupacao' == 244
	replace `nvsName' = 4 if `ocupacao' == 631   
	replace `nvsName' = 4 if `ocupacao' == 632   
	replace `nvsName' = 4 if `ocupacao' == 633   
	replace `nvsName' = 4 if `ocupacao' == 641   
	replace `nvsName' = 4 if `ocupacao' == 642   
	replace `nvsName' = 4 if `ocupacao' == 643   
	replace `nvsName' = 4 if `ocupacao' == 644   
	replace `nvsName' = 4 if `ocupacao' == 645   
	replace `nvsName' = 4 if `ocupacao' == 646   

	replace `nvsName' = 5 if `ocupacao' == 53  
	replace `nvsName' = 5 if `ocupacao' == 54  
	replace `nvsName' = 5 if `ocupacao' == 55  
	replace `nvsName' = 5 if `ocupacao' == 56  
	replace `nvsName' = 5 if `ocupacao' == 57  
	replace `nvsName' = 5 if `ocupacao' == 58  
	replace `nvsName' = 5 if `ocupacao' == 59  
	replace `nvsName' = 5 if `ocupacao' == 60  
	replace `nvsName' = 5 if `ocupacao' == 61  
	replace `nvsName' = 5 if `ocupacao' == 62  
	replace `nvsName' = 5 if `ocupacao' == 63  
	replace `nvsName' = 5 if `ocupacao' == 64  
	replace `nvsName' = 5 if `ocupacao' == 243  
	replace `nvsName' = 5 if `ocupacao' == 771  
	replace `nvsName' = 5 if `ocupacao' == 772  
	replace `nvsName' = 5 if `ocupacao' == 773  

	replace `nvsName' = 6 if `ocupacao' == 7  
	replace `nvsName' = 6 if `ocupacao' == 8  
	replace `nvsName' = 6 if `ocupacao' == 9  
	replace `nvsName' = 6 if `ocupacao' == 10  
	replace `nvsName' = 6 if `ocupacao' == 11  
	replace `nvsName' = 6 if `ocupacao' == 12  
	replace `nvsName' = 6 if `ocupacao' == 15  

	replace `nvsName' = 7 if `ocupacao' == 601  
	replace `nvsName' = 7 if `ocupacao' == 811 
	replace `nvsName' = 7 if `ocupacao' == 852  

	replace `nvsName' = 8 if `ocupacao' == 103 
	replace `nvsName' = 8 if `ocupacao' == 104 
	replace `nvsName' = 8 if `ocupacao' == 111 
	replace `nvsName' = 8 if `ocupacao' == 112 
	replace `nvsName' = 8 if `ocupacao' == 113 
	replace `nvsName' = 8 if `ocupacao' == 131 
	replace `nvsName' = 8 if `ocupacao' == 132 
	replace `nvsName' = 8 if `ocupacao' == 162 
	replace `nvsName' = 8 if `ocupacao' == 163 
	replace `nvsName' = 8 if `ocupacao' == 164 
	replace `nvsName' = 8 if `ocupacao' == 165 
	replace `nvsName' = 8 if `ocupacao' == 167 
	replace `nvsName' = 8 if `ocupacao' == 168 
	replace `nvsName' = 8 if `ocupacao' == 191 
	replace `nvsName' = 8 if `ocupacao' == 192 
	replace `nvsName' = 8 if `ocupacao' == 193 
	replace `nvsName' = 8 if `ocupacao' == 194 
	replace `nvsName' = 8 if `ocupacao' == 215 
	replace `nvsName' = 8 if `ocupacao' == 216 
	replace `nvsName' = 8 if `ocupacao' == 217 
	replace `nvsName' = 8 if `ocupacao' == 218 
	replace `nvsName' = 8 if `ocupacao' == 219 
	replace `nvsName' = 8 if `ocupacao' == 220 
	replace `nvsName' = 8 if `ocupacao' == 221 
	replace `nvsName' = 8 if `ocupacao' == 222 
	replace `nvsName' = 8 if `ocupacao' == 251 
	replace `nvsName' = 8 if `ocupacao' == 252 
	replace `nvsName' = 8 if `ocupacao' == 261 
	replace `nvsName' = 8 if `ocupacao' == 271 
	replace `nvsName' = 8 if `ocupacao' == 273 
	replace `nvsName' = 8 if `ocupacao' == 274 
	replace `nvsName' = 8 if `ocupacao' == 275 
	replace `nvsName' = 8 if `ocupacao' == 276 
	replace `nvsName' = 8 if `ocupacao' == 277 
	replace `nvsName' = 8 if `ocupacao' == 278 
	replace `nvsName' = 8 if `ocupacao' == 279 
	replace `nvsName' = 8 if `ocupacao' == 280 
	replace `nvsName' = 8 if `ocupacao' == 281 
	replace `nvsName' = 8 if `ocupacao' == 282 
	replace `nvsName' = 8 if `ocupacao' == 293 
	replace `nvsName' = 8 if `ocupacao' == 402 
	replace `nvsName' = 8 if `ocupacao' == 403 
	replace `nvsName' = 8 if `ocupacao' == 404 
	replace `nvsName' = 8 if `ocupacao' == 405 
	replace `nvsName' = 8 if `ocupacao' == 406 
	replace `nvsName' = 8 if `ocupacao' == 571 
	replace `nvsName' = 8 if `ocupacao' == 588 
	replace `nvsName' = 8 if `ocupacao' == 602 
	replace `nvsName' = 8 if `ocupacao' == 603 
	replace `nvsName' = 8 if `ocupacao' == 604 
	replace `nvsName' = 8 if `ocupacao' == 605 
	replace `nvsName' = 8 if `ocupacao' == 712 
	replace `nvsName' = 8 if `ocupacao' == 721 
	replace `nvsName' = 8 if `ocupacao' == 761 
	replace `nvsName' = 8 if `ocupacao' == 834 
	replace `nvsName' = 8 if `ocupacao' == 861 
	replace `nvsName' = 8 if `ocupacao' == 862 
	replace `nvsName' = 8 if `ocupacao' == 863 
	replace `nvsName' = 8 if `ocupacao' == 865 
	replace `nvsName' = 8 if `ocupacao' == 866 
	replace `nvsName' = 8 if `ocupacao' == 867 
	replace `nvsName' = 8 if `ocupacao' == 868 
	replace `nvsName' = 8 if `ocupacao' == 914 
	replace `nvsName' = 8 if `ocupacao' == 918 

	replace `nvsName' = 9 if `ocupacao' == 361 
	replace `nvsName' = 9 if `ocupacao' == 391 
	replace `nvsName' = 9 if `ocupacao' == 411 
	replace `nvsName' = 9 if `ocupacao' == 412 
	replace `nvsName' = 9 if `ocupacao' == 413 
	replace `nvsName' = 9 if `ocupacao' == 414 
	replace `nvsName' = 9 if `ocupacao' == 415 
	replace `nvsName' = 9 if `ocupacao' == 416 
	replace `nvsName' = 9 if `ocupacao' == 417 
	replace `nvsName' = 9 if `ocupacao' == 418 
	replace `nvsName' = 9 if `ocupacao' == 419 
	replace `nvsName' = 9 if `ocupacao' == 420 
	replace `nvsName' = 9 if `ocupacao' == 421 
	replace `nvsName' = 9 if `ocupacao' == 422 
	replace `nvsName' = 9 if `ocupacao' == 423 
	replace `nvsName' = 9 if `ocupacao' == 424 
	replace `nvsName' = 9 if `ocupacao' == 425 
	replace `nvsName' = 9 if `ocupacao' == 426 
	replace `nvsName' = 9 if `ocupacao' == 427 
	replace `nvsName' = 9 if `ocupacao' == 428 
	replace `nvsName' = 9 if `ocupacao' == 429 
	replace `nvsName' = 9 if `ocupacao' == 430 
	replace `nvsName' = 9 if `ocupacao' == 431 
	replace `nvsName' = 9 if `ocupacao' == 501 
	replace `nvsName' = 9 if `ocupacao' == 502 
	replace `nvsName' = 9 if `ocupacao' == 503 
	replace `nvsName' = 9 if `ocupacao' == 504 
	replace `nvsName' = 9 if `ocupacao' == 505 
	replace `nvsName' = 9 if `ocupacao' == 506 
	replace `nvsName' = 9 if `ocupacao' == 507 
	replace `nvsName' = 9 if `ocupacao' == 508 
	replace `nvsName' = 9 if `ocupacao' == 509 
	replace `nvsName' = 9 if `ocupacao' == 551 
	replace `nvsName' = 9 if `ocupacao' == 552 
	replace `nvsName' = 9 if `ocupacao' == 553 
	replace `nvsName' = 9 if `ocupacao' == 554 
	replace `nvsName' = 9 if `ocupacao' == 555 
	replace `nvsName' = 9 if `ocupacao' == 556 
	replace `nvsName' = 9 if `ocupacao' == 557 

	replace `nvsName' = 10 if `ocupacao' == 441 
	replace `nvsName' = 10 if `ocupacao' == 442 
	replace `nvsName' = 10 if `ocupacao' == 443 
	replace `nvsName' = 10 if `ocupacao' == 445 
	replace `nvsName' = 10 if `ocupacao' == 446 
	replace `nvsName' = 10 if `ocupacao' == 447 
	replace `nvsName' = 10 if `ocupacao' == 450 
	replace `nvsName' = 10 if `ocupacao' == 451 
	replace `nvsName' = 10 if `ocupacao' == 452 
	replace `nvsName' = 10 if `ocupacao' == 461 
	replace `nvsName' = 10 if `ocupacao' == 462 
	replace `nvsName' = 10 if `ocupacao' == 470 
	replace `nvsName' = 10 if `ocupacao' == 471 
	replace `nvsName' = 10 if `ocupacao' == 472 
	replace `nvsName' = 10 if `ocupacao' == 473 
	replace `nvsName' = 10 if `ocupacao' == 477
	replace `nvsName' = 10 if `ocupacao' == 478 
	replace `nvsName' = 10 if `ocupacao' == 479 
	replace `nvsName' = 10 if `ocupacao' == 481 
	replace `nvsName' = 10 if `ocupacao' == 482 
	replace `nvsName' = 10 if `ocupacao' == 483 
	replace `nvsName' = 10 if `ocupacao' == 484 
	replace `nvsName' = 10 if `ocupacao' == 485 
	replace `nvsName' = 10 if `ocupacao' == 486 
	replace `nvsName' = 10 if `ocupacao' == 487 
	replace `nvsName' = 10 if `ocupacao' == 488 
	replace `nvsName' = 10 if `ocupacao' == 489 
	replace `nvsName' = 10 if `ocupacao' == 511 
	replace `nvsName' = 10 if `ocupacao' == 512 
	replace `nvsName' = 10 if `ocupacao' == 513 
	replace `nvsName' = 10 if `ocupacao' == 514 
	replace `nvsName' = 10 if `ocupacao' == 515 
	replace `nvsName' = 10 if `ocupacao' == 516 
	replace `nvsName' = 10 if `ocupacao' == 517 
	replace `nvsName' = 10 if `ocupacao' == 518 
	replace `nvsName' = 10 if `ocupacao' == 519 
	replace `nvsName' = 10 if `ocupacao' == 520 
	replace `nvsName' = 10 if `ocupacao' == 521 
	replace `nvsName' = 10 if `ocupacao' == 531 
	replace `nvsName' = 10 if `ocupacao' == 532 
	replace `nvsName' = 10 if `ocupacao' == 533 
	replace `nvsName' = 10 if `ocupacao' == 534 
	replace `nvsName' = 10 if `ocupacao' == 535 
	replace `nvsName' = 10 if `ocupacao' == 536 
	replace `nvsName' = 10 if `ocupacao' == 537 
	replace `nvsName' = 10 if `ocupacao' == 538 
	replace `nvsName' = 10 if `ocupacao' == 539 
	replace `nvsName' = 10 if `ocupacao' == 540 
	replace `nvsName' = 10 if `ocupacao' == 541 
	replace `nvsName' = 10 if `ocupacao' == 542 
	replace `nvsName' = 10 if `ocupacao' == 543 
	replace `nvsName' = 10 if `ocupacao' == 544 
	replace `nvsName' = 10 if `ocupacao' == 545 
	replace `nvsName' = 10 if `ocupacao' == 561 
	replace `nvsName' = 10 if `ocupacao' == 562 
	replace `nvsName' = 10 if `ocupacao' == 563 
	replace `nvsName' = 10 if `ocupacao' == 564 
	replace `nvsName' = 10 if `ocupacao' == 572 
	replace `nvsName' = 10 if `ocupacao' == 573 
	replace `nvsName' = 10 if `ocupacao' == 574 
	replace `nvsName' = 10 if `ocupacao' == 575 
	replace `nvsName' = 10 if `ocupacao' == 576 
	replace `nvsName' = 10 if `ocupacao' == 577 
	replace `nvsName' = 10 if `ocupacao' == 578 
	replace `nvsName' = 10 if `ocupacao' == 579 
	replace `nvsName' = 10 if `ocupacao' == 580 
	replace `nvsName' = 10 if `ocupacao' == 581 
	replace `nvsName' = 10 if `ocupacao' == 582 
	replace `nvsName' = 10 if `ocupacao' == 583 
	replace `nvsName' = 10 if `ocupacao' == 584 
	replace `nvsName' = 10 if `ocupacao' == 585 
	replace `nvsName' = 10 if `ocupacao' == 586 
	replace `nvsName' = 10 if `ocupacao' == 587 
	replace `nvsName' = 10 if `ocupacao' == 589 
	replace `nvsName' = 10 if `ocupacao' == 762 
	replace `nvsName' = 10 if `ocupacao' == 923 
	replace `nvsName' = 10 if `ocupacao' == 925 

	replace `nvsName' = 11 if `ocupacao' == 166 
	replace `nvsName' = 11 if `ocupacao' == 283 
	replace `nvsName' = 11 if `ocupacao' == 722 
	replace `nvsName' = 11 if `ocupacao' == 723 
	replace `nvsName' = 11 if `ocupacao' == 724 
	replace `nvsName' = 11 if `ocupacao' == 725 
	replace `nvsName' = 11 if `ocupacao' == 726 
	replace `nvsName' = 11 if `ocupacao' == 727 
	replace `nvsName' = 11 if `ocupacao' == 731 
	replace `nvsName' = 11 if `ocupacao' == 732 
	replace `nvsName' = 11 if `ocupacao' == 741
	replace `nvsName' = 11 if `ocupacao' == 743 
	replace `nvsName' = 11 if `ocupacao' == 745 
	replace `nvsName' = 11 if `ocupacao' == 746 
	replace `nvsName' = 11 if `ocupacao' == 751 
	replace `nvsName' = 11 if `ocupacao' == 752 
	replace `nvsName' = 11 if `ocupacao' == 774 
	replace `nvsName' = 11 if `ocupacao' == 775 
	replace `nvsName' = 11 if `ocupacao' == 812 
	replace `nvsName' = 11 if `ocupacao' == 813 
	replace `nvsName' = 11 if `ocupacao' == 814 
	replace `nvsName' = 11 if `ocupacao' == 815 
	replace `nvsName' = 11 if `ocupacao' == 816 
	replace `nvsName' = 11 if `ocupacao' == 817 
	replace `nvsName' = 11 if `ocupacao' == 818 
	replace `nvsName' = 11 if `ocupacao' == 821 
	replace `nvsName' = 11 if `ocupacao' == 822 
	replace `nvsName' = 11 if `ocupacao' == 823 
	replace `nvsName' = 11 if `ocupacao' == 824 
	replace `nvsName' = 11 if `ocupacao' == 831 
	replace `nvsName' = 11 if `ocupacao' == 832 
	replace `nvsName' = 11 if `ocupacao' == 833 
	replace `nvsName' = 11 if `ocupacao' == 845 
	replace `nvsName' = 11 if `ocupacao' == 911 
	replace `nvsName' = 11 if `ocupacao' == 912 
	replace `nvsName' = 11 if `ocupacao' == 913 
	replace `nvsName' = 11 if `ocupacao' == 915 
	replace `nvsName' = 11 if `ocupacao' == 916 
	replace `nvsName' = 11 if `ocupacao' == 917 
	replace `nvsName' = 11 if `ocupacao' == 920 
	replace `nvsName' = 11 if `ocupacao' == 921 
	replace `nvsName' = 11 if `ocupacao' == 922 

	replace `nvsName' = 12 if `ocupacao' == 801 
	replace `nvsName' = 12 if `ocupacao' == 802 
	replace `nvsName' = 12 if `ocupacao' == 803 
	replace `nvsName' = 12 if `ocupacao' == 804 
	replace `nvsName' = 12 if `ocupacao' == 805 
	replace `nvsName' = 12 if `ocupacao' == 806 
	replace `nvsName' = 12 if `ocupacao' == 807 
	replace `nvsName' = 12 if `ocupacao' == 808 
	replace `nvsName' = 12 if `ocupacao' == 825 
	replace `nvsName' = 12 if `ocupacao' == 841 
	replace `nvsName' = 12 if `ocupacao' == 842 
	replace `nvsName' = 12 if `ocupacao' == 843 
	replace `nvsName' = 12 if `ocupacao' == 844 
	replace `nvsName' = 12 if `ocupacao' == 869 
	replace `nvsName' = 12 if `ocupacao' == 919 
	replace `nvsName' = 12 if `ocupacao' == 926 

	replace `nvsName' = 13 if `ocupacao' == 13 
	replace `nvsName' = 13 if `ocupacao' == 611 
	replace `nvsName' = 13 if `ocupacao' == 612 
	replace `nvsName' = 13 if `ocupacao' == 613 
	replace `nvsName' = 13 if `ocupacao' == 614 
	replace `nvsName' = 13 if `ocupacao' == 615 
	replace `nvsName' = 13 if `ocupacao' == 616 
	replace `nvsName' = 13 if `ocupacao' == 617 
	replace `nvsName' = 13 if `ocupacao' == 621 
	replace `nvsName' = 13 if `ocupacao' == 826 

	replace `nvsName' = 14 if `ocupacao' == 8
	replace `nvsName' = 14 if `ocupacao' == 142 
	replace `nvsName' = 14 if `ocupacao' == 272 
	replace `nvsName' = 14 if `ocupacao' == 444 
	replace `nvsName' = 14 if `ocupacao' == 448 
	replace `nvsName' = 14 if `ocupacao' == 449 
	replace `nvsName' = 14 if `ocupacao' == 474
	replace `nvsName' = 14 if `ocupacao' == 475 
	replace `nvsName' = 14 if `ocupacao' == 490 

	replace `nvsName' = 15 if `ocupacao' == 1
	replace `nvsName' = 15 if `ocupacao' == 2
	replace `nvsName' = 15 if `ocupacao' == 3
	replace `nvsName' = 15 if `ocupacao' == 4
	replace `nvsName' = 15 if `ocupacao' == 5
	replace `nvsName' = 15 if `ocupacao' == 6 

	replace `nvsName' = 16 if `ocupacao' == 30
	replace `nvsName' = 16 if `ocupacao' == 32
	replace `nvsName' = 16 if `ocupacao' == 302
	replace `nvsName' = 16 if `ocupacao' == 303
	replace `nvsName' = 16 if `ocupacao' == 351
	replace `nvsName' = 16 if `ocupacao' == 401

	replace `nvsName' = 17 if `ocupacao' == 301

	replace `nvsName' = 18 if `ocupacao' == 304
	replace `nvsName' = 18 if `ocupacao' == 305
	replace `nvsName' = 18 if `ocupacao' == 321
	replace `nvsName' = 18 if `ocupacao' == 322
	replace `nvsName' = 18 if `ocupacao' == 331
	replace `nvsName' = 18 if `ocupacao' == 332
	replace `nvsName' = 18 if `ocupacao' == 333
	replace `nvsName' = 18 if `ocupacao' == 334
	replace `nvsName' = 18 if `ocupacao' == 336
	replace `nvsName' = 18 if `ocupacao' == 341
	replace `nvsName' = 18 if `ocupacao' == 345
	replace `nvsName' = 18 if `ocupacao' == 371
	replace `nvsName' = 18 if `ocupacao' == 381
	replace `nvsName' = 18 if `ocupacao' == 753
	replace `nvsName' = 18 if `ocupacao' == 924

	replace `nvsName' = 13 if `ocupacao' == 14
	replace `nvsName' = 18 if `ocupacao' == 300
	replace `nvsName' = 9 if `ocupacao' == 744
	replace `nvsName' = 9 if `ocupacao' == 742

	replace `nvsName' = 8 if `ocupacao' == 125
	replace `nvsName' = 17 if `ocupacao' == 851

	replace `nvsName' = 14 if `ocupacao' == 476
	replace `nvsName' = 3 if `ocupacao' == 172

	** Dezembro de 2016: ajustes e inclusões a partir da sintaxe "nvs18 FINAL 2002 em diante" 
	* (alguns desses códigos aparecem mais de uma vez na lista acima e são codificados errado na segunda)
		replace `nvsName' = 11 if `ocupacao' == 193
		replace `nvsName' = 11 if `ocupacao' == 844
		replace `nvsName' = 6 if `ocupacao' == 8
		replace `nvsName' = 3 if `ocupacao' == 142
		replace `nvsName' = 11 if `ocupacao' == 924

		* adicionando ocupação 335 (ervateiros) 
		replace `nvsName' = 18 if `ocupacao' == 335

		* adicionando 133 
		replace `nvsName' = 8 if `ocupacao' == 133

		* adicionando ocupação 171 (matemáticos)
		replace `nvsName' = 3 if `ocupacao' == 171

		* adicionando ocupação 161 (acadêmicos de hospital)
		replace `nvsName' = 3 if `ocupacao' == 161

		* adicionando ocupação 31 (administradores na extração vegetal e pesca)
		replace `nvsName' = 16 if `ocupacao' == 31

	} 
	label val `nvsName' nvs
}

/*********************************************************************
* 4 - EGPS
**********************************************************************/

if "`egps'" != ""  {

	quietly {

	noisily di "Criando classes EGPS - `complabel'..."		
	gen `egpsName'=`egp12Name'*10
	lab var `egpsName' "EGPS - `complabel'"

	replace `egpsName'= 711 if `nvsName' <= 10 & `egp12Name' == 71
	replace `egpsName'= 712 if `nvsName' == 11 & `egp12Name' == 71
	replace `egpsName'= 713 if `nvsName' == 12 & `egp12Name' == 71
	replace `egpsName'= 714 if `nvsName' == 13 & `egp12Name' == 71
	replace `egpsName'= 714 if `nvsName' == 14 & `egp12Name' == 71
	replace `egpsName'= 711 if `nvsName' == 16 & `egp12Name' == 71
	replace `egpsName'= 711 if `nvsName' == 18 & `egp12Name' == 71
	replace `egpsName'= 601 if `nvsName' == 8 & `egp12Name' == 60
	replace `egpsName'= 601 if `nvsName' == 9 & `egp12Name' == 60
	replace `egpsName'= 602 if `nvsName' == 10 & `egp12Name' == 60
	replace `egpsName'= 603 if `nvsName' == 11 & `egp12Name' == 60
	replace `egpsName'= 603 if `nvsName' == 14 & `egp12Name' == 60

	replace `egpsName'= 311 if `nvsName' <= 6 & `egp12Name' == 31
	replace `egpsName'= 312 if `nvsName' >= 8 & `egp12Name' == 31

	replace `egpsName'= 321 if `nvsName' == 4 & `egp12Name' == 32
	replace `egpsName'= 321 if `nvsName' == 5 & `egp12Name' == 32
	replace `egpsName'= 321 if `nvsName' == 8 & `egp12Name' == 32
	replace `egpsName'= 322 if `nvsName' == 11 & `egp12Name' == 32
	replace `egpsName'= 322 if `nvsName' == 12 & `egp12Name' == 32

	}

	label val `egpsName' egps
}
