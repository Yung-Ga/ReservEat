DROP DATABASE IF EXISTS StoreCustomerDB;

CREATE DATABASE StoreCustomerDB;

USE StoreCustomerDB;

show tables;
DESCRIBE Store;
SHOW CREATE TABLE Store;
SHOW GRANTS FOR CURRENT_USER;
SELECT DATABASE();



DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Image;
DROP TABLE IF EXISTS Seat;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS District;

SELECT * FROM User;
SELECT * FROM Store;
SELECT * FROM Image;
SELECT * FROM Reservation;

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
    Password VARCHAR(255) NOT NULL,               -- 해시된 비밀번호
    UserName VARCHAR(50) NOT NULL,                -- 사용자 이름
    PhoneNumber VARCHAR(20) NOT NULL,             -- 전화번호
    Email VARCHAR(100) NOT NULL,                  -- 이메일
    Gender CHAR(1),                               -- 성별 (M: 남성, F: 여성)
    BirthYY INT,                                  -- 생년 (연도)
    BirthMM INT,                                  -- 생월 (월)
    BirthDD INT,                                  -- 생일 (일)
    Address VARCHAR(255)                          -- 주소
);

-- Store 테이블 생성 (가게 정보 저장)
CREATE TABLE Store (
    StoreID INT AUTO_INCREMENT PRIMARY KEY,      -- 가게 ID
    RegistrationNumber VARCHAR(50) NOT NULL,     -- 사업자 등록번호 (사업자 아이디)
    Password VARCHAR(255) NOT NULL,              -- 해시된 비밀번호
    PhoneNumber VARCHAR(20) NOT NULL,            -- 전화번호
    OwnerName VARCHAR(50) NOT NULL,              -- 대표자 이름
    StoreName VARCHAR(100) NOT NULL,             -- 가게 이름
    DistrictID INT,                              -- 구/군 ID (외래키)
    StoreAddress VARCHAR(255) NOT NULL,          -- 도로명 주소
    StoreNumber VARCHAR(20),                     -- 가게 전화번호
    OpenTime TIME NOT NULL,                      -- 오픈 시간
    CloseTime TIME NOT NULL,                     -- 클로즈 시간
    ClosedDay VARCHAR(50),                       -- 휴일
    Category VARCHAR(50) NOT NULL,               -- 가게 카테고리 (예: 한식, 일식, 중식 등)
    ServiceType VARCHAR(100),                    -- 서비스 유형 (예: 배달, 포장, 주차 등)
    PaymentMethods VARCHAR(100),                 -- 결제 방법
    MainImage VARCHAR(255),                      -- 메인 사진
    FOREIGN KEY (DistrictID) REFERENCES District(DistrictID) ON DELETE CASCADE ON UPDATE CASCADE -- District 테이블의 DistrictID를 참조하는 외래키
);

-- Image 테이블 생성 (가게 이미지 정보 저장)
CREATE TABLE Image (
    ImageID INT AUTO_INCREMENT PRIMARY KEY,      -- 이미지 ID
    StoreID INT,                                 -- 가게 ID (외래키)
    ImageType VARCHAR(50) NOT NULL,              -- 이미지 유형 (예: 음식, 내부, 외부 등)
    ImageURL VARCHAR(255) NOT NULL,              -- 이미지 경로(URL)
    INDEX (StoreID),                             -- 인덱스 추가
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID) ON DELETE CASCADE ON UPDATE CASCADE  -- Store 테이블의 StoreID를 참조하는 외래키
);

-- Menu 테이블 생성 (가게 메뉴 정보 저장)
CREATE TABLE Menu (
    MenuID INT AUTO_INCREMENT PRIMARY KEY,       -- 메뉴 ID
    StoreID INT,                                 -- 가게 ID (외래키)
    ImageID INT,                                 -- 이미지 ID (외래키)
    ItemName VARCHAR(100) NOT NULL,              -- 메뉴 아이템 이름
    Price INT NOT NULL,                          -- 메뉴 아이템 가격
    INDEX (StoreID),                             -- 인덱스 추가
    INDEX (ImageID),                             -- 인덱스 추가
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID) ON DELETE CASCADE ON UPDATE CASCADE,  -- Store 테이블의 StoreID를 참조하는 외래키
    FOREIGN KEY (ImageID) REFERENCES Image(ImageID) ON DELETE SET NULL ON UPDATE CASCADE  -- Image 테이블의 ImageID를 참조하는 외래키
);

-- Review 테이블 생성 (가게 리뷰 정보 저장)
CREATE TABLE Review (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,     -- 리뷰 ID
    StoreID INT,                                 -- 가게 ID (외래키)
    UserID VARCHAR(50),                          -- 사용자 ID (외래키)
    ImageID INT,                                 -- 이미지 ID (외래키)
    Comment TEXT NOT NULL,                       -- 리뷰 내용
    ReviewDate DATE NOT NULL,                    -- 리뷰 작성일
    INDEX (StoreID),                             -- 인덱스 추가
    INDEX (UserID),                              -- 인덱스 추가
    INDEX (ImageID),                             -- 인덱스 추가
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID) ON DELETE CASCADE ON UPDATE CASCADE,  -- Store 테이블의 StoreID를 참조하는 외래키
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,     -- User 테이블의 UserID를 참조하는 외래키
    FOREIGN KEY (ImageID) REFERENCES Image(ImageID) ON DELETE SET NULL ON UPDATE CASCADE  -- Image 테이블의 ImageID를 참조하는 외래키
);
SHOW TRIGGERS;
SELECT * FROM Reservation;
DROP TABLE IF EXISTS Reservation;
-- Reservation 테이블 생성 (예약 정보 저장)
CREATE TABLE Reservation (
    ReservationID INT AUTO_INCREMENT PRIMARY KEY,  -- 예약 ID
    StoreID INT NOT NULL,                          -- 가게 ID (외래키)
    UserID VARCHAR(50),                            -- 사용자 ID (외래키)
    ReservationDate DATE NOT NULL,                 -- 예약 날짜
    ReservationTime TIME NOT NULL,                 -- 예약 시간
    NumberOfPeople INT NOT NULL,                   -- 예약 인원
    ReservationStatus ENUM('Pending', 'Confirmed' ,'Completion') NOT NULL DEFAULT 'Pending', -- 예약 상태
    INDEX (StoreID),                               -- 인덱스 추가
    INDEX (UserID),                                -- 인덱스 추가
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,    -- User 테이블의 UserID를 참조하는 외래키
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID) ON DELETE CASCADE ON UPDATE CASCADE, -- Store 테이블의 StoreID를 참조하는 외래키
    UNIQUE (StoreID, ReservationDate, ReservationTime)  -- 유니크 제약 조건
);
