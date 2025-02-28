SELECT vehicleID, agencyID
FROM Vehicles JOIN Routes
ON Vehicles.routeID = Routes.routeID
AND Vehicles.agencyID = Routes.agencyID
WHERE routeName LIKE '% Express'
AND yearBuilt IS NOT NULL;