--Script to populate the Public Transport schema for W25 CSE 180 Lab1
-- Agencies(agencyID, agencyCity, agencyState)
COPY Agencies FROM stdin USING DELIMITERS '|';
SCMTD|Santa Cruz|CA
TAPS|Santa Cruz|CA
SFMTA|San Francisco|CA
JPBX|San Carlos|CA
AMTK|Washington|DC
\.
-- Routes(routeID, agencyID, routeName, length, ridership)
COPY Routes FROM stdin USING DELIMITERS '|';
49|SFMTA|Van Ness & Mission|6.9|25000
Loop|TAPS|Loop|4.7|3000
7XX|JPBX|Baby Bullet|46.7|52859
8XX|JPBX|S County Connector|29.5|300
CC|AMTK|Capitol Corridor|168|4932
SJS|AMTK|San Joaquins|315|2935
CS|AMTK|Coast Starlight|1377|985
17|SCMTD|Highway 17|32|1110
18|SCMTD|Mission|5.9|3500
19|SCMTD|Bay|5.8|1400
N|SFMTA|Judah|8.2|45000
30|SFMTA|Stockton|5.3|20400
\.
-- Stations(stationID, operatorID, stationName, address)
COPY Stations FROM stdin USING DELIMITERS '|';
1920|SCMTD|Metro Center|920 Pacific Avenue
2168|SCMTD|Main Gate|1156 High Street
2862|TAPS|Science Hill|25 McLaughlin Drive
1928|AMTK|Diridon|65 Cahill Street
8452|JPBX|4th & Townsend|700 4th Street
8736|AMTK|Jack London Square|245 2nd Street
6423|SFMTA|Fort Mason|3200 Van Ness Avenue
\.
-- Transfers(route1, agency1, route2, agency2, stationID)
COPY Transfers FROM stdin USING DELIMITERS '|';
18|SCMTD|19|SCMTD|1920
17|SCMTD|19|SCMTD|1920
18|SCMTD|Loop|TAPS|2862
7XX|JPBX|17|SCMTD|1928
SJS|AMTK|CC|AMTK|8736
30|SFMTA|49|SFMTA|6423
\.
-- VehicleKinds(vehicleMake, vehicleModel, vehicleType, stillOffered)
COPY VehicleKinds FROM stdin USING DELIMITERS '|';
Stadler|KISS|HR|T
Nippon-Sharyo|Gallery|HR|T
New Flyer|XT60|TB|T
Amerail|California Car|HR|F
Pullman|Superliner|HR|F
Gillig|BRT|MB|T
New Flyer|D60|MB|F
Siemens|S200|LR|T
Breda|LRV3|LR|F
\.
-- Vehicles(vehicleID, agencyID, routeID, vehicleMake, vehicleModel, yearBuilt,
inService)
COPY Vehicles FROM stdin USING DELIMITERS '|';
2322|SCMTD|18|New Flyer|D60|2002|F
1903|SCMTD|19|Gillig|BRT|2019|T
2001|SFMTA|N|Siemens|S200|2016|T
7260|SFMTA|30|New Flyer|XT60|2015|T
38028|AMTK|CS|Pullman|Superliner|1981|F
8015|AMTK|CC|Amerail|California Car|1996|T
1515|SFMTA|N|Breda|LRV3|2001|F
\.
-- VehicleServices(vehicleID, agencyID, serviceTimestamp, serviceComplete, cost)
COPY VehicleServices FROM stdin USING DELIMITERS '|';
2001|SFMTA|2020-09-03 14:45:00|T|2735.40
7260|SFMTA|2024-03-13 14:30:00|T|10692.86
2322|SCMTD|2021-11-7 16:15:00|F|27340.00
\.