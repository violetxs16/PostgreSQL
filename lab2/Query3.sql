


---- Variant 1: Using Only routeID


-- Using `EXISTS` and `NOT EXISTS`**

SELECT s.stationName
FROM Stations s
WHERE s.stationName LIKE '% Station'
  AND EXISTS (
      SELECT 1
      FROM Transfers t
      JOIN Routes r1 ON t.route1 = r1.routeID
      JOIN Routes r2 ON t.route2 = r2.routeID
      WHERE s.stationID = t.stationID
        AND t.agency1 = t.agency2
        AND r1.length > 10
        AND r2.length > 10
  )
  AND NOT EXISTS (
      SELECT 1
      FROM Transfers t
      JOIN Routes r ON t.route1 = r.routeID OR t.route2 = r.routeID
      WHERE t.stationID = s.stationID
        AND r.ridership > 2000
  );


---### **Solution 2: Using Joins and `NOT EXISTS`**

SELECT DISTINCT s.stationName
FROM Stations s
JOIN Transfers t ON s.stationID = t.stationID
JOIN Routes r1 ON t.route1 = r1.routeID
JOIN Routes r2 ON t.route2 = r2.routeID
WHERE s.stationName LIKE '% Station'
  AND t.agency1 = t.agency2
  AND r1.length > 10
  AND r2.length > 10
  AND NOT EXISTS (
      SELECT 1
      FROM Transfers t2
      JOIN Routes r ON t2.route1 = r.routeID OR t2.route2 = r.routeID
      WHERE t2.stationID = s.stationID
        AND r.ridership > 2000
  );



---### **Solution 3: Alternate with `IN`**



SELECT s.stationName
FROM Stations s
WHERE s.stationName LIKE '% Station'
  AND s.stationID IN (
      SELECT t.stationID
      FROM Transfers t
      JOIN Routes r1 ON t.route1 = r1.routeID
      JOIN Routes r2 ON t.route2 = r2.routeID
      WHERE t.agency1 = t.agency2
        AND r1.length > 10
        AND r2.length > 10
  )
  AND s.stationID NOT IN (
      SELECT t.stationID
      FROM Transfers t
      JOIN Routes r ON t.route1 = r.routeID OR t.route2 = r.routeID
      WHERE r.ridership > 2000
  );


--Using ALL 

SELECT  s.stationName
FROM Stations s
JOIN Transfers t ON s.stationID = t.stationID
WHERE s.stationName LIKE '% Station'
  AND t.agency1 = t.agency2
  AND 10 < ALL (
      SELECT r.length
      FROM Routes r
      WHERE r.routeID = t.route1 
         OR r.routeID = t.route2
  )
  AND 2000 >= ALL (
      SELECT r.ridership
      FROM Routes r
      WHERE r.routeID = t.route1 
         OR r.routeID = t.route2
  );



----- Variant 2: Using (routeID, agencyID)


-- Using `EXISTS` and `NOT EXISTS`**
SELECT s.stationName
FROM Stations s
WHERE s.stationName LIKE '% Station'
  AND EXISTS (
      SELECT 1
      FROM Transfers t
      JOIN Routes r1 ON t.route1 = r1.routeID AND t.agency1 = r1.agencyID
      JOIN Routes r2 ON t.route2 = r2.routeID AND t.agency2 = r2.agencyID
      WHERE s.stationID = t.stationID
        AND t.agency1 = t.agency2
        AND r1.length > 10
        AND r2.length > 10
  )
  AND NOT EXISTS (
      SELECT 1
      FROM Transfers t
      JOIN Routes r ON (t.route1 = r.routeID AND t.agency1 = r.agencyID) 
                     OR (t.route2 = r.routeID AND t.agency2 = r.agencyID)
      WHERE t.stationID = s.stationID
        AND r.ridership > 2000
  );



---Using JOIN and NOT EXISTS

SELECT s.stationName
FROM Stations s
JOIN Transfers t ON s.stationID = t.stationID
JOIN Routes r1 ON t.route1 = r1.routeID AND t.agency1 = r1.agencyID
JOIN Routes r2 ON t.route2 = r2.routeID AND t.agency2 = r2.agencyID
WHERE s.stationName LIKE '% Station'
  AND t.agency1 = t.agency2
  AND r1.length > 10
  AND r2.length > 10
  AND NOT EXISTS (
      SELECT 1
      FROM Transfers t2
      JOIN Routes r ON (t2.route1 = r.routeID AND t2.agency1 = r.agencyID) 
                     OR (t2.route2 = r.routeID AND t2.agency2 = r.agencyID)
      WHERE t2.stationID = s.stationID
        AND r.ridership > 2000
  );


-- Using IN and NOT IN

SELECT s.stationName
FROM Stations s
WHERE s.stationName LIKE '% Station'
  AND s.stationID IN (
      SELECT t.stationID
      FROM Transfers t
      JOIN Routes r1 ON t.route1 = r1.routeID AND t.agency1 = r1.agencyID
      JOIN Routes r2 ON t.route2 = r2.routeID AND t.agency2 = r2.agencyID
      WHERE t.agency1 = t.agency2
        AND r1.length > 10
        AND r2.length > 10
  )
  AND s.stationID NOT IN (
      SELECT t.stationID
      FROM Transfers t
      JOIN Routes r ON (t.route1 = r.routeID AND t.agency1 = r.agencyID) 
                     OR (t.route2 = r.routeID AND t.agency2 = r.agencyID)
      WHERE r.ridership > 2000
  );


--Using ALL

SELECT s.stationName
FROM Stations s
JOIN Transfers t ON s.stationID = t.stationID
WHERE s.stationName LIKE '% Station'
  AND t.agency1 = t.agency2
  AND 10 < ALL (
      SELECT r.length
      FROM Routes r
      WHERE (r.routeID = t.route1 AND r.agencyID = t.agency1) 
         OR (r.routeID = t.route2 AND r.agencyID = t.agency2)
  )
  AND 2000 >= ALL (
      SELECT r.ridership
      FROM Routes r
      WHERE (r.routeID = t.route1 AND r.agencyID = t.agency1) 
         OR (r.routeID = t.route2 AND r.agencyID = t.agency2)
  );





**Notes:**
- The `IN` and `NOT IN` clauses replace the `EXISTS` logic.

---

### **Expected Output**

"stationname"
"Golden Gate Station"