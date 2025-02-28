### New Query 4 for the Current Lab Schema

**Question:**

Find the `agencyID` and `routeID` of routes for which there is more than one vehicle operating with the same non-NULL `yearBuilt`. The attributes in your result should be `agencyID`, `routeID`, and `yearBuilt`, which should appear in your result as `theAgency`, `theRoute`, and `theYear`. No duplicates should appear in your result.



/*
Even though there’s no enforced foreign key constraint, we assume that a vehicle must be assigned to a valid route for the data to make sense.

If a routeID were in Vehicles but NOT in Routes, that would mean vehicles exist on a route that does not exist in the system, which would be incorrect data.
Since Vehicles records real vehicles operating on actual routes, it makes no logical sense for a route to be missing from Routes.
Thus, even though it's not enforced via constraints, logically every routeID in Vehicles should exist in Routes. But if a student has considered this as well, that's a good thing. students should not be penalized for considering this.
*/

-- variant1 : with just Vehicles table




---### **Solution 1: Using Self-Join**

SELECT DISTINCT v1.agencyID AS theAgency, 
                v1.routeID AS theRoute, 
                v1.yearBuilt AS theYear
FROM Vehicles v1, Vehicles v2
WHERE v1.agencyID = v2.agencyID
  AND v1.routeID = v2.routeID
  AND v1.yearBuilt = v2.yearBuilt
  AND v1.vehicleID != v2.vehicleID;

---### **Solution 2: Using `EXISTS`**

SELECT DISTINCT v.agencyID AS theAgency, 
                v.routeID AS theRoute, 
                v.yearBuilt AS theYear
FROM Vehicles v
WHERE v.yearBuilt IS NOT NULL
  AND EXISTS (
      SELECT *
      FROM Vehicles v2
      WHERE v.agencyID = v2.agencyID
        AND v.routeID = v2.routeID
        AND v.yearBuilt = v2.yearBuilt
        AND v.vehicleID != v2.vehicleID
  );



---### **Solution 3: Using `GROUP BY` and `HAVING`** 

SELECT v.agencyID AS theAgency, 
       v.routeID AS theRoute, 
       v.yearBuilt AS theYear
FROM Vehicles v
WHERE v.yearBuilt IS NOT NULL
GROUP BY v.agencyID, v.routeID, v.yearBuilt
HAVING COUNT(*) > 1;

SELECT v.agencyID AS theAgency, 
       v.routeID AS theRoute, 
       v.yearBuilt AS theYear
FROM Vehicles v
JOIN Routes r ON v.routeID = r.routeID
WHERE v.yearBuilt IS NOT NULL
GROUP BY v.agencyID, v.routeID, v.yearBuilt
HAVING COUNT(*) > 1;

SELECT v.agencyID AS theAgency, 
       v.routeID AS theRoute, 
       v.yearBuilt AS theYear
FROM Vehicles v
JOIN Routes r ON v.routeID = r.routeID AND v.agencyID = r.agencyID
WHERE v.yearBuilt IS NOT NULL
GROUP BY v.agencyID, v.routeID, v.yearBuilt
HAVING COUNT(*) > 1;



**Notes:**
- This approach uses `GROUP BY` to group vehicles by `agencyID`, `routeID`, and `yearBuilt`.
- The `HAVING` clause ensures only groups with more than one vehicle are included.

---


--- Variant 2 : (routeID, agencyID) join


SELECT v.agencyID AS theAgency, v.routeID AS theRoute, v.yearBuilt AS theYear
FROM Vehicles v
JOIN Routes r ON v.routeID = r.routeID AND v.agencyID = r.agencyID
WHERE v.yearBuilt IS NOT NULL
GROUP BY v.agencyID, v.routeID, v.yearBuilt
HAVING COUNT(*) > 1;





### Expected Output

"theagency"	"theroute"	"theyear"
"SFMTA"	      "N"	         2016