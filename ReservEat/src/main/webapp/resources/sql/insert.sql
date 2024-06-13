-- 고객 정보 삽입
INSERT INTO User (UserID, Password, UserName, PhoneNumber, Email, Gender, BirthYY, BirthMM, BirthDD, Address) 
VALUES ('yung_ga', '0806', '윤가영', '123-456-7890', 'yun86@naver.com', 'F', 2000, 08, 06, '서울특별시 중구');
INSERT INTO User (UserID, Password, UserName, PhoneNumber, Email, Gender, BirthYY, BirthMM, BirthDD, Address) 
VALUES ('seungmin', '1025', '김승민', '010-5678-1234', 'ming@gmail.com', 'F', 2002, 10, 25, '서울특별시 성동구');

-- 가게 정보 삽입(1)
INSERT INTO Store (RegistrationNumber, Password, PhoneNumber, OwnerName, StoreName, DistrictID, StoreAddress, StoreNumber, OpenTime, CloseTime, ClosedDay, Category, ServiceType, PaymentMethods, MainImage)
VALUES (20000806, '1234', '010-1234-5678', '윤가영', '집무실', 16, '고산자로14길 26 1층', '02-877-7624', '00:00:00', '24:00:00', '연중무휴', 'Cafe', '와이파이, 주차', '카드', '집무실.jpg');
-- 이미지 삽입
INSERT INTO Image (StoreID, ImageType, ImageURL)
VALUES(1, 'Interior', '집무실.jpg');

INSERT INTO Reservation (StoreID, UserID, ReservationDate, ReservationTime, NumberOfPeople, ReservationStatus)
VALUES (2, 'dus1655', '2024-06-15', '03:20:00', 4, 'Completion');
INSERT INTO Reservation (StoreID, UserID, ReservationDate, ReservationTime, NumberOfPeople, ReservationStatus)
VALUES (1, 'dus1655', '2024-06-15', '03:20:00', 4, 'Confirmed');


INSERT INTO Reservation (StoreID, UserID, ReservationDate, ReservationTime, NumberOfPeople, ReservationStatus)
VALUES (3, NULL, '2024-06-11', '13:00:00', 4, 'Pending');



-- 가게 정보 삽입(2)
INSERT INTO Store (RegistrationNumber, Password, PhoneNumber, OwnerName, StoreName, DistrictID, StoreAddress, StoreNumber, OpenTime, CloseTime, ClosedDay, Category, ServiceType, PaymentMethods, MainImage)
VALUES (20021025, '1234', '010-0000-5678', '김승민', '본지르르성수', 16, '광나루로4가길 13 B1, 1, 2층', '0507-1327-8615', '11:00:00', '23:00:00', '연중무휴', 'Cafe', '포장, 와이파이', '카드, 현금, 네이버페이', '본지르르성수.jpg');
-- 이미지 삽입
INSERT INTO Image (StoreID, ImageType, ImageURL)
VALUES(2, 'Interior', '본지르르성수.jpg');





DELETE FROM Image 
WHERE ImageID = 33;

DELETE FROM Reservation 
WHERE StoreID = 6;


UPDATE Store
SET Category = 'Cafe'
WHERE StoreID = 3;
