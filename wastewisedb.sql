CREATE DATABASE WasteWiseDB;
USE WasteWiseDB;

-- TABLE 1: AREAS / WARDS
CREATE TABLE Area (
    area_id INT PRIMARY KEY AUTO_INCREMENT,
    area_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    population INT
);

-- TABLE 2: SMART BINS
CREATE TABLE Smart_Bin (
    bin_id INT PRIMARY KEY AUTO_INCREMENT,
    area_id INT NOT NULL,
    location_lat DECIMAL(10,6),
    location_long DECIMAL(10,6),
    fill_level INT DEFAULT 0, -- in percentage 0-100
    status VARCHAR(20) DEFAULT 'Active', -- Active, Full, Maintenance
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (area_id) REFERENCES Area(area_id)
);

-- TABLE 3: COLLECTION TRUCKS
CREATE TABLE Collection_Truck (
    truck_id INT PRIMARY KEY AUTO_INCREMENT,
    truck_number VARCHAR(20) UNIQUE NOT NULL,
    driver_name VARCHAR(100),
    capacity_kg INT,
    status VARCHAR(20) DEFAULT 'Available' -- Available, On Route
);

-- TABLE 4: ROUTES
CREATE TABLE Route (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    route_name VARCHAR(100),
    area_id INT NOT NULL,
    truck_id INT,
    scheduled_date DATE,
    FOREIGN KEY (area_id) REFERENCES Area(area_id),
    FOREIGN KEY (truck_id) REFERENCES Collection_Truck(truck_id)
);

-- TABLE 5: PICKUP LOG - connects Route and Bin
CREATE TABLE Pickup_Log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    route_id INT NOT NULL,
    bin_id INT NOT NULL,
    pickup_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    waste_collected_kg DECIMAL(10,2),
    FOREIGN KEY (route_id) REFERENCES Route(route_id),
    FOREIGN KEY (bin_id) REFERENCES Smart_Bin(bin_id)
);