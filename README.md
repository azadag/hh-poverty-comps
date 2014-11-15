hh-poverty-comps
================

## Introduction
Creates international comparisons of market and post transfer household poverty rates by household type 
(partner, children status) for use with LIS micro-data.

Stata code is used with the [LIS Data Center's](http://www.lisdatacenter.org/) cross-country micro-data LISSY interface.
Code needs to be manually adjusted for each country that is added to the list.


## Data Access
You need to sign up for LIS [data access](http://www.lisdatacenter.org/data-access/)
for confidentiality reasons, micro-data from various countries is granted to LIS but not to individuals.
Consumers are provided access to run code remotely without being granted access to the data.

You can get access to sample micro-data for local code execution [here](http://www.lisdatacenter.org/resources/self-teaching/)

## Summary
Poverty rates are calculated and provided for a sample of countries: US, Canada, Denmark, Finland, France, Germany, Netherlands, Poland, Russia,  and the United Kingdom. The poverty rates are for the year 2010 in every country except France which is for 2005.

Three types of poverty rates are outputed for each country. 
* Market Income  - Before Taxes / Transfers 
*	After Taxes, Social Insurance, Univ. Benefits	
*	After Taxes, and all Transfers 

see output [here](https://github.com/azadag/hh-poverty-comps/blob/master/output.md)

## Code Source
LIS' two part Stata [self-teaching](http://www.lisdatacenter.org/resources/self-teaching/) tutorial. [Part 1](http://www.lisdatacenter.org/workshop/stata-part-I.pdf) teaches you how to create poverty rates, and gini levels of different types from the micro-data.
[Part 2](http://www.lisdatacenter.org/workshop/stata-part-II.pdf) teaches you how to combine household and individual datasets to create descriptive statistics on household types.

I combined code logic from the two parts to create poverty statistics for different types of households.
The full dataset is combined, data is recoded, then subsetted by household, partner, and child status. Note that the code will not work for countries that use different income and tax data definitions e.g. Sweden, Japan.

## Additional Sources
[List of variables](http://www.lisdatacenter.org/wp-content/uploads/our-lis-documentation-variables-list.pdf)

[List of datasets](http://www.lisdatacenter.org/our-data/lis-database/documentation/list-of-datasets/)

[Paper on poverty in US](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2831375/)

[Blog post by M. Bruenig that got me interested in playing with data](http://www.demos.org/blog/4/14/14/single-mother-child-poverty-myth)
