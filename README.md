hh-poverty-comps
================

## Introduction
This creates international comparisons of market and post transfer household poverty rates by household type 
(partner, children status) for use with LIS micro-data. A blog post by M. Bruenig got me interested in playing with this  [data](http://www.demos.org/blog/4/14/14/single-mother-child-poverty-myth). Mike Konczal and Bryce Covert wrote another recent article regarding policy implications currently as currently applied  [here](http://www.thenation.com/article/190521/why-you-shouldnt-marry-money).

Stata code is used with the [LIS Data Center's](http://www.lisdatacenter.org/) cross-country micro-data LISSY interface.
Code needs to be manually adjusted for each country that is added to the list.


## Data Access
You need to sign up for LIS [data access](http://www.lisdatacenter.org/data-access/)
for confidentiality reasons, micro-data from various countries is granted to LIS but not to individuals.
Consumers are provided access to run code remotely without being granted access to the data.

You can get access to sample micro-data for local code execution [here](http://www.lisdatacenter.org/resources/self-teaching/)

## Summary
Poverty rates are calculated and provided for a sample of countries: US, Canada, Denmark, Finland, France, Germany, Netherlands, Poland, Russia,  and the United Kingdom. The poverty rates are for the year 2010 in every country except France which is for 2005.

Three types of poverty rates are outputed for each country. (This paper on types of [poverty in US](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2831375/) was helpful in understanding coding choices)


* Market Income  - Before Taxes / Transfers 
*	After Taxes, Social Insurance, Univ. Benefits	
*	After Taxes, and all Transfers 

Poverty rates are calculated for these household types
* M/F Head HH  Partner, w/ Children
* F Head HH no Partner, w/ Children
* F Head HH Partner, w/ Children
* F Head HH Partner, No Children
* F Head HH no Partner, No Children

The first household type should serve as a baseline for all households. It is male or female headed, partnered, with children.

## Code Source
LIS provides a two part [self-teaching](http://www.lisdatacenter.org/resources/self-teaching/) tutorial with SAS, Stata and SPSS. [Part 1](http://www.lisdatacenter.org/workshop/stata-part-I.pdf) teaches you how to create poverty rates, and gini levels of different types from the micro-data, and [Part 2](http://www.lisdatacenter.org/workshop/stata-part-II.pdf) teaches you how to combine household and individual datasets to create descriptive statistics on household types.

I combined logic from the two parts to create poverty statistics for different types of households.
The full dataset is combined, data is recoded, then subsetted by household, partner, and child status, which are used to create the various poverty definitions. Note that the code will not work for countries that use different income and tax data definitions e.g. Sweden, Japan.

## Data Output
| Poverty Rate by Country / HH Type | Market Income  - Before Taxes / Transfers | After Taxes, Social Insurance, Univ. Benefits | After Taxes, all Transfers  | 
|:----------------------------------|------------------------------------------:|----------------------------------------------:|----------------------------:| 
|_US_                                |                                           |                                               |                             | 
| M/F Head HH  Partner, w/ Children |  21.8                                     |  20.0                                         |  18.4                       | 
| F Head HH no Partner, w/ Children |  38.0                                     |  34.1                                         |  23.9                       | 
| F Head HH Partner, w/ Children    |  20.0                                     |  19.9                                         |  14.7                       | 
| F Head HH Partner, No Children    |  18.5                                     |  16.8                                         |  15.6                       | 
| F Head HH no Partner, No Children |  28.0                                     |  24.3                                         |  20.8                       | 
|                                   |                                           |                                               |                             | 
| Canada                            |                                           |                                               |                             | 
| M/F Head HH  Partner, w/ Children |  16.4                                     |  14.7                                         |  12.7                       | 
| F Head HH no Partner, w/ Children |  42.3                                     |  32.6                                         |  11.1                       | 
| F Head HH Partner, w/ Children    |  18.3                                     |  16.7                                         |  10.0                       | 
| F Head HH Partner, No Children    |  13.9                                     |  12.3                                         |  10.8                       | 
| F Head HH no Partner, No Children |  23.7                                     |  21.2                                         |  18.2                       | 
|                                   |                                           |                                               |                             | 
|Denmark                           |                                           |                                               |                             | 
| M/F Head HH  Partner, w/ Children |  15.8                                     |  11.9                                         |  7.8                        | 
| F Head HH no Partner, w/ Children |  32.0                                     |  17.3                                         |  2.1                        | 
| F Head HH Partner, w/ Children    |  8.8                                      |  7.4                                          |  4.0                        | 
| F Head HH Partner, No Children    |  10.3                                     |  8.0                                          |  5.1                        | 
| F Head HH no Partner, No Children |  31.0                                     |  14.6                                         |  8.2                        | 
|                                   |                                           |                                               |                             | 
| Netherlands                       |                                           |                                               |                             | 
| M/F Head HH  Partner, w/ Children |  12.6                                     |  9.8                                          |  7.6                        | 
| F Head HH no Partner, w/ Children |  35.0                                     |  30.6                                         |  5.8                        | 
| F Head HH Partner, w/ Children    |  5.7                                      |  5.1                                          |  2.6                        | 
| F Head HH Partner, No Children    |  7.4                                      |  5.4                                          |  4.2                        | 
| F Head HH no Partner, No Children |  25.3                                     |  20.5                                         |  5.8                        | 
|                                   |                                           |                                               |                             | 
| ##Finland                           |                                           |                                               |                             | 
| M/F Head HH  Partner, w/ Children | 15.1                                      | 8.7                                           | 4.2                         | 
| F Head HH no Partner, w/ Children | 26.3                                      | 10.4                                          | 3.1                         | 
| F Head HH Partner, w/ Children    | 13.3                                      | 7.4                                           | 3.9                         | 
| F Head HH Partner, No Children    | 11.4                                      | 8.3                                           | 7.6                         | 
| F Head HH no Partner, No Children | 26.6                                      | 14.7                                          | 9.7                         | 
|                                   |                                           |                                               |                             | 
| UK                                |                                           |                                               |                             | 
| M/F Head HH  Partner, w/ Children | 17.5                                      | 17.5                                          | 15.1                        | 
| F Head HH no Partner, w/ Children | 55                                        | 46.6                                          | 7.1                         | 
| F Head HH Partner, w/ Children    | 19.6                                      | 20.2                                          | 11.5                        | 
| F Head HH Partner, No Children    | 14.1                                      | 13.7                                          | 12.6                        | 
| F Head HH no Partner, No Children | 28.4                                      | 26.9                                          | 20.9                        | 
|                                   |                                           |                                               |                             | 
| ##Ireland                           |                                           |                                               |                             | 
| M/F Head HH  Partner, w/ Children | 26.4                                      | 24.0                                          | 12.2                        | 
| F Head HH no Partner, w/ Children | 65.1                                      | 48.9                                          | 4.3                         | 
| F Head HH Partner, w/ Children    | 31.1                                      | 22.3                                          | 6.5                         | 
| F Head HH Partner, No Children    | 24.1                                      | 21.3                                          | 11.5                        | 
| F Head HH no Partner, No Children | 34.3                                      | 27.9                                          | 16.3                        | 
|                                   |                                           |                                               |                             | 
| Russia                            |                                           |                                               |                             | 
| M/F Head HH  Partner, w/ Children | .                                         | 18.3                                          | 17.1                        | 
| F Head HH no Partner, w/ Children | .                                         | 21.6                                          | 19.5                        | 
| F Head HH Partner, w/ Children    | .                                         | 16.7                                          | 14.4                        | 
| F Head HH Partner, No Children    | .                                         | 19.1                                          | 18.4                        | 
| F Head HH no Partner, No Children |                                           | 15.3                                          | 14.2                        | 
|                                   |                                           |                                               |                             | 
| Poland                            |                                           |                                               |                             | 
| M/F Head HH  Partner, w/ Children | 22.6                                      | 11.7                                          | 10.8                        | 
| F Head HH no Partner, w/ Children | 30.4                                      | 20.0                                          | 6.4                         | 
| F Head HH Partner, w/ Children    | 20.5                                      | 14.0                                          | 9.7                         | 
| F Head HH Partner, No Children    | 21.2                                      | 11.3                                          | 10.6                        | 
| F Head HH no Partner, No Children | 26.8                                      | 13.6                                          | 11.4                        | 
|                                   |                                           |                                               |                             | 
| France (05)                       |                                           |                                               |                             | 
| M/F Head HH  Partner, w/ Children | 18.2                                      | 10.8                                          | 8.7                         | 
| F Head HH no Partner, w/ Children | 43.3                                      | 22.6                                          | 3.7                         | 
| F Head HH Partner, w/ Children    | 21.7                                      | 9.4                                           | 6.1                         | 
| F Head HH Partner, No Children    | 16.8                                      | 8.9                                           | 7.8                         | 
| F Head HH no Partner, No Children | 23.7                                      | 17.0                                          | 9.5                         | 
|                                   |                                           |                                               |                             | 
| Germany                           |                                           |                                               |                             | 
| M/F Head HH  Partner, w/ Children | 13.1                                      | 12.0                                          | 9.6                         | 
| F Head HH no Partner, w/ Children | 48.0                                      | 34.6                                          | 4.5                         | 
| F Head HH Partner, w/ Children    | 11.4                                      | 8.4                                           | 4.2                         | 
| F Head HH Partner, No Children    | 9.0                                       | 6.5                                           | 5.4                         | 
| F Head HH no Partner, No Children | 23.9                                      | 22.8                                          | 12.0                        | 


## Additional Helpful LIS Links
[List of variables](http://www.lisdatacenter.org/wp-content/uploads/our-lis-documentation-variables-list.pdf)

[List of datasets](http://www.lisdatacenter.org/our-data/lis-database/documentation/list-of-datasets/)
