ib-traffic-2010
===============

International Bureau - International Traffic Data 2010

This project represents the data from the Federal Communications Commission
International Bureau Internaltional Traffic Data for 2010

source data is posted at http://transition.fcc.gov/ib/sand/mniab/traffic/

This project contains the following folders and files;
- data - folder containing the source data
    - load_international_traffic.sql - sql script used to load the individual data files into a single table
    - traffic_2010.csv - an appended version of the all the regional files into one 2010 data file

- mapbox-project
    - layers - folder containg layers redirect
    - project.mml - mapbox project file
    - style.mss - mapbox style file 
