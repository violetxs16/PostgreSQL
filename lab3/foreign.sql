ALTER TABLE MaintenanceRecords
ADD CONSTRAINT foreign_constraint
FOREIGN KEY(vehicleID, agencyID) REFERENCES Vehicles(vehicleID, agencyID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE MaintenanceRecords
ADD CONSTRAINT foreign_route_const
FOREIGN KEY(routeID, agencyID) REFERENCES Routes(routeID, agencyID)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE MaintenanceDeltas
ADD CONSTRAINT foreign_vehicles_const
FOREIGN KEY (vehicleID, agencyID) REFERENCES Vehicles(vehicleID, agencyID)
ON DELETE CASCADE
ON UPDATE CASCADE;