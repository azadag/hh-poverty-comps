
global varshh "hid dname own dhi hpopwgt nhhmem factor hitsi hitsu hitp hxit grossnet"
global varspp "hid dname ppopwgt relation partner children age sex"
global datasets "no10 ru10 pl10 se05 uk10 ie10"


program define make_data 
	foreach ccyy in $datasets { 
		use $varspp using $`ccyy'p,clear 
		merge m:1 hid using $`ccyy'h, keepusing($varshh) 
		keep if inrange(age,25,54) & relation<=2200 
		if "`ccyy'" != "no10" { 
			append using $mydata\user_data
	} 
	save $mydata\user_data, replace
} 
end

** in LISSY you only need to run make_data once, can re-use temporary data
** across session; make_data merges household with person microdatasets
** necessary for looking at individual poverty by household type

quietly make_data

program define recode_data
	*recode own (100/199=1) (200/299=0), gen(homeowner) 
	recode children (140 200=0) (110 120 130=1), gen(achildcat)
	label define achildcatl 0 "no children <18" 1 "<17 years"
	label values achildcat achildcatl
	recode partner (110=1) (100 120 200=0), gen(livepartner) 
	label define partnerl 0 "not living with partner" 1 "living with partner" 
	label values livepartner partner

end

program define get_descriptives 
	use $mydata\user_data, clear
	quietly recode_data
	* dname : country code / year pair 
	keep if dname== "no10" 
	keep if sex == 2
	keep if achildcat == 0
	*keep if livepartner == 1
	collapse (min) nhhmem hpopwgt dhi factor hitsi hitsu hitp hxit grossnet, by(hid)

	gen miss_comp = 0 
	replace miss_comp=1 if dhi==. | factor==. | hitsi==. | hitsu==. | hitp==. | hxit==. & inrange(grossnet,100,199) 
	replace miss_comp=1 if dhi==. | factor==. | hitsi==. | hitsu==. | hitp==. & grossnet==200

	drop if miss_comp==1

	quietly sum dhi [w=hpopwgt], de 
	global topline = 10*r(p50) 
	gen mi = factor + hitp 
	gen siti = factor + hitp + hitsi + hitsu - hxit 
	*For net income datasets, omit tax variable from second income measure 
	replace siti = factor + hitp + hitsi + hitsu if grossnet==200

	foreach var in mi siti dhi {
		gen e`var'_tb = `var'
		replace e`var'_tb = 0 if `var'<0
		replace e`var'_tb = $topline if `var'>$topline
		replace e`var'_tb = (e`var'_tb/(nhhmem^0.5))
	}


	quietly sum edhi_tb [w=hpopwgt*nhhmem], de
	global povline = r(p50)*0.5

	foreach var in mi siti dhi {
		quietly gen byte poor`var'=(e`var'_tb<$povline)
		quietly sum poor`var' [w=hpopwgt*nhhmem]
		local povrate`var' = round(100*r(mean), .1)

		if "`var'" == "mi" & grossnet==200 { 
			local gini`var' =. 
			local povrate`var' =.
		}
	}

	di "`ginimi',`ginisiti',`ginidhi',`povratemi',`povratesiti',`povratedhi'"
end

program define get_descriptives1
	use $mydata\user_data, clear
	quietly recode_data
	keep if dname== "nl10"
	keep if sex == 2
	keep if achildcat == 1
	keep if livepartner == 0
	collapse (min) nhhmem hpopwgt dhi factor hitsi hitsu hitp hxit grossnet, by(hid)

	gen miss_comp = 0 
	replace miss_comp=1 if dhi==. | factor==. | hitsi==. | hitsu==. | hitp==. | hxit==. & inrange(grossnet,100,199) 
	replace miss_comp=1 if dhi==. | factor==. | hitsi==. | hitsu==. | hitp==. & grossnet==200

	drop if miss_comp==1

	quietly sum dhi [w=hpopwgt], de 
	global topline = 10*r(p50) 
	gen mi = factor + hitp 
	gen siti = factor + hitp + hitsi + hitsu - hxit 
	*For net income datasets, omit tax variable from second income measure 
	replace siti = factor + hitp + hitsi + hitsu if grossnet==200

	foreach var in mi siti dhi {
		gen e`var'_tb = `var'
		replace e`var'_tb = 0 if `var'<0
		replace e`var'_tb = $topline if `var'>$topline
		replace e`var'_tb = (e`var'_tb/(nhhmem^0.5))
	}

	quietly sum edhi_tb [w=hpopwgt*nhhmem], de
	global povline = r(p50)*0.5

	foreach var in mi siti dhi {
		quietly gen byte poor`var'=(e`var'_tb<$povline)
		quietly sum poor`var' [w=hpopwgt*nhhmem]
		local povrate`var' = round(100*r(mean), .1)

		if "`var'" == "mi" & grossnet==200 { 
			local gini`var' =. 
			local povrate`var' =.
		}
	}
	di "`ginimi',`ginisiti',`ginidhi',`povratemi',`povratesiti',`povratedhi'"
end


program define get_descriptives2
	use $mydata\user_data, clear
	quietly recode_data
	keep if dname== "nl10"
	keep if sex == 2
	keep if achildcat == 1
	keep if livepartner == 1
	collapse (min) nhhmem hpopwgt dhi factor hitsi hitsu hitp hxit grossnet, by(hid)

	gen miss_comp = 0 
	replace miss_comp=1 if dhi==. | factor==. | hitsi==. | hitsu==. | hitp==. | hxit==. & inrange(grossnet,100,199) 
	replace miss_comp=1 if dhi==. | factor==. | hitsi==. | hitsu==. | hitp==. & grossnet==200

	drop if miss_comp==1

	quietly sum dhi [w=hpopwgt], de 
	global topline = 10*r(p50) 
	gen mi = factor + hitp 
	gen siti = factor + hitp + hitsi + hitsu - hxit 
	replace siti = factor + hitp + hitsi + hitsu if grossnet==200

	foreach var in mi siti dhi {
		gen e`var'_tb = `var'
		replace e`var'_tb = 0 if `var'<0
		replace e`var'_tb = $topline if `var'>$topline
		replace e`var'_tb = (e`var'_tb/(nhhmem^0.5))
	}

	quietly sum edhi_tb [w=hpopwgt*nhhmem], de
	global povline = r(p50)*0.5

	foreach var in mi siti dhi {
		quietly gen byte poor`var'=(e`var'_tb<$povline)
		quietly sum poor`var' [w=hpopwgt*nhhmem]
		local povrate`var' = round(100*r(mean), .1)

		if "`var'" == "mi" & grossnet==200 { 
			local gini`var' =. 
			local povrate`var' =.
		}
	}

	di "`ginimi',`ginisiti',`ginidhi',`povratemi',`povratesiti',`povratedhi'"
end

program define get_descriptives3 
	use $mydata\user_data, clear
	quietly recode_data
	keep if dname== "nl10"
	keep if sex == 2
	keep if achildcat == 0
	keep if livepartner == 1
	collapse (min) nhhmem hpopwgt dhi factor hitsi hitsu hitp hxit grossnet, by(hid)

	gen miss_comp = 0 
	replace miss_comp=1 if dhi==. | factor==. | hitsi==. | hitsu==. | hitp==. | hxit==. & inrange(grossnet,100,199) 
	replace miss_comp=1 if dhi==. | factor==. | hitsi==. | hitsu==. | hitp==. & grossnet==200

	drop if miss_comp==1

	quietly sum dhi [w=hpopwgt], de 
	global topline = 10*r(p50) 
	gen mi = factor + hitp 
	gen siti = factor + hitp + hitsi + hitsu - hxit 
	*For net income datasets, omit tax variable from second income measure 
	replace siti = factor + hitp + hitsi + hitsu if grossnet==200

	foreach var in mi siti dhi {
		gen e`var'_tb = `var'
		replace e`var'_tb = 0 if `var'<0
		replace e`var'_tb = $topline if `var'>$topline
		replace e`var'_tb = (e`var'_tb/(nhhmem^0.5))
	}


	quietly sum edhi_tb [w=hpopwgt*nhhmem], de
	global povline = r(p50)*0.5


	foreach var in mi siti dhi {
		quietly gen byte poor`var'=(e`var'_tb<$povline)
		quietly sum poor`var' [w=hpopwgt*nhhmem]
		local povrate`var' = round(100*r(mean), .1)

		if "`var'" == "mi" & grossnet==200 { 
			local gini`var' =. 
			local povrate`var' =.
		}
	}

	di "`ginimi',`ginisiti',`ginidhi',`povratemi',`povratesiti',`povratedhi'"
end

program define get_descriptives4
	use $mydata\user_data, clear
	quietly recode_data
	keep if dname== "nl10"
	keep if sex == 2
	keep if achildcat == 0
	keep if livepartner == 0
	collapse (min) nhhmem hpopwgt dhi factor hitsi hitsu hitp hxit grossnet, by(hid)

	gen miss_comp = 0 
	replace miss_comp=1 if dhi==. | factor==. | hitsi==. | hitsu==. | hitp==. | hxit==. & inrange(grossnet,100,199) 
	replace miss_comp=1 if dhi==. | factor==. | hitsi==. | hitsu==. | hitp==. & grossnet==200

	drop if miss_comp==1

	quietly sum dhi [w=hpopwgt], de 
	global topline = 10*r(p50) 
	gen mi = factor + hitp 
	gen siti = factor + hitp + hitsi + hitsu - hxit 
	*For net income datasets, omit tax variable from second income measure 
	replace siti = factor + hitp + hitsi + hitsu if grossnet==200

	foreach var in mi siti dhi {
		gen e`var'_tb = `var'
		replace e`var'_tb = 0 if `var'<0
		replace e`var'_tb = $topline if `var'>$topline
		replace e`var'_tb = (e`var'_tb/(nhhmem^0.5))
	}


	quietly sum edhi_tb [w=hpopwgt*nhhmem], de
	global povline = r(p50)*0.5


	foreach var in mi siti dhi {
		quietly gen byte poor`var'=(e`var'_tb<$povline)
		quietly sum poor`var' [w=hpopwgt*nhhmem]
		local povrate`var' = round(100*r(mean), .1)

		if "`var'" == "mi" & grossnet==200 { 
			local gini`var' =. 
			local povrate`var' =.
		}
	}

	di "`ginimi',`ginisiti',`ginidhi',`povratemi',`povratesiti',`povratedhi'"
end

** run by country outputs.
get_descriptives
get_descriptives1
get_descriptives2
get_descriptives3
get_descriptives4

