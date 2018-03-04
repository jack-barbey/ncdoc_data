# ncdoc_data
North Carolina's Department of Public Safety posts "[all public information on all NC Department of Public Safety offenders convicted since 1972](http://webapps6.doc.state.nc.us/opi/downloads.do?method=view)." Inspired by a previous scrape by Fred Whitehurst, Isabella Langan, and Tom Workman, I wrote scripts to download the data and save in CSV format. 

Requirements:
* [bash](https://www.gnu.org/software/bash/)
* [csvkit](https://github.com/wireservice/csvkit)
* [GNU parallel](https://www.gnu.org/software/parallel/)
