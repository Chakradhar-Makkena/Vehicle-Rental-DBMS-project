show databases;
create database Vehicle_Rental_Management;
use Vehicle_Rental_Management;

CREATE TABLE LOYALTY ( 
    TIER VARCHAR(20), 
    MINIMUM_NO_OF_TIMES_RENTED INT, 
    DISCOUNT FLOAT, 
    PRIMARY KEY(TIER) 
);

CREATE TABLE CUSTOMER_INFO ( 
 CUSTOMER_ID VARCHAR(20), 
    FIRST_NAME VARCHAR(50), 
    LAST_NAME VARCHAR(50), 
    CITY VARCHAR(20), 
    TIER VARCHAR(20), 
    LICENSE_NO CHAR(16), 
    PHONE_NO NUMERIC(10,0), 
 EMAIL VARCHAR(50), 
    PRIMARY KEY(CUSTOMER_ID), 
    FOREIGN KEY(TIER) REFERENCES LOYALTY(TIER) 
);

CREATE TABLE LOCATION ( 
 LOCATION_CODE VARCHAR(20), 
    PLACE VARCHAR(50) NOT NULL, 
    ROAD_NO VARCHAR(50), 
    CITY VARCHAR(20) NOT NULL, 
    PRIMARY KEY(LOCATION_CODE) 
);

CREATE TABLE CLASSIFIED ( 
 VEHICLE_TYPE VARCHAR(30), 
    CATEGORY VARCHAR(30), 
    PRIMARY KEY(VEHICLE_TYPE) 
); 

CREATE TABLE MODEL_SPECIFICATIONS ( 
 MODEL_ID VARCHAR(20), 
    ENGINE_CC INT, 
    FUEL_TYPE VARCHAR(20), 
    MILEAGE INT, 
    POWER_HP INT, 
    VEHICLE_TYPE VARCHAR(30), 
    PRIMARY KEY(MODEL_ID), 
    FOREIGN KEY(VEHICLE_TYPE) REFERENCES CLASSIFIED(VEHICLE_TYPE) 
); 

CREATE TABLE GARAGE ( 
 GARAGE_ID VARCHAR(20), 
    MODEL_ID VARCHAR(20), 
    NO_OF_AVAILABLE INT, 
    PRIMARY KEY(GARAGE_ID,MODEL_ID), 
    FOREIGN KEY(MODEL_ID) REFERENCES MODEL_SPECIFICATIONS(MODEL_ID) 
);

CREATE TABLE VEHICLE_FARE ( 
 REGISTRATION_NO CHAR(10), 
    MODEL_ID VARCHAR(20), 
    GARAGE_ID VARCHAR(20), 
    COLOR VARCHAR(10), 
    BASE_FARE INT, 
    PERDAY_FARE INT, 
    DAMAGE_PENALTY INT, 
    PRIMARY KEY(REGISTRATION_NO), 
    FOREIGN KEY(GARAGE_ID) REFERENCES GARAGE(GARAGE_ID), 
    FOREIGN KEY(MODEL_ID) REFERENCES GARAGE(MODEL_ID) 
);

CREATE TABLE AGENCY ( 
 AGENCY_ID VARCHAR(20), 
    NAME VARCHAR(30), 
    CITY VARCHAR(20), 
    GARAGE_ID VARCHAR(20), 
    PRIMARY KEY(AGENCY_ID), 
    FOREIGN KEY(GARAGE_ID) REFERENCES GARAGE(GARAGE_ID) 
);

CREATE TABLE RENTAL ( 
 CUSTOMER_ID VARCHAR(20), 
 RENTAL_ID VARCHAR(20), 
    NO_OF_PEOPLE INT, 
    START_DAY DATE, 
    END_DAY DATE, 
    PICKUP_LOCATION VARCHAR(20), 
    DROPOFF_LOCATION VARCHAR(20), 
    RETURN_DATE DATE, 
    LATERETURN_FEE INT, 
    AGENCY_ID VARCHAR(20), 
    REGISTRATION_NO CHAR(10), 
    PRIMARY KEY(RENTAL_ID), 
    FOREIGN KEY(AGENCY_ID) REFERENCES AGENCY(AGENCY_ID), 
    FOREIGN KEY(REGISTRATION_NO) REFERENCES VEHICLE_FARE(REGISTRATION_NO), 
    FOREIGN KEY(PICKUP_LOCATION) REFERENCES LOCATION(LOCATION_CODE), 
    FOREIGN KEY(DROPOFF_LOCATION) REFERENCES LOCATION(LOCATION_CODE), 
 FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER_INFO(CUSTOMER_ID) 
);

CREATE TABLE PAYMENT ( 
   TRANSACTION_ID INT, 
    ADVANCE INT, 
    AMOUNT INT, 
    BOOK_DATE DATE, 
    CUSTOMER_ID VARCHAR(20), 
    AGENCY_ID VARCHAR(20), 
    RENTAL_ID VARCHAR(20), 
    PRIMARY KEY(TRANSACTION_ID), 
    FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER_INFO(CUSTOMER_ID), 
    FOREIGN KEY(AGENCY_ID) REFERENCES AGENCY(AGENCY_ID), 
    FOREIGN KEY(RENTAL_ID) REFERENCES RENTAL(RENTAL_ID) 
); 

CREATE TABLE INSURANCE ( 
 POLICY_ID VARCHAR(10), 
    INSURANCE_PREMIUM INT, 
    COST INT, 
    PRIMARY KEY(POLICY_ID) 
); 

CREATE TABLE COVERS ( 
    RENTAL_ID VARCHAR(20), 
    POLICY_ID VARCHAR(10), 
    PRIMARY KEY(RENTAL_ID,POLICY_ID), 
    FOREIGN KEY(RENTAL_ID) REFERENCES RENTAL(RENTAL_ID), 
    FOREIGN KEY(POLICY_ID) REFERENCES INSURANCE(POLICY_ID) 
);

CREATE TABLE REVIEWS ( 
 CUSTOMER_ID VARCHAR(20), 
    AGENCY_ID VARCHAR(20), 
    RATING_SCALE10 INT, 
    FEEDBACK VARCHAR(100), 
    PRIMARY KEY(CUSTOMER_ID,AGENCY_ID), 
    FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER_INFO(CUSTOMER_ID), 
    FOREIGN KEY(AGENCY_ID) REFERENCES AGENCY(AGENCY_ID) 
); 

INSERT INTO LOYALTY VALUES ('BRONZE',0,0.05);  
INSERT INTO LOYALTY VALUES ('SILVER',5,0.10); 
INSERT INTO LOYALTY VALUES ('GOLD',10,0.15); 
INSERT INTO LOYALTY VALUES ('PLATINUM',15,0.20);

INSERT INTO CUSTOMER_INFO VALUES  
('CUST1', 'John', 'Doe', 'Mumbai', 'Gold', 'DL-0720090054321', 9876543210, 'john.doe@example.com'), 
('CUST2', 'Jane', 'Smith', 'Delhi', 'Silver', 'DL14 20120098765', 9876543211, 'jane.smith@example.com'), 
('CUST3', 'Michael', 'Johnson', 'Pune', 'Bronze', 'MH-0820180012345', 9876543212, 'michael.j@example.com'), 
('CUST4', 'Emily', 'Brown', 'Bangalore', 'Platinum', 'MH06 20210012345', 9876543213, 'emily.b@example.com'), 
('CUST5', 'David', 'Lee', 'Ahmedabad', 'Silver', 'GJ-0520190067890', 9876543214, 'david.lee@example.com'), 
('CUST6', 'Emma', 'Wilson', 'Surat', 'Gold', 'GJ03 20220098765', 9876543215, 'emma.wilson@example.com'), 
('CUST7', 'Christopher', 'Martinez', 'Jaipur', 'Bronze', 'RJ-0120160034567', 9876543216, 'chris.m@example.com'), 
('CUST8', 'Olivia', 'Taylor', 'Lucknow', 'Platinum', 'RJ14 20190076543', 9876543217, 'olivia.t@example.com'), 
('CUST9', 'Daniel', 'Anderson', 'Chennai', 'Silver', 'KA-0920170043210', 9876543218, 'daniel.a@example.com'), 
('CUST10', 'Sophia', 'Garcia', 'Hyderabad', 'Gold', 'KA06 20200098765', 9876543219, 'sophia.g@example.com'); 

INSERT INTO LOCATION VALUES 
('LOC001', 'Mumbai Airport', 'Airport Road', 'Mumbai'), 
('LOC002', 'Bandra', 'Linking Road', 'Mumbai'), 
('LOC003', 'Gateway of India', 'Apollo Bunder', 'Mumbai'), 
('LOC004', 'Juhu Beach', 'Juhu Tara Road', 'Mumbai'), 
('LOC005', 'Marine Drive', 'Netaji Subhash Chandra Bose Road', 'Mumbai'), 
('LOC006', 'Haji Ali Dargah', 'Lala Lajpatrai Marg', 'Mumbai'), 
('LOC007', 'Siddhivinayak Temple', 'SK Bole Marg', 'Mumbai'), 
('LOC008', 'Film City', 'Goregaon East', 'Mumbai'), 
('LOC009', 'India Gate', 'Rajpath', 'Delhi'), 
('LOC010', 'Lotus Temple', 'Lotus Temple Road', 'Delhi'), 
('LOC011', 'Qutub Minar', 'Mehrauli', 'Delhi'), 
('LOC012', 'Red Fort', 'Netaji Subhash Marg', 'Delhi'), 
('LOC013', 'Humayun’s Tomb', 'Mathura Road', 'Delhi'), 
('LOC014', 'Connaught Place', 'Inner Circle', 'Delhi'), 
('LOC015', 'Chandni Chowk', 'Old Delhi', 'Delhi'), 
('LOC016', 'Jama Masjid', 'Meena Bazaar', 'Delhi'), 
('LOC017', 'Bangalore Palace', 'Palace Road', 'Bangalore'), 
('LOC018', 'Lalbagh Botanical Garden', 'Mavalli', 'Bangalore'), 
('LOC019', 'Cubbon Park', 'Kasturba Road', 'Bangalore'), 
('LOC020', 'ISKCON Temple', 'Hare Krishna Hill', 'Bangalore'), 
('LOC021', 'Tipu Sultan’s Summer Palace', 'Albert Victor Road', 'Bangalore'), 
('LOC022', 'Vidhana Soudha', 'Dr Ambedkar Veedhi', 'Bangalore'), 
('LOC023', 'Wonderla Amusement Park', 'Mysore Road', 'Bangalore'), 
('LOC024', 'Bannerghatta National Park', 'Bannerghatta Road', 'Bangalore'), 
('LOC025', 'Marina Beach', 'Kamarajar Salai', 'Chennai'), 
('LOC026', 'Kapaleeshwarar Temple', 'Kutchery Road', 'Chennai'), 
('LOC027', 'Fort St. George', 'Rajaji Salai', 'Chennai'), 
('LOC028', 'Arignar Anna Zoological Park', 'GST Road', 'Chennai'), 
('LOC029', 'San Thome Church', 'Santhome High Road', 'Chennai'), 
('LOC030', 'Guindy National Park', 'Sardar Patel Road', 'Chennai'), 
('LOC031', 'Charminar', 'Charminar Road', 'Hyderabad'), 
('LOC032', 'Golconda Fort', 'Fort Road', 'Hyderabad'), 
('LOC033', 'Ramoji Film City', 'Anajpur', 'Hyderabad'), 
('LOC034', 'Salar Jung Museum', 'Darushifa', 'Hyderabad'), 
('LOC035', 'Hussain Sagar Lake', 'Tank Bund Road', 'Hyderabad'), 
('LOC036', 'Birla Mandir', 'Hill Fort Road', 'Hyderabad'), 
('LOC037', 'Victoria Memorial', 'Queens Way', 'Kolkata'), 
('LOC038', 'Dakshineswar Kali Temple', 'May Dibas Pally', 'Kolkata'), 
('LOC039', 'Indian Museum', 'Jawaharlal Nehru Road', 'Kolkata'), 
('LOC040', 'Howrah Bridge', 'Strand Road', 'Kolkata');

INSERT INTO CLASSIFIED VALUES 
('SUV', 'CAR'), 
('SEDAN', 'CAR'), 
('CUV', 'CAR'), 
('HATCH_BACK', 'CAR'), 
('ROADSTER', 'CAR'), 
('PICKUP', 'CAR'), 
('SUPERCAR', 'CAR'), 
('COUPE', 'CAR'), 
('CABRIOLET', 'CAR'), 
('SPORTS', 'CAR'), 
('TESLA', 'CAR'), 
('STANDARD', 'BIKE'), 
('CRUISER', 'BIKE'), 
('SPORTS_B', 'BIKE'), 
('SCOOTER', 'BIKE'), 
('MOPED', 'BIKE'), 
('ADVENTURE', 'BIKE'), 
('NAKED', 'BIKE'), 
('ELECTRIC', 'BIKE'), 
('BUS_A', 'BUS'), 
('BUS_B', 'BUS'), 
('BUS_C', 'BUS'), 
('TRAVELLER', 'BUS');

INSERT INTO MODEL_SPECIFICATIONS (MODEL_ID, ENGINE_CC, FUEL_TYPE, MILEAGE, POWER_HP, VEHICLE_TYPE) VALUES 
('CAR001', 2000, 'Petrol', 15, 150, 'SUV'), 
('CAR002', 1800, 'Diesel', 18, 140, 'SEDAN'), 
('CAR003', 1600, 'Petrol', 20, 130, 'CUV'), 
('CAR004', 1500, 'Diesel', 22, 120, 'HATCH_BACK'), 
('CAR005', 2500, 'Petrol', 12, 180, 'ROADSTER'), 
('CAR006', 2200, 'Diesel', 14, 170, 'PICKUP'), 
('CAR007', 3000, 'Petrol', 10, 250, 'SUPERCAR'), 
('CAR008', 2000, 'Petrol', 18, 160, 'COUPE'), 
('CAR009', 1800, 'Electric', 25, 200, 'CABRIOLET'), 
('CAR010', 2000, 'Petrol', 17, 170, 'SPORTS'), 
('CAR011', 0, 'Electric', 50, 300, 'TESLA'), 
('BIKE001', 150, 'Petrol', 40, 12, 'STANDARD'), 
('BIKE002', 200, 'Petrol', 35, 15, 'CRUISER'), 
('BIKE003', 250, 'Petrol', 30, 18, 'SPORTS_B'), 
('BIKE004', 125, 'Petrol', 50, 10, 'SCOOTER'), 
('BIKE005', 100, 'Electric', 60, 8, 'MOPED'), 
('BIKE006', 200, 'Petrol', 30, 20, 'ADVENTURE'), 
('BIKE007', 180, 'Petrol', 35, 14, 'NAKED'), 
('BIKE008', 0, 'Electric', 70, 15, 'ELECTRIC'), 
('BUS001', 6000, 'Diesel', 8, 300, 'BUS_A'), 
('BUS002', 8000, 'Diesel', 6, 400, 'BUS_B'), 
('BUS003', 5000, 'Diesel', 10, 250, 'BUS_C'), 
('BUS004', 4500, 'Diesel', 12, 200, 'TRAVELLER');

INSERT INTO GARAGE VALUES 
('GARAGE001', 'CAR001', 3), 
('GARAGE001', 'CAR002', 2), 
('GARAGE002', 'CAR003', 1), 
('GARAGE002', 'CAR004', 2), 
('GARAGE003', 'CAR005', 3), 
('GARAGE003', 'CAR006', 1), 
('GARAGE004', 'CAR007', 2), 
('GARAGE004', 'CAR008', 1), 
('GARAGE005', 'CAR009', 2), 
('GARAGE005', 'CAR010', 1), 
('GARAGE006', 'CAR011', 2), 
('GARAGE001', 'BIKE001', 1), 
('GARAGE002', 'BIKE002', 2), 
('GARAGE003', 'BIKE003', 1), 
('GARAGE004', 'BIKE004', 2), 
('GARAGE001', 'BUS001', 1), 
('GARAGE002', 'BUS002', 2), 
('GARAGE003', 'BUS003', 1), 
('GARAGE004', 'BUS004', 2); 

INSERT INTO VEHICLE_FARE VALUES 
('MH01AB1234', 'CAR001', 'GARAGE001', 'Red', 2000, 1500, 1000), 
('GJ05CD5678', 'CAR001', 'GARAGE001', 'Blue', 2000, 1500, 1000), 
('AP09EF9012', 'CAR001', 'GARAGE001', 'Black', 2000, 1500, 1000), 
('TS12GH3456', 'CAR002', 'GARAGE001', 'White', 1800, 1400, 900), 
('TN15IJ7890', 'CAR002', 'GARAGE001', 'Silver', 1800, 1400, 900), 
('TN20KL2345', 'CAR003', 'GARAGE002', 'Gray', 1600, 1300, 800), 
('AP25MN6789', 'CAR004', 'GARAGE002', 'Green', 1500, 1200, 700), 
('RJ30OP0123', 'CAR005', 'GARAGE003', 'Yellow', 1500, 1200, 700), 
('MP35QR4567', 'CAR005', 'GARAGE003', 'Brown', 2500, 1800, 1100), 
('PB40ST8901', 'CAR005', 'GARAGE003', 'Orange', 2200, 1700, 1000), 
('MH10BC1234', 'CAR006', 'GARAGE003', 'Red', 2000, 1500, 1000), 
('GJ05CD5677', 'CAR007', 'GARAGE004', 'Blue', 2000, 1500, 1000), 
('AP09EF9011', 'CAR007', 'GARAGE004', 'Black', 2000, 1500, 1000), 
('TS12GH3457', 'CAR008', 'GARAGE004', 'White', 1800, 1400, 900), 
('TN15IJ7801', 'CAR009', 'GARAGE005', 'Silver', 1800, 1400, 900), 
('TN20KL2344', 'CAR009', 'GARAGE005', 'Gray', 1600, 1300, 800), 
('AP35MN6789', 'CAR010', 'GARAGE005', 'Green', 1500, 1200, 700), 
('RJ40OP0123', 'CAR011', 'GARAGE006', 'Yellow', 1500, 1200, 700), 
('MP55QR4567', 'CAR011', 'GARAGE006', 'Brown', 2500, 1800, 1100), 
('MH50AB1001', 'BIKE001', 'GARAGE001', 'Red', 1500, 1000, 500), 
('GJ55CD2002', 'BIKE002', 'GARAGE002', 'Blue', 2000, 1500, 600), 
('KA60EF3003', 'BIKE002', 'GARAGE002', 'Green', 2000, 1500, 600), 
('AN65GH4004', 'BIKE003', 'GARAGE003', 'Yellow', 2500, 2000, 700), 
('UP70IJ5005', 'BIKE004', 'GARAGE004', 'White', 1250, 8000, 400), 
('TN75KL6006', 'BIKE004', 'GARAGE004', 'Black', 1250, 8000, 400), 
('AP80MN7007', 'BUS001', 'GARAGE001', 'Red', 5000, 3000, 200), 
('RJ85OP8008', 'BUS002', 'GARAGE002', 'Blue', 8000, 4000, 250), 
('MP90QR9009', 'BUS002', 'GARAGE002', 'Green', 8000, 4000, 2500), 
('PB95ST0010', 'BUS003', 'GARAGE003', 'Yellow', 5000, 2500, 1500), 
('HR00UV1011', 'BUS004', 'GARAGE004', 'White', 4500, 2000, 1500), 
('CG05WX2012', 'BUS004', 'GARAGE004', 'Black', 4500, 2000, 1500);

INSERT INTO AGENCY (AGENCY_ID, NAME, CITY, GARAGE_ID) VALUES 
('AGY001', 'City Rent-a-Car', 'Mumbai', 'GARAGE001'), 
('AGY002', 'Zoom Rentals', 'Delhi', 'GARAGE002'), 
('AGY003', 'Go Rentals', 'Bangalore', 'GARAGE003'), 
('AGY004', 'Speedy Cars', 'Chennai', 'GARAGE004'), 
('AGY005', 'Easy Drive', 'Hyderabad', 'GARAGE005'), 
('AGY006', 'Wheels on Wheels', 'Kolkata', 'GARAGE006');

INSERT INTO RENTAL VALUES 
('CUST1', 'RENTAL001', 2, '2024-04-01', '2024-04-05', 'LOC001', 'LOC002', '2024-04-06', 0, 'AGY001', 'GJ05CD5678') , 
('CUST1', 'RENTAL002', 1, '2024-04-10', '2024-04-15', 'LOC003', 'LOC004', '2024-04-16', 0, 'AGY002', 'TN20KL2345') , 
('CUST1', 'RENTAL003', 4, '2024-04-20', '2024-04-25', 'LOC005', 'LOC006', '2024-04-26', 0, 'AGY003', 'PB40ST8901') , 
('CUST1', 'RENTAL004', 3, '2024-05-01', '2024-05-05', 'LOC007', 'LOC008', '2024-05-06', 0, 'AGY004', 'AP09EF9011') , 
('CUST1', 'RENTAL005', 2, '2024-05-10', '2024-05-15', 'LOC009', 'LOC010', '2024-05-16', 0, 'AGY005',  'TN15IJ7801') , 
('CUST1', 'RENTAL006', 1, '2024-05-20', '2024-05-25', 'LOC011', 'LOC012', '2024-05-26', 0, 'AGY006', 'RJ40OP0123') , 
('CUST1', 'RENTAL007', 2, '2024-06-01', '2024-06-05', 'LOC013', 'LOC014', '2024-06-06', 0, 'AGY001', 'MH50AB1001') , 
('CUST2', 'RENTAL008', 1, '2024-06-10', '2024-06-15', 'LOC015', 'LOC016', '2024-06-16', 0, 'AGY002', 'AN65GH4004') , 
('CUST2', 'RENTAL010', 2, '2024-07-01', '2024-07-05', 'LOC019', 'LOC020', '2024-07-06', 0, 'AGY004', 'AP80MN7007') , 
('CUST2', 'RENTAL011', 1, '2024-07-10', '2024-07-15', 'LOC021', 'LOC022', '2024-07-16', 0, 'AGY005',  'TN15IJ7890') , 
('CUST2', 'RENTAL012', 4, '2024-07-20', '2024-07-25', 'LOC023', 'LOC024', '2024-07-26', 0, 'AGY006', 'AP25MN6789') , 
('CUST3', 'RENTAL013', 3, '2024-08-01', '2024-08-05', 'LOC025', 'LOC026', '2024-08-06', 0, 'AGY001', 'MH10BC1234') , 
('CUST3', 'RENTAL014', 2, '2024-08-10', '2024-08-15', 'LOC027', 'LOC028', '2024-08-16', 0, 'AGY002', 'TS12GH3457') , 
('CUST3', 'RENTAL015', 1, '2024-08-20', '2024-08-25', 'LOC029', 'LOC030', '2024-08-26', 0, 'AGY003', 'AP35MN6789') , 
('CUST3', 'RENTAL016', 2, '2024-09-01', '2024-09-05', 'LOC031', 'LOC032', '2024-09-06', 0, 'AGY004', 'GJ05CD5678') , 
('CUST4', 'RENTAL017', 1, '2024-09-10', '2024-09-15', 'LOC033', 'LOC034', '2024-09-16', 0, 'AGY005', 'GJ55CD2002') , 
('CUST4', 'RENTAL018', 4, '2024-09-20', '2024-09-25', 'LOC035', 'LOC036', '2024-09-26', 0, 'AGY006',  'UP70IJ5005') , 
('CUST4', 'RENTAL021', 1, '2024-10-20', '2024-10-25', 'LOC001', 'LOC004', '2024-10-26', 0, 'AGY003', 'RJ85OP8008') , 
('CUST4', 'RENTAL022', 2, '2024-11-01', '2024-11-05', 'LOC003', 'LOC004', '2024-11-06', 0, 'AGY004', 'PB95ST0010') , 
('CUST5', 'RENTAL023', 1, '2024-11-10', '2024-11-15', 'LOC005', 'LOC006', '2024-11-16', 0, 'AGY005', 'AP80MN7007') , 
('CUST5', 'RENTAL024', 4, '2024-11-20', '2024-11-25', 'LOC007', 'LOC008', '2024-11-26', 0, 'AGY006', 'HR00UV1011') , 
('CUST5', 'RENTAL025', 3, '2024-12-01', '2024-12-05', 'LOC009', 'LOC001', '2024-12-06', 0, 'AGY001', 'TS12GH3456') , 
('CUST6', 'RENTAL026', 2, '2024-12-10', '2024-12-15', 'LOC010', 'LOC012', '2024-12-16', 0, 'AGY002', 'AP25MN6789') , 
('CUST7', 'RENTAL027', 1, '2024-12-20', '2024-12-25', 'LOC040', 'LOC001', '2024-12-26', 0, 'AGY003', 'MH10BC1234') , 
('CUST7', 'RENTAL028', 2, '2025-01-01', '2025-01-05', 'LOC005', 'LOC036', '2025-01-06', 0, 'AGY004', 'TS12GH3457') , 
('CUST7', 'RENTAL029', 1, '2025-01-10', '2025-01-15', 'LOC007', 'LOC005', '2025-01-16', 0, 'AGY005', 'AP35MN6789') , 
('CUST7', 'RENTAL030', 4, '2025-01-20', '2025-01-25', 'LOC009', 'LOC006', '2025-01-26', 0, 'AGY006', 'AP09EF9012') , 
('CUST7', 'RENTAL031', 3, '2025-02-01', '2025-02-05', 'LOC001', 'LOC002', '2025-02-06', 0, 'AGY001', 'MH50AB1001') , 
('CUST7', 'RENTAL032', 2, '2025-02-10', '2025-02-15', 'LOC005', 'LOC015', '2025-02-16', 0, 'AGY002', 'AN65GH4004') , 
('CUST7', 'RENTAL034', 2, '2025-03-01', '2025-03-05', 'LOC007', 'LOC008', '2025-03-06', 0, 'AGY004', 'AP80MN7007') , 
('CUST8', 'RENTAL035', 1, '2025-03-10', '2025-03-15', 'LOC009', 'LOC010', '2025-03-16', 0, 'AGY005', 'TS12GH3456') , 
('CUST8', 'RENTAL036', 4, '2025-03-20', '2025-03-25', 'LOC011', 'LOC012', '2025-03-26', 0, 'AGY006', 'AP25MN6789') , 
('CUST9', 'RENTAL037', 3, '2025-04-01', '2025-04-05', 'LOC013', 'LOC014', '2025-04-06', 0, 'AGY001', 'MH10BC1234') , 
('CUST9', 'RENTAL038', 2, '2025-04-10', '2025-04-15', 'LOC015', 'LOC016', '2025-04-16', 0, 'AGY002', 'TS12GH3457');

INSERT INTO PAYMENT (TRANSACTION_ID, ADVANCE, AMOUNT, BOOK_DATE, CUSTOMER_ID, AGENCY_ID, RENTAL_ID) 
SELECT  
ROW_NUMBER() OVER (ORDER BY R.RENTAL_ID) AS TRANSACTION_ID, 
V.BASE_FARE AS ADVANCE, 
(V.BASE_FARE + (V.PERDAY_FARE * (DATEDIFF(R.END_DAY, R.START_DAY) + 1))) AS AMOUNT, 
CURRENT_DATE() AS BOOK_DATE, 
R.CUSTOMER_ID, 
  R.AGENCY_ID, 
    R.RENTAL_ID 
FROM  
    RENTAL R 
JOIN  
    VEHICLE_FARE V ON R.REGISTRATION_NO = V.REGISTRATION_NO;
    
INSERT INTO INSURANCE VALUES 
('POL001', 5000, 1500), -- Highest premium 
('POL002', 3000, 1200), -- Medium premium 
('POL003', 2000, 1000), -- Medium premium 
('POL004', 1000, 800),  -- Lowest premium 
('POL005', 2500, 1100); -- Medium premium

INSERT INTO COVERS (RENTAL_ID, POLICY_ID) VALUES 
('RENTAL001', 'POL001'), -- Assigned highest premium policy 
('RENTAL002', 'POL002'), -- Assigned medium premium policy 
('RENTAL003', 'POL003'), -- Assigned medium premium policy 
('RENTAL004', 'POL004'), -- Assigned lowest premium policy 
('RENTAL005', 'POL005'), -- Assigned medium premium policy 
('RENTAL006', 'POL001'), -- Assigned highest premium policy 
('RENTAL007', 'POL002'), -- Assigned medium premium policy 
('RENTAL008', 'POL003'), -- Assigned medium premium policy 
('RENTAL030', 'POL004'), -- Assigned lowest premium policy 
('RENTAL010', 'POL005'), -- Assigned medium premium policy 
('RENTAL011', 'POL001'), -- Assigned highest premium policy 
('RENTAL012', 'POL002'), -- Assigned medium premium policy 
('RENTAL013', 'POL003'), -- Assigned medium premium policy 
('RENTAL014', 'POL004'), -- Assigned lowest premium policy 
('RENTAL015', 'POL005'), -- Assigned medium premium policy 
('RENTAL016', 'POL001'), -- Assigned highest premium policy 
('RENTAL017', 'POL002'); -- Assigned medium premium policy

INSERT INTO REVIEWS (CUSTOMER_ID, AGENCY_ID, RATING_SCALE10, FEEDBACK) VALUES 
('CUST1', 'AGY001', 8, 'Great service overall'), 
('CUST2', 'AGY002', 7, 'Smooth experience, would rent again'), 
('CUST3', 'AGY003', 9, 'Excellent customer support'), 
('CUST4', 'AGY004', 6, 'Average experience, could be improved'), 
('CUST5', 'AGY005', 8, 'Good selection of vehicles'), 
('CUST6', 'AGY002', 9, 'Very satisfied with the rental process'), 
('CUST7', 'AGY001', 7, 'Decent service, but room for improvement'), 
('CUST8', 'AGY005', 8, 'Friendly staff, easy pickup and drop-off'), 
('CUST9', 'AGY001', 9, 'Highly recommended, will rent again');
