/*
No Need to Join with the Routes Table
Since every vehicle in Vehicles is already associated with a routeID and agencyID, we do not need to verify the route’s existence in Routes.
We assume that if a route is assigned to a vehicle, it must exist.


Also an assumption was to given as hint - FOREIGN KEY (agencyID, routeID) REFERENCES Routes This assumption simplifies the query, ensuring that every routeID in Vehicles must also exist in Routes. 


*/
---### **Solution 1: Using `NOT EXISTS`**

SELECT DISTINCT v.routeID, v.agencyID
FROM Vehicles v
WHERE NOT EXISTS (
    SELECT *
    FROM Vehicles v2
    WHERE v.routeID = v2.routeID
      AND v.agencyID != v2.agencyID
);



---### **Solution 2: Using `NOT IN`**

SELECT DISTINCT v.routeID, v.agencyID
FROM Vehicles v
WHERE v.routeID NOT IN (
    SELECT v2.routeID
    FROM Vehicles v1, Vehicles v2
    WHERE v1.routeID = v2.routeID
      AND v1.agencyID != v2.agencyID
);

---### **Solution 3: Using `ALL`**

SELECT DISTINCT v.routeID, v.agencyID
FROM Vehicles v
WHERE v.agencyID = ALL (
    SELECT v2.agencyID
    FROM Vehicles v2
    WHERE v.routeID = v2.routeID
);



---### **Solution 4: Using `GROUP BY`**
SELECT v.routeID, v.agencyID
FROM Vehicles v
GROUP BY v.routeID, v.agencyID
HAVING COUNT(DISTINCT v.agencyID) = 1;

**Explanation:**
- The `GROUP BY` clause groups vehicles by `routeID` and `agencyID`.
- The `HAVING` clause ensures only routes where all vehicles belong to the same agency are included.

---
### **Expected Output**
-- Order does not matter
"routeid"	"agencyid"
"18"	      "SCMTD"
"19"	      "SCMTD"
"30"	      "SFMTA"
"CC"	       "AMTK"
"CS"	       "AMTK"
"N"	         "SFMTA"



--- there are correct solutions which  involves vehicle and routes table but these might give different result based how they are joined 

--- joining on both routeID and agencyID
SELECT r.routeID, MIN(v.agencyID) AS agencyID
FROM Routes r
JOIN Vehicles v ON r.routeID = v.routeID AND r.agencyID = v.agencyID
WHERE v.agencyID = ALL (
    SELECT v1.agencyID
    FROM Vehicles v1
    WHERE v1.routeID = r.routeID AND v1.agencyID = r.agencyID
)
GROUP BY r.routeID
HAVING COUNT(DISTINCT v.agencyID) = 1;

### **Expected Output**
-- Order does not matter
"routeid"	"agencyid"
"19"	      "SCMTD"
"30"	      "SFMTA"
"CC"	       "AMTK"
"CS"	       "AMTK"
"N"	         "SFMTA"


--- joining on only routeID
SELECT r.routeID, MIN(v.agencyID) AS agencyID
FROM Routes r
JOIN Vehicles v ON r.routeID = v.routeID 
WHERE v.agencyID = ALL (
    SELECT v1.agencyID
    FROM Vehicles v1
    WHERE v1.routeID = r.routeID AND v1.agencyID = r.agencyID
)
GROUP BY r.routeID
HAVING COUNT(DISTINCT v.agencyID) = 1;




### **Expected Output**
-- Order does not matter
"routeid"	"agencyid"
"18"	      "SCMTD"
"19"	      "SCMTD"
"30"	      "SFMTA"
"CC"	       "AMTK"
"CS"	       "AMTK"
"N"	         "SFMTA"




