SELECT vehicleID, yearBuilt AS manufactureYear, routeID
FROM Vehicles JOIN Routes on Vehicles.routeID = Routes.routeID AND Vehicles.agencyID = Routes.agencyID
WHERE yearBuilt < 2010
AND inService = false
AND Routes.length > 10
ORDER BY yearBuilt DESC, vehicleID ASC;