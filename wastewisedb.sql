CREATE DATABASE WasteWiseDB;
USE WasteWiseDB;

CREATE TABLE Area (
    area_id INT PRIMARY KEY AUTO_INCREMENT,
    area_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    population INT
);

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

CREATE TABLE Collection_Truck (
    truck_id INT PRIMARY KEY AUTO_INCREMENT,
    truck_number VARCHAR(20) UNIQUE NOT NULL,
    driver_name VARCHAR(100),
    capacity_kg INT,
    status VARCHAR(20) DEFAULT 'Available' -- Available, On Route
);

CREATE TABLE Route (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    route_name VARCHAR(100),
    area_id INT NOT NULL,
    truck_id INT,
    scheduled_date DATE,
    FOREIGN KEY (area_id) REFERENCES Area(area_id),
    FOREIGN KEY (truck_id) REFERENCES Collection_Truck(truck_id)
);

CREATE TABLE Pickup_Log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    route_id INT NOT NULL,
    bin_id INT NOT NULL,
    pickup_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    waste_collected_kg DECIMAL(10,2),
    FOREIGN KEY (route_id) REFERENCES Route(route_id),
    FOREIGN KEY (bin_id) REFERENCES Smart_Bin(bin_id)
);

SELECT * FROM WasteWiseDB