INSERT INTO User VALUES('yung_ga', '0806', '윤가영', '010-1234-5678', 'yun86@naver.com', 'Business');
INSERT INTO Store (UserID, StoreName, RegistrationNumber, OwnerName, DistrictID, StoreAddress, StoreNumber, OpenTime, CloseTime, ClosedDay, Category, ServiceType, PaymentMethods, MainImage) 
VALUES ('yung_ga', '집무실', '20000806', '윤가영', 16, '고산자로14길 26 1층', '02-877-7624', '00:00:00', '24:00:00', '연중무휴', 'Cafe', '와이파이, 주차', '카드', '11_jibmusil.jpg');
INSERT INTO Image (StoreID, ImageType, ImageURL)
VALUES(1, 'Interior', '11_jibmusil.jpg');

INSERT INTO User VALUES('seungmin', '1025', '김승민', '010-5678-1234', 'ming@gmail.com', 'Business');

INSERT INTO Store (UserID, StoreName, RegistrationNumber, OwnerName, DistrictID, StoreAddress, StoreNumber, OpenTime, CloseTime, ClosedDay, Category, ServiceType, PaymentMethods, MainImage) 
VALUES ('seungmin', '본지르르 성수', '20021025', '김승민', 16, '광나루로4가길 13 B1, 1, 2층', '0507-1327-8615', '11:00:00', '23:00:00', '연중무휴', '카페', '포장, 와이파이', '카드, 현금, 네이버페이', '15_bzrr.jpg');
INSERT INTO Image (StoreID, ImageType, ImageURL)
VALUES(3, 'Interior', '15_bzrr.jpg');

DELETE FROM Image 
WHERE ImageID = 33;

DELETE FROM Store 
WHERE StoreAddress = "고려";


INSERT INTO Image (StoreID, ImageType, ImageURL)
VALUES(4, 'Food', '4_KakaoTalk_20240606_233001896.jpg');

UPDATE Store
SET Category = 'Cafe'
WHERE StoreID = 3;
