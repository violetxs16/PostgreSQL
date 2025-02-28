SELECT agencyID AS theAgency, route AS theRoute, yearBuilt AS theYear
FROM Vehicles v JOIN Routes r ON v.routeID = r.routeID AND v.agencyID = r.agencyID
WHERE yearBuilt IS NOT NULL
GROUP BY v.agencyID, v.routeID, v.yearBuilt
HAVING COUNT(*) > 1;