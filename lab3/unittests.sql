--Unit tests for foreign.sql constraints to break constraints
INSERT INTO MaintenanceRecords
VALUES(2017,'SVVFS', '10', 3000, 'Poor');

INSERT INTO MaintenanceRecords
VALUES(2018,'SQVFS', '15', 2000, 'Good');

INSERT INTO MaintenanceDeltas
VALUES(2019,'SQVFL', '15', 1500, 'Poor');

UPDATE Vehicles
SET yearBuilt = 1950
WHERE vehicleID = 2322;

UPDATE Vehicles
SET yearBuilt = 1800
WHERE vehicleID = 7260;

UPDATE Routes
SET length = 1
WHERE routeID = 7XX;

UPDATE Routes
SET length = 0
WHERE routeID = CC;

UPDATE Routes
SET length = 5, ridership = 5100
WHERE routeID = CS;

UPDATE Routes
SET length = 2, ridership = 5100
WHERE routeID = 19;



