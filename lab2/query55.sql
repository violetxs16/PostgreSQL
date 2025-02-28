SELECT routeID, agencyID
FROM Vehicles v JOIN Routes r ON v.routeID = r.routeID AND v.agencyID = r.agencyID
GROUP BY v.agencyID, v.routeID
HAVING COUNT(DISTINCT v.agencyID) = 1;
