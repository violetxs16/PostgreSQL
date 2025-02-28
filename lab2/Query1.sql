

------- Variant 1: Using Only routeID (Assuming routeID is Unique)
--#### Solution 1:

-- distinct is not needed as routeID is unique
SELECT v.vehicleID AS vehicleID, 
       v.yearBuilt AS manufactureYear, 
       v.routeID AS routeID
FROM Vehicles v, Routes r
WHERE v.routeID = r.routeID
  AND v.yearBuilt < 2010
  AND v.inService = FALSE
  AND r.length > 10
ORDER BY v.yearBuilt DESC, v.vehicleID ASC;

--Using EXISTS
SELECT v.vehicleID AS vehicleID, 
       v.yearBuilt AS manufactureYear, 
       v.routeID AS routeID
FROM Vehicles v
WHERE v.yearBuilt < 2010
  AND v.inService = FALSE
  AND EXISTS (
      SELECT 1 FROM Routes r
      WHERE v.routeID = r.routeID 
        AND r.length > 10
  )
ORDER BY v.yearBuilt DESC, v.vehicleID ASC;


--Using IN
SELECT v.vehicleID AS vehicleID, 
       v.yearBuilt AS manufactureYear, 
       v.routeID AS routeID
FROM Vehicles v
WHERE v.yearBuilt < 2010
  AND v.inService = FALSE
  AND v.routeID IN (
      SELECT r.routeID FROM Routes r
      WHERE r.length > 10
  )
ORDER BY v.yearBuilt DESC, v.vehicleID ASC;

--Using ANY
SELECT v.vehicleID AS vehicleID, 
       v.yearBuilt AS manufactureYear, 
       v.routeID AS routeID
FROM Vehicles v
WHERE v.yearBuilt < 2010
  AND v.inService = FALSE
  AND v.routeID = ANY (
      SELECT r.routeID FROM Routes r
      WHERE r.length > 10
  )
ORDER BY v.yearBuilt DESC, v.vehicleID ASC;



Output ---- 
-- Order of the output matters.
"vehicleid"	"manufactureyear"	"routeid"
2322	          2002	           "18"
38028	          1981	           "CS"


---Variant 2: Using (routeID, agencyID) (Assuming Route Needs Both)

SELECT DISTINCT v.vehicleID AS vehicleID, 
       v.yearBuilt AS manufactureYear, 
       v.routeID AS routeID
FROM Vehicles v, Routes r
WHERE v.routeID = r.routeID AND v.agencyID = r.agencyID
  AND v.yearBuilt < 2010
  AND v.inService = FALSE
  AND r.length > 10
ORDER BY v.yearBuilt DESC, v.vehicleID ASC;

--  DISTINCT is required because routeID alone is not unique, meaning multiple rows from Routes can map to the same vehicle.


---Using EXISTS
SELECT DISTINCT v.vehicleID AS vehicleID, 
       v.yearBuilt AS manufactureYear, 
       v.routeID AS routeID
FROM Vehicles v
WHERE v.yearBuilt < 2010
  AND v.inService = FALSE
  AND EXISTS (
      SELECT 1 FROM Routes r
      WHERE v.routeID = r.routeID 
        AND v.agencyID = r.agencyID
        AND r.length > 10
  )
ORDER BY v.yearBuilt DESC, v.vehicleID ASC;

--Using IN

SELECT DISTINCT v.vehicleID AS vehicleID, 
       v.yearBuilt AS manufactureYear, 
       v.routeID AS routeID
FROM Vehicles v
WHERE v.yearBuilt < 2010
  AND v.inService = FALSE
  AND (v.routeID, v.agencyID) IN (
      SELECT r.routeID, r.agencyID FROM Routes r
      WHERE r.length > 10
  )
ORDER BY v.yearBuilt DESC, v.vehicleID ASC;

--Using ANY
SELECT DISTINCT v.vehicleID AS vehicleID, 
       v.yearBuilt AS manufactureYear, 
       v.routeID AS routeID
FROM Vehicles v
WHERE v.yearBuilt < 2010
  AND v.inService = FALSE
  AND v.routeID = ANY (
      SELECT r.routeID FROM Routes r
      WHERE r.length > 10
  ) AND v.agencyID = ANY (
      SELECT r.agencyID FROM Routes r
      WHERE r.length > 10
  )
ORDER BY v.yearBuilt DESC, v.vehicleID ASC;

Output ----
"vehicleid"	"manufactureyear"	"routeid"
38028	          1981	           "CS"