CREATE TABLE Agencies(
    agencyID VARCHAR(5),
    agencyCity VARCHAR(20) NOT NULL,
    agencyState CHAR(2),
    PRIMARY KEY(agencyID),
    UNIQUE(agencyCity, agencyState)
);
CREATE TABLE Routes(
    routeID VARCHAR(5),
    agencyID VARCHAR(5),
    routeName VARCHAR(20) NOT NULL UNIQUE,
    length DECIMAL(5,1),
    ridership INTEGER,
    PRIMARY KEY(routeID,agencyID),
    FOREIGN KEY(agencyID) REFERENCES Agencies(agencyID)
);
CREATE TABLE Stations(
    stationID INTEGER,
    operatorID VARCHAR(5),
    stationName VARCHAR(20) NOT NULL UNIQUE,
    address VARCHAR(60),
    PRIMARY KEY(stationID),
    FOREIGN KEY(operatorID) REFERENCES Agencies(agencyID)
);
CREATE TABLE Transfers(
    route1 VARCHAR(5),
    agency1 VARCHAR(5),
    route2 VARCHAR(5),
    agency2 VARCHAR(5),
    stationID INTEGER,
    PRIMARY KEY(route1, agency1, route2, agency2),
    FOREIGN KEY(route1, agency1) REFERENCES Routes(routeID, agencyID),
    FOREIGN KEY(route2, agency2) REFERENCES Routes(routeID, agencyID),
    FOREIGN KEY(stationID) REFERENCES Stations(stationID)
);
CREATE TABLE VehicleKinds(
    vehicleMake VARCHAR(20),
    vehicleModel VARCHAR(20),
    vehicleType CHAR(2),
    stillOffered BOOLEAN,
    PRIMARY KEY(vehicleMake, vehicleModel)
);
CREATE TABLE Vehicles(
    vehicleID INTEGER UNIQUE,
    agencyID VARCHAR(5),
    routeID VARCHAR(5),
    vehicleMake VARCHAR(20),
    vehicleModel VARCHAR(20),
    yearBuilt INTEGER,
    inService BOOLEAN,
    PRIMARY KEY(vehicleID, agencyID),
    FOREIGN KEY(vehicleMake, vehicleModel) REFERENCES VehicleKinds(vehicleMake,vehicleModel)
);
CREATE TABLE VehicleServices(
    vehicleID INTEGER,
    agencyID VARCHAR(5),
    serviceTimestamp TIMESTAMP,
    serviceComplete BOOLEAN,
    cost DECIMAL(8,2),
    PRIMARY KEY(vehicleID, agencyID, serviceTimestamp),
    FOREIGN KEY(vehicleID, agencyID) REFERENCES Vehicles(vehicleID, agencyID)
);