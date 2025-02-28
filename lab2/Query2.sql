### New Query 2 for the Current Lab Schema

-- Using `EXISTS`
SELECT v.vehicleID, v.agencyID
FROM Vehicles v
WHERE v.yearBuilt IS NOT NULL
  AND EXISTS (SELECT *
              FROM Routes r
              WHERE v.agencyID = r.agencyID
                AND r.routeName LIKE '% Express');
--Using IN
SELECT v.vehicleID, v.agencyID
FROM Vehicles v
WHERE v.yearBuilt IS NOT NULL
  AND v.agencyID IN (
      SELECT r.agencyID
      FROM Routes r
      WHERE r.routeName LIKE '% Express'
  );

-- Using ANY
SELECT v.vehicleID, v.agencyID
FROM Vehicles v
WHERE v.yearBuilt IS NOT NULL
  AND v.agencyID = ANY (
      SELECT r.agencyID
      FROM Routes r
      WHERE r.routeName LIKE '% Express'
  );


--### **Expected Output**
-- Order of the output does not matter.
"vehicleid"	"agencyid"
1515	"SFMTA"
2001	"SFMTA"
7260	"SFMTA"
9001	"SFMTA"

