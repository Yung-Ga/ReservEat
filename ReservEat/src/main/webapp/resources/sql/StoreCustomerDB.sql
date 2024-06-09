DROP DATABASE IF EXISTS StoreCustomerDB;

CREATE DATABASE StoreCustomerDB;

USE StoreCustomerDB;

show tables;
DESCRIBE Store;
SHOW CREATE TABLE Store;
SHOW GRANTS FOR CURRENT_USER;
SELECT DATABASE();



DROP TABLE IF EXISTS CustomerReservation;
DROP TABLE IF EXISTS StoreReservation;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Image;
DROP TABLE IF EXISTS Seat;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS District;

SELECT * FROM User;
SELECT * FROM Image;
SELECT * FROM Store;

-- District 테이블 생성 (구/군 정보 저장)
CREATE TABLE District (
    DistrictID INT AUTO_INCREMENT PRIMARY KEY,  -- 구/군 ID
    DistrictName VARCHAR(100) NOT NULL UNIQUE   -- 구/군 이름
);

-- District 테이블에 데이터 삽입
INSERT INTO District (DistrictName) VALUES 
('강남구'), ('강동구'), ('강북구'), ('강서구'), ('관악구'), ('광진구'), ('구로구'), ('금천구'),
('노원구'), ('도봉구'), ('동대문구'), ('동작구'), ('마포구'), ('서대문구'), ('서초구'), ('성동구'),
('성북구'), ('송파구'), ('양천구'), ('영등포구'), ('용산구'), ('은평구'), ('종로구'), ('중구'),
('중랑구');

-- User 테이블 생성 (사용자 정보 저장)
CREATE TABLE User (
    UserID VARCHAR(50) PRIMARY KEY,               -- 사용자 ID
    Password VARCHAR(100) NOT NULL,               -- 비밀번호
    UserName VARCHAR(50) NOT NULL,                -- 사용자 이름
    PhoneNumber VARCHAR(20),                      -- 전화번호
    Email VARCHAR(100),                           -- 이메일
    UserType ENUM('Customer', 'Business') NOT NULL-- 사용자 유형 (예: 고객, 사업자)
);

-- Store 테이블 생성 (가게 정보 저장)
CREATE TABLE Store (
    StoreID INT AUTO_INCREMENT PRIMARY KEY,      -- 가게 ID
    UserID VARCHAR(50),                          -- 사용자 ID
    StoreName VARCHAR(100) NOT NULL,             -- 가게 이름
    RegistrationNumber VARCHAR(50) NOT NULL,     -- 사업자 등록번호
    OwnerName VARCHAR(50) NOT NULL,              -- 대표자 이름
    DistrictID INT,                              -- 구/군 ID (외래키)
    StoreAddress VARCHAR(255) NOT NULL,          -- 도로명 주소
    StoreNumber VARCHAR(20),                     -- 가게 전화번호
    OpenTime TIME NOT NULL,                      -- 오픈 시간
    CloseTime TIME NOT NULL,                     -- 클로즈 시간
    ClosedDay VARCHAR(50),                       -- 휴일
    Category VARCHAR(50) NOT NULL,               -- 가게 카테고리 (예: 한식, 일식, 중식 등)
    ServiceType VARCHAR(100),                     -- 서비스 유형 (예: 배달, 포장, 주차 등)
    PaymentMethods VARCHAR(100),                 -- 결제 방법
    MainImage VARCHAR(255),                      -- 메인 사진
    FOREIGN KEY (DistrictID) REFERENCES District(DistrictID), -- District 테이블의 DistrictID를 참조하는 외래키
    FOREIGN KEY (UserID) REFERENCES User(UserID) -- User 테이블의 UserID를 참조하는 외래키
);

-- Image 테이블 생성 (가게 이미지 정보 저장)
CREATE TABLE Image (
    ImageID INT AUTO_INCREMENT PRIMARY KEY,      -- 이미지 ID
    StoreID INT,                                 -- 가게 ID (외래키)
    ImageType VARCHAR(50) NOT NULL,              -- 이미지 유형 (예: 음식, 내부, 외부 등)
    ImageURL VARCHAR(255) NOT NULL,              -- 이미지 경로(URL)
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)  -- Store 테이블의 StoreID를 참조하는 외래키
);

-- Menu 테이블 생성 (가게 메뉴 정보 저장)
CREATE TABLE Menu (
    MenuID INT AUTO_INCREMENT PRIMARY KEY,       -- 메뉴 ID
    StoreID INT,                                 -- 가게 ID (외래키)
    ImageID INT,								 -- 이미지 ID (외래키)
    ItemName VARCHAR(100) NOT NULL,              -- 메뉴 아이템 이름
    Price INT NOT NULL,                          -- 메뉴 아이템 가격
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID),  -- Store 테이블의 StoreID를 참조하는 외래키
    FOREIGN KEY (ImageID) REFERENCES Image(ImageID)	  -- Image 테이블의 ImageID를 참조하는 외래키
);

-- Review 테이블 생성 (가게 리뷰 정보 저장)
CREATE TABLE Review (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,     -- 리뷰 ID
    StoreID INT,                                 -- 가게 ID (외래키)
    UserID VARCHAR(50),                          -- 사용자 ID (외래키)
    ImageID INT,								 -- 이미지 ID (외래키)
    Comment TEXT NOT NULL,                       -- 리뷰 내용
    ReviewDate DATE NOT NULL,                    -- 리뷰 작성일
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID),  -- Store 테이블의 StoreID를 참조하는 외래키
    FOREIGN KEY (UserID) REFERENCES User(UserID),     -- User 테이블의 UserID를 참조하는 외래키
    FOREIGN KEY (ImageID) REFERENCES Image(ImageID)	  -- Image 테이블의 ImageID를 참조하는 외래키
);

-- Seat 테이블 생성 (가게 좌석 정보 저장)
CREATE TABLE Seat (
    SeatID INT AUTO_INCREMENT PRIMARY KEY,       -- 좌석 ID
    StoreID INT,                                 -- 가게 ID (외래키)
    SeatType VARCHAR(50),                        -- 좌석 유형 (예: 테이블, 바, 외부 좌석 등)
    Capacity INT NOT NULL,                       -- 좌석 수용 인원
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)  -- Store 테이블의 StoreID를 참조하는 외래키
);

-- StoreReservation 테이블 생성 (가게 예약 정보 저장)
CREATE TABLE StoreReservation (
    ReservationID INT AUTO_INCREMENT PRIMARY KEY,  -- 예약 ID
    StoreID INT,                                   -- 가게 ID (외래키)
    ReservationStatus VARCHAR(50) NOT NULL,        -- 예약 상태
    AvailableTimes TIME,                           -- 예약 가능 시간
    RestrictionDetails TEXT,                       -- 예약 제한 사항
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)  -- Store 테이블의 StoreID를 참조하는 외래키
);

-- CustomerReservation 테이블 생성 (고객 예약 정보 저장)
CREATE TABLE CustomerReservation (
    ReservationID INT AUTO_INCREMENT PRIMARY KEY,  -- 예약 ID
    UserID VARCHAR(50),                            -- 사용자 ID (외래키)
    StoreID INT,                                   -- 가게 ID (외래키)
    ReservationDate DATE NOT NULL,                 -- 예약 날짜
    ReservationTime TIME NOT NULL,                 -- 예약 시간
    NumberOfPeople INT NOT NULL,                   -- 예약 인원
    Status VARCHAR(50) NOT NULL,                   -- 예약 상태
    FOREIGN KEY (UserID) REFERENCES User(UserID),    -- User 테이블의 UserID를 참조하는 외래키
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)  -- Store 테이블의 StoreID를 참조하는 외래키
);