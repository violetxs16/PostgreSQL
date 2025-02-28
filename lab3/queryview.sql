SELECT v.inService, COUNT(*) AS mismatchedVehicleCount
FROM MisreportedServiceCountView m
JOIN Vehicles v ON m.vehicleID = v.vehicleID AND m.agencyID = v.agencyID
GROUP BY v.inService;

--  inservice | mismatchedvehiclecount 
-----------+------------------------
 --t         |                      1
INSERT INTO VehicleServices (vehicleID, agencyID, serviceTimestamp, serviceComplete, cost)
VALUES (2001, 'SFMTA', NOW(), TRUE, 500.00);

SELECT v.inService, COUNT(*) AS mismatchedVehicleCount
FROM MisreportedServiceCountView m
JOIN Vehicles v ON m.vehicleID = v.vehicleID AND m.agencyID = v.agencyID
GROUP BY v.inService;

--  inservice | mismatchedvehiclecount
-----------+------------------------
-- (0 rows)