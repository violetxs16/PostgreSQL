SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;
-- Insert new records from MaintenanceDeltas when no corresponding record exists in MaintenanceRecords
INSERT INTO MaintenanceRecords (vehicleID, agencyID, routeID, lastMaintenanceMileage, maintenanceStatus)
SELECT m.vehicleID, m.agencyID, m.routeID, m.mileageDelta, m.newMaintenanceStatus
FROM MaintenanceDeltas m
WHERE NOT EXISTS (
    SELECT 1
    FROM MaintenanceRecords mr
    WHERE mr.vehicleID = m.vehicleID
    AND mr.agencyID = m.agencyID
    AND mr.routeID = m.routeID
);

-- Update existing records by adding mileageDelta and setting newMaintenanceStatus
UPDATE MaintenanceRecords
SET lastMaintenanceMileage = lastMaintenanceMileage + m.mileageDelta,
    maintenanceStatus = m.newMaintenanceStatus
FROM MaintenanceDeltas m
WHERE MaintenanceRecords.vehicleID = m.vehicleID
AND MaintenanceRecords.agencyID = m.agencyID
AND MaintenanceRecords.routeID = m.routeID;

COMMIT;

--Need to update existing records in maintaincerecords
--using data from MaintenanceDeltas(mileage and new maintrance status)
--If there is no