SELECT DISTINCT stationName
FROM Stations
WHERE stationName LIKE '% Station'
AND Stations.stationID IN (
    SELECT stationID
    FROM Transfers
    JOIN Routes r1 ON Transfers.route1 = r1.routeID AND Transfers.agency1 = r1.agencyID
    JOIN Routes r2 ON Transfers.route2 = r2.routeID AND Transfers.agency2 = r2.agencyID
    WHERE r1.agencyID = r2.agencyID
    AND (r1.length + r2.length) > 10
)
AND NOT EXISTS (
    SELECT 1
    FROM Routes r
    JOIN Transfers t ON (r.routeID = t.route1 AND r.agencyID = t.agency1) OR (r.routeID = t.route2 AND r.agencyID = t.agency2)
    WHERE t.stationID = s.stationID
    AND r.ridership > 2000
);