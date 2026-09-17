/*
  CINEHIVE — FULL DATABASE REBUILD SCRIPT
  Oracle Database 19c
  Based on the supplied CINEHIVE-4.sql dump (17/09/2026).

  Includes all current table definitions, all INSERT data, keys,
  unique constraints, checks, and foreign keys from the source dump.

  The original Navicat hidden ISEQ$$_ sequences have been replaced with
  normal CINEHIVE-owned sequences. Their START WITH values are set to
  one greater than the highest imported ID, so future inserts can safely
  continue after the imported data.

  WARNING: THIS SCRIPT REBUILDS THE DATABASE. It drops existing tables
  and data in the CINEHIVE schema. Do not run it on a database you need
  to preserve.
*/

SET DEFINE OFF;

-- ============================================================
-- 1. DROP EXISTING TABLES
-- ============================================================
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."ACTOR" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."ACTS_IN" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."APP_USER" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."BOOKING" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."BOOKING_SEAT" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."CINEMA" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."DIRECTOR" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."DIRECTS" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."GENRE" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."MOVIE" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."MOVIE_GENRE" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."PRODUCES" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."PRODUCTION_COMPANY" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."RATING" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."REVIEW" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."SCREEN" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."SEAT" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."SHOWTIME" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE "CINEHIVE"."WATCHLIST" CASCADE CONSTRAINTS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
-- ============================================================
-- 2. CREATE ID SEQUENCES
-- ============================================================
BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_ACTOR"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_ACTOR"
  START WITH 1034
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_APP_USER"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_APP_USER"
  START WITH 71
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_BOOKING"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_BOOKING"
  START WITH 82
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_CINEMA"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_CINEMA"
  START WITH 4
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_DIRECTOR"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_DIRECTOR"
  START WITH 211
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_GENRE"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_GENRE"
  START WITH 9
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_MOVIE"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_MOVIE"
  START WITH 262
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_PRODUCTION_COMPANY"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_PRODUCTION_COMPANY"
  START WITH 6
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_REVIEW"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_REVIEW"
  START WITH 49
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_SCREEN"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_SCREEN"
  START WITH 6
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_SEAT"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_SEAT"
  START WITH 2301
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE "CINEHIVE"."SEQ_SHOWTIME"';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE "CINEHIVE"."SEQ_SHOWTIME"
  START WITH 535
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  CACHE 20
  NOCYCLE;

-- ============================================================
-- 3. TABLES + ALL DATA + CONSTRAINTS
-- ============================================================
-- Table structure for ACTOR
-- ----------------------------
CREATE TABLE "CINEHIVE"."ACTOR" (
  "ACTOR_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_ACTOR".nextval NOT NULL,
  "ACTOR_NAME" VARCHAR2(150 BYTE) VISIBLE NOT NULL,
  "DATE_OF_BIRTH" DATE VISIBLE,
  "NATIONALITY" VARCHAR2(80 BYTE) VISIBLE,
  "PHOTO_URL" VARCHAR2(500 BYTE) VISIBLE,
  "BIOGRAPHY" VARCHAR2(2000 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of ACTOR
-- ----------------------------
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1', 'Leonardo DiCaprio', TO_DATE('1974-11-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/wo2hJpn04vbtmh0B9utCFdsQhxM.jpg', 'American actor known for dramatic and critically acclaimed film performances.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('2', 'Tom Hanks', TO_DATE('1956-07-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/oFvZoKI6lvU03n4YoNGAll9rkas.jpg', 'American actor known for versatile performances in drama and comedy.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('3', 'Margot Robbie', TO_DATE('1990-07-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Australian', 'https://image.tmdb.org/t/p/w500/8LqG2N6j98lFGMpuYsRUAhOunSd.jpg', 'Australian actress and producer known for major international film roles.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('4', 'Ryan Gosling', TO_DATE('1980-11-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Canadian', 'https://image.tmdb.org/t/p/w500/lyUyVARQKhGxaxy0FbPJCQRpiaW.jpg', 'Canadian actor known for performances across drama, comedy, and musical films.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('5', 'Anne Hathaway', TO_DATE('1982-11-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/nbccV2pMoyLTCeg5DQip24Eq0Jp.jpg', 'American actress known for performances in drama, comedy, and musical films.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('6', 'Christian Bale', TO_DATE('1974-01-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'British', 'https://image.tmdb.org/t/p/w500/7Pxez9J8fuPd2Mn9kex13YALrCQ.jpg', 'British actor recognized for transformative performances in a wide range of films.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('7', 'Robert Downey Jr.', TO_DATE('1965-04-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg', 'American actor known for major roles in action and superhero films.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('8', 'Chris Evans', TO_DATE('1981-06-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/3bOGNsHlrswhyW79uvIHH1V43JI.jpg', 'American actor known for action and superhero film performances.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('9', 'Emma Stone', TO_DATE('1988-11-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/t7EYLBMWQiIDtCoOYZjvqXV84S5.jpg', 'American actress known for performances in comedy, drama, and musical films.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('10', 'Ryan Reynolds', TO_DATE('1976-10-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Canadian', 'https://image.tmdb.org/t/p/w500/trzgptffGvAlAT6MEu01fz47cLW.jpg', 'Canadian actor known for comedy, action, and superhero films.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('170', 'Naomi Watts', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7ysvff7ZhW388SIh2YjQ0XIryOn.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('171', 'Jack Black', NULL, NULL, 'https://image.tmdb.org/t/p/w500/59IhgCtiWI5yTfzPhsjzg7GjCjm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('172', 'Colin Hanks', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iljyDSiJRcwJL8QXQZ2WTyU1wh5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('173', 'Helena Bonham Carter', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hJMbNSPJ2PCahsP3rNEU39C8GWU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('174', 'Meat Loaf', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1zkohpaG3my4qQAZGVgzgPuXwZ6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('175', 'Jared Leto', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ca3x0OfIKbJppZh8S1Alx3GfUZO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('176', 'Josh Hartnett', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5eMo8D7h1XrSu6ZN4UXhPcS6YNG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('177', 'James Woods', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tLH7mpH4KqkWL5VgjueTbewGsfK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('178', 'Kathleen Turner', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hvmMGjWKy1CGmaJzPtOtbb3fD57.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('179', 'Michael Paré', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jxrXW8OL6hwJgtJgePdMO5yHuAM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('180', 'Rinko Kikuchi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lv4UuorZtC37VaFAHO205u4lS73.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('181', 'Adriana Barraza', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kfww4YbO9J2HpCldEqyyhQugwy5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('182', 'Satoshi Nikaido', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9fmVRDkkMwHxItNzBJQungwj5Ow.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('183', 'Russell Crowe', NULL, NULL, 'https://image.tmdb.org/t/p/w500/uxiXuVH4vNWrKlJMVVPG1sxAJFe.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('184', 'Connie Nielsen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gSQ3O3PJ6ly6nT63joOtfZyscFP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('185', 'Oliver Reed', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dWfotc1X71wNCGyPO9hXpv8U9Gw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('186', 'Richard Harris', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lCvcVMuxrg1f5A8OMqY9AqkkcZR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('187', 'George Clooney', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dt0a7DT0SQeHb7NpURD6ifyEzsN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('188', 'Eric Chase Anderson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5sFl3q2AhgOQz2L4cwWr2fwbSj1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('189', 'Wallace Wolodarsky', NULL, NULL, 'https://image.tmdb.org/t/p/w500/a6npTg5wUQIHkyH17m5FPc9hJPV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('190', 'Noriko Hidaka', NULL, NULL, 'https://image.tmdb.org/t/p/w500/43OuwsjqGf7JxpFpUvB75OdDDXQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('191', 'Chika Sakamoto', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lIIwnLmcgGpifpRflBq0kLW9EpK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('192', 'Hitoshi Takagi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lQWkgAGIdJ3Q93xI95ke6LZfzHW.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('193', 'Shigesato Itoi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2V17CMIcxb6JEHT5Qp3FKdlHUoE.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('194', 'Sumi Shimamoto', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iKIDv2VFpAgzJ0uMQi7pzcMHB9i.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('195', 'Jodie Comer', NULL, NULL, 'https://image.tmdb.org/t/p/w500/AfsBpnfw0E2h8NZK4zkFcOjYlEb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('196', 'Lil Rel Howery', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9MDi35Fy6ym7SYbO3B04vf1vBnm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('197', 'Joe Keery', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ayIAVLMfZGEGIFwAo3pPnY7p59.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('198', 'Utkarsh Ambudkar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vUW5bFrkjWikNFzh5B6F11r5C3X.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('199', 'Algee Smith', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8lSjFECJflwHJJGt5e7CqyItXW2.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('200', 'Hannah Murray', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kbD8Plq6EC8K9d6hsPb2DcS56gv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('201', 'Mia Wasikowska', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xOYlAZsLwFZ0gNHLnt1Hzuo2yqN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('202', 'Charlie Hunnam', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5WIDrnY25Ps2RYu0zIzHSVuSt5n.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('203', 'Jim Beaver', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mvawGDw5ge5rxgMKhTSggasOyin.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('204', 'Harvey Keitel', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7P30hza1neYWW3r7rSQOC736K2Z.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('205', 'Tim Roth', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qSizF2i9gz6c6DbAC5RoIq8sVqX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('206', 'Michael Madsen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fvr2EXEPrVwsF2JlfRp0Olbj4g8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('207', 'Chris Penn', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rePKftsRntg7gO8vPzDDAOddXmC.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('208', 'Steve Buscemi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/n0pZumkrcZrAPMoPq684RhYnjPV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('209', 'Robert De Niro', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cT8htcckIuyI1Lqwt1CvD02ynTh.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('210', 'Ray Liotta', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jdwGJbJNSRQiG2kB5MJxiu2clCQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('211', 'Joe Pesci', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pEHQoL8yOndOq59iXlgsOpUTcTk.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('212', 'Lorraine Bracco', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tAtpCzN4sTOy1RHpMpJj52zTO4S.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('213', 'Paul Sorvino', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1gF0UskusEdDcNaBDJ2CMsz5Agi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('214', 'Rachel Weisz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9tfHL5tholha1YF6bSKt422ETPM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('215', 'Susan Sarandon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jR6l2EfvvGA8qCzZ7MB5FT9ZLkq.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('216', 'Stanley Tucci', NULL, NULL, 'https://image.tmdb.org/t/p/w500/q4TanMDI5Rgsvw4SfyNbPBh4URr.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('217', 'Taraji P. Henson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jUU2X9mDwJaAniEmJOfvImBS9qb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('218', 'Julia Ormond', NULL, NULL, 'https://image.tmdb.org/t/p/w500/u7Oz6nHfMSlXuT34K7Ffp4f2qgP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('219', 'Jason Flemyng', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nYl0180ACnLzVlGbaAfuPtdGr9K.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('220', 'Stephen Dorff', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bhlM1xNzBvc8jTw42YloUKlGTCL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('221', 'Elle Fanning', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ucC5faqfEYVhoC25M6Hi3znZmab.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('222', 'Chris Pontius', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fNthW6ozHId6veZmZO6dC1ofZhI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('223', 'Laura Chiatti', NULL, NULL, 'https://image.tmdb.org/t/p/w500/83WW4ZPkkEsCWEuug9viUUZ2wHQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('224', 'Lala Sloatman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6YgmotO8F1oJYdFlAdKDEBpWobX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('225', 'Harrison Ford', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pjBMJVPpcZK23Vt1nzr1zEBTWrP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('226', 'Dave Bautista', NULL, NULL, 'https://image.tmdb.org/t/p/w500/snk6JiXOOoRjPtHU5VMoy6qbd32.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('227', 'Robin Wright', NULL, NULL, 'https://image.tmdb.org/t/p/w500/d3rIv0y2p0jMsQ7ViR7O1606NZa.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('228', 'Jared Gilman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/13KfThcvowIgbLpOfp0ihoUWRe.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('229', 'Kara Hayward', NULL, NULL, 'https://image.tmdb.org/t/p/w500/p25g942Abuq1c9YPJbE3VeFXbue.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('230', 'Chieko Baisho', NULL, NULL, 'https://image.tmdb.org/t/p/w500/u4mVoOgrqGutrPGi7ZHV1zRAtLK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('312', 'Richard Attenborough', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mJGvNS69xUqiNRybKzPl2Zuxe9Z.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('313', 'Bob Peck', NULL, NULL, 'https://image.tmdb.org/t/p/w500/66wkMHY76swadwfHLcTEKEKhUbv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('314', 'Arnold Schwarzenegger', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dgCABuZp2HBehCT84O4WBp7KIoe.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('315', 'Linda Hamilton', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7FNn9Z5xkRS9EFbGL2tpmpph9xV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('316', 'Edward Furlong', NULL, NULL, 'https://image.tmdb.org/t/p/w500/e221dMIBgb6Lk092GIkHB9ohQF1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('317', 'Robert Patrick', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qRv2Es9rZoloullTbzss3I5j1Mp.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('318', 'Earl Boen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nRAlyqkAA84gCTDwjFR77avdfHK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('319', 'Michael J. Fox', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2JB4FMgQmnhbBlQ4SxWFN9EIVDi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('320', 'Christopher Lloyd', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nxVjpyb3UrfbPZnEyDNlQVlFAs5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('321', 'Crispin Glover', NULL, NULL, 'https://image.tmdb.org/t/p/w500/imBnLpSXvg61qDDdEfvL6R4ITKt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('322', 'Lea Thompson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/n7qTKpbAbr2P1RlcW1Lq1NhckQ2.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('323', 'Claudia Wells', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2VOsPvoV2vmEUd1O2KjW3kcN8JD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('324', 'Tom Skerritt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/oWFCyBLm1lsbsbT5Nmx3SPMaqFZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('325', 'Sigourney Weaver', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wTSnfktNBLd6kwQxgvkqYw6vEon.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('326', 'Veronica Cartwright', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fRa2mQ3iQz2m3zaFAiHoNRlVtFb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('327', 'Harry Dean Stanton', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9zOTpVMwMHNjPFBNoPy9vOBT1NC.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('328', 'John Hurt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bjNSzt1d7uK3q5PbtFXUJrRt4qg.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('329', 'Carrie Henn', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iNaYp4liKvKsEZp5g5xjd94OFCz.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('330', 'Michael Biehn', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9oFLsADWQm2TvU8XzLIzBbjdMkU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('331', 'Paul Reiser', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rGryzG00uSk8LsidacSBXVgo3iv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('332', 'Lance Henriksen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1PkFmD5HdjmRa2DumtwINnnAjTH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('333', 'Alan Rickman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7tADZs4ILE93oJ5pAh6mKQFEq2m.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('334', 'Alexander Godunov', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ubA1t1Rj3dpDZkgli5D17Py0OPh.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('335', 'Bonnie Bedelia', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2dCd7HGOfmn4x7v97EcNIwy12io.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('336', 'Reginald VelJohnson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/r0F5y1PAQEDM08MBj3oI1IIX4gi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('337', 'Charlize Theron', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gd7ShD0yt4bsR2STeQ19KQ6hvXL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('338', 'Nicholas Hoult', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pXm8GWTm9eIA8pUGOjvmYjlxamu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('339', 'Hugh Keays-Byrne', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7XSPjKNwmyEPMnmoVSQ42ykMz6M.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('340', 'Josh Helman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1thwLjrgvFv7ifjyVtTKQh23OCh.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('341', 'Terrence Howard', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wXWt2NSY23v7DHe2yZQ1C8TikBp.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('342', 'Jeff Bridges', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xms1RAY6q7Lzp7wNeRCB0kzhucn.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('343', 'Leslie Bibb', NULL, NULL, 'https://image.tmdb.org/t/p/w500/g3a1O9lOTZvrwQupUtg4Fc3CdTd.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('344', 'Shameik Moore', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ovUKfVOwJ7CadEHaG3NDsfA5xRq.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('345', 'Jake Johnson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3UNfW2qZgRkW81neNVfQvaRC92K.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('346', 'Hailee Steinfeld', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qDInsG0cxWNxS1X4t59TBZ5S6x5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('347', 'Mahershala Ali', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9ZmSejm5lnUVY5IJ1iNx2QEjnHb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('348', 'Brian Tyree Henry', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2MsJh0bpyzwvOUnXOltHp3j85Pb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('349', 'Anthony Gonzalez', NULL, NULL, 'https://image.tmdb.org/t/p/w500/WF7bn6t0LkxwBWyDMWvomVujn7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('350', 'Gael García Bernal', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7uEO29wtdyY9bjt2JN43gVpE6vt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('351', 'Benjamin Bratt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hBenHPT4iJEG2kt5z2TOGnkRZwh.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('352', 'Alanna Ubach', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ffyBAEoW3bDgVJQV3GaHsZ9x29W.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('353', 'Renée Victor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wAVDqwFhQsRQgO6VIYq6T9Wbbx8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('354', 'Tim Allen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/woWhZzFILVhYMAvsPL171HjMY0y.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('355', 'Don Rickles', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iGMOVxIQoTPepRvqSCtRulfpx7u.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('356', 'Jim Varney', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zvBFmvKUrPvE6FW35O3RP4i1ZPp.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('357', 'Wallace Shawn', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wVaM1WlFKDce4esThwL4XtNLhOe.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('358', 'Joan Cusack', NULL, NULL, 'https://image.tmdb.org/t/p/w500/59UIeHZFYrKyP20lXqijtfTXglO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('359', 'Albert Brooks', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8iDSGu5l93N7benjf6b3AysBore.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('360', 'Ellen DeGeneres', NULL, NULL, 'https://image.tmdb.org/t/p/w500/z8IEEid4z63CBlJtxrTKEfsW7NA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('361', 'Alexander Gould', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zzfj8LHhSiRntnyThvOBirEEmII.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('362', 'Geoffrey Rush', NULL, NULL, 'https://image.tmdb.org/t/p/w500/npXFjaFQzBNroCEPllGPTZ5IisA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('363', 'Ed Asner', NULL, NULL, 'https://image.tmdb.org/t/p/w500/AeVizz1AfAB2TbsfyzgBvqeSR3G.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('364', 'Christopher Plummer', NULL, NULL, 'https://image.tmdb.org/t/p/w500/u0YBwss0ebEUp8sjRtQKnK2wZdR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('365', 'Jordan Nagai', NULL, NULL, 'https://image.tmdb.org/t/p/w500/j1kVS2sI3wWIHCCzzYD1buXAP9e.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('366', 'Bob Peterson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dJe3nTCIToebjj1WHFHP7LmZKyk.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('367', 'Delroy Lindo', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kLwUBBmEIdchrLqwsYzgLB2B6q5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('368', 'Ben Burtt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7asFDWjls2bYQSfXJf5StjXmlhI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('369', 'Elissa Knight', NULL, NULL, 'https://image.tmdb.org/t/p/w500/exRLyaNaHcgawQA0DoBxo5IvdoI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('370', 'Mike Myers', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gjfDl52Kk02MPgUYFjs9bOy33OY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('371', 'Eddie Murphy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qgjMfefsKwSYsyCaIX46uyOXIpy.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('372', 'Cameron Diaz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tIWUyvmJayu8gtbrzCWC0L3H8kH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('373', 'John Lithgow', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ajfuBSm1HuVqFJlbTmAlza62Xxr.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('374', 'Vincent Cassel', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ivUQfhn5olOmR5hthN8C8GThBV4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('375', 'Matthew Broderick', NULL, NULL, 'https://image.tmdb.org/t/p/w500/papqFgpyroZJEqd7WvuNGN8ti2k.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('376', 'Moira Kelly', NULL, NULL, 'https://image.tmdb.org/t/p/w500/oUuY9xERN1rpb7dPKchM5QQKEyt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('377', 'Jeremy Irons', NULL, NULL, 'https://image.tmdb.org/t/p/w500/w8Ct1q02Ht3sWdOSqfp3B85TzT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('378', 'Nathan Lane', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jLPp3RoDhwOpLimKj3NhhBofPfT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('379', 'Ernie Sabella', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rALAxs5zUfQS3bZrEcns86gCHwI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('380', 'Paige O''Hara', NULL, NULL, 'https://image.tmdb.org/t/p/w500/g61DJhK2rUOJJ2Rk4Kw0svUPWRh.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('381', 'Robby Benson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/a7lauBiOZmJEuYDSpfHrJDOgrOc.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('382', 'Richard White', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ffrXvosdpVWd00neXUyposGNViF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('383', 'Jerry Orbach', NULL, NULL, 'https://image.tmdb.org/t/p/w500/36Bsh8VKClXn6diVnEbDLgniBF4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('384', 'David Ogden Stiers', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cgCTQt3RZVkhkusG77l4HwHEH6A.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('385', 'Scott Weinger', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5EvrWMz2xi3hOkrEMNGH2Rts2jz.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('386', 'Robin Williams', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iYdeP6K0qz44Wg2Nw9LPJGMBkQ5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('387', 'Linda Larkin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/uN35v1Z374JvfdnDJBVmvnB2JNQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('388', 'Jonathan Freeman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ceyXr2JHuB32l74sFuzgMGGVLGQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('389', 'Gilbert Gottfried', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hkkAgJD0HKcuyd8EuvhyN5vHcDQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('390', 'Kristen Bell', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rP74dJXl7EjinGM0shQtUOlH5s2.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('391', 'Idina Menzel', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eGsyJmAZNV5tUU4RYy2DIRlFVpW.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('392', 'Jonathan Groff', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3kmnYKAzSc3Lp7iK5pcj97Hx9Cm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('231', 'Takuya Kimura', NULL, NULL, 'https://image.tmdb.org/t/p/w500/sswCg8kvFsgSaVJwcIKKe4K7jOe.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('232', 'Akihiro Miwa', NULL, NULL, 'https://image.tmdb.org/t/p/w500/20n18waqgVo5zSO6Ot0d4fz3jAM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('233', 'Tatsuya Gashuin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fLqIdkShknsJmZy4EfBWuWyHN4C.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('234', 'Ryunosuke Kamiki', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ut7ewXjdgUmgkhJ1EtbOo9tbc7s.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('235', 'Michael Fassbender', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xvbnUiB2ZBR3QIt595OzNy657Vw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('236', 'Oscar Kightley', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vFVWVtJXxbwNzANrvjHpXJZ8uaK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('237', 'Kaimana', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nQR4BANBAiTYXpUeu38l38tQAVT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('238', 'David Fane', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tcozyaTgAa8rRmzc5qeht0loni6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('239', 'Rachel House', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2LCQF7Bn0I91o17GGkox0ZhhbE7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('240', 'Keanu Reeves', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8RZLOyYGsoRe9p44q3xin9QkMHv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('241', 'Patrick Swayze', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ys8dRhQRsS0nLPTXXEHyuFhXCYO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('242', 'Lori Petty', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bmJFh4VxRii7h7jpo4YVC6BFeVd.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('243', 'Gary Busey', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8H7Hlv6b7ZoK4jZKeLnc2i4pfPL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('244', 'John C. McGinley', NULL, NULL, 'https://image.tmdb.org/t/p/w500/a9Oc7STg83syQh3X22u2TroAifk.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('245', 'Bradley Cooper', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5Dhy50qOMOHfR1NZifKIfffjV9X.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('246', 'Toni Collette', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lzXRh16qe4HHeBN6tMyw0DHvaMn.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('247', 'Emile Hirsch', NULL, NULL, 'https://image.tmdb.org/t/p/w500/NQjX6KjtDDyLnvbxhrU9xQWaYJ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('248', 'Margaret Qualley', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4LeaweyyTXCNs9V5swAuU4gGgZC.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('249', 'Tim Robbins', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3FfJMIVwXgsIXbAT8ECBSZJAncR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('250', 'Bob Gunton', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ulbVvuBToBN3aCGcV028hwO0MOP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('251', 'William Sadler', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rWeb2kjYCA7V9MC9kRwRpm57YoY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('252', 'Clancy Brown', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1JeBRNG7VS7r64V9lOvej9bZXW5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('253', 'Marlon Brando', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fuTEPMsBtV1zE98ujPONbKiYDc2.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('254', 'Al Pacino', NULL, NULL, 'https://image.tmdb.org/t/p/w500/m8HAAjq1T75JypKk0v1FFQn4ysZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('255', 'James Caan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/z2Lz3rtxZ7aJjzBUkCnExvo8stn.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('256', 'Robert Duvall', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3tcKxC5Sc3DJ6XPDKKC2EAomEWn.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('257', 'Richard S. Castellano', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1vr75BdHWret81vuSJ3ugiCBkxw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('258', 'Diane Keaton', NULL, NULL, 'https://image.tmdb.org/t/p/w500/A8B3BsFgbmw2WEmJuQX38qeU9eR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('259', 'John Cazale', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7uKBc2BVbLlAiHuSdfioe1OUnCX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('260', 'Gary Sinise', NULL, NULL, 'https://image.tmdb.org/t/p/w500/olRjiV8ZhBixQiTvrGwXhpVXxsV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('261', 'Sally Field', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iMeq1j9Xwvaf6PbTJ0FQz69fpuA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('262', 'Mykelti Williamson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dR16zD9AjnHWbeN5OVmJWE0vSax.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('263', 'Laurence Fishburne', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2GbXERENPpl5MmlqOLlPVaVtifD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('264', 'Carrie-Anne Moss', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xD4jTA3KmVp5Rq3aHcymL9DUGjD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('265', 'Hugo Weaving', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lSC8Et0PYi5zeQb3IpPkFje7hgR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('266', 'Gloria Foster', NULL, NULL, 'https://image.tmdb.org/t/p/w500/AriGXtC9fjBOia9Zr8CZjn4o3rx.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('267', 'Jodie Foster', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5emVgsLFlU6SmeBIFsF2Y7aqwtG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('268', 'Anthony Hopkins', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iaf7SHSkGDpnyrDh1Jolilwk2TD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('269', 'Scott Glenn', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8DHORod2l6ZFS9KR0gNAAM3WZfI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('270', 'Ted Levine', NULL, NULL, 'https://image.tmdb.org/t/p/w500/451KSkowLW6M2Au0wBKZZcidgGm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('271', 'Anthony Heald', NULL, NULL, 'https://image.tmdb.org/t/p/w500/e0E6Z1Y0debr4mAHgj0HO7MYyXG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('272', 'Tom Sizemore', NULL, NULL, 'https://image.tmdb.org/t/p/w500/soINOuacuiThRb2LyPD4tTWve7C.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('273', 'Edward Burns', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pTLdPUSxDUcdmvy91LGCF3pk0AM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('274', 'Barry Pepper', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xBvW4dMoz496rItLQU6TGteYCEP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('275', 'Adam Goldberg', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xEbqDqTWlSSCi4v8FI3S9YSEPJz.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('276', 'Liam Neeson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/sRLev3wJioBgun3ZoeAUFpkLy0D.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('277', 'Caroline Goodall', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4cagGtMqACvkuw6Llq8Li8UJ1AR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('278', 'Jonathan Sagall', NULL, NULL, 'https://image.tmdb.org/t/p/w500/waxNDsgfw7CXXO3LH8EdKi8z7VV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('279', 'Bonnie Hunt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tT9C6uLztgN8OxJULq6F9iEzqlA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('280', 'Michael Clarke Duncan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3RX8OBqt3gbvFwKYZqiom4O3Ta6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('281', 'James Cromwell', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vpNQQbM5PtxsYmVm4oh79SGFyUK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('282', 'Kevin Spacey', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nPrUZDEbGQe6jwpVbHKJCXsMd7r.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('283', 'Annette Bening', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kGslMAWcpv8MKzODhDRDkFE0uX7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('284', 'Thora Birch', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xJ6Bb3C8f0ior5LlWdNzxlb8cgV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('285', 'Wes Bentley', NULL, NULL, 'https://image.tmdb.org/t/p/w500/voD93lzFZrr9xfAggwFcPRBi84i.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('286', 'Mena Suvari', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xjqKvy0bos02oSKNYzC4mxLbQ0W.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('287', 'Vivien Leigh', NULL, NULL, 'https://image.tmdb.org/t/p/w500/h1hS5o0cKXF2g9Wjej0RtibMPT0.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('288', 'Clark Gable', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qD6WJzydym7n7fCeL9PGnHe1aEV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('289', 'Olivia de Havilland', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9pIjSCaOSIp9IbMVUaZhQ4dWc9F.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('290', 'Leslie Howard', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mlD06Vq50FnNvEPI8GcWKZ8C1BG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('291', 'Hattie McDaniel', NULL, NULL, 'https://image.tmdb.org/t/p/w500/n47w7mAMNZ2DZiSOZREDL4L1ASm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('292', 'Humphrey Bogart', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4pk2VbOb2td7iBZyir6Ji46HH4N.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('293', 'Ingrid Bergman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jXEE0P6705JbMAJ2nwtHjmqkd5F.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('294', 'Paul Henreid', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kqlDSharpQjqeNVS5BZkqqJl3ZF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('295', 'Claude Rains', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fcM7Xfs0lWBw8TDjcFSLosX2YAD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('296', 'Conrad Veidt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rmlK341dwK57BVWz1S96tpv7SSF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('297', 'Orson Welles', NULL, NULL, 'https://image.tmdb.org/t/p/w500/e9lGmqQq3EsHeUQgQLByo275hcc.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('298', 'Joseph Cotten', NULL, NULL, 'https://image.tmdb.org/t/p/w500/djfCB0jPOgmq3w7RD3BMLzWsAu8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('299', 'Dorothy Comingore', NULL, NULL, 'https://image.tmdb.org/t/p/w500/x8RBK7T3HgWMWVniWkapAfPULDU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('300', 'Ray Collins', NULL, NULL, 'https://image.tmdb.org/t/p/w500/usQN1n6UMPwYrTuTKdiSxUj8Qwa.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('301', 'George Coulouris', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cB87rJWOsstpwhBXk6nqqZ9SEJg.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('302', 'Ian Holm', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cOJDgvgj4nMec6Inzj1H5nugTO5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('303', 'Mark Hamill', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zMQ93JTLW8KxusKhOlHFZhih3YQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('304', 'Carrie Fisher', NULL, NULL, 'https://image.tmdb.org/t/p/w500/of4yHmryKPy92eeskUQ7MRmjC3l.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('305', 'Peter Cushing', NULL, NULL, 'https://image.tmdb.org/t/p/w500/if5g03wn6uvHx7F6FxXHLebKc0q.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('306', 'Alec Guinness', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qaN3cZdd2pvKaOXIIJ5BXnbjPp3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('307', 'Billy Dee Williams', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dCiHLiCapPuRwKkM1ytVZ7PwYQY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('308', 'Anthony Daniels', NULL, NULL, 'https://image.tmdb.org/t/p/w500/c876ZM5ObwYgXksrRWNNrL9KeZg.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('309', 'Sam Neill', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iIfuxalf37xUayuGyK0zG7z6WEZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('310', 'Laura Dern', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gB9PnGEvxKg33OSlcqptQwTBwPE.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('311', 'Jeff Goldblum', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kcyEPgYtBP5Pm6LLeLGfXKjYovL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('31', 'Joseph Gordon-Levitt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/z2FA8js799xqtfiFjBTicFYdfk.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('32', 'Ken Watanabe', NULL, NULL, 'https://image.tmdb.org/t/p/w500/psAXOYp9SBOXvg6AXzARDedNQ9P.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('33', 'Tom Hardy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/d81K0RH8UX7tZj49tZaQhZ9ewH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('34', 'Elliot Page', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nXO8DE4biVXY4UDYP0NdIY1zvXS.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('35', 'Matthew McConaughey', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lCySuYjhXix3FzQdS4oceDDrXKI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('36', 'Michael Caine', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bVZRMlpjTAO2pJK6v90buFgVbSW.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('37', 'Jessica Chastain', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lodMzLKSdrPcBry6TdoDsMN3Vge.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('38', 'Casey Affleck', NULL, NULL, 'https://image.tmdb.org/t/p/w500/304ilSygaCRWykoBWAL67TOw8g9.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('39', 'Heath Ledger', NULL, NULL, 'https://image.tmdb.org/t/p/w500/AdWKVqyWpkYSfKE5Gb2qn8JzHni.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('40', 'Aaron Eckhart', NULL, NULL, 'https://image.tmdb.org/t/p/w500/u5JjnRMr9zKEVvOP7k3F6gdcwT6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('41', 'Maggie Gyllenhaal', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vsfkWdYWmA9CpzMHTJzrFxlDnEZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('42', 'Cillian Murphy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2lKs67r7FI4bPu0AXxMUJZxmUXn.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('43', 'Emily Blunt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5nCSG5TL1bP1geD8aaBfaLnLLCD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('44', 'Matt Damon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aCvBXTAR9B1qRjIRzMBYhhbm1fR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('45', 'Timothée Chalamet', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dFxpwRpmzpVfP1zjluH68DeQhyj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('46', 'Rebecca Ferguson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ra53cM1aNmdH0aFhj8yBqPOj2fb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('47', 'Javier Bardem', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zfRID0jx8DKBluPGU9xtk9sZWUt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('48', 'Josh Brolin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/sX2etBbIkxRaCsATyw5ZpOVMPTD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('49', 'Song Kang-ho', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kBM9UTPYXUA2RNk210DXhztLFns.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('50', 'Lee Sun-kyun', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nHFBbSFohzOUOvMxPVwe3Es2nJw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('51', 'Cho Yeo-jeong', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5MgWM8pkUiYkj9MEaEpO0Ir1FD9.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('52', 'Choi Woo-shik', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9mZ9DNopxpCLUjXd0rLd42TLamw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('53', 'Park So-dam', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fGVOikpvivopeATDy6ZzLdKYXDu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('54', 'America Ferrera', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7q9uUWnaIjveX8DTU2lcA7mA3dp.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('55', 'Ariana Greenblatt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lp7lzzBE7EYTMvSb4foN5LyZUkP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('56', 'Issa Rae', NULL, NULL, 'https://image.tmdb.org/t/p/w500/uFjimuDgBv8kckApr19t8DykxPH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('57', 'Mark Ruffalo', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5GilHMOt5PAQh6rlUKZzGmaKEI7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('58', 'Chris Hemsworth', NULL, NULL, 'https://image.tmdb.org/t/p/w500/piQGdoIQOF3C1EI5cbYZLAW1gfj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('59', 'Scarlett Johansson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/druW5adKddizHNSoPbI0q7Mvn0K.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('60', 'Kate Winslet', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6qNnMsKtKz9si5rabpUEG85UfHp.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('61', 'Billy Zane', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wr4fuwLzQvW1G0MS7cmQ3ObFjvL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('62', 'Kathy Bates', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qZRTzTjV4OC1Ii9a0n8QBS9zMOd.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('63', 'Frances Fisher', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3iNDgd54IIj8g8hGqhhUjM6TeWd.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('64', 'Amy Poehler', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rwmvRonpluV6dCPiQissYrchvSD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('65', 'Phyllis Smith', NULL, NULL, 'https://image.tmdb.org/t/p/w500/h9w9pQbiderRWAC2mi7spjzuIGz.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('66', 'Richard Kind', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yWmuVQeQUzb5OSMVDoWkR0IylCK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('67', 'Bill Hader', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qyT50vQ9PQIEctE1IxDTEsBKstU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('68', 'Lewis Black', NULL, NULL, 'https://image.tmdb.org/t/p/w500/f6660RU8eG10Rrk0Fnfih90b0ME.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('69', 'John Travolta', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ap8eEYfBKTLixmVVpRlq4NslDD5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('70', 'Bruce Willis', NULL, NULL, 'https://image.tmdb.org/t/p/w500/w3aXr1e7gQCn8MSp1vW4sXHn99P.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('71', 'Ving Rhames', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tOVDvu1EQP78AwaUw6uh1wN818E.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('72', 'Jack Nicholson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hBHcQIEa6P48HQAlLZkh0eKSSkG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('73', 'Mark Wahlberg', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1Oc3XSLyb8hxmjmlgFENu582Kqw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('74', 'Martin Sheen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/m2Y3Q0uyuW6htrn2W9UWCWMkpZu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('75', 'Martin Freeman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nrO54AzrxiNgCjBUOSz6ebyxDZY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('76', 'Ian McKellen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5cnnnpnJG6TiYUSS7qgJheUZgnv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('77', 'Richard Armitage', NULL, NULL, 'https://image.tmdb.org/t/p/w500/oNoKjTOUNUiJ01UNQSCQDkt5EHi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('78', 'James Nesbitt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lQiGZcwUXbCqpF055Ia5jxdZ2Ma.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('79', 'Ken Stott', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yzF2h7xhwtCkQ6T556pHSE7F1k4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('80', 'Ben Affleck', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aTcqu8cI4wMohU17xTdqmXKTGrw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('81', 'Rosamund Pike', NULL, NULL, 'https://image.tmdb.org/t/p/w500/by7w5dAZImcaBjP7Mnf8Aa8MQA6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('82', 'Neil Patrick Harris', NULL, NULL, 'https://image.tmdb.org/t/p/w500/r2twLWLwDpKJ7JyhWsD1YsL7rJV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('83', 'Tyler Perry', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8KU0OizemVLrERXt5HJIa0PAkIN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('84', 'Carrie Coon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vWChiHhXFjZVKC6HbACyyRFmdW4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('85', 'Bill Murray', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nnCsJc9x3ZiG3AFyiyc3FPehppy.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('86', 'Giovanni Ribisi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8EAiS9D3YtGOrwNM0OrwmDpWK7s.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('87', 'Anna Faris', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tptTb0BQwCpKWETNqzkZzzf5qSZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('88', 'Akiko Takeshita', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dKawZTpMtjAYZanVf20wr6a81sL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('89', 'Michael Keaton', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tYSja1KByFnZ4Hkp3stPqkKHnNL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('90', 'Zach Galifianakis', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ncBSLoNUufKpg7vzx1gCtjhst8i.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('91', 'Edward Norton', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8nytsqL59SFJTVYVrN72k6qkGgJ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('92', 'Andrea Riseborough', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dQzAXj6R8cTRqTwGzxUgegXbV13.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('93', 'Kristen Wiig', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6U6UGztBwk7c4lg8n5BS5QOByot.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('94', 'Jeff Daniels', NULL, NULL, 'https://image.tmdb.org/t/p/w500/r0mkZJZnTSJO3HJRsMW5HtszxE8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('95', 'Michael Peña', NULL, NULL, 'https://image.tmdb.org/t/p/w500/afs4PCiwn8LR93a10drULLVeVLo.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('96', 'Ralph Fiennes', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tJr9GcmGNHhLVVEH3i7QYbj6hBi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('97', 'F. Murray Abraham', NULL, NULL, 'https://image.tmdb.org/t/p/w500/p2RYVGdrcP0m70BkkiKcwyrDeim.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('98', 'Tony Revolori', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tSF6XmXDikrKZbFUeoDnafXxKjT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('99', 'Adrien Brody', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qBc7ahQrpVpcllaZ5hkivsOEb3C.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('100', 'Willem Dafoe', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ui8e4sgZAwMPi3hzEO53jyBJF9B.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('101', 'Rumi Hiiragi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nTKM4GgfkrZvAOFL55uhEuckt7M.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('102', 'Miyu Irino', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8qEEhHUObNvGQr4e6eqLu5z4qTz.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('103', 'Mari Natsuki', NULL, NULL, 'https://image.tmdb.org/t/p/w500/MIFzUc77Sx57FQOZsoiGWEbpH2.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('104', 'Takashi Naito', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xwsm0ygjG79jLIogutwo6r64igy.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('105', 'Yasuko Sawaguchi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rWspusb13VeJowmctnniXYYTcqq.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('106', 'Roman Griffin Davis', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jEox6Bq4TlINrnp5EUjqSlDK3eP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('107', 'Thomasin McKenzie', NULL, NULL, 'https://image.tmdb.org/t/p/w500/WOpnEFG5Q8LWxP81MtUrskmVox.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('108', 'Taika Waititi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ww6L2ksfJNMbuiIdDuvVKndUHsv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('109', 'Sam Rockwell', NULL, NULL, 'https://image.tmdb.org/t/p/w500/afYhNpLwpa65Yy0Q0g00FNFhzx5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('110', 'Jason Clarke', NULL, NULL, 'https://image.tmdb.org/t/p/w500/quH4y2dto3UAgZOfaM0QriyRLPN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('111', 'Joel Edgerton', NULL, NULL, 'https://image.tmdb.org/t/p/w500/r2TTDZ8cG5wrZqx7Drz1M95S9z3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('112', 'Jennifer Ehle', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kMddVKineLFpxsUoGrb3E6edkOv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('11', 'Samuel L. Jackson', TO_DATE('1948-12-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/qdfRtvPCj51C9Uy5VEgjgj69JyV.jpg', 'American actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('12', 'Uma Thurman', TO_DATE('1970-04-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/hlYG0MC6im0MHNq1xixxVilfwyR.jpg', 'American actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('13', 'Brad Pitt', TO_DATE('1963-12-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/ajNaPmXVVMJFg9GWmu6MJzTaXdV.jpg', 'American actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('14', 'Meryl Streep', TO_DATE('1949-06-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/g5cVxQBAQ3AXt3LhdBXtbbN47Uc.jpg', 'American actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('15', 'Cate Blanchett', TO_DATE('1969-05-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Australian', 'https://image.tmdb.org/t/p/w500/vUuEHiAR0eD3XEJhg2DWIjymUAA.jpg', 'Australian actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('16', 'Joaquin Phoenix', TO_DATE('1974-10-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/u38k3hQBDwNX0VA22aQceDp9Iyv.jpg', 'American actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('17', 'Zendaya', TO_DATE('1996-09-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/3WdOloHpjtjL96uVOhFRRCcYSwq.jpg', 'American actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('18', 'Timothee Chalamet', TO_DATE('1995-12-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/dFxpwRpmzpVfP1zjluH68DeQhyj.jpg', 'American actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('19', 'Florence Pugh', TO_DATE('1996-01-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'British', 'https://image.tmdb.org/t/p/w500/1Uvfh7xL4U2evkhs0M3C7BbBYFf.jpg', 'British actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('20', 'Idris Elba', TO_DATE('1972-09-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'British', 'https://image.tmdb.org/t/p/w500/be1bVF7qGX91a6c5WeRPs5pKXln.jpg', 'British actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('21', 'Saoirse Ronan', TO_DATE('1994-04-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Irish', 'https://image.tmdb.org/t/p/w500/tsk3iKGmMgXIGbRjwf2zYkh8Zkb.jpg', 'Irish actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('22', 'Michael B. Jordan', TO_DATE('1987-02-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/sMBpav8cK7t7Nk0yf4tuNOqNUyW.jpg', 'American actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('23', 'Awkwafina', TO_DATE('1988-06-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/l5AKkg3H1QhMuXmTTmq1EyjyiRb.jpg', 'American actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('24', 'John Boyega', TO_DATE('1992-03-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'British', 'https://image.tmdb.org/t/p/w500/3153CfpgZQXTzCY0i74WpJumMQe.jpg', 'British actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('25', 'Lupita Nyong''o', TO_DATE('1983-03-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Kenyan', 'https://image.tmdb.org/t/p/w500/y40Wu1T742kynOqtwXASc5Qgm49.jpg', 'Kenyan actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('26', 'Adam Driver', TO_DATE('1983-11-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/b5w381C8Z33D1iF30KT4k8tJNsk.jpg', 'American actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('27', 'Emma Stone', TO_DATE('1988-11-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/t7EYLBMWQiIDtCoOYZjvqXV84S5.jpg', 'American actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('28', 'Ana de Armas', TO_DATE('1988-04-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Cuban', 'https://image.tmdb.org/t/p/w500/eDuBeSHV0R7vuCnHHXrfa7d7IfB.jpg', 'Cuban actor.');
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('113', 'Mark Strong', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3cNmatYsoifytg7TfQhI1EHow3v.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('114', 'Ivana Baquero', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wT8cNP0Aip9sEWM9AwSZ9ogJPiT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('115', 'Sergi López', NULL, NULL, 'https://image.tmdb.org/t/p/w500/n3HcmUflYYaHUiQmzaayi0yqcRf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('116', 'Maribel Verdú', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7hxTsW5CKi2lkz5yGMWShki7DOo.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('117', 'Doug Jones', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rpvvWATYWHGjedJea0G97XufOwU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('118', 'Ariadna Gil', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4g5IyK6br9UCRqLLlW8z5ZLFtYf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('119', 'Lucy Liu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9nbtjqsx3De7hO2XDtrBQ7M9VCH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('120', 'Vivica A. Fox', NULL, NULL, 'https://image.tmdb.org/t/p/w500/oIzevp0dqjIxqRQ2VoSzjiDCBt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('121', 'Daryl Hannah', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5FllFmoiaru7tjXJ6Orc11OpQcw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('122', 'David Carradine', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1X2GlkMKS9FIG1kGou7o6LRqAjz.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('123', 'Ben Kingsley', NULL, NULL, 'https://image.tmdb.org/t/p/w500/k3Dmu49B2akwDvgqy52MOxznI59.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('124', 'Max von Sydow', NULL, NULL, 'https://image.tmdb.org/t/p/w500/u16BsGyT6v9yuO7wWAF62NayDth.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('125', 'Michelle Williams', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jn3BVMVbIptz2gc6Fhxo1qwJVvW.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('126', 'Elijah Wood', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7UKRbJBNG7mxBl2QQc5XsAh6F8B.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('127', 'Viggo Mortensen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vH5gVSpHAMhDaFWfh0Q7BG61O1y.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('128', 'Sean Astin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/As3ctGUtBYmG4zj4Ifyrcqd71HP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('129', 'Andy Serkis', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eNGqhebQ4cDssjVeNFrKtUvweV5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('130', 'Morgan Freeman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/905k0RFzH0Kd6gx8oSxRdnr6FL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('131', 'Gwyneth Paltrow', NULL, NULL, 'https://image.tmdb.org/t/p/w500/r4wbWWEEjmtRFZ0GU10XbLTgp47.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('132', 'John Cassini', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kn2Rtn0I8ivCR7ydZTY74XUBh1K.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('133', 'Peter Crombie', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pMvhE1wwQo3eTSp4vwq8Hb22CwN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('134', 'Kirsten Dunst', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yhLKGjuiMMdbGnFrR8AREkCZcVF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('135', 'Jason Schwartzman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gCjMdmW1DiPAClHVl4zHEIffIsE.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('136', 'Steve Coogan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tT7OXc2qA6hlREHXdwGLp0XihzA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('137', 'Judy Davis', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yAwsKkca91QJdsf1suUm637mwUx.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('138', 'Rip Torn', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jP74MHyQl6R8mH7aZKHrrD2Qjj2.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('139', 'Domhnall Gleeson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/a63BgOBKzJ9XPaLFyu7u5Ge3REG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('140', 'Will Poulter', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9blYMaj79VGC6BHTLmJp3V5S8r3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('141', 'Forrest Goodluck', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4xjRFmyJqYZRtLODw22baOla2Ub.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('142', 'Vanessa Kirby', NULL, NULL, 'https://image.tmdb.org/t/p/w500/a8a9U00KL2JJkkekzhNnueIGKKF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('143', 'Tahar Rahim', NULL, NULL, 'https://image.tmdb.org/t/p/w500/r1SJ9nkG9q4JbPHbtcvcVxmRcHw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('144', 'Rupert Everett', NULL, NULL, 'https://image.tmdb.org/t/p/w500/g0kqfIxf9eIV7rOMQcbebsgMS9Z.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('145', 'Mark Bonnar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qEOp1lj0HGAVy1wpqIxMNkxIzn7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('146', 'Bryan Cranston', NULL, NULL, 'https://image.tmdb.org/t/p/w500/npIIZJGSrcJIJ6yHdmbqO6Jzo5I.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('147', 'Koyu Rankin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cJsX8JA9fCqdHlNYf2945MUvvn1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('148', 'Bob Balaban', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qceORed11dvRnxQjVGexPvgF5Xu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('149', 'Yoji Matsuda', NULL, NULL, 'https://image.tmdb.org/t/p/w500/42WeHwCymsgJh3mLAyknCdRcef8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('150', 'Yuriko Ishida', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cADoBCi603Chz2IaxcwWT2mNwCf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('151', 'Yuko Tanaka', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fMonAnp3OQ16FmGy5SGhEJRcuVI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('152', 'Kaoru Kobayashi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zpnQ8L6SpyT8pI5vgbpKqXyMYoj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('153', 'Masahiko Nishimura', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qk7nO5RWFr2f3VeJNpf7sgsbsXR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('154', 'Tom Hiddleston', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mclHxMm8aPlCPKptP67257F5GPo.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('155', 'Jeremy Renner', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yB84D1neTYXfWBaV0QOE9RF2VCu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('156', 'Anthony Mackie', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vecvTm7SimizluJkyIwBxeLbvRm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('157', 'Brian Geraghty', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4sqeUc4xYyzQ3Qpl5oxlQBTAAQk.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('158', 'David Morse', NULL, NULL, 'https://image.tmdb.org/t/p/w500/A6zGbkFjM3uajIakgsSeNTmSKqY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('159', 'Guy Pearce', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vTqk6Nh3WgqPubkS23eOlMAwmwa.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('160', 'Sally Hawkins', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1dtDq82dM2YQ17lBL4ZKPJo5LKw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('161', 'Michael Shannon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6mMczfjM8CiS1WuBOgo5Xom1TcR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('162', 'Richard Jenkins', NULL, NULL, 'https://image.tmdb.org/t/p/w500/muT3RZG9hiKaKojD751RcQ5tGEy.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('163', 'Octavia Spencer', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zDGydyM1fmvNWzQlTAns9IZjNxT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('164', 'Michael Stuhlbarg', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aYB3SQm3h6ZyAdlbGyiNfakjx56.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('165', 'Jamie Foxx', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zD8Nsy4Xrghp7WunwpCj5JKBPeU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('166', 'Christoph Waltz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jMvLGCVXLaBqjRLf5olyvEucZob.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('167', 'Kerry Washington', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zgyjYlxmHG6Ntbg16JcTp8Vu8M3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('168', 'Jonah Hill', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cymlWttB83MsAGR2EkTgANtjeRH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('169', 'Kyle Chandler', NULL, NULL, 'https://image.tmdb.org/t/p/w500/66n7XNj1dyYkzCBWR3Lq8Vz4PJ1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('636', 'Amitabh Bachchan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/u69PvpWqGkywSm0YjFiw77j9eqS.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('637', 'Sanjeev Kumar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xfqirwZjtRdzioJ66dUZTBU2KgB.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('638', 'Amjad Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/52s7Cbukn505Bo0JzLdurF8RXb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('639', 'Hema Malini', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dfNRjtvbxisRSBDhCoUMuEFyY3V.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('640', 'Kajol', NULL, NULL, 'https://image.tmdb.org/t/p/w500/h4m0TkDuEMCUNaPrQxMRyFb2AQ7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('641', 'Shah Rukh Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tCEppfUu0g2Luu0rS5VKMoL4eSw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('642', 'Amrish Puri', NULL, NULL, 'https://image.tmdb.org/t/p/w500/uhMGFS7tuG71LDv2wk9LfZZ4EG6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('643', 'Farida Jalal', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tJdqL4BRSAWVFX1W6cmwxFs9IFh.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('644', 'Anupam Kher', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kgU5Ap1Kf9RnicB5DMcXEZqed2f.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('645', 'Aamir Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6uiZSwi2kvd1jZ7X7Xz9W9VGuV4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('646', 'Gracy Singh', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nJRYXqpctHNuswpesaSm6GFsyX0.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('647', 'Rachel Shelley', NULL, NULL, 'https://image.tmdb.org/t/p/w500/AoZAGf20aNUCqh2ujPxfyC1Sk5O.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('648', 'Paul Blackthorne', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3OC1M0rKJO8B3JpwAeavk5EAscl.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('649', 'Suhasini Mulay', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9mD9ASIlw56LIRIEGSXHmIovu4D.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('650', 'R. Madhavan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gaDrAdXxIrbBRCd9cX8YvJDEuLb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('651', 'Sharman Joshi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mQr8ynFFVq08qgQ4aSNl5B0ko8v.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('652', 'Kareena Kapoor Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kp9xnwDALUt6nuPBGuJHlvnxGnM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('653', 'Boman Irani', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5J7GiiNar9bg9rGYeA2L30JXE2W.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('654', 'Fatima Sana Shaikh', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eVOziSvi6PLL5vkROHO1sbsKUFW.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('655', 'Sanya Malhotra', NULL, NULL, 'https://image.tmdb.org/t/p/w500/sQ0VIqGLecfpwYayO05Z7NC32yN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('656', 'Zaira Wasim', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lt7S0HddIyHC6HiyuSD75dJppCX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('657', 'Suhani Bhatnagar', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('658', 'Anushka Sharma', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8Xmfnwe6pf58duYqxxYv81phs2.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('659', 'Saurabh Shukla', NULL, NULL, 'https://image.tmdb.org/t/p/w500/uFGVBmRIHLAQkYYSI2lSXOxMi4f.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('660', 'Sushant Singh Rajput', NULL, NULL, 'https://image.tmdb.org/t/p/w500/j5cjz4SlZYlhrIFZkmCREvG3wSm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('661', 'Manoj Bajpayee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hBiAldG2BGMVoZUPbvK3FNDSw22.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('662', 'Richa Chadha', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cb15PLOeRNt7uxsiymjHfnJPm3i.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('663', 'Tigmanshu Dhulia', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2CRk2UX3KfqMythuLBleMwQ7bQr.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('664', 'Nawazuddin Siddiqui', NULL, NULL, 'https://image.tmdb.org/t/p/w500/w1eXF7T60QlEC2gNfr99J3n8CgX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('665', 'Reema Sen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/f5Xe92gA1BXa4BddAxnysRZwnjf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('666', 'Hrithik Roshan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/d7XGTvyYgmrsA05XOn1YtxYcuY1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('667', 'Abhay Deol', NULL, NULL, 'https://image.tmdb.org/t/p/w500/h7eVy3QlTVwbWL10dpY5Y9mVlFB.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('668', 'Farhan Akhtar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nYx5T3tkghBPvmI29J2iJlZOFyV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('669', 'Katrina Kaif', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gSNaBg8Q7Nh0u4HhW6pR5B0ujlL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('670', 'Kalki Koechlin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4m81jxAeWJ1h1T6265pGBZoCC10.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('671', 'Isabelle Adjani', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ad0GTy4ivzDhep1R0CgiR0O0g2v.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('672', 'Daniel Auteuil', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5asrvkdSnlYlHap3ldDNyE5opeI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('673', 'Jean-Hugues Anglade', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cpSxpZLgtzuizHyEmdkh9rgKkRs.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('674', 'Vincent Perez', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mpNv77WJ0kmi8vecBmRKQAdRzzo.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('675', 'Virna Lisi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/v119CeFIeiOebwwutvs886JKG3l.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('676', 'Ayushmann Khurrana', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qbdclvnDkJxPX7OQqmMY7w9ekBP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('677', 'Tabu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cvt5nvCHr1ICf5u8A2mlzLQ8LsV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('678', 'Radhika Apte', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wKPybRcSYcbgDiJZwELudrRNf0r.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('679', 'Manav Vij', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qBGYyDNhHB8Gt2gKQUs0VdsWutJ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('680', 'Zakir Hussain', NULL, NULL, 'https://image.tmdb.org/t/p/w500/etiL0ANjzBhTiyvUblZl6vwIog9.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('681', 'Isha Talwar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dVRrb9aLf6s1XmtIkpSbzuMl0Uv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('682', 'Sayani Gupta', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ZswP4g0UHDYvZLI2HlWzEcbvEN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('683', 'Kumud Mishra', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pM4eD7eIEPk2Lx0c5C1K201qnp6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('684', 'Manoj Pahwa', NULL, NULL, 'https://image.tmdb.org/t/p/w500/p7sufhnro3CM04au3L4KubTx43B.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('685', 'Irrfan Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qkA9PpWJRw3rNjVkWfNZdwLvRZx.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('686', 'Nimrat Kaur', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7tJoyJygnKOweIlirFCWoOcuSzq.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('687', 'Lillete Dubey', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qeAlaycZ3ATHr2P6LV1V5LeC4hV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('688', 'Nasir Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dAg66KrESe0JIpB6Iaj1XHRp1zU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('689', 'Ranveer Singh', NULL, NULL, 'https://image.tmdb.org/t/p/w500/sRiwLmhduFghJo8U2coUafnDD4C.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('690', 'Alia Bhatt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lAgBZgHKTo6amIO9CfNxUbm1usH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('691', 'Siddhant Chaturvedi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9hsOatm8AtXf55ko7dWySVv9noZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('692', 'Vijay Raaz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bLSjiy51UPjVnTYRDmgRUy1VOwD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('693', 'Vijay Varma', NULL, NULL, 'https://image.tmdb.org/t/p/w500/A46ekiPFC3vA1442FJmiIudpxX1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('694', 'Darsheel Safary', NULL, NULL, 'https://image.tmdb.org/t/p/w500/k0I9AOoWN5LtDD1mOEFK9Vfrmgo.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('695', 'Tisca Chopra', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3Paj1g86LtZIcP3poEcDJhIdpQJ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('696', 'Vipin Sharma', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3TZHbQ1Zi3z1B721jwwTKxAMXqI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('697', 'Tanay Chheda', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lZ0tjKg0FQ869tP80eBHobb3ouH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('698', 'Siddharth', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9XrTuJp9lnB1rsBPzTaoXdp1ig8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('699', 'Kunal Kapoor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/i6NhU7lFjT5BIO8Bb014xnx9W62.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('700', 'Atul Kulkarni', NULL, NULL, 'https://image.tmdb.org/t/p/w500/z3mRRjJfYs5C9PR4jzKsbZVKTKy.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('701', 'Ranbir Kapoor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ymYNHV9luwgyrw17NXHqbOWTQkg.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('702', 'Priyanka Chopra Jonas', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hh48u9scic0nITGtzi9b6rJeAtT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('703', 'Ileana D''Cruz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xoKp6IDot9vG4yB6EtoByzRYlik.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('704', 'Jisshu Sengupta', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6Ha4p2iQOHpnKC1uB4NKJ53kHRi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('705', 'Vidya Balan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/m4bnX5VQs2DfvQsLmfbKbBxUkC9.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('706', 'Parambrata Chatterjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/f0vKFvgiyBvdgiXOFKpnnb6AfbG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('707', 'Saswata Chatterjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cVJVLDy7BNzIbFMcJBPOWeN0Kb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('708', 'Kharaj Mukherjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gvRKdSuaVHY33NFSgGWNVTzLyWU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('709', 'Konkona Sen Sharma', NULL, NULL, 'https://image.tmdb.org/t/p/w500/i538HToMEGR6J2OVmOGX3GfWcQC.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('710', 'Neeraj Kabi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2LgLKonM6di8yBPaCkm809NsBDi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('711', 'Prakash Belawadi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bECb7W5XUSFVOgN0z9Ob1ludIha.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('712', 'Sohum Shah', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5B7hSdq9hWEICHVxZtiL2ekwpzx.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('713', 'Vicky Kaushal', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hKSa4DWEAD7DYhABYGwjPmxdpAY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('714', 'Paresh Rawal', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xFVHMvDC8s4Ab2sLXrdVxMxZ33b.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('715', 'Yami Gautam Dhar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wQwYuofypdW7JnglmyFbeWKu33j.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('716', 'Mohit Raina', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mPQ68Zweqt8HC6tI9tQ8i3KW3g9.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('717', 'Kirti Kulhari', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5jm5YN7QGKCjgHYFQOFySIZ1Od3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('887', 'P N Sunny', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aIIidOtvFKEG6fIBMez7gogixTK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('888', 'Joji Mundakayam', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zmAObRaLUJqNYp85R8KJnMKMYGh.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('889', 'Unnimaya Prasad', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8t3hx3ZAMNnBPW9hmGb1bskel1O.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('890', 'Nimisha Sajayan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/r1tiqFWXlWDFlZx966yOeBYs2qY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('891', 'Suraj Venjaramoodu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2FUs0wmR3eHBd8g4GVbCmhkUzeI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('892', 'Ajitha V M', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('893', 'T. Suresh Babu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tqbLcsKV5MAskEcMxuLrRNBv199.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('894', 'Ramadevi Kannanchery', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eiepbWa4FUy1EMWi82MpaTFfCcl.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('895', 'Vivek Oberoi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/60T3Q8CsxF4kF6RIHZ1yis2Q0wA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('896', 'Tovino Thomas', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5JjhHzqPIowouatvKEpzwb9bGRO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('897', 'Indrajith Sukumaran', NULL, NULL, 'https://image.tmdb.org/t/p/w500/32YxjXVmgkPCVKUQAkNqWUGbBIl.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('898', 'Kanu Bannerjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4Si1KHQMsgIlmRtxoMualY6Iazv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('899', 'Karuna Banerjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pm4DcNLgkzzuHO53mi1BEuYnliv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('900', 'Subir Banerjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ta2slxvbMeVGgIgDjmA7p9ZCBqR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('901', 'Runki Banerjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/stIqJonoZE6oeHpWsc5vFHrLHlw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('902', 'Uma Dasgupta', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nVjTm0b1pt1eU2mVHgGKaBLRrLj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('903', 'Pinaki Sengupta', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6MkmjUtm6aMF8s4WBzN7jvLRgCQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('904', 'Smaran Ghosal', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gL1X2iFscjA3ARrOFfd7OMrHeUT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('905', 'Ramani Ranjan Sengupta', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('906', 'Soumitra Chatterjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pjomXVYzHd62IuduDc9UVS82sBb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('907', 'Sharmila Tagore', NULL, NULL, 'https://image.tmdb.org/t/p/w500/m2MFSVdx4aKVoLRFPJoO5u0FMon.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('908', 'Alok Chakravarty', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('909', 'Swapan Mukherjee', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('910', 'Sefalika Devi', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('911', 'Madhabi Mukherjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nqjJEBXvhA5E4bivtrcWP3berAv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('912', 'Shailen Mukherjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vUZQgd8X3UGOSYJBcmPI2fLtUCf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('913', 'Shyamal Ghoshal', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cX0HoZXLjHrbCaA9Y7NTBPpiKMw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('914', 'Gitali Roy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zY6mcMMpEQxrrBRFm18twXsalLX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('915', 'Uttam Kumar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pabRzgGYH6aWD0X0JRD6DPrd3YB.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('916', 'Bireswar Sen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9yKjTl11VlpgSdrXzgqklhNXY6u.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('917', 'Kamu Mukherjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2dCO3gORxiiaJtnUxVQBO8vUORh.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('918', 'Susmita Mukherjee', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('919', 'Santosh Dutta', NULL, NULL, 'https://image.tmdb.org/t/p/w500/txW9awMmcHrgs5kfEddOON5Ur7A.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('920', 'Siddhartha Chatterjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rVNKD6ggL8hE92SYq5O7mR0KNzw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('921', 'Kushal Chakraborty', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('922', 'Tapan Chatterjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/l0yao6b415pxQXpXfD02l6c9qWR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('923', 'Rabi Ghosh', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zDBWVAmAV0KbeOZ5JjKC4reQBaE.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('924', 'Harindranath Chattopadhyay', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qxudXN3d4GisrcitZ7l10JyYIt1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('925', 'Ajoy Bandyopadhyay', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yqE5bVUccidVCSZFnNxVGWuDj9p.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('926', 'Rinku Rajguru', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tCF3MBCmpiFN4ftF7PDzfzNGUEu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('927', 'Akash Thosar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8yNhmEagtRnDIEg07r8CahQy3PU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('928', 'Tanaji Galgunde', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kcI0y5prqtgdo2EpvAFJWB5LxoL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('929', 'Anuja Mule', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('930', 'Suraj Pawar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ujJgBLvsRUEspEk0yWXh9hKi7px.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('931', 'Kohinoor Akhter Suchanda', NULL, NULL, 'https://image.tmdb.org/t/p/w500/uQ7uDyrNNWesSzdhvQzFrM2WSp4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('932', 'Abdur Razzak', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qsHlsvj44C154QNAIBy7hp2V7Ci.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('933', 'Rosy Afsary', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fWxsk6TTTdRVZiWj97vkjNIBQtA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('934', 'Shaukat Akbar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5NQ7gIkjyjz3Luh2QcHuddWeOWq.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('935', 'Rawshan Zamil', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6LzLAQ3aKWQCqEqNO7gBUxCzjyU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('936', 'Raisul Islam Asad', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xKocsyZO7H6GEb0N4Zm5SKxCXKs.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('937', 'Suborna Mustafa', NULL, NULL, 'https://image.tmdb.org/t/p/w500/faBHriQKPaeyAxgLhI274HjevHi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('938', 'Nasiruddin Yousuff', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('939', 'Tariq Anam Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hHKkmaNQtvSV3cNeBpm9wHcTn55.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('940', 'Syed Hasan Imam', NULL, NULL, 'https://image.tmdb.org/t/p/w500/haZHNWNkPAJbjay6w5ja38qvArH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('941', 'Ilias Kanchan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8qWyYqP4H81YyfBP2iTJX83OGGI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('942', 'Anju Ghosh', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('943', 'Abbas', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('944', 'Anamika', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('945', 'Dildar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vi7yvn89DwbS0gEvA8ZaGEpBsWj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('946', 'Shabana', NULL, NULL, 'https://image.tmdb.org/t/p/w500/f789HK8zQu8F3bgkBCwWgq1K9q7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('947', 'A.T.M. Shamsuzzaman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fv34EvE9WsVITIGr9hedpD8hzBY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('948', 'Munira Yusuf Memi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3QuCNkRXv12yxyDwn9PIulQSdfQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('949', 'Mehbooba Mahnoor Chandni', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fBgPyphNRJQVOgBgGvt4AZaCTB4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('950', 'Aly Zaker ', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dgiLGF9vAdg2fIqQmCw6eRSGRz7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('951', 'Amirul Haque Chowdhury', NULL, NULL, 'https://image.tmdb.org/t/p/w500/97xDqT2TKKaNN8Ni1Aa7s4H4ARW.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('952', 'Nurul Islam Bablu', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('953', 'Russell Farazi', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('954', 'Jayanto Chattopadhyay', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1YLSDO84dJazHEHpMyT6FclWqt1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('955', 'Rokeya Prachy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fL78qrrJ3eGIWSmZzunUS0aYAMx.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('956', 'Soaeb Islam', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('957', 'Riaz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eSErLKimeBiLD7Vkv6AWAmbcWxp.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('958', 'Meher Afroz Shaon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vd4ttri5vFllDaYlqVE8v9Stll6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('959', 'Shadhin Khasru', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8b0CZtMr636tLSa1zZzo7fYI3bE.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('960', 'Ahmed Rubel', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ivEyuJa98tu5d5hSaBwlPwGDuxH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('961', 'Monir Khan Shimul', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('962', 'Chanchal Chowdhury', NULL, NULL, 'https://image.tmdb.org/t/p/w500/46ebiphxjeUP4T1JCGp6G4DAyQL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('963', 'Farhana Mili', NULL, NULL, 'https://image.tmdb.org/t/p/w500/p6Axcs1EwrgSYGA24y6N0udaIwQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('964', 'Mamunur Rashid', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vX1qznTb67f3bJa3RZ6mO7aLWlu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('965', 'Shirin Alam', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bJnuy1pxNasnj4cCMtKpAJrFLC.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('966', 'Fazlur Rahman Babu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mQsL3mzv4IeJhoj6q4QUTjsTlHM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('967', 'Nusrat Imrose Tisha', NULL, NULL, 'https://image.tmdb.org/t/p/w500/v5gbJBs0vTH2x1MHsVXwr30qf48.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('968', 'Mosharraf Karim', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6cGP2k6wblQqwyfGdPWyFDWr0wT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('969', 'Rashed Uddin Ahmed Topu', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('970', 'Abul Hayat', NULL, NULL, 'https://image.tmdb.org/t/p/w500/k4gvcB31puk2I05kDlsErszxeOf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('971', 'Shuveccha Haque', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('972', 'Zanyar Adami', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('973', 'Taher Adami', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('974', 'Kazi Shahir Huda Rumi', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('975', 'Imam Lee', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('976', 'Masuma Rahman Nabila', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rxMuUs11oWqwQCewR7oN5w860Jl.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('977', 'Partha Barua', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bNpFLd8GCGtbhadkTg89chHgRlz.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('978', 'Lutfur Rahman George', NULL, NULL, 'https://image.tmdb.org/t/p/w500/sSVW9aBUKWoN7rNzI7A7i4Kzljc.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('979', 'Gousul Alam Shaon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gkG0ISGFN2e5Zqj690uHN4RMGzs.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('980', 'Arifin Shuvoo', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4GRh5RiWA6RMKvb7oUodiPtgvX8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('981', 'Mahiya Mahi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8Ohl18ACGJVSslUkUsbp1qzKAJT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('982', 'ABM Sumon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bC7mqhqlNgnDuybqiR4OV93TZQG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('983', 'Quazi Nawshaba Ahmed', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8yza4B1o1LVEwoTj9ceZf5TOKI7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('984', 'Shatabdi Wadud', NULL, NULL, 'https://image.tmdb.org/t/p/w500/uezypVSHHDNoi3joJyukjwMhBZK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('985', 'Jaya Ahsan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6rQ5XEIG9wsBiI025blQ3aC8ZJG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('986', 'Animesh Aich', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eOHglIyAcST0hWPPiaTvtk2M6x4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('987', 'Iresh Zaker', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vx4WLoVlVEaCVclQdKteMYCHo2z.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('988', 'Sabnam Faria', NULL, NULL, 'https://image.tmdb.org/t/p/w500/56cqOpXl750AGjmnr4UX7bJsuEs.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('989', 'Siam Ahmed', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4gSLuSAkUMnjv0nRRgUjOGSo2YU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('990', 'Yashpal Sharma', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hYDZkMl6u3rM2cASabpHgrvA0mf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('991', 'Reekita Nondine Shimu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/sXVihTwMJ9s240lpqGdyNSkV5kF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('992', 'Novera Rahman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2MLUqW3TgRe0fTHe0FvpKNVKysU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('993', 'Parvin Paru', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('994', 'Mayabi Rahman', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('995', 'Shahana Goswami', NULL, NULL, 'https://image.tmdb.org/t/p/w500/huexJWjPKR940RPiUAtXyzkx6Jf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('996', 'Sunerah Binte Kamal', NULL, NULL, 'https://image.tmdb.org/t/p/w500/L111ffXC7xn0gRB8auzMiTGdrt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('997', 'Sariful Razz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nRlFXqXAfG4yGYvSxZ9OqoXahuB.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('998', 'Sayed Babu', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('999', 'Josefine Lindegaard', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ffOtFSrTUclF44jftJvBVGb4HVL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1000', 'Tommy Hindley', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1001', 'Azmeri Haque Badhon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/chH09tG9J8ZhOm8XM21CgO0uyaq.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1002', 'Afia Jahin Jaima', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1003', 'Kazi Sami Hassan', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1004', 'Afia Tabassum Borno', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1005', 'Zopari Lushai', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1006', 'Sania Halifa', NULL, NULL, 'https://image.tmdb.org/t/p/w500/n6XQbAG8uxk2Kej6HXfjHxfMW6u.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1007', 'Oumou Sangaré', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cNKAmc8aZIS6qnIdMmur8xgn1Qy.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1008', 'Titouan Gerbier', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4HFCb8vi9U2IP9B3PePrE0nWDYL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1009', 'Yseult', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rlFU2xuCozaUCEniBZd4C3sguTy.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1010', 'Thomas Pesquet', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nEo0X12EqmyKM5EyXjCG92xj0WB.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1011', 'Bidya Sinha Saha Mim', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hNYH8zcMAfOAuHMb25M23FxxNla.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1012', 'Yash Rohan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/87a7L2isCo8qqNkm5unzzJzLbL1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1013', 'Shahiduzzaman Selim', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2O6yfkpnBMxp1Q5CS649N310KPf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1014', 'Rosey Siddiqui', NULL, NULL, 'https://image.tmdb.org/t/p/w500/Alj882FHghEZnuLVw1syngQnMBI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1015', 'Intekhab Dinar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/stdfywGwXON2MqaCIWRBvnOlNiJ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1016', 'Sumit Sen Gupta', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1017', 'Shakib Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pmJvt5SBS1AwJqMSx6Ix8VtdKqQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1018', 'Idhika Paul', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9ESB0o596aFeSmAtsQieuuVGqXw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1019', 'Kazi Hayat', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kd4VPx2StCVzBWmrCD5e2luDqWM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1031', 'Juno Temple', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1032', 'Tracy Morgan', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('1033', 'Nate Torrence', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('718', 'Taapsee Pannu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/43e24aeOC8AZITo6ShaKKG9aV0Y.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('719', 'Andrea Tariang', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mbXG4wCAISoPel38NdIfBrMQ9Ix.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('720', 'Angad Bedi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ejv7eALY9SMa39aKuQdG7frlKtm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('721', 'Sanjay Mishra', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4MGKohKGU4v9SoXcQKCcC4e4Bpi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('722', 'Shweta Tripathi Sharma', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xZ0pk5qKzfK1oB54Mmfo1lUSSEu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('723', 'Pankaj Tripathi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/f3Vxz0QB7PHeyPcXrfJX14Xkxnu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('724', 'Rajkummar Rao', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ttBY7Y8x4NCpXfGS9Tc1NN8ISos.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('725', 'Anjali Patil', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tK8kdrWhm9hhTigWupWV7n6OmKG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('726', 'Raghubir Yadav', NULL, NULL, 'https://image.tmdb.org/t/p/w500/khyp4vnuGKVxrtszyB7kSf3vuzw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('727', 'Mukesh Prajapati', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('728', 'Mohammad Samad', NULL, NULL, 'https://image.tmdb.org/t/p/w500/re9EbYoUrKVj38nNoet25vAxTOr.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('729', 'Harsh K.', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('730', 'Jyoti Malshe', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hrraERT7xvfhlSf6RoPvowhyu53.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('731', 'Dhundiraj Prabhakar Jogalekar', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('732', 'Shraddha Kapoor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tFx6DRETklfkFIUu5Sl5TCN1gD9.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('733', 'Aparshakti Khurana', NULL, NULL, 'https://image.tmdb.org/t/p/w500/w7OEkPAaweO1JU105Qqvg073yW8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('734', 'Abhishek Banerjee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cfyRkFBFfodBbNKbsTc8eG9YtVj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('735', 'Salman Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/n7pKtccmf2jVOz8Qn90q2ThqLge.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('736', 'Harshaali Malthotra', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2DoOTtR1iDn3AjofqMVLbTqqgPU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('737', 'Sharat Saxena', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ArW6nQ23bjVfbcFmNVl4W9zpd7X.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('738', 'Gayatri Joshi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/j7htn5mcWPP4qWoV1NQ3DLkmJlv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('739', 'Kishori Ballal', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('740', 'Smit Sheth', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('741', 'Lekh Tandon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5d5vycLFTHtk58N8O0I3leb6slG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('742', 'Nargis Fakhri', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nFwsS7KrNYvPGamYCFPNWewAsYh.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('743', 'Shammi Kapoor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qMv1oc2ZH6GKZ9b7BPtLfP6Y1KA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('744', 'Aditi Rao Hydari', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iVbsdPXzs4CjlG98qIxG2lsQl31.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('745', 'Preity Zinta', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qY4GG9zj4JhgoiBaHhT5FIGeHu3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('746', 'Saif Ali Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/85uKiFDEcIqzLh0GwqYvecXw4uA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('747', 'Jaya Bachchan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gXmIdkOhJN7pa8XDR7KQJXgtXni.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('748', 'Sushma Seth', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1UqCt8kfYWfkrWNfcWp4nO8XWcz.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('749', 'Aishwarya Rai Bachchan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/59YeZ2zAoBfl3bnloriMyQkgwOK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('750', 'Madhuri Dixit', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gxQjVzLxpxiu5gncrmtGiAaULUi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('751', 'Jackie Shroff', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1UNJypgEyuihUW2avLLVYj76jie.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('752', 'Smita Jaykar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5YpJqn2u69d9MaEkn0ucD2tbz4x.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('753', 'Deepika Padukone', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rzvvBQ0r6oiqDdzcsdTRB7jN4Rx.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('754', 'Nikitin Dheer', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gAHNWVtStTGsqf2uxCegxvn6ILe.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('755', 'Sathyaraj', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lnlBZ7V3K3Z3OIsjCd0zkKx26L3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('756', 'Mukesh Tiwari', NULL, NULL, 'https://image.tmdb.org/t/p/w500/37GTjltEJHpi1lQmLmHKJYTpxjj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('757', 'Shahid Kapoor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/q5jqLRioZgIVjXpKS8XHx27ScDQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('758', 'Jim Sarbh', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lJPX2ehRqqtrJOqx5PS9dkSAw7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('759', 'Aayam Mehta', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qEBejJquDOqnDQbPmUYG7jZwN3J.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('760', 'Dilip Kumar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4qnST3lxsD0kPHCbxfDgmcBDSuC.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('761', 'Prithviraj Kapoor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/g8GvSAZJULFTRfGjRp8bcxxi3MB.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('762', 'Madhubala', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fXNA5aCPFClxmiRb3h7QH0OkuQJ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('763', 'Durga Khote', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hyQIVmAkauqtZGuiHOxv0ggYU5B.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('764', 'Nigar Sultana', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1p3NbZOKwZiYE5HhbDxkJgSRxyi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('765', 'Kamal Haasan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/17zscZgz4wOlGDd3Gziw4YbI3G.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('766', 'Saranya Ponvannan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iFKB2AQi0iL78HykQlaSFLxErfA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('767', 'Karthika', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7jDqTt20zIzaP39IF8hsNm33q6W.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('768', 'Janagaraj', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tYtzehaD4QhVYWG5gadcEFIAON1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('769', 'Delhi Ganesh', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8oMzQRumoUs5a6iStcK1B3znY1D.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('770', 'Rajinikanth', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cQBcrXqcQPfXOQfNfgO3slJM2xi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('771', 'Nagma', NULL, NULL, 'https://image.tmdb.org/t/p/w500/osQbepU8ejfIaeONvAlqsGVCOeC.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('772', 'Raghuvaran', NULL, NULL, 'https://image.tmdb.org/t/p/w500/z6IJ61kEaU6cjBHVX2eqxL2nnMx.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('773', 'Devan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/TSAMYfaw3yWAXWO3cuqehIkYbO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('774', 'Fahadh Faasil', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wmkwZWFHqMptqdt4HacMIAe8OBP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('775', 'Vijay Sethupathi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/a3HWdfCAbplrvoMNEJCjnkbqqOo.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('776', 'Narain', NULL, NULL, 'https://image.tmdb.org/t/p/w500/d0ApUGeFuGXpBkODIc6eLbBkb7B.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('777', 'Chemban Vinod Jose', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4bCAqhHMcPeoI41Emi4BBSXwZaj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('778', 'Cheng Qimeng', NULL, NULL, 'https://image.tmdb.org/t/p/w500/uO0vZ7dk8ddi7jn9eKfVviN8e0n.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('779', 'Chen Guoliang', NULL, NULL, 'https://image.tmdb.org/t/p/w500/g0YkestYQSQPpo4clMsmMb77cuA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('780', 'Shi Xuanru', NULL, NULL, 'https://image.tmdb.org/t/p/w500/z2Q4hvBMZEVC7GLCvj5vjMOfopF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('781', 'Xu Zhanwei', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hGxdoSir6nKbafgEH2zzn8vtaJ1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('782', 'Zhou Luoyi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qNsn9hDqvIQSehcOgFgvYlMnaO9.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('783', 'Karthi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ycxl56NbjNkJZkYbUMdwGdnBIg7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('784', 'Arjun Das', NULL, NULL, 'https://image.tmdb.org/t/p/w500/20RDzfTjpfRHxLYBfnIYXs7vcri.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('785', 'Harish Uthaman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eR3Ua6CxacxPnfUijasCEKhNqAt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('786', 'George Mariyan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/izpHGWpHeMeOV7mXlhF19Hu7IER.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('787', 'Shraddha Srinath', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fzna7CNrtggE9sJLWWOPCHVdCmD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('788', 'Kathir', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cQNlW5ztPIANrUNRos81cxZuZe5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('789', 'Varalaxmi Sarathkumar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vudH16iDpzft1uWIMMgcCRxBTXa.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('790', 'Trisha Krishnan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8YkgaUlTshiDWHymBOEXZ948Yyn.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('791', 'Aditya Baskar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ss57yU8ksFCvmpL8q3IFbvpP7se.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('792', 'Gouri G Kishan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mYfNk1j2yDFNcHCJ3WHHHz39QxI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('793', 'Devadarshini', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gSq4nM6z82LfI4yjL116P1RDkb0.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('794', 'Samantha Ruth Prabhu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/FFGYlhLQK7FWzPLtmOb1QHTDAh.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('795', 'Ramya Krishnan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7C1bj7z3XhqxjDIGoCs6MFJdSVa.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('796', 'Mysskin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2g65eG5FBh9oOMAhxpfk5T6um6A.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('797', 'Suriya', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hIFXv3gIjlNS78gJmaguEOxvfPH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('798', 'Lijomol Jose', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vXFBgF6NMON7L4RzZ6B35lOVYOu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('799', 'Baby Joshika Maya', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('800', 'Manikandan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/x54nrbLPVxUaStUt5I2om0WuE6j.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('801', 'Rajisha Vijayan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/u5Oq0XHQeHeZLg0NbPZCyCo3Uc6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('802', 'Aparna Balamurali', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yF9WcexaxgPWuP7ciVEMZbN3lLI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('803', 'Mohan Babu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zwqcXtnk0ju0nhuhvZXSLL2nLIy.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('804', 'Urvashi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/A6kHkXIhzL2LHIi78kNROdud7Mw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('805', 'Dhanush', NULL, NULL, 'https://image.tmdb.org/t/p/w500/34gv8DThQCh74oZQZe5zoDnaZrw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('806', 'Manju Warrier', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7u1WgUHnwIW9mtL6aTdo1cRXmCM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('807', 'Ken Karunaas', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3f6I1GD1yKg9raFBfKCKPP3w7v4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('808', 'Teejay', NULL, NULL, 'https://image.tmdb.org/t/p/w500/a8mdbaSzPEEH0q0J7twCOKzfYWe.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('809', 'Pasupathy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/luiNwyZPi2snUB7mA4MTyQ1tvU3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('810', 'Anandhi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2pGgJ8TowhQfFG6So3pdbN6QCXT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('811', 'Yogi Babu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4UMOPd8NqGfKp19VQHsnIzlSRUl.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('812', 'G. Marimuthu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gDBqLLiwYqYtKdhHowX7ppCmko8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('813', 'Lijeesh', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('814', 'V R Dinesh', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yc1PWTXrJEisKpb9OGK5J6I8LMP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('815', 'Samuthirakani', NULL, NULL, 'https://image.tmdb.org/t/p/w500/z8mU71yAUfVLgKWHorsTIsyQwnt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('816', 'Aadukalam Murugadoss', NULL, NULL, 'https://image.tmdb.org/t/p/w500/q3y0dkbyEHZisNrlZNmtZzZzb9R.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('817', 'Kishore', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qDKUEHZRsVgbXKJjuziUnZcOC1L.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('818', 'Sai Dhanshika', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5rs0yfqpqlIIndCmqa1CbCXGzgq.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('819', 'Winston Chao', NULL, NULL, 'https://image.tmdb.org/t/p/w500/c5LTdq5lsDzIxfu2a6a4jZQe3nK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('820', 'Danny Denzongpa', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xDNLtgG8iDXxNRvSDjpuNSNfKvX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('821', 'Santhanam', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6OoqLm0jzC1Ko6jMGdIJrVWM9nk.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('822', 'Karunas', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dnh00MeOyiWFQ21l5az3UVJ5rhp.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('823', 'Prabhas', NULL, NULL, 'https://image.tmdb.org/t/p/w500/u6RVP8ukgLaymeoi5VmX0JRAcCn.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('824', 'Rana Daggubati', NULL, NULL, 'https://image.tmdb.org/t/p/w500/q0Rw0e9RogMD0zJ0Heq0GotDYoy.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('825', 'Tamannaah Bhatia', NULL, NULL, 'https://image.tmdb.org/t/p/w500/t4WYoKiFAyO1Rhjv7O03EKmJHp4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('826', 'Anushka Shetty', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zpe6Es8kdNOXuPdXiJvqxzsmN6z.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('827', 'Nassar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/p3I0tSQY3C5qZW3NzFfbpjKPNL6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('828', 'N.T. Rama Rao Jr.', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5ycQgZ3SPUa12bq0yn1jpToBq9X.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('829', 'Ram Charan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/twGqYUCR0Yh33j3TcgRTZRBRhTd.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('830', 'Olivia Morris', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iAzUTXzFWwEkRx6Ygudqnx4DmtW.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('831', 'Ray Stevenson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9QCVNDgTgDEbGsa6w3JuECEPuQz.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('832', 'Alison Doody', NULL, NULL, 'https://image.tmdb.org/t/p/w500/q5CpMFAjLP40JHgwS6qWku6arSC.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('833', 'Vijay Deverakonda', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8oVIWyIoFUal8SJFnmCUtkkm1HP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('834', 'Shalini Pandey', NULL, NULL, 'https://image.tmdb.org/t/p/w500/x0VLQqGuQocLALiauiZV2wge3OI.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('835', 'Rahul Ramakrishna', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jsRbEXcUgR8zniBb3UTGOqrtxV9.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('836', 'Kamal Kamaraju', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dzRe0pHRcBHTKJCGcMFjPJ0K8Fp.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('837', 'Kanchana', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5MIFRK08ooRWugaZbhDKoWilmx6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('838', 'Aadhi Pinisetty', NULL, NULL, 'https://image.tmdb.org/t/p/w500/m5HrEYFIPaO73RCGLrPbpoqKRxt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('839', 'Jagapati Babu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bm72k6FmDxhxtZsl1xvxoz88Hkm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('840', 'Prakash Raj', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dJvFZOXmZdkYCOUcKTXQAhBcAoH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('841', 'Allu Arjun', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wHr3bKhYpiDiYVMZLZqebeauEVw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('842', 'Rashmika Mandanna', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lj16BGfdqygHF8PZVt2KO8GUXn1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('843', 'Jagadeesh Bandari', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cntovFhpWby0XJdMszCJCTrLk2g.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('844', 'Sunil Varma', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2ueRNLlbB8jaivO6yb7zfIlFhh7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('845', 'Pooja Hegde', NULL, NULL, 'https://image.tmdb.org/t/p/w500/t09lf8vem5MRk3KaALcdgehreXg.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('846', 'Murali Sharma', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8m4L7L9lK4Z2YK4Jg97pMbA0Le5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('847', 'Jayaram', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cc1SfVFctuYH353NgxXNBoAFX2d.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('848', 'Sushanth', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mN2TjZ3r5HIzMd67ObfxqpuRsqC.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('849', 'Kichcha Sudeepa', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8c5TYgGwbkcQkvC3ZlTU41OfYBN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('850', 'Nani', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jfOH4sUWs3VXuGUlo0VLMYNRBQ4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('851', 'Adithya Menon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5cmnhtj6npxjKQ8SwqopNfnHBYD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('852', 'Thagubothu Ramesh', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1D510DdV5c4CnWkzl13zIwAshZQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('853', 'Kajal Aggarwal', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wDzYjnDRNzyigCPBEwc9gf1hZ0Q.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('854', 'Dev Gill', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8Ta11Sdp6jCCbBEroTbnzoRxkvw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('855', 'Srihari', NULL, NULL, 'https://image.tmdb.org/t/p/w500/j0sMxR2Hq69iLCJKMcVHe4XuA17.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('856', 'Ronit Kamra', NULL, NULL, 'https://image.tmdb.org/t/p/w500/A90xgEIR02s85z5SzMlOUZ8z0YB.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('857', 'Harish Kalyan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6MnxqZm2knYxzm4VqW36WuAsoHW.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('858', 'Viswant Duddumpudi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ld4D4X3Xk0YhcWPeln89tOqHhUX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('859', 'Mohanlal', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wvoBULQimwguAGPOHZ8TDoy7jBJ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('860', 'Meena', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vMawuuT7VCeeJuBqpkm5siuWPij.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('861', 'Asha Sarath', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1Bun1cGDrA14XOr7iHPk3w5bzAX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('862', 'Kalabhavan Shajon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/AeiCzOHp0lo426jJGpwJ2CWwISy.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('863', 'Ansiba Hassan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dh55iMR1ablDwrowT9UaKxEgNHZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('864', 'Shane Nigam', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9KJqx2V9aRwcTuMh2FQmWj5HrAO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('865', 'Soubin Shahir', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eFMA1PFOpDtiJ5MlkSAMexvTPsl.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('866', 'Sreenath Bhasi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/oPsXUtaE0ZslhaGRdtww0ZpMRe7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('867', 'Mathew Thomas', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tynqqZ6LXz6TCDUWMG0xR4pNDkw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('868', 'Nivin Pauly', NULL, NULL, 'https://image.tmdb.org/t/p/w500/v8duBiKG9cfOy3RX1cW6JnrLuDe.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('869', 'Madonna Sebastian', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zQuhFAXtJNOkVbW3ZgsdGCi8IUv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('870', 'Sai Pallavi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qAPdGKUIUEzLibdgVCey7oKvvME.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('871', 'Anupama Parameswaran', NULL, NULL, 'https://image.tmdb.org/t/p/w500/k5rCSAtRv8LbKWX65clkPDN66aj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('872', 'Shabareesh Varma', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dTas79Xjvh1ynA0nZwuIwM1emPl.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('873', 'Nazriya Nazim', NULL, NULL, 'https://image.tmdb.org/t/p/w500/s4kqCkKKsrwrzzoTCNelyEHQYAE.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('874', 'Dulquer Salmaan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cKngC3leAnZRXTzg0N8N2DYn4HY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('875', 'Parvathy Thiruvothu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8PD546DV51Rwc2YkBsQw8iUCWTk.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('876', 'Anusree Nair', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gI1mBmAa3IPVqn1CSej0IEiPIws.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('877', 'Alencier Ley Lopez', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gWammRTzSJiyK9TROHWkoM9AqzS.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('878', 'Jaffer Idukki', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6kkv7LDD0NIGFTKZyrgGH5KGZpR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('879', 'Antony Varghese', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dKRa8ghSXw6J1OTcxMziZh3l1jb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('880', 'Sarath Kumar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mCHrGwh7rpelEaZE584sM1aQL1x.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('881', 'Tito Wilson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pynJaNvKviTTnzfQDJc6GyANyaF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('882', 'Bitto Davis', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hOgWT8Sr9gYDPA9MGVT1PpUqgvD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('883', 'Sinoj Varghese', NULL, NULL, 'https://image.tmdb.org/t/p/w500/l5xXBRo5kjKiEmcHQZgb0vnPVGo.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('884', 'Sabumon Abdusamad', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mI81jD0mykZh84e0k8X0TPb11Sj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('885', 'Santhy Balachandran', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gLpx6IM3Ifs6m1tytsc3yc4Lw90.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('886', 'Baburaj', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nuJ7GhTfuBrlGBWeMPIYr59O8kP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('393', 'Josh Gad', NULL, NULL, 'https://image.tmdb.org/t/p/w500/17iKlfWZBDTAucqjkhRKHr9xjIz.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('394', 'Santino Fontana', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3EtNGPVBN5bBamV817n43kFd4MB.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('395', 'Patton Oswalt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ljQvjbPmcIAl205Lb2Mu4CW8WO7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('396', 'Lou Romano', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1qOuqRzlp5BghzTkYSN3MsaEXgF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('397', 'Brian Dennehy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cg7CwS1vMJXCzZ0FUm4RbrjAJ2t.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('398', 'Peter Sohn', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8cQGViF2lXlcsAIvFUMWboXYXIu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('399', 'Miles Teller', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kDf3sW3USjEBDQ3Ua7lbwOfwty6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('400', 'J.K. Simmons', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ScmKoJ9eiSUOthAt1PDNLi8Fkw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('401', 'Melissa Benoist', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1F0fCPNhb5W0WyFe8Tszfbx1DEp.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('402', 'Austin Stowell', NULL, NULL, 'https://image.tmdb.org/t/p/w500/At09XQpVXnChgedNsxu4ceR5W9i.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('403', 'John Legend', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cCv0YBy2YFFWp9h3kvNPmwWwrCD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('404', 'Rosemarie DeWitt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/44sxIdGtYN24R14OmnZbCpcd8J8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('405', 'Finn Wittrock', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gwGMGTmli0uBF7eAhhXePWhYNFJ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('406', 'Jesse Eisenberg', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2ojZrkt5rdkUi857WSeCatxXdGS.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('407', 'Andrew Garfield', NULL, NULL, 'https://image.tmdb.org/t/p/w500/beO5YvbTjrr5yy8hW26KVDMSr35.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('408', 'Armie Hammer', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4Z5nLW2biRjqstDMKqSaeQYAesK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('409', 'Justin Timberlake', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6Yk5t9RwkdkAT8Qv45934Eez2CA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('410', 'Rooney Mara', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zT6UyHFHEQ9RcKykplWCycKBnoS.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('411', 'Dev Patel', NULL, NULL, 'https://image.tmdb.org/t/p/w500/byAo6xoleVSG5O9YpGrQ5YuCRX7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('412', 'Freida Pinto', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tub18dfDNMxlempVIuPXh8fmZVs.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('413', 'Madhur Mittal', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zUAMHowKCKkmx1rM9il5t8B7fxt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('414', 'Anil Kapoor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dwvnpiwg9m2zj0VHzlgzEotFl0G.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('415', 'Mahesh Manjrekar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4lFytre6m4SruIUpUIoyNjsMo7F.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('416', 'Tommy Lee Jones', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mCiZNRAzbnPojJEZwVZWLw9kzxR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('417', 'Woody Harrelson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/igxYDQBbTEdAqaJxaW6ffqswmUU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('418', 'Kelly Macdonald', NULL, NULL, 'https://image.tmdb.org/t/p/w500/k0yVocTnTMWlNdaeOO7YRViCdhO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('419', 'Daniel Day-Lewis', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3kNA9VcmymoEwT0btQ4bvMYxzcP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('420', 'Paul Dano', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gOD5bO0hKnzzJm7sJeGeEJjfBBw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('421', 'Kevin J. O''Connor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9ZO0QYkxjhThd8IVqSJw7gHyQ68.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('422', 'Ciarán Hinds', NULL, NULL, 'https://image.tmdb.org/t/p/w500/d8wLIX9VYgwXRGSp1gmUdUxmApv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('423', 'Dillon Freasier', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pTm23xcMB2oLu6Mc5LNXkrXVdla.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('424', 'Steve Carell', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cS7Cbyff6wFVfUGem497vy9LS7A.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('425', 'Marisa Tomei', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5NCCKQooVCQD36R6JL3a1hOeBVn.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('426', 'Rachel McAdams', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2DPh6KoNg0p57vvGc6N468zr3ct.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('427', 'Liev Schreiber', NULL, NULL, 'https://image.tmdb.org/t/p/w500/26G7QjSb5ZazgWb9XB2X6SwcILQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('428', 'John Slattery', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tm7g84OWD5gQRoyfG4hduBphP1j.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('429', 'Alan Alda', NULL, NULL, 'https://image.tmdb.org/t/p/w500/a5tOOHdsrKSabKwdzDOYqeTp446.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('430', 'Lucas Hedges', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8WP1uXUwm6Z1vzrMaIiKj89M6kX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('431', 'C.J. Wilson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4qoB1VuVQ7m3MtcL3iRIZiXN39H.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('432', 'Trevante Rhodes', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mx11nZOnT5nZbuzFi3TPVBQBZr.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('433', 'André Holland', NULL, NULL, 'https://image.tmdb.org/t/p/w500/riYqFOgYLYH4Hw8p2JYTw5lXGDE.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('434', 'Janelle Monáe', NULL, NULL, 'https://image.tmdb.org/t/p/w500/JqyNdRukkUGffIV0UaP25IqQHw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('435', 'Ashton Sanders', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2hMKOd6TLQWwLAS6ztUcZj8IZAC.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('436', 'Jharrel Jerome', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zH840Fv86TixTLVZKzPZJJacphd.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('437', 'Chiwetel Ejiofor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kq5DDnqqofoRI0t6ddtRlsJnNPT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('438', 'Benedict Cumberbatch', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wz3MRiMmoz6b5X3oSzMRC9nLxY1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('439', 'Linda Cardellini', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bcycvynDprC1rrhBNrnBjn5uOUd.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('440', 'Sebastian Maniscalco', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bvJQGVOI8fJ9Y4eAvYqoQcOAbHZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('441', 'Dimiter D. Marinov', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lZwHZ27xqsPsuswcxyx6uWSh5VP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('442', 'Colin Firth', NULL, NULL, 'https://image.tmdb.org/t/p/w500/z6wxnkqSTnzO1tcBui0ss7ehdm9.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('443', 'Timothy Spall', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pcR6t8kpAgGwIUo4UjlP5gyKkNA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('444', 'Alan Arkin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lTMMpkqL0G3WeFNfbtdP5COZEiX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('445', 'John Goodman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yyYqoyKHO7hE1zpgEV2XlqYWcNV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('446', 'Victor Garber', NULL, NULL, 'https://image.tmdb.org/t/p/w500/FdhXl8qxsKgj22Ip99SRM9jUx1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('447', 'Rami Malek', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8ykTeTRSYd2MKF5uLBvD93X5KMJ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('448', 'Gwilym Lee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bHSmjJLJyrg5Q0tC0W2FFreuOnO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('449', 'Ben Hardy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/b20ijbr2tbqlGvqZgkCpNZ5AYvS.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('450', 'Joseph Mazzello', NULL, NULL, 'https://image.tmdb.org/t/p/w500/44gsv7TlXOOKDGg5aRtqxZjM9ae.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('451', 'Lucy Boynton', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fs7aYUYzzNdilz4JY6wxvIedDIc.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('452', 'Lady Gaga', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9Y4Pz7AEXhB9qNar2tMsx5EVXML.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('453', 'Sam Elliott', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zE1fpXlIUo7fcujlVlGvHdDiCv6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('454', 'Andrew Dice Clay', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xwNn8mJrhww89P2pIVkWnaTlqHw.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('455', 'Rafi Gavron', NULL, NULL, 'https://image.tmdb.org/t/p/w500/avCWoO9fLwEhbT6cvu0TJcSj49g.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('456', 'Daniel Kaluuya', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jj2kZqJobjom36wlhlYhc38nTwN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('457', 'Allison Williams', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5Jy9HELKS1OYg7moRl8870OSfJq.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('458', 'Catherine Keener', NULL, NULL, 'https://image.tmdb.org/t/p/w500/n4CTwGszs6cwS1wJRlDQ5Mlh7Ex.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('459', 'Bradley Whitford', NULL, NULL, 'https://image.tmdb.org/t/p/w500/oeDv2qZWTxELLaNtOIoeG72leNY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('460', 'Caleb Landry Jones', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8M5lPHrERwAIfWK56RkH30FOjhV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('461', 'Winston Duke', NULL, NULL, 'https://image.tmdb.org/t/p/w500/MhBiZbryibwuoEtPL9Ns8pYHC1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('462', 'Elisabeth Moss', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vZDe22EtLtcHvPr28l4ZM0b7qjG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('463', 'Tim Heidecker', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mj9huol5uyggzejRYTEHPVztRQg.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('464', 'Shahadi Wright Joseph', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aOIwpf4CaXxzzBMowzKjJ9ieinu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('465', 'John Krasinski', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pmVGDb6Yl6OyFcHVGbu1EYNfyFK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('466', 'Millicent Simmonds', NULL, NULL, 'https://image.tmdb.org/t/p/w500/clNmG7JlsI5qZTVjYoXiGZ3Pvbq.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('467', 'Noah Jupe', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cBhJisZrIsZzamiUCVjOZODcqOK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('468', 'Cade Woodward', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6tXfrNe9ilHeAby6Eg5tNvq5MGY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('469', 'Alex Wolff', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7PMu5zFOEH7PqFDzrKThgKD4Ndf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('470', 'Gabriel Byrne', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9r9oDGENg92VYYFMkV4C09IUlrb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('471', 'Milly Shapiro', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5QVwZttyqVDl0M3AKwe0SDU8S5R.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('472', 'Ann Dowd', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zo44U71uiMNVW1HSiOa5F9MpqIq.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('473', 'Jaeden Martell', NULL, NULL, 'https://image.tmdb.org/t/p/w500/oR7ZJsOHMNFzM1HeugV4a4qCMSF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('474', 'Jeremy Ray Taylor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/czfmzjsDrGqIvDA3kkq62h9RCA1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('475', 'Sophia Lillis', NULL, NULL, 'https://image.tmdb.org/t/p/w500/AscFyjYymxGtBtIZf1TX98VSgrY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('476', 'Finn Wolfhard', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vgjd34eWfVL6GsLHwiwcAsjWLmo.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('477', 'Chosen Jacobs', NULL, NULL, 'https://image.tmdb.org/t/p/w500/y7Aho0JOSIyT6SH7nyhheRibPCf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('478', 'Vera Farmiga', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5Vs7huBmTKftwlsc2BPAntyaQYj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('479', 'Patrick Wilson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/oym6H2QD9esk4yABjCHaUoNAOa8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('480', 'Lili Taylor', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vWcMUi3QyvCr3QuFbjtwyPx7WtU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('481', 'Ron Livingston', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pr5CjWnkaf5WKTIYh8wtNufjmyb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('482', 'Hayley McFarland', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mapxc0eyuNFqj9IybLmMIofhuzF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('483', 'Zazie Beetz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ijrT4pvALvxU0gphea4YxDnDh6e.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('484', 'Frances Conroy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aJRQAkO24L6bH8qkkE5Iv1nA3gf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('485', 'Brett Cullen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4P6TsRcnr9MRbXlCdHitulGM5LT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('486', 'Hugh Jackman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/oX6CpXmnXCHLyqsa4NEed1DZAKx.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('487', 'Dafne Keen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/34BhddK5z2YHjfppOleezVrQ7Jt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('488', 'Patrick Stewart', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ufqtnLh3JJjPbEgxEag3MM5nZyv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('489', 'Elizabeth Rodriguez', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9f851DP7NHAOKvvlZdXxYigDYbl.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('490', 'Boyd Holbrook', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xmkpedcct3ey1d1HGDNsUMQPHcB.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('491', 'Chris Pratt', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cRH6HPAQ98PlOwwEvhYO4CM9lwu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('492', 'Zoe Saldaña', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vQBwmsSOAd0JDaEcZ5p43J9xzsY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('493', 'Vin Diesel', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nZdVry7lnUkE24PnXakok9okvL4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('494', 'Chadwick Boseman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nL16SKfyP1b7Hk6LsuWiqMfbdb8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('495', 'Danai Gurira', NULL, NULL, 'https://image.tmdb.org/t/p/w500/z7H7QeQvr24vskGlANQhG43vozQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('496', 'Benedict Wong', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yYfLyrC2CE6vBWSJfkpuVKL2POM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('497', 'Mads Mikkelsen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/AsX4bdvZ8UCayWTmAf9lAqOA8V7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('498', 'Tom Holland', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5OK84Wn1bIEIThFKcVoaN087mLj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('499', 'Jacob Batalon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/53YhaL4xw4Sb1ssoHkeSSBaO29c.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('500', 'Jon Favreau', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tnx7iMVydPQXGOoLsxXl84PXtbA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('501', 'Tom Cruise', NULL, NULL, 'https://image.tmdb.org/t/p/w500/maf8PhSvDCdEwjEMbYfGpojR5RP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('502', 'Jennifer Connelly', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wdmcJagSRJ65AuJ4IUCzuHAdvgy.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('503', 'Bashir Salahuddin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ZL5MRzjd6kWkvQXqh5mgPY1CKP.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('504', 'Jon Hamm', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mrXE5fZbEDPc7BEE5G21J6qrwzi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('505', 'Michelle Yeoh', NULL, NULL, 'https://image.tmdb.org/t/p/w500/i6fHvGt7Rb8oVyjjdQVV6vEHB94.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('506', 'Stephanie Hsu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/8gb3lfIHKQAGOQyeC4ynQPsCiHr.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('507', 'Ke Huy Quan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iestHyn7PLuVowj5Jaa1SGPboQ4.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('508', 'James Hong', NULL, NULL, 'https://image.tmdb.org/t/p/w500/v3lfw5aHOy0paOCx6WHiSnwzbH0.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('509', 'Jamie Lee Curtis', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eWKubKAAssRzmFwCZKh1mdYqGCH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('510', 'Robert Pattinson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3qZ09UE7lN6AtorfXFRYpEtSY93.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('511', 'Zoë Kravitz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/n0mhAgmY6eJQmA7kaugsTZEJgHo.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('512', 'Jeffrey Wright', NULL, NULL, 'https://image.tmdb.org/t/p/w500/quunS3w4QtALMDnvA0y81Y2pO9N.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('513', 'Colin Farrell', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5FdalJbrbZ5UCsED5rFrXpvbqJa.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('514', 'Michael Nyqvist', NULL, NULL, 'https://image.tmdb.org/t/p/w500/d9nGt8MloJwosRbGp10gaeHExcZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('515', 'Alfie Allen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aF3SyXNd2JfktnYkUvC1tsFHJDu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('516', 'Dean Winters', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zxgOZAYGxa2qmiZkJKGRIhwbGhG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('517', 'Ansel Elgort', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pbU6qz8eudly20UE6u9T7jUXTgT.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('518', 'Lily James', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2w8tMEdCxBXB44X05RQDC2Kvbap.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('519', 'Hubert Koundé', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nii46CtpR2AYPkl8fBKtbrffqQg.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('520', 'Saïd Taghmaoui', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kuxI08YpwQFGweIXK7TELknwexr.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('521', 'Abdel Ahmed Ghili', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zCBgVA0B1ywgIQsMCPIhfnE7C60.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('522', 'Solo', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ydu1Na06GXKjARkfbdv4ulG6z6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('523', 'Audrey Tautou', NULL, NULL, 'https://image.tmdb.org/t/p/w500/d1HVrV8zXy1FJVptmOCkHWG8Jf2.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('524', 'Mathieu Kassovitz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3FRBEdKKlxhvPWPt0jzgmSjeHwn.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('525', 'Rufus', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aC6rEJrBgCNjeG6vetJPBdgj5h3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('526', 'Serge Merlin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/90Kwb8hfORDXcEeA1lzikAubcQe.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('527', 'Jamel Debbouze', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aiqWSWbRJ6rrjxxVE6y2Xb3KdSp.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('528', 'Alexandre Rodrigues', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iExs5h6LeFmdR3kDtSS5xYU1Qgx.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('529', 'Leandro Firmino', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aEzWJgEzId04EP8C2UFQaF28WTW.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('530', 'Phellipe Haagensen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3dxy4unadLTAb6aUQUyX2r3AkE.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('531', 'Douglas Silva', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7C2ZoLBU0W2gwnGbNRbi1cyIU2h.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('532', 'Jonathan Haagensen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cha3GxI1MfbCjc973iUNKUvopQF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('533', 'Choi Min-sik', NULL, NULL, 'https://image.tmdb.org/t/p/w500/sd7gIA6nEkq6zumkDCfxSE0YSSV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('534', 'Yoo Ji-tae', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gGGV2gc0orgssYJ0Q9MSomdYo2I.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('535', 'Kang Hye-jung', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1MYnPxhU9GnhkitxVoWuR9kNiqu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('536', 'Kim Byeong-ok', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9A4pQUNIJsm1JbbamKNqz8ryOVM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('537', 'Ji Dae-han', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9aoOX8p2oxUAwOaT8jT6GWfjs01.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('538', 'Gong Yoo', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ocGoFb6TrK3uWGXt4WnuibUG1vD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('539', 'Kim Su-an', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hmPZhhoeUY89Rys6LrsjpTMeoEN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('540', 'Jung Yu-mi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pU8iBcZHhuc4kQe6HHZVcommefG.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('541', 'Don Lee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xqnARIEzfyr3BalhFBWHmCusLKH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('542', 'Emilio Echevarría', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dd97sd38NhiXlvfrL4ZpLi138Dk.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('543', 'Goya Toledo', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ygZpmXYB1fDSnpeJx1PadEQLgA5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('544', 'Álvaro Guerrero', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gqo0QF9a3MQpRI2o7GVl0c8gZdu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('545', 'Vanessa Bauche', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1WQaHygZ1AsRxDBcPmxL0fSLNri.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('546', 'Shelley Duvall', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zwscEWl7QLiOsfsvzGXFjAQCVp3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('547', 'Danny Lloyd', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5pEmugZ6m25RB0cXbL4t5D4kZAO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('548', 'Scatman Crothers', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ughfThqQuuoPLSsC9HfkxwX370w.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('549', 'Barry Nelson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fSrHmvOxZJbeKpNM0uWGvha1aK9.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('550', 'Diego Luna', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qwbjcyDN37OHiln4a6P4LP31o7F.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('551', 'Daniel Giménez Cacho', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4sM4fbDAyjDcEcxRqVWpUF35IrL.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('552', 'Diana Bracho', NULL, NULL, 'https://image.tmdb.org/t/p/w500/33QwkFoQj4CzTUCEJ9qbLVtfBHk.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('553', 'Martina Gedeck', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ju7H4RLIzfrcMg2e3SUAaA9fEc6.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('554', 'Ulrich Mühe', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kdqKmnaBDDT0cwTE2C3fKDJrF8D.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('555', 'Sebastian Koch', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3n3BP3FmuFinFokeGx0cHhM4XBH.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('556', 'Ulrich Tukur', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nP9iuQml65bHD0jINp0f4I7Fkce.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('557', 'Thomas Thieme', NULL, NULL, 'https://image.tmdb.org/t/p/w500/omWXGbeRR32MWuYhpnLOSqJ6xkO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('558', 'Franka Potente', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aU6f9UemZsTkqKEG4l77zf6masg.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('559', 'Moritz Bleibtreu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xg2F0OM9ZTLrEvaQsqFSiMH79WB.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('560', 'Herbert Knaup', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1QmgD5ce0cUEZ4Jk3HqdoxvlGrZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('561', 'Nina Petri', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pw6sA1kMJsJe8cSutLCJCFfZSX0.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('562', 'Armin Rohde', NULL, NULL, 'https://image.tmdb.org/t/p/w500/h1CuhGgADJFD9vw1IYFskJK9q9V.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('563', 'François Cluzet', NULL, NULL, 'https://image.tmdb.org/t/p/w500/f6PO7Lkrem1N4UmklxHro2k6Jto.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('564', 'Omar Sy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/Uuy6WuizieB4fOIGFp0gY90Yq2.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('565', 'Anne Le Ny', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eyvOUlmpllkSTRRT2mmGcUUrKZR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('566', 'Audrey Fleurot', NULL, NULL, 'https://image.tmdb.org/t/p/w500/83wsYI6oRWrtkcKr7ozobh1VWrm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('567', 'Joséphine de Meaux', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kpkTzxQTcVhaANLEtqX5TKZ9Njr.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('568', 'Payman Maadi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/96dWXnLoCI32jiSSnn2jweaAjBU.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('569', 'Leila Hatami', NULL, NULL, 'https://image.tmdb.org/t/p/w500/2ryc1fia5FJBACnUZSXh0muxrVO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('570', 'Shahab Hosseini', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ksZOIn0nTIQDiEeaDwT4lb7zZTF.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('571', 'Sareh Bayat', NULL, NULL, 'https://image.tmdb.org/t/p/w500/el6WyRhfKq5HztB0HZwQWjV6ITn.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('572', 'Sarina Farhadi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ppRlKN3lyMrjgsTbmp121DMBcUR.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('573', 'Yalitza Aparicio', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wiZEyqNTNkevCT768bKvvOJvCHb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('574', 'Marina de Tavira', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rGGjW1UnUL1Q4TGlfRL3W5yuyq1.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('575', 'Diego Cortina Autrey', NULL, NULL, 'https://image.tmdb.org/t/p/w500/sjk18uMlWDEW1SghHtYOckS2Bmm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('576', 'Carlos Peralta', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rCtVtycU3dG8Z3nWhi1XSsEbPN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('577', 'Marco Graf', NULL, NULL, 'https://image.tmdb.org/t/p/w500/na3AUeMwiN027NAb8gr4FfgBJJK.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('578', 'Kim Min-hee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zZ41nW0GJqesHB75hFP6qllPS9y.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('579', 'Kim Tae-ri', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gFofVUeVlIvBJMUv7maHQwWdfsk.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('580', 'Ha Jung-woo', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9KINm0XIwbt4Qql4oZX55krzKxg.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('581', 'Cho Jin-woong', NULL, NULL, 'https://image.tmdb.org/t/p/w500/r3o7eKsqVCQu0ppIY88d16VLCsj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('582', 'Kim Hae-sook', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dt5bmKeG7qbvDwHrxFZFxiGc9fZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('583', 'Kim Sang-kyung', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5VKIhf0ZVxqtrZfyMPbubZz3INr.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('584', 'Kim Roi-ha', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bGHnBUrBKk2ItXDZJrBDnBeQJvj.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('585', 'Song Jae-ho', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gLKek8JICZXq4YdJpOd3jECaLCA.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('586', 'Byun Hee-bong', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fV8BtRziGqUsBozd1G6lEwmW2b5.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('587', 'Toshirō Mifune', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cZ5ybA7cDA0EBMaM5jX2f7RNBVb.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('588', 'Machiko Kyō', NULL, NULL, 'https://image.tmdb.org/t/p/w500/neliTpXsuAfUj5CR5OGi2j5fCgg.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('589', 'Takashi Shimura', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ydyAm2vyBbEPZRICIMqqjDm0NM9.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('590', 'Masayuki Mori', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4HZFAdEGIOk7HxJjcdcxfL4k1x3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('591', 'Minoru Chiaki', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9E3efYEg8pxANdfVLqYGiX8zJE8.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('592', 'Yoshio Inaba', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5qIAqM5PegWTNq67qNofz78fb6U.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('593', 'Seiji Miyaguchi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mAGkZlsowKzgpvvi40mRLU4vA53.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('594', 'Haruo Tanaka', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eziah9QZcIs3SVPgTS3iuyUpiW3.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('595', 'Nobuo Kaneko', NULL, NULL, 'https://image.tmdb.org/t/p/w500/uKkx38oqe1VqAzVjpXslOPSTajW.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('596', 'Bokuzen Hidari', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kvISvHgKAAWVPOnDjgVHWOgSOaO.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('597', 'Miki Odagiri', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9pfgepQ89gE9wZyHLnMM3tMRV1Y.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('598', 'Philippe Noiret', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mWPa6A0JK3tfVRQDIzCQGEao19B.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('599', 'Jacques Perrin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lGbDfSdDgFg3QHgungWIDsV9uh7.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('600', 'Marco Leonardi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5VVhO9rPvRgKsZME2gZKtG9WgWD.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('601', 'Salvatore Cascio', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7t59ZGfLUv30DBgoUcqXXhK0t6Y.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('602', 'Agnese Nano', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gUbvX3dm8rIq58phY8jSl3oPgUe.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('603', 'Roberto Benigni', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ba1Sg02XxCphu6E1dWDMAH1GzeE.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('604', 'Nicoletta Braschi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9IeE3Iz9HXZVTrvhjSCKlR4FLxB.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('605', 'Giorgio Cantarini', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1tKZHpVTYcw8EP3naVTZFlrOkhQ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('606', 'Giustino Durano', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5VbG50qZNUnpx6UW7594RUlX7SZ.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('607', 'Sergio Bini Bustric', NULL, NULL, 'https://image.tmdb.org/t/p/w500/crnlLn1SxP2LqbsXNr8CQrvaiNc.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('608', 'Jean Gabin', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pmFuOVTQvYdgmN7cYOuyJHPfMRt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('609', 'Dita Parlo', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kbCBLwzBRgbb91mi5vjnnDWOzlM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('610', 'Pierre Fresnay', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wuwYnv65VbV3ALm7eHCwRFqP83p.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('611', 'Erich von Stroheim', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lUoSEdmX6Cl7lLUnV4ewLkVDnhY.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('612', 'Julien Carette', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9QD6WW8DPZDtHEO7d26EXu2C0nM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('613', 'Gunnar Björnstrand', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vy5Y0c1ACGCI6d4rVjmTM6HOqNN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('614', 'Bengt Ekerot', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4UxoMzIdE9PR4THNr3U2PL17veu.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('615', 'Nils Poppe', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qPXSktfOnVn2zlGFSoYUn8BQUhf.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('616', 'Bibi Andersson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6EGqmWOR3R3jv3IgrEZmCjTAVGv.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('617', 'Marcello Mastroianni', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bfLnFfNfMC73Q7WW90xQy2PvRZm.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('618', 'Claudia Cardinale', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gbTVdZGrOwteJ7qYSzyn8XpUk0H.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('619', 'Anouk Aimée', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rXkZZRfbBlGfcxQstQqeXX0GDZx.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('620', 'Sandra Milo', NULL, NULL, 'https://image.tmdb.org/t/p/w500/730Y68UaEtm9G34KvsNe7xbdXMi.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('621', 'Rossella Falk', NULL, NULL, 'https://image.tmdb.org/t/p/w500/30pEtkiH2drjkke3nfjjGYhouhN.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('622', 'Liv Ullmann', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7IJimLbXIOYpLAS4UaHcNYWRsJe.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('623', 'Margaretha Krook', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eIfMDQG8oaU2Vt5xbYt4vS6ftja.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('624', 'Jörgen Lindström', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yXsYjc6FvmcHgSJ5Uv4GJBnRBqX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('625', 'Gustav Fröhlich', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bkjDaorTT3LcOeTcQF1TDpBlHwt.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('626', 'Brigitte Helm', NULL, NULL, 'https://image.tmdb.org/t/p/w500/a7mwxoeF34BCxmteoHQSB1ENth0.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('627', 'Alfred Abel', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dGk5r64zQZVHplTwRDZGpNkoCjc.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('628', 'Rudolf Klein-Rogge', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fbP75fGfXFQlkf3Q5oHbJ4wjG1g.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('629', 'Theodor Loos', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4NYdHddN0cg4598XOsRXiFlwulg.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('630', 'Max Schreck', NULL, NULL, 'https://image.tmdb.org/t/p/w500/uKVNFFt6VA8R7pp7HIPJF4e5PfX.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('631', 'Gustav von Wangenheim', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5BQ07rsNY9z3IoN6sdwipoFoNWV.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('632', 'Greta Schröder', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vkwD2LVM2QRD2a6auvq1K6Zpwd0.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('633', 'Georg H. Schnell', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1uTps71tiRThDbvNqnyrCcH7IfM.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('634', 'Ruth Landshoff', NULL, NULL, 'https://image.tmdb.org/t/p/w500/C0i7fUARc4OZxYbNetwEJ9rhp0.jpg', NULL);
INSERT INTO "CINEHIVE"."ACTOR" VALUES ('635', 'Dharmendra', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aagrv7LIDWq0GxZelUPqubCg7sH.jpg', NULL);

-- ----------------------------
-- Table structure for ACTS_IN
-- ----------------------------
CREATE TABLE "CINEHIVE"."ACTS_IN" (
  "ACTOR_ID" NUMBER VISIBLE NOT NULL,
  "MOVIE_ID" NUMBER VISIBLE NOT NULL,
  "ROLE" VARCHAR2(150 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of ACTS_IN
-- ----------------------------
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('461', '118', 'Gabe Wilson / Abraham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('462', '118', 'Kitty Tyler / Dahlia');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('463', '118', 'Josh Tyler / Tex');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('464', '118', 'Zora Wilson / Umbrae');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('43', '119', 'Evelyn Abbott');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('465', '119', 'Lee Abbott');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('466', '119', 'Regan Abbott');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('467', '119', 'Marcus Abbott');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('468', '119', 'Beau Abbott');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('246', '120', 'Annie Graham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('469', '120', 'Peter Graham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('470', '120', 'Steve Graham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('471', '120', 'Charlie Graham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('472', '120', 'Joan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('473', '121', 'Bill Denbrough');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('459', '117', 'Dean Armitage');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('460', '117', 'Jeremy Armitage');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('25', '118', 'Adelaide Wilson / Red');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('474', '121', 'Ben Hanscom');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('475', '121', 'Beverly Marsh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('476', '121', 'Richie Tozier');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('477', '121', 'Mike Hanlon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('478', '122', 'Lorraine Warren');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('479', '122', 'Ed Warren');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('480', '122', 'Carolyn Perron');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('481', '122', 'Roger Perron');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('482', '122', 'Nancy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('16', '123', 'Arthur Fleck');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('209', '123', 'Murray Franklin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('483', '123', 'Sophie Dumond');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('484', '123', 'Penny Fleck');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('485', '123', 'Thomas Wayne');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('486', '124', 'Logan / X-24');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('487', '124', 'Laura');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('488', '124', 'Charles');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('489', '124', 'Gabriela');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('490', '124', 'Pierce');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('491', '125', 'Peter Quill');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('492', '125', 'Gamora');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('226', '125', 'Drax');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('493', '125', 'Groot (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('245', '125', 'Rocket (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('494', '126', 'T''Challa / Black Panther');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('22', '126', 'Erik Killmonger');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('25', '126', 'Nakia');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('495', '126', 'Okoye');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('75', '126', 'Everett K. Ross');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('438', '127', 'Dr. Stephen Strange');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('437', '127', 'Mordo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('426', '127', 'Dr. Christine Palmer');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('496', '127', 'Wong');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('497', '127', 'Kaecilius');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('498', '128', 'Peter Parker / Spider-Man');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('17', '128', 'MJ');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('438', '128', 'Doctor Strange');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('499', '128', 'Ned Leeds');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('500', '128', 'Happy Hogan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('501', '129', 'Capt. Pete ''Maverick'' Mitchell');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('399', '129', 'Lt. Bradley ''Rooster'' Bradshaw');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('502', '129', 'Penny Benjamin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('503', '129', 'Wo-1. Bernie ''Hondo'' Coleman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('504', '129', 'Adm. Beau ''Cyclone'' Simpson');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('505', '130', 'Evelyn Wang');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('506', '130', 'Joy Wang / Jobu Tupaki');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('507', '130', 'Waymond Wang');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('508', '130', 'Gong Gong');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('509', '130', 'Deirdre Beaubeirdre');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('510', '131', 'Bruce Wayne / The Batman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('511', '131', 'Selina Kyle');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('512', '131', 'Lt. James Gordon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('513', '131', 'Oz / The Penguin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('420', '131', 'The Riddler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('240', '132', 'John Wick');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('514', '132', 'Viggo Tarasov');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('515', '132', 'Iosef Tarasov');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('100', '132', 'Marcus');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('516', '132', 'Avi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('517', '133', 'Baby');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('282', '133', 'Doc');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('518', '133', 'Debora');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('504', '133', 'Buddy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('165', '133', 'Bats');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('374', '134', 'Vinz');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('519', '134', 'Hubert');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('520', '134', 'Saïd');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('521', '134', 'Abdel');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('522', '134', 'Santo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('523', '135', 'Amélie Poulain');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('524', '135', 'Nino Quincampoix');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('525', '135', 'Raphaël Poulain');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('526', '135', 'Raymond Dufayel');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('527', '135', 'Lucien');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('528', '136', 'Buscapé');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('529', '136', 'Zé Pequeno / Dadinho');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('530', '136', 'Bené');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('531', '136', 'Dadinho');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('532', '136', 'Cabeleira');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('533', '137', 'Oh Dae-su');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('534', '137', 'Lee Woo-jin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('535', '137', 'Mi-do');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('536', '137', 'Mr. Han');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('537', '137', 'No Joo-hwan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('538', '138', 'Seok-woo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('539', '138', 'Soo-ahn');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('540', '138', 'Sung-gyeong');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('541', '138', 'Sang-hwa');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('52', '138', 'Yeong-gook');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('542', '139', 'El Chivo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('350', '139', 'Octavio');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('543', '139', 'Valeria');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('544', '139', 'Daniel');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('545', '139', 'Susana');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('72', '140', 'Jack Torrance');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('546', '140', 'Wendy Torrance');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('547', '140', 'Danny');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('548', '140', 'Hallorann');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('549', '140', 'Ullman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('116', '141', 'Luisa Cortés');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('350', '141', 'Julio Zapata');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('550', '141', 'Tenoch Iturbide');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('551', '141', 'Narrator (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('552', '141', 'Silvia Allende de Iturbide');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('553', '142', 'Christa-Maria Sieland');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('554', '142', 'Gerd Wiesler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('555', '142', 'Georg Dreyman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('556', '142', 'Anton Grubitz');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('557', '142', 'Bruno Hempf');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('558', '143', 'Lola');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('559', '143', 'Manni');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('560', '143', 'Father');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('561', '143', 'Mrs. Hansen');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('562', '143', 'Mr. Schuster');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('563', '144', 'Philippe');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('564', '144', 'Driss');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('565', '144', 'Yvonne');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('566', '144', 'Magalie');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('567', '144', 'La DRH société de courses');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('568', '145', 'Nader');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('569', '145', 'Simin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('570', '145', 'Hojjat');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('571', '145', 'Razieh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('572', '145', 'Termeh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('573', '146', 'Cleo Gutiérrez');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('574', '146', 'Sofía');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('575', '146', 'Toño');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('576', '146', 'Paco');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('577', '146', 'Pepe');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('578', '147', 'Lady Hideko');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('579', '147', 'Sook-hee');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('580', '147', 'Count Fujiwara');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('581', '147', 'Uncle Kouzuki');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('582', '147', 'Ms. Sasaki');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('49', '148', 'Detective Park Doo-man');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('583', '148', 'Detective Seo Tae-yoon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('584', '148', 'Detective Cho Yong-koo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('585', '148', 'Sergeant Shin Dong-chul');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('586', '148', 'Sergeant Koo Hee-bong');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('587', '149', 'Tajômaru');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('588', '149', 'Masako');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('589', '149', 'Woodcutter');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('590', '149', 'Takehiro');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('591', '149', 'Priest');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('587', '150', 'Kikuchiyo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('589', '150', 'Kambei Shimada');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('592', '150', 'Gorobei Katayama');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('593', '150', 'Kyuzo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('591', '150', 'Heihachi Hayashida');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('589', '151', 'Kanji Watanabe');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('594', '151', 'Sakai');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('595', '151', 'Mitsuo, son of Kanji');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('596', '151', 'Ohara');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('597', '151', 'Toyo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('598', '152', 'Alfredo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('599', '152', 'Salvatore ''Totò'' Di Vita (adult)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('600', '152', 'Salvatore ''Totò'' Di Vita (teen)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('601', '152', 'Salvatore ''Totò'' Di Vita (child)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('602', '152', 'Elena Mendola (teen) / Elena''s daughter (in Director''s cut)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('603', '153', 'Guido');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('604', '153', 'Dora');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('605', '153', 'Giosué');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('606', '153', 'Zio');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('607', '153', 'Ferruccio');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('608', '154', 'Lieutenant Maréchal');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('609', '154', 'Elsa');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('610', '154', 'Captain de Boëldieu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('611', '154', 'Captain von Rauffenstein');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('612', '154', 'Cartier, the Vaudeville Performer');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('613', '155', 'Jöns');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('614', '155', 'Death');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('615', '155', 'Jof');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('124', '155', 'Antonius Block');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('616', '155', 'Mia');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('617', '156', 'Guido Anselmi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('618', '156', 'Claudia');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('619', '156', 'Luisa Anselmi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('620', '156', 'Carla');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('621', '156', 'Rossella');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('616', '157', 'Alma');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('622', '157', 'Elisabet Vogler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('623', '157', 'The Doctor');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('613', '157', 'Herr Vogler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('624', '157', 'Elisabet''s Son (uncredited)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('625', '158', 'Freder Fredersen');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('626', '158', 'Maria / The Machine Man');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('627', '158', 'Johann ''Joh'' Fredersen');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('628', '158', 'C.A. Rotwang');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('629', '158', 'Josaphat');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('630', '159', 'Count Orlok');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('631', '159', 'Hutter');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('632', '159', 'Ellen');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('633', '159', 'Harding');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('634', '159', 'Ruth');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('635', '160', 'Veeru');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('636', '160', 'Jai');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('637', '160', 'Thakur Baldev Singh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('638', '160', 'Gabbar Singh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('639', '160', 'Basanti');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('640', '161', 'Simran Singh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('641', '161', 'Raj Malhotra');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('642', '161', 'Chaudhry Baldev Singh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('643', '161', 'Lajwanti ''Lajjo'' Singh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('644', '161', 'Dharamvir Malhotra');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('645', '162', 'Bhuvan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('646', '162', 'Gauri');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('647', '162', 'Elizabeth Russell');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('648', '162', 'Captain Andrew Russell');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('649', '162', 'Yashoda');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('645', '163', 'Ranchoddas "Rancho" Chanchad');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('650', '163', 'Farhan Qureshi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('651', '163', 'Raju Rastogi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('652', '163', 'Pia Sahastrabudhhe');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('653', '163', 'Viru "Virus" Sahastrabudhhe');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('645', '164', 'Mahavir Singh Phogat');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('654', '164', 'Geeta Phogat');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('655', '164', 'Babita Kumari');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('656', '164', 'Young Geeta');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('657', '164', 'Young Babita');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('645', '165', 'PK');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('658', '165', 'Jagat ''Jaggu'' Janani Sahni');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('659', '165', 'Tapasvi Maharaj');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('653', '165', 'Cherry Bajwa');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('660', '165', 'Sarfraz Yousuf');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('661', '166', 'Sardar Khan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('662', '166', 'Nagma');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('663', '166', 'Ramadhir Singh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('664', '166', 'Faizal Khan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('665', '166', 'Durga');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('666', '167', 'Arjun Saluja');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('667', '167', 'Kabir Dewan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('668', '167', 'Imran Qureshi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('669', '167', 'Laila');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('670', '167', 'Natasha Arora');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('671', '168', 'Margot');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('672', '168', 'Henri de Navarre');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('673', '168', 'Charles IX');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('674', '168', 'La Môle');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('675', '168', 'Catherine de Médicis');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('676', '169', 'Akash Sarraf');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('677', '169', 'Simi Sinha');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('678', '169', 'Sophie');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('679', '169', 'Inspector Manohar Jawanda');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('680', '169', 'Dr. Swami');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('676', '170', 'Ayan Ranjan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('681', '170', 'Aditi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('682', '170', 'Gaura');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('683', '170', 'Jatav');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('684', '170', 'Bhramadatt');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('685', '171', 'Saajan Fernandes');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('686', '171', 'Ila');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('664', '171', 'Shaikh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('687', '171', 'Ila''s Mother');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('688', '171', 'Ila''s Father');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('689', '172', 'Murad Ahmed / Gully Boy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('690', '172', 'Safeena Firdausi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('691', '172', 'Shrikant Bhosie / MC Sher');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('692', '172', 'Aftab Ahmed');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('693', '172', 'Moeen Arif');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('694', '173', 'Ishaan Nandkishore Awasthi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('902', '227', 'Durga Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('903', '228', 'Young Apurba ''Apu'' Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('904', '228', 'Teenage Apurba ''Apu'' Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('898', '228', 'Harihar Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('899', '228', 'Sarbajaya Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('905', '228', 'Bhabataran');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('906', '229', 'Apurba ''Apu'' Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('907', '229', 'Aparna Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('908', '229', 'Kajal Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('909', '229', 'Pulu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('910', '229', 'Shashinarayan''s Wife');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('911', '230', 'Charulata');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('906', '230', 'Amal');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('912', '230', 'Bhupati Dutta');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('913', '230', 'Umapada');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('914', '230', 'Mandakini (Manda)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('915', '231', 'Arindam Mukherjee');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('907', '231', 'Aditi Sengupta');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('916', '231', 'Mukunda Lahiri');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('917', '231', 'Pritish Sarkar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('918', '231', 'Molly Sarkar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('906', '232', 'Prodosh Chandra Mitra (Feluda)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('919', '232', 'Lalmohan Ganguli (Jotayu)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('920', '232', 'Tapesh Mitra');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('921', '232', 'Mukul Dhar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('912', '232', 'Dr. Hemanga Hajra');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('922', '233', 'Gopinath ''Goopy'' Gyne');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('923', '233', 'Bagha Byne');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('919', '233', 'King of Shundi / King of Halla');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('924', '233', 'The Magician');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('925', '233', 'Visitor to Halla');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('926', '234', 'Archana "Archie" Patil');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('927', '234', 'Prashant "Parshya" Kale');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('928', '234', 'Pradeep "Langdya" "Balya" Bansode');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('929', '234', 'Annie');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('930', '234', 'Prince Patil');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('931', '235', 'Bithi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('932', '235', 'Faruk');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('933', '235', 'Sathi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('934', '235', 'Anis');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('935', '235', 'Apa');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('936', '238', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('937', '238', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('938', '238', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('939', '238', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('940', '238', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('941', '240', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('942', '240', 'Josna');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('943', '240', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('944', '240', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('945', '240', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('932', '241', 'Parvez');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('946', '241', 'Mita');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('947', '241', 'Begar Ali');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('940', '241', 'Doctor');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('935', '241', 'Abu''s Mother');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('936', '242', 'Majid');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('948', '242', 'Rahima');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('949', '242', 'Jamila');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('950', '242', 'Pir');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('951', '242', 'Khalek Bepari');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('952', '243', 'Anu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('953', '243', 'Rokon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('954', '243', 'Kazi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('955', '243', 'Ayesha');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('956', '243', 'Milon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('957', '244', 'Maulana');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('958', '244', 'Ashalata');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('959', '244', 'Ashalata''s husband');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('960', '244', 'Pitamber');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('961', '244', 'Man with radio');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('962', '245', 'Sonai');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('963', '245', 'Pori');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('964', '245', 'Gazi Shaheb');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('965', '245', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('966', '245', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('967', '246', 'Ruba Haque');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('968', '246', 'Munna');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('969', '246', 'Topu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('970', '246', 'Mr. Rahman (The Old Man)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('971', '246', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('972', '247', 'Himself');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('973', '247', 'Himself');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('974', '248', 'Amin Chairman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('962', '248', 'Solaiman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('967', '248', 'Kohinoor');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('968', '248', 'Mojnu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('975', '248', 'Jobbar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('962', '249', 'Sharafat Karim Ayna / Nizam Sayeed Chowdhury');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('976', '249', 'Hridi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('977', '249', 'Saber Hossain');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('978', '249', 'Mr. Kuddus');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('979', '249', 'Gousul');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('980', '250', 'Abid Rahman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('981', '250', 'Chaity');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('982', '250', 'Ashfaque Hossain');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('983', '250', 'Ashfaque Hossain''s wife');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('984', '250', 'Sajedul Karim');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('985', '251', 'Ranu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('962', '251', 'Misir Ali');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('986', '251', 'Anis');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('987', '251', 'Ahmed Sabet');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('988', '251', 'Nilu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('989', '252', 'Nasir');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('967', '252', 'Deepti');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('966', '252', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('990', '252', 'Zamshed');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('970', '252', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('991', '253', 'Shimu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('992', '253', 'Daliya');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('993', '253', 'Maya');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('994', '253', 'Tania');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('995', '253', 'Nasima');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('996', '254', 'Ayesha');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('997', '254', 'Sohel');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('998', '254', 'Amir');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('999', '254', 'Esther');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1000', '254', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1001', '255', 'Rehana');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1002', '255', 'Emu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1003', '255', 'Arefin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1004', '255', 'Annie');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1005', '255', 'Mimi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1006', '256', 'Hawa');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1007', '256', 'Mamimata');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1008', '256', 'Erwan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1009', '256', 'Yseult');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1010', '256', 'Thomas Pesquet');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('997', '257', 'Roman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1011', '257', 'Ananya');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1012', '257', 'Shifat');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1013', '257', 'Ananya''s Father');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1014', '257', 'Leader');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('989', '258', 'Durjoy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1011', '258', 'Hasna');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('997', '258', 'Munna');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1015', '258', 'Manager');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1016', '258', 'Monir');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1017', '259', 'Shumon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1018', '259', 'Itl');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1013', '259', 'Usman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('978', '259', 'Chairman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1019', '259', 'Shumon''s father');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('22', '261', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1031', '261', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1032', '261', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1033', '261', NULL);
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('645', '173', 'Ram Shankar Nikumbh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('695', '173', 'Maya Awasthi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('696', '173', 'Nandkishore Awasthi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('697', '173', 'Rajan Damodaran');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('645', '174', 'Daljit ''DJ'' Singh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('698', '174', 'Karan Singhania');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('699', '174', 'Aslam Khan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('651', '174', 'Sukhi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('700', '174', 'Laxman Pandey');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('701', '175', 'Murphy Johnson "Barfi"');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('702', '175', 'Jhilmil Chatterjee');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('703', '175', 'Shruti Ghosh Sengupta');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('659', '175', 'Sub-Inspector Sudhanshu Dutta');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('704', '175', 'Ranjit Sengupta');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('705', '176', 'Vidya Bagchi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('706', '176', 'ASI Satyoki "Rana" Sinha');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('664', '176', 'A. Khan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('707', '176', 'Bob Biswas');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('708', '176', 'Sub-Inspector Chatterjee');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('685', '177', 'Ashwin Kumar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('709', '177', 'Nutan Tandon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('710', '177', 'Ramesh Tandon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('711', '177', 'Ramashankar Pillai');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('712', '177', 'Vedant Mishra (ACP)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('713', '178', 'Major Vihan Singh Shergill');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('714', '178', 'NSA Govind Bhardwaj');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('715', '178', 'Pallavi Sharma / Jasmine');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('716', '178', 'Major Karan Kashyap');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('717', '178', 'Fl. Lt. Seerat Kaur');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('636', '179', 'Deepak Sehgal');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('718', '179', 'Minal Arora');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('717', '179', 'Falak Ali');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('719', '179', 'Andrea');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('720', '179', 'Rajveer Singh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('662', '180', 'Devi Pathak');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('721', '180', 'Vidyadhar Pathak');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('713', '180', 'Deepak Chaudhary');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('722', '180', 'Shaalu Gupta');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('723', '180', 'Sadhya Ji');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('724', '181', 'Newton Kumar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('723', '181', 'Aatma Singh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('725', '181', 'Malka');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('726', '181', 'Loknath');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('727', '181', 'Shambhoo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('712', '182', 'Vinayak Rao');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('728', '182', 'Pandurang / Grandmother');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('729', '182', 'Hastar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('730', '182', 'Vinayak''s Mother');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('731', '182', 'Young Vinayak');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('724', '183', 'Vicky');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('732', '183', 'Unnamed Woman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('723', '183', 'Rudra');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('733', '183', 'Bittu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('734', '183', '''Jana'' Janardan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('735', '184', 'Pawan Kumar "Bajarangi" Chaturvedi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('736', '184', 'Shahida "Munni"');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('664', '184', 'Chand Nawab');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('652', '184', 'Rasika');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('737', '184', 'Dayanand');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('641', '185', 'Mohan Bhargav');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('738', '185', 'Gita');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('739', '185', 'Kaveri Amma');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('740', '185', 'Chiku');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('741', '185', 'Dadaji');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('701', '186', 'Janardan Jakhar / Jordan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('742', '186', 'Heer Kaul');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('743', '186', 'Ustad Jameel Khan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('744', '186', 'Sheena');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('683', '186', 'Khatana');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('641', '187', 'Aman Mathur');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('745', '187', 'Naina Catherine Kapur');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('746', '187', 'Rohit Patel');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('747', '187', 'Jennifer Kapur');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('748', '187', 'Lajjo Kapur');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('641', '188', 'Devdas Mukherjee');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('749', '188', 'Parvati "Paro" Chakraborty');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('750', '188', 'Chandramukhi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('751', '188', 'Chunnilal');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('752', '188', 'Kaushalya Mukherjee');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('641', '189', 'Rahul Mithaiwala');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('753', '189', 'Meenamma Lochini Azhagusundaram');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('754', '189', 'Tangaballi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('755', '189', 'Durgeshwara Azhagusundaram');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('756', '189', 'Inspector Shamsher');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('753', '190', 'Queen Padmavati');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('757', '190', 'Maharaja Ratan Singh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('689', '190', 'Sultan Alauddin Khilji');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('758', '190', 'Malik Kafur');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('759', '190', 'Raghav Chetan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('760', '191', 'Prince Salim');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('761', '191', 'Emperor Akbar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('762', '191', 'Anarkali');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('763', '191', 'Maharani Jodha Bai');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('764', '191', 'Bahar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('765', '192', 'Sakthivel ''Velu'' Naicker');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('766', '192', 'Neela');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('767', '192', 'Charumati (adult)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('768', '192', 'Selvam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('769', '192', 'Iyer');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('770', '193', 'Manikkam / Manik Baashha');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('771', '193', 'Priya');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('772', '193', 'Mark Anthony');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('768', '193', 'Gurumurthy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('773', '193', 'Kesavan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('765', '194', 'Karnan / Arun Kumar Vikram');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('774', '194', 'Amar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('775', '194', 'Sandhanam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('776', '194', 'Bejoy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('777', '194', 'Police Chief Jose');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('778', '195', 'Su Can');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('779', '195', 'Sha To');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('780', '195', 'Wu Pianpian');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('781', '195', 'Liu Jiang');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('782', '195', 'Shen Ruyu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('783', '196', 'Dilli');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('776', '196', 'Bejoy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('784', '196', 'Anbu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('785', '196', 'Adaikalam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('786', '196', 'Napoleon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('650', '197', 'Vikram');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('775', '197', 'Vedha');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('787', '197', 'Priya');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('788', '197', 'Pulli');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('789', '197', 'Chandra');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('775', '198', 'Ramachandran "Ram" Krishnamoorthy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('790', '198', 'Janaki "Janu" Devi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('791', '198', 'Younger Ram');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('792', '198', 'Younger Janu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('793', '198', 'Subhashini');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('775', '199', 'Shilpa');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('774', '199', 'Mugilan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('794', '199', 'Vaembu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('795', '199', 'Leela');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('796', '199', 'Arputham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('797', '200', 'Chandru');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('798', '200', 'Sengani Rajakannu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('799', '200', 'Alli Rajakannu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('800', '200', 'Rajakannu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('801', '200', 'Mythra');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('797', '201', 'Nedumaaran ''Maara'' Rajangam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('802', '201', 'Sundari ''Bommi'' Nedumaaran');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('714', '201', 'Paresh Goswami');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('803', '201', 'M. Bhaktavatsalam Naidu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('804', '201', 'Pechi Rajangam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('805', '202', 'Sivasaamy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('806', '202', 'Pachaiyammal');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('807', '202', 'Chidambaram');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('808', '202', 'Vel Murugan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('809', '202', 'Murugesan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('788', '203', 'Pariyerum Perumal');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('810', '203', 'Jothi Mahalakshmi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('811', '203', 'Anand');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('812', '203', 'Jothi Mahalakshmi''s Father');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('813', '203', 'Sankaralingam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('814', '204', 'Pandi Ravi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('815', '204', 'Muthuvel');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('810', '204', 'Shanthi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('816', '204', 'Murugan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('817', '204', 'K. K.');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('770', '205', '''Kabali'' Kabaliswaran');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('678', '205', 'Kumudhavalli');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('818', '205', 'Yogi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('819', '205', 'Tony Lee');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('817', '205', 'Veerasekaran');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('770', '206', 'Dr. Vaseegaran / Chitti');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('749', '206', 'Sana');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('820', '206', 'Dr Bohra');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('821', '206', 'Siva');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('822', '206', 'Ravi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('823', '207', 'Mahendra ''Sivudu'' Bāhubali / Amarendra Bāhubali');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('824', '207', 'Bhallaladeva');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('825', '207', 'Avanthika');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('826', '207', 'Devasena');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('795', '207', 'Sivagami');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('823', '208', 'Mahendra ''Sivudu'' Bāhubali / Amarendra Bāhubali');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('824', '208', 'Bhallaladeva');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('826', '208', 'Devasena');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('755', '208', 'Karikala Kattappa Nadar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('827', '208', 'Bijjaladeva');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('828', '209', 'Komaram Bheem');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('829', '209', 'Alluri Sitarama Raju');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('830', '209', 'Jennifer ''Jenny'' Buxton');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('831', '209', 'Scott Buxton');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('832', '209', 'Cassandra Buxton');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('833', '210', 'Arjun Reddy Deshmukh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('834', '210', 'Preethi Shetty');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('835', '210', 'Shiva');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('836', '210', 'Gautham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('837', '210', 'Arjun''s Grandmother');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('829', '211', 'Chelluboyina Chitti Babu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('838', '211', 'Chelluboyina Kumar Babu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('794', '211', 'Ramalakshmi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('839', '211', 'Phanindra Bhupathi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('840', '211', 'Dakshina Murthy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('841', '212', 'Pushpa Raj');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('774', '212', 'Bhanwar Singh Shekhawat');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('842', '212', 'Srivalli');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('843', '212', 'Kesava');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('844', '212', 'Mangalam Srinu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('841', '213', 'Devaraj / Bantu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('845', '213', 'Amulya');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('846', '213', 'Valmiki');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('847', '213', 'Ramachandra');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('848', '213', 'Raj Manohar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('849', '214', 'Sudeep');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('794', '214', 'Bindhu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('850', '214', 'Nani');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('851', '214', 'Sudeep''s Business Partner');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('852', '214', 'Thief');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('829', '215', 'Kala Bhairava / Harsha');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('853', '215', 'Mitravinda / Indu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('854', '215', 'Ranadev Bhilla / Raghubeer');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('855', '215', 'Sher Khan / Solomon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('844', '215', 'Harsha''s Friend');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('850', '216', 'Arjun');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('787', '216', 'Sarah');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('856', '216', 'Nani');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('857', '216', 'Senior Nani');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('858', '216', 'Nandu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('859', '217', 'Georgekutty');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('860', '217', 'Rani');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('861', '217', 'IG Geetha Prabhakar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('862', '217', 'Constable Sahadevan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('863', '217', 'Anju');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('864', '218', 'Bobby');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('865', '218', 'Saji');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('866', '218', 'Boney');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('867', '218', 'Franky');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('774', '218', 'Shammi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('868', '219', 'George David');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('869', '219', 'Celine George');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('870', '219', 'Malar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('871', '219', 'Mary George');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('872', '219', 'Shambu');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('873', '220', 'Divya Prakash ''Kunju''');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('868', '220', 'Krishnan PP ''Kuttan''');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('874', '220', 'Arjun ''Aju''');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('774', '220', 'Shivadas ''Shiva''');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('875', '220', 'RJ Sarah');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('774', '221', 'Mahesh Bhavana');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('876', '221', 'Soumya');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('802', '221', 'Jimsy Augustine');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('877', '221', 'Baby');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('878', '221', 'Kunjumon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('879', '222', 'Vincent ''Pepe''');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('880', '222', '''Appani'' Ravi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('881', '222', '''U-Clamp'' Rajan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('882', '222', '''10ml'' Thomas');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('883', '222', 'Kunjoottan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('879', '223', 'Antony');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('777', '223', '''Kalan'' Varkey');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('884', '223', 'Kuttachan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('885', '223', 'Sophie');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('878', '223', 'Kuriachan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('774', '224', 'Joji');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('886', '224', 'Jomon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('887', '224', 'Kuttappan P K Panachel');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('888', '224', 'Jaison');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('889', '224', 'Bincy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('890', '225', 'Wife');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('891', '225', 'Husband');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('892', '225', 'Mother-In-Law');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('893', '225', 'Father-In-Law');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('894', '225', 'Aunt');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('859', '226', 'Stephen Nedumpally / Khureshi-Ab''raam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('895', '226', 'Bobby');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('806', '226', 'Priyadarshini Ramdas');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('896', '226', 'Jathin Ramdas');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('897', '226', 'Govardhan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('898', '227', 'Harihar Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('899', '227', 'Sarbajaya Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('900', '227', 'Apurba ''Apu'' Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('901', '227', 'Little Durga Roy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1', '1', 'Dom Cobb');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('31', '1', 'Arthur');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('32', '1', 'Saito');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('33', '1', 'Eames');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('34', '1', 'Ariadne');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('35', '2', 'Cooper');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('5', '2', 'Brand');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('36', '2', 'Professor Brand');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('37', '2', 'Murph');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('38', '2', 'Tom');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('6', '3', 'Bruce Wayne');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('39', '3', 'Joker');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('40', '3', 'Harvey Dent');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('36', '3', 'Alfred');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('41', '3', 'Rachel');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('42', '4', 'J. Robert Oppenheimer');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('43', '4', 'Kitty Oppenheimer');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('44', '4', 'Leslie Groves');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('7', '4', 'Lewis Strauss');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('19', '4', 'Jean Tatlock');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('45', '5', 'Paul Atreides');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('17', '5', 'Chani');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('46', '5', 'Jessica');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('47', '5', 'Stilgar');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('48', '5', 'Gurney Halleck');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('49', '6', 'Kim Ki-taek');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('50', '6', 'Park Dong-ik');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('51', '6', 'Yeon-kyo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('52', '6', 'Ki-woo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('53', '6', 'Ki-jung');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('3', '7', 'Barbie');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('4', '7', 'Ken');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('54', '7', 'Gloria');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('55', '7', 'Sasha');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('56', '7', 'Barbie');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('7', '8', 'Tony Stark / Iron Man');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('8', '8', 'Steve Rogers / Captain America');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('57', '8', 'Bruce Banner / Hulk');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('58', '8', 'Thor');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('59', '8', 'Natasha Romanoff / Black Widow');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1', '9', 'Jack Dawson');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('60', '9', 'Rose DeWitt Bukater');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('61', '9', 'Cal Hockley');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('62', '9', 'Molly Brown');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('63', '9', 'Ruth DeWitt Bukater');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('64', '10', 'Joy (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('65', '10', 'Sadness (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('66', '10', 'Bing Bong (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('67', '10', 'Fear (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('68', '10', 'Anger (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('69', '11', 'Vincent Vega');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('11', '11', 'Jules Winnfield');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('12', '11', 'Mia Wallace');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('70', '11', 'Butch Coolidge');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('71', '11', 'Marsellus Wallace');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1', '12', 'Billy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('44', '12', 'Colin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('72', '12', 'Costello');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('73', '12', 'Dignam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('74', '12', 'Queenan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('75', '13', 'Bilbo Baggins');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('76', '13', 'Gandalf the Grey');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('77', '13', 'Thorin Oakenshield');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('78', '13', 'Bofur');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('79', '13', 'Balin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('80', '14', 'Nick Dunne');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('81', '14', 'Amy Dunne');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('82', '14', 'Desi Collings');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('83', '14', 'Tanner Bolt');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('84', '14', 'Margo Dunne');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('85', '15', 'Bob Harris');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('59', '15', 'Charlotte');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('86', '15', 'John');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('87', '15', 'Kelly');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('88', '15', 'Ms. Kawasaki');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('89', '16', 'Riggan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('27', '16', 'Sam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('90', '16', 'Jake');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('91', '16', 'Mike');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('92', '16', 'Laura');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('44', '17', 'Mark Watney');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('37', '17', 'Melissa Lewis');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('93', '17', 'Annie Montrose');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('94', '17', 'Theodore "Teddy" Sanders');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('95', '17', 'Rick Martinez');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('96', '18', 'M. Gustave');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('97', '18', 'Mr. Moustafa');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('98', '18', 'Zero');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('99', '18', 'Dmitri');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('100', '18', 'Jopling');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('101', '19', 'Chihiro (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('102', '19', 'Haku (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('103', '19', 'Yubaba / Zeniba (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('104', '19', 'Father (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('105', '19', 'Mother (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('106', '20', 'Jojo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('107', '20', 'Elsa');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('59', '20', 'Rosie');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('108', '20', 'Adolf');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('109', '20', 'Captain Klenzendorf');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('37', '21', 'Maya');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('110', '21', 'Dan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('111', '21', 'Patrick - Squadron Team Leader');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('112', '21', 'Jessica');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('113', '21', 'George');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('114', '22', 'Ofelia');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('115', '22', 'Capitán Vidal');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('116', '22', 'Mercedes');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('117', '22', 'Fauno / Pale Man');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('118', '22', 'Carmen');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('12', '23', 'The Bride');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('119', '23', 'O-Ren Ishii');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('120', '23', 'Vernita Green');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('121', '23', 'Elle Driver');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('122', '23', 'Bill');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1', '24', 'Teddy Daniels');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('57', '24', 'Chuck Aule');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('123', '24', 'Dr. Cawley');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('124', '24', 'Dr. Naehring');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('125', '24', 'Dolores');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('126', '25', 'Frodo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('76', '25', 'Gandalf');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('127', '25', 'Aragorn');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('128', '25', 'Sam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('129', '25', 'Gollum');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('130', '26', 'Somerset');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('13', '26', 'Mills');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('131', '26', 'Tracy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('132', '26', 'Officer Davis');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('133', '26', 'Dr. O''Neill');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('134', '27', 'Marie Antoinette');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('135', '27', 'Louis XVI');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('136', '27', 'Ambassador Mercy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('137', '27', 'Comtesse de Noailles');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('138', '27', 'Louis XV');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1', '28', 'Hugh Glass');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('33', '28', 'John Fitzgerald');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('139', '28', 'Captain Andrew Henry');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('140', '28', 'Jim Bridger');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('141', '28', 'Hawk');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('16', '29', 'Napoleon Bonaparte');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('142', '29', 'Josephine Bonaparte');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('143', '29', 'Paul Barras');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('144', '29', 'Duke of Wellington');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('145', '29', 'Junot');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('146', '30', 'Chief (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('147', '30', 'Atari Kobayashi (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('148', '30', 'King (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('91', '30', 'Rex (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('85', '30', 'Boss (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('149', '31', 'Ashitaka (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('150', '31', 'San / Kaya (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('151', '31', 'Eboshi Gozen (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('152', '31', 'Jikobo (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('153', '31', 'Kouroku (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('58', '32', 'Thor');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('57', '32', 'Bruce Banner / Hulk');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('154', '32', 'Loki');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('15', '32', 'Hela');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('20', '32', 'Heimdall');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('155', '33', 'Staff Sergeant William James');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('156', '33', 'Sergeant JT Sanborn');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('157', '33', 'Specialist Owen Eldridge');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('158', '33', 'Colonel Reed');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('159', '33', 'Sergeant Matt Thompson');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('160', '34', 'Elisa Esposito');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('161', '34', 'Richard Strickland');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('162', '34', 'Giles');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('163', '34', 'Zelda Fuller');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('164', '34', 'Dr. Robert Hoffstetler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('165', '35', 'Django Freeman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('166', '35', 'Dr. King Schultz');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1', '35', 'Calvin J. Candie');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('167', '35', 'Broomhilda von Shaft');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('11', '35', 'Stephen');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1', '36', 'Jordan Belfort');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('168', '36', 'Donnie Azoff');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('3', '36', 'Naomi Lapaglia');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('35', '36', 'Mark Hanna');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('169', '36', 'Agent Patrick Denham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('170', '37', 'Ann Darrow');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('99', '37', 'Jack Driscoll');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('171', '37', 'Carl Denham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('129', '37', 'Kong / Lumpy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('172', '37', 'Preston');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('91', '38', 'Narrator');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('13', '38', 'Tyler Durden');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('173', '38', 'Marla Singer');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('174', '38', 'Robert Paulson');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('175', '38', 'Angel Face');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('134', '39', 'Lux Lisbon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('176', '39', 'Trip Fontaine');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('177', '39', 'Mr. Lisbon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('178', '39', 'Mrs. Lisbon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('179', '39', 'Adult Trip Fontaine');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('13', '40', 'Richard Jones');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('180', '40', 'Chieko');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('181', '40', 'Amelia');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('15', '40', 'Susan Jones');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('182', '40', 'Kenji Mamiya');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('183', '41', 'Maximus');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('16', '41', 'Commodus');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('184', '41', 'Lucilla');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('185', '41', 'Proximo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('186', '41', 'Marcus Aurelius');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('187', '42', 'Mr. Fox (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('14', '42', 'Mrs. Fox (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('135', '42', 'Ash Fox (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('188', '42', 'Kristofferson Silverfox (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('189', '42', 'Kylie (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('190', '43', 'Satsuki Kusakabe (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('191', '43', 'Mei Kusakabe (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('192', '43', 'Totoro (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('193', '43', 'Tatsuo Kusakabe (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('194', '43', 'Yasuko Kusakabe (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('10', '44', 'Guy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('195', '44', 'Millie Rusk / Molotovgirl');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('196', '44', 'Buddy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('197', '44', 'Keys');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('198', '44', 'Mouser');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('24', '45', 'Melvin Dismukes');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('140', '45', 'Philip Krauss');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('156', '45', 'Greene');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('199', '45', 'Larry Reed');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('200', '45', 'Julie Ann');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('201', '46', 'Edith Cushing');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('37', '46', 'Lady Lucille Sharpe');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('154', '46', 'Sir Thomas Sharpe');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('202', '46', 'Dr. Alan McMichael');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('203', '46', 'Carter Cushing');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('204', '47', 'Mr. White / Larry Dimmick');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('205', '47', 'Mr. Orange / Freddy Newandyke');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('206', '47', 'Mr. Blonde / Vic Vega');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('207', '47', '"Nice Guy" Eddie Cabot');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('208', '47', 'Mr. Pink');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('209', '48', 'James Conway');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('210', '48', 'Henry Hill');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('211', '48', 'Tommy DeVito');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('212', '48', 'Karen Hill');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('213', '48', 'Paul Cicero');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('21', '49', 'Susie Salmon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('73', '49', 'Jack Salmon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('214', '49', 'Abigail Salmon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('215', '49', 'Grandma Lynn');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('216', '49', 'George Harvey');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('13', '50', 'Benjamin Button');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('15', '50', 'Daisy Fuller');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('217', '50', 'Queenie');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('218', '50', 'Caroline Fuller');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('219', '50', 'Thomas Button');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('220', '51', 'Johnny Marco');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('221', '51', 'Cleo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('222', '51', 'Sammy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('223', '51', 'Sylvia');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('224', '51', 'Layla');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('4', '53', '''K''');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('225', '53', 'Rick Deckard');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('28', '53', 'Joi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('226', '53', 'Sapper Morton');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('227', '53', 'Lieutenant Joshi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('228', '54', 'Sam Shakusky');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('229', '54', 'Suzy Bishop');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('70', '54', 'Captain Sharp');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('91', '54', 'Scout Master Ward');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('85', '54', 'Mr. Bishop');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('230', '55', 'Sophie (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('231', '55', 'Howl (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('232', '55', 'Witch of the Waste (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('233', '55', 'Calcifer (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('234', '55', 'Markl (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('235', '56', 'Thomas Rongen');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('236', '56', 'Tavita');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('237', '56', 'Jaiyah');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('238', '56', 'Ace');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('239', '56', 'Ruth');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('240', '57', 'Agent Johnny Utah');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('241', '57', 'Bodhi / Mask President');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('242', '57', 'Tyler Endicott');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('243', '57', 'Agent Angelo Pappas');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('244', '57', 'SAIC Ben Harp');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('245', '58', 'Stanton Carlisle');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('15', '58', 'Dr. Lilith Ritter');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('246', '58', 'Zeena the Seer');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('100', '58', 'Clem Hoatley');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('162', '58', 'Ezra Grindle');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('1', '59', 'Rick Dalton');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('13', '59', 'Cliff Booth');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('3', '59', 'Sharon Tate');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('247', '59', 'Jay Sebring');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('248', '59', '''Pussycat''');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('249', '60', 'Andy Dufresne');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('130', '60', 'Ellis Boyd ''Red'' Redding');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('250', '60', 'Warden Norton');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('251', '60', 'Heywood');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('252', '60', 'Captain Byron T. Hadley');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('253', '61', 'Don Vito Corleone');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('254', '61', 'Michael Corleone');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('256', '61', 'Tom Hagen');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('257', '61', 'Clemenza');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('254', '62', 'Don Michael Corleone');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('256', '62', 'Tom Hagen');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('258', '62', 'Kay Corleone');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('209', '62', 'Vito Corleone');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('259', '62', 'Frederico ''Fredo'' Corleone');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('2', '63', 'Forrest Gump');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('227', '63', 'Jenny Curran');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('260', '63', 'Lieutenant Dan Taylor');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('261', '63', 'Mrs. Gump');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('262', '63', 'Bubba Blue');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('240', '64', 'Neo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('263', '64', 'Morpheus');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('264', '64', 'Trinity');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('265', '64', 'Agent Smith');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('266', '64', 'Oracle');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('267', '65', 'Clarice Starling');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('268', '65', 'Dr. Hannibal Lecter');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('269', '65', 'Jack Crawford');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('270', '65', 'Jame Gumb');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('271', '65', 'Dr. Frederick Chilton');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('2', '66', 'Captain Miller');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('272', '66', 'Sergeant Horvath');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('273', '66', 'Private Reiben');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('274', '66', 'Private Jackson');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('275', '66', 'Private Mellish');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('276', '67', 'Oskar Schindler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('123', '67', 'Itzhak Stern');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('96', '67', 'Amon Goeth');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('277', '67', 'Emilie Schindler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('278', '67', 'Poldek Pfefferberg');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('2', '68', 'Paul Edgecomb');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('158', '68', 'Brutus ''Brutal'' Howell');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('279', '68', 'Jan Edgecomb');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('280', '68', 'John Coffey');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('281', '68', 'Warden Hal Moores');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('282', '69', 'Lester Burnham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('283', '69', 'Carolyn Burnham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('284', '69', 'Jane Burnham');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('285', '69', 'Ricky Fitts');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('286', '69', 'Angela Hayes');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('287', '70', 'Scarlett O''Hara');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('288', '70', 'Rhett Butler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('289', '70', 'Melanie Hamilton');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('290', '70', 'Ashley Wilkes');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('291', '70', 'Mammy');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('292', '71', 'Rick Blaine');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('293', '71', 'Ilsa Lund');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('294', '71', 'Victor Laszlo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('295', '71', 'Captain Louis Renault');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('296', '71', 'Major Heinrich Strasser');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('297', '72', 'Charles Foster Kane');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('255', '61', 'Sonny Corleone');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('298', '72', 'Jedediah Leland');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('299', '72', 'Susan Alexander Kane');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('300', '72', 'Jim W. Gettys');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('301', '72', 'Walter Parks Thatcher');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('126', '73', 'Frodo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('76', '73', 'Gandalf');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('127', '73', 'Aragorn');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('128', '73', 'Sam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('302', '73', 'Bilbo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('126', '74', 'Frodo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('76', '74', 'Gandalf');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('127', '74', 'Aragorn');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('128', '74', 'Sam');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('129', '74', 'Gollum / Smeagol');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('303', '75', 'Luke Skywalker');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('225', '75', 'Han Solo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('304', '75', 'Princess Leia Organa');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('305', '75', 'Grand Moff Tarkin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('306', '75', 'Obi-Wan "Ben" Kenobi');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('303', '76', 'Luke Skywalker');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('225', '76', 'Han Solo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('304', '76', 'Princess Leia');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('307', '76', 'Lando Calrissian');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('308', '76', 'C-3PO');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('303', '77', 'Luke Skywalker');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('225', '77', 'Han Solo');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('304', '77', 'Princess Leia');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('307', '77', 'Lando Calrissian');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('308', '77', 'C-3PO');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('309', '78', 'Grant');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('310', '78', 'Ellie');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('311', '78', 'Malcolm');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('312', '78', 'Hammond');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('313', '78', 'Muldoon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('314', '79', 'The Terminator');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('315', '79', 'Sarah Connor');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('316', '79', 'John Connor');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('317', '79', 'T-1000');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('318', '79', 'Dr. Silberman');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('319', '80', 'Marty McFly');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('320', '80', 'Emmett Brown');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('321', '80', 'George McFly');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('322', '80', 'Lorraine Baines');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('323', '80', 'Jennifer Parker');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('324', '81', 'Dallas');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('325', '81', 'Ripley');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('326', '81', 'Lambert');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('327', '81', 'Brett');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('328', '81', 'Kane');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('325', '82', 'Ripley');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('329', '82', 'Newt');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('330', '82', 'Corporal Hicks');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('331', '82', 'Burke');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('332', '82', 'Bishop');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('70', '83', 'John McClane');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('333', '83', 'Hans Gruber');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('334', '83', 'Karl');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('335', '83', 'Holly Gennaro McClane');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('336', '83', 'Al Powell');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('33', '84', 'Max Rockatansky');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('337', '84', 'Imperator Furiosa');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('338', '84', 'Nux');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('339', '84', 'Immortan Joe');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('340', '84', 'Slit');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('7', '85', 'Tony Stark / Iron Man');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('8', '85', 'Steve Rogers / Captain America');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('57', '85', 'Bruce Banner / The Hulk');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('58', '85', 'Thor');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('59', '85', 'Natasha Romanoff / Black Widow');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('7', '86', 'Tony Stark');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('341', '86', 'Rhodey');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('342', '86', 'Obadiah Stane');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('131', '86', 'Pepper Potts');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('343', '86', 'Christine Everhart');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('344', '87', 'Miles Morales (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('345', '87', 'Peter B. Parker (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('346', '87', 'Gwen Stacy (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('347', '87', 'Uncle Aaron (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('348', '87', 'Jefferson Davis (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('349', '88', 'Miguel Rivera (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('350', '88', 'Héctor (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('351', '88', 'Ernesto de la Cruz (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('352', '88', 'Mamá Imelda (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('353', '88', 'Abuelita (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('2', '89', 'Woody (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('354', '89', 'Buzz Lightyear (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('355', '89', 'Mr. Potato Head (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('356', '89', 'Slinky Dog (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('357', '89', 'Rex (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('2', '90', 'Woody (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('354', '90', 'Buzz Lightyear (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('358', '90', 'Jessie (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('355', '90', 'Mr. Potato Head (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('357', '90', 'Rex (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('359', '91', 'Marlin (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('360', '91', 'Dory (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('361', '91', 'Nemo (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('100', '91', 'Gill (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('362', '91', 'Nigel (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('363', '92', 'Carl Fredricksen (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('364', '92', 'Charles Muntz (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('365', '92', 'Russell (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('366', '92', 'Dug / Alpha (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('367', '92', 'Beta (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('368', '93', 'WALL·E / M-O (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('369', '93', 'EVE (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('370', '94', 'Shrek / Blind Mouse (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('371', '94', 'Donkey (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('372', '94', 'Princess Fiona (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('373', '94', 'Lord Farquaad (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('374', '94', 'Monsieur Hood (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('375', '95', 'Simba (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('376', '95', 'Nala (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('377', '95', 'Scar (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('378', '95', 'Timon (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('379', '95', 'Pumbaa (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('380', '96', 'Belle (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('381', '96', 'Beast (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('382', '96', 'Gaston (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('383', '96', 'Lumiere (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('384', '96', 'Cogsworth (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('385', '97', 'Aladdin (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('386', '97', 'Genie / Peddler (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('387', '97', 'Jasmine (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('388', '97', 'Jafar (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('389', '97', 'Iago (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('390', '98', 'Anna (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('391', '98', 'Elsa (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('392', '98', 'Kristoff (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('393', '98', 'Olaf (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('394', '98', 'Hans (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('395', '99', 'Remy (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('302', '99', 'Skinner (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('396', '99', 'Linguini (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('397', '99', 'Django (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('398', '99', 'Emile (voice)');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('399', '100', 'Andrew');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('400', '100', 'Fletcher');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('331', '100', 'Jim');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('401', '100', 'Nicole');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('402', '100', 'Ryan');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('4', '101', 'Sebastian');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('27', '101', 'Mia');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('403', '101', 'Keith');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('404', '101', 'Laura');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('405', '101', 'Greg');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('406', '102', 'Mark Zuckerberg');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('407', '102', 'Eduardo Saverin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('408', '102', 'Cameron Winklevoss / Tyler Winklevoss');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('409', '102', 'Sean Parker');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('410', '102', 'Erica Albright');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('411', '103', 'Older Jamal');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('412', '103', 'Older Latika');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('413', '103', 'Older Salim');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('414', '103', 'Prem');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('415', '103', 'Javed');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('47', '104', 'Anton Chigurh');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('416', '104', 'Ed Tom Bell');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('48', '104', 'Llewelyn Moss');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('417', '104', 'Carson Wells');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('418', '104', 'Carla Jean Moss');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('419', '105', 'Daniel Plainview');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('420', '105', 'Paul Sunday / Eli Sunday');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('421', '105', 'Henry');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('422', '105', 'Fletcher Hamilton');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('423', '105', 'H.W. Plainview');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('424', '106', 'Mark Baum');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('6', '106', 'Michael Burry');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('4', '106', 'Jared Vennett');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('13', '106', 'Ben Rickert');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('425', '106', 'Cynthia Baum');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('57', '107', 'Michael Rezendes');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('89', '107', 'Walter ''Robby'' Robinson');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('426', '107', 'Sacha Pfeiffer');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('427', '107', 'Marty Baron');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('428', '107', 'Ben Bradlee, Jr.');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('26', '108', 'Charlie Barber');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('59', '108', 'Nicole Barber');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('310', '108', 'Nora Fanshaw');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('429', '108', 'Bert Spitz');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('210', '108', 'Jay Marotta');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('38', '109', 'Lee Chandler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('430', '109', 'Patrick Chandler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('125', '109', 'Randi Chandler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('169', '109', 'Joe Chandler');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('431', '109', 'George');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('432', '110', 'Black');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('433', '110', 'Kevin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('434', '110', 'Teresa');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('435', '110', 'Chiron');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('436', '110', 'Kevin Age 16');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('437', '111', 'Solomon Northup');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('235', '111', 'Edwin Epps');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('25', '111', 'Patsey');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('438', '111', 'William Ford');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('420', '111', 'John Tibeats');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('127', '112', 'Tony Lip');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('347', '112', 'Dr. Don Shirley');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('439', '112', 'Dolores');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('440', '112', 'Johnny Venere');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('441', '112', 'Oleg');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('442', '113', 'King George VI');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('362', '113', 'Lionel Logue');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('173', '113', 'Queen Elizabeth');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('159', '113', 'King Edward VIII');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('443', '113', 'Winston Churchill');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('80', '114', 'Tony Mendez');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('146', '114', 'Jack O''Donnell');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('444', '114', 'Lester Siegel');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('445', '114', 'John Chambers');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('446', '114', 'Ken Taylor');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('447', '115', 'Freddie Mercury');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('448', '115', 'Brian May');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('449', '115', 'Roger Taylor');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('450', '115', 'John Deacon');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('451', '115', 'Mary Austin');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('452', '116', 'Ally Campana');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('245', '116', 'Jackson Maine');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('453', '116', 'Bobby Maine');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('454', '116', 'Lorenzo Campana');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('455', '116', 'Rez Gavron');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('456', '117', 'Chris Washington');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('457', '117', 'Rose Armitage');
INSERT INTO "CINEHIVE"."ACTS_IN" VALUES ('458', '117', 'Missy Armitage');

-- ----------------------------
-- Table structure for APP_USER
-- ----------------------------
CREATE TABLE "CINEHIVE"."APP_USER" (
  "USER_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_APP_USER".nextval NOT NULL,
  "USERNAME" VARCHAR2(80 BYTE) VISIBLE NOT NULL,
  "EMAIL" VARCHAR2(200 BYTE) VISIBLE NOT NULL,
  "PASSWORD_HASH" VARCHAR2(255 BYTE) VISIBLE NOT NULL,
  "DATE_OF_BIRTH" DATE VISIBLE,
  "PROFILE_PIC" VARCHAR2(500 BYTE) VISIBLE,
  "DATE_JOINED" DATE VISIBLE DEFAULT SYSDATE NOT NULL,
  "ROLE" VARCHAR2(20 BYTE) VISIBLE DEFAULT 'CUSTOMER' NOT NULL,
  "CINEMA_ID" NUMBER VISIBLE,
  "IS_APPROVED" NUMBER(1,0) VISIBLE DEFAULT 1
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of APP_USER
-- ----------------------------
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('1', 'shafiq01', 'shafiq01@gmail.com', 'HASH_001', TO_DATE('2001-05-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'https://example.com/profiles/shafiq.jpg', TO_DATE('2025-01-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'CUSTOMER', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('3', 'tanvir99', 'tanvir99@gmail.com', 'HASH_003', TO_DATE('1999-11-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'https://example.com/profiles/tanvir.jpg', TO_DATE('2025-03-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'CUSTOMER', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('4', 'mehedi07', 'mehedi07@gmail.com', 'HASH_004', TO_DATE('2000-02-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'https://example.com/profiles/mehedi.jpg', TO_DATE('2025-03-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'CUSTOMER', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('6', 'arif_cine', 'arif.cine@gmail.com', 'HASH_006', TO_DATE('1998-12-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'https://example.com/profiles/arif.jpg', TO_DATE('2025-05-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'CUSTOMER', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('7', 'farhan_movie', 'farhan.movie@gmail.com', 'HASH_007', TO_DATE('2003-06-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'https://example.com/profiles/farhan.jpg', TO_DATE('2025-05-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'CUSTOMER', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('70', 'rafsan_site_admin', 'rafsan_site_admin@gmail.com', '$2b$10$2LJuypjphtPTlHxsr6dArOPCrs0aFSGc8A1gK8SCLxUqGCVv2AZTi', NULL, NULL, TO_DATE('2026-09-13 18:52:04', 'SYYYY-MM-DD HH24:MI:SS'), 'SITE_ADMIN', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('9', 'cinefan1', 'cinefan1@example.com', '$2b$10$wc/SnEusLcDtps9RuYjAO.lm71/cSgcWbUPjSy7X16PKjfDyXavoa', NULL, NULL, TO_DATE('2026-08-22 11:54:06', 'SYYYY-MM-DD HH24:MI:SS'), 'CUSTOMER', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('10', 'shariar_habib', 'tickletitan89@gmail.com', '$2b$10$oriIseAWhTkLywzSnAcnxO4RqsymivC5.CR9xaZ5lsBraO6LVUNNq', NULL, NULL, TO_DATE('2026-08-22 12:09:57', 'SYYYY-MM-DD HH24:MI:SS'), 'CUSTOMER', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('51', 'admin_cineplexchattogram', 'admin.cineplexchattogram@cinehive.com', '$2b$10$GhTTUvAogpPWgds5pT6qgeiUtoQhHAgs3lbCdwqwUypCJVuuUC9b2', NULL, NULL, TO_DATE('2026-09-11 17:24:06', 'SYYYY-MM-DD HH24:MI:SS'), 'CINEMA_ADMIN', '3', '0');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('54', 'dibya', 'dibya@gmail.com', '$2b$10$plcLT7Wh6KPJjHK.R9hv5.OYUf.fyO4CLIKNJwhf73JFaWubplNXO', NULL, NULL, TO_DATE('2026-09-12 12:56:41', 'SYYYY-MM-DD HH24:MI:SS'), 'CUSTOMER', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('59', 'habib_cine_admin', 'habib_cine_admin@gmail.com', '$2b$10$xIPTFSIfQZXLTLOV6CrXuOeLH9133sWqNedSI8J772SXXuw7Gv81i', NULL, NULL, TO_DATE('2026-09-12 19:59:02', 'SYYYY-MM-DD HH24:MI:SS'), 'CINEMA_ADMIN', '3', '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('29', 'Noorie', 'noorie@gmail.com', '$2b$10$e.cJHndGZEjIbwgcKLyV/emLZQymYjeV.f2CG4mgZm6id9UaIMW12', NULL, NULL, TO_DATE('2026-09-08 01:16:30', 'SYYYY-MM-DD HH24:MI:SS'), 'CUSTOMER', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('53', 'Habib', 'Habib@gmail.com', '$2b$10$u7aDET8JLP/JRQX0Q.tgO.Cse2Z0i1BglO73m/81/LfTPY9mRKDhq', NULL, NULL, TO_DATE('2026-09-11 21:40:19', 'SYYYY-MM-DD HH24:MI:SS'), 'CUSTOMER', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('56', 'habib_site_admin', 'habib_site_admin@gmail.com', '$2b$10$eR4D4GumhESOQ06Gb3vP/uFuY3ZjWUIcPi1mt4Pb8e0xU/ox1XBr2', NULL, NULL, TO_DATE('2026-09-12 19:53:34', 'SYYYY-MM-DD HH24:MI:SS'), 'SITE_ADMIN', NULL, '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('57', 'habib_block_admin', 'habib_block_admin@gmail.com', '$2b$10$4lW55pWmxf8YDvx6y8WQCu78FlqvZp4PJmh8JYLNBrzkZ2kPJw972', NULL, NULL, TO_DATE('2026-09-12 19:54:34', 'SYYYY-MM-DD HH24:MI:SS'), 'CINEMA_ADMIN', '2', '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('58', 'habib_star_admin', 'habib_star_admin@gmail.com', '$2b$10$LpUZkPU.ZIccuX3ubqVmR.A4gH/YqH4cmurWwbqbQYOpzbLnVVxfW', NULL, NULL, TO_DATE('2026-09-12 19:58:13', 'SYYYY-MM-DD HH24:MI:SS'), 'CINEMA_ADMIN', '1', '1');
INSERT INTO "CINEHIVE"."APP_USER" VALUES ('55', 'habib_customer', 'habib_customer@gmail.com', '$2b$10$vpvYq3y/sMtZyWbDyXein.CPRxqGf7R/REfUOlUvyZzAYsZQFcT6a', NULL, NULL, TO_DATE('2026-09-12 19:52:36', 'SYYYY-MM-DD HH24:MI:SS'), 'CUSTOMER', NULL, '1');

-- ----------------------------
-- Table structure for BOOKING
-- ----------------------------
CREATE TABLE "CINEHIVE"."BOOKING" (
  "BOOKING_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_BOOKING".nextval NOT NULL,
  "USER_ID" NUMBER VISIBLE NOT NULL,
  "SHOWTIME_ID" NUMBER VISIBLE NOT NULL,
  "BOOKING_DATE" TIMESTAMP(6) VISIBLE DEFAULT SYSTIMESTAMP NOT NULL,
  "TOTAL_AMOUNT" NUMBER(10,2) VISIBLE DEFAULT 0 NOT NULL,
  "PAYMENT_STATUS" VARCHAR2(20 BYTE) VISIBLE DEFAULT 'PENDING' NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of BOOKING
-- ----------------------------
INSERT INTO "CINEHIVE"."BOOKING" VALUES ('62', '29', '382', TO_TIMESTAMP('2026-09-12 13:29:28.602000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1680', 'PENDING');
INSERT INTO "CINEHIVE"."BOOKING" VALUES ('61', '29', '382', TO_TIMESTAMP('2026-09-12 13:28:17.543000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '700', 'PENDING');
INSERT INTO "CINEHIVE"."BOOKING" VALUES ('64', '55', '514', TO_TIMESTAMP('2026-09-13 02:14:59.355000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1300', 'REFUNDED');
INSERT INTO "CINEHIVE"."BOOKING" VALUES ('1', '1', '1', TO_TIMESTAMP('2026-08-22 10:45:05.044000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '600', 'REFUNDED');
INSERT INTO "CINEHIVE"."BOOKING" VALUES ('21', '10', '1', TO_TIMESTAMP('2026-09-08 01:12:51.957000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '600', 'REFUNDED');
INSERT INTO "CINEHIVE"."BOOKING" VALUES ('63', '55', '253', TO_TIMESTAMP('2026-09-12 20:11:29.785000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '560', 'PENDING');
INSERT INTO "CINEHIVE"."BOOKING" VALUES ('65', '55', '514', TO_TIMESTAMP('2026-09-13 02:30:48.303000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1800', 'PENDING');
INSERT INTO "CINEHIVE"."BOOKING" VALUES ('2', '10', '3', TO_TIMESTAMP('2026-08-22 12:19:04.899000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1050', 'REFUNDED');
INSERT INTO "CINEHIVE"."BOOKING" VALUES ('22', '29', '108', TO_TIMESTAMP('2026-09-10 01:45:54.708000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '640', 'REFUNDED');
INSERT INTO "CINEHIVE"."BOOKING" VALUES ('41', '29', '78', TO_TIMESTAMP('2026-09-10 15:00:13.299000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '960', 'PENDING');
INSERT INTO "CINEHIVE"."BOOKING" VALUES ('81', '55', '413', TO_TIMESTAMP('2026-09-14 02:58:10.172000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '960', 'PENDING');

-- ----------------------------
-- Table structure for BOOKING_SEAT
-- ----------------------------
CREATE TABLE "CINEHIVE"."BOOKING_SEAT" (
  "BOOKING_ID" NUMBER VISIBLE NOT NULL,
  "SHOWTIME_ID" NUMBER VISIBLE NOT NULL,
  "SEAT_ID" NUMBER VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of BOOKING_SEAT
-- ----------------------------
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('41', '78', '1185');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('41', '78', '1186');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('22', '108', '1165');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('22', '108', '1186');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('63', '253', '1155');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('63', '253', '1176');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('61', '382', '1046');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('62', '382', '1064');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('62', '382', '1065');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('62', '382', '1066');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('61', '382', '1087');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('62', '382', '1088');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('62', '382', '1089');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('81', '413', '1084');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('81', '413', '1085');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('64', '514', '2243');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('65', '514', '2262');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('65', '514', '2265');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('65', '514', '2268');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('64', '514', '2277');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('65', '514', '2282');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('64', '514', '2284');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('64', '514', '2285');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('64', '514', '2286');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('65', '514', '2294');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('65', '514', '2295');
INSERT INTO "CINEHIVE"."BOOKING_SEAT" VALUES ('65', '514', '2296');

-- ----------------------------
-- Table structure for CINEMA
-- ----------------------------
CREATE TABLE "CINEHIVE"."CINEMA" (
  "CINEMA_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_CINEMA".nextval NOT NULL,
  "CINEMA_NAME" VARCHAR2(200 BYTE) VISIBLE NOT NULL,
  "ADDRESS" VARCHAR2(300 BYTE) VISIBLE,
  "CITY" VARCHAR2(100 BYTE) VISIBLE,
  "CONTACT_NUMBER" VARCHAR2(30 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of CINEMA
-- ----------------------------
INSERT INTO "CINEHIVE"."CINEMA" VALUES ('1', 'Star Cineplex Bashundhara', 'Bashundhara City Shopping Complex', 'Dhaka', '02-9123456');
INSERT INTO "CINEHIVE"."CINEMA" VALUES ('2', 'Blockbuster Cinemas', 'Jamuna Future Park', 'Dhaka', '02-8876543');
INSERT INTO "CINEHIVE"."CINEMA" VALUES ('3', 'Cineplex Chattogram', 'Sanmar Ocean City', 'Chattogram', '031-654321');

-- ----------------------------
-- Table structure for DIRECTOR
-- ----------------------------
CREATE TABLE "CINEHIVE"."DIRECTOR" (
  "DIRECTOR_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_DIRECTOR".nextval NOT NULL,
  "DIRECTOR_NAME" VARCHAR2(150 BYTE) VISIBLE NOT NULL,
  "DATE_OF_BIRTH" DATE VISIBLE,
  "NATIONALITY" VARCHAR2(80 BYTE) VISIBLE,
  "PHOTO_URL" VARCHAR2(500 BYTE) VISIBLE,
  "BIOGRAPHY" VARCHAR2(2000 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of DIRECTOR
-- ----------------------------
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('1', 'Christopher Nolan', TO_DATE('1970-07-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'British-American', 'https://image.tmdb.org/t/p/w500/xuAIuYSmsUzKlUMBFGVZaWsY3DZ.jpg', 'British-American filmmaker known for complex narratives and large-scale filmmaking.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('2', 'Steven Spielberg', TO_DATE('1946-12-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/tZxcg19YQ3e8fJ0pOs7hjlnmmr6.jpg', 'American filmmaker and producer known for influential blockbuster films.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('3', 'James Cameron', TO_DATE('1954-08-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Canadian', 'https://image.tmdb.org/t/p/w500/2Hh4Jos62luf90CCglP5K32qaWO.jpg', 'Canadian filmmaker known for technologically ambitious and visually spectacular films.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('4', 'Denis Villeneuve', TO_DATE('1967-10-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Canadian', 'https://image.tmdb.org/t/p/w500/zdDx9Xs93UIrJFWYApYR28J8M6b.jpg', 'Canadian filmmaker recognized for visually striking and atmospheric science-fiction films.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('5', 'Greta Gerwig', TO_DATE('1983-08-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/dxKAhpkz4XNwmRzMG5QOpXjPZ1N.jpg', 'American filmmaker and actress known for character-driven contemporary films.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('6', 'Bong Joon-ho', TO_DATE('1969-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'South Korean', 'https://image.tmdb.org/t/p/w500/stwnTvZAoD8gEJEDHpDQyLCyDy5.jpg', 'South Korean filmmaker known for combining social commentary with thriller and drama.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('7', 'Anthony Russo', TO_DATE('1970-02-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/xbINBnWn28YygYWUJ1aSAw0xPRv.jpg', 'American filmmaker known for major action and superhero productions.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('8', 'Joe Russo', TO_DATE('1971-07-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/o0OXjFzL10jCy89iAs7UzzSbyoK.jpg', 'American filmmaker and producer known for large-scale action films.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('9', 'Pete Docter', TO_DATE('1968-10-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/vITDphkNpSn1LP5gUEheAnlclnl.jpg', 'American animator and filmmaker known for acclaimed animated films.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('177', 'Syed Salahuddin Zaki', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('178', 'Tojammel Hossen Bokul', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('179', 'Chashi Nazrul Islam', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6ooPMUQPJo5wO62RgIwHKgeIqsv.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('180', 'Tanvir Mokammel', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5AC1o0IM1HWgOJVQDXtY95EO1ip.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('181', 'Tareque Masud', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kB8ZcaO8PQtE5zrsiUPEimLVYMo.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('182', 'Humayun Ahmed', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hBrZV7djlnaVtQHNGwxxcuagizG.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('183', 'Giasuddin Selim', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aGU7xxqEReryg2N6a27Fq6yGH8x.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('184', 'Mostofa Sarwar Farooki', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bkjcviQhIfuFRKXz7a9E0yUSktZ.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('185', 'David Herdies', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('186', 'Zanyar Adami', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('187', 'Amitabh Reza Chowdhury', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mLKKMeug2b8rewOTXZla1gZWPRj.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('188', 'Dipankar Dipon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7r51W7r8MhoOpmY9OPk09ZdnljK.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('189', 'Anam Biswas', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zFoTpGxsXhHW6uPDO0OPJyNx0ig.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('190', 'Tauquir Ahmed', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fBT5QkDNkzGN9Cppgt1L5qvU6QL.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('191', 'Rubaiyat Hossain', NULL, NULL, 'https://image.tmdb.org/t/p/w500/uOSr7q2hXYWfGyGMvDiol6Rs0qN.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('192', 'Taneem Rahman Angshu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nsOLsSwR39IlQfLqOog2yVJ9I9R.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('193', 'Abdullah Mohammad Saad', NULL, NULL, 'https://image.tmdb.org/t/p/w500/i8bxLlqHMgSFjeYGgcC4KOnnpZQ.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('194', 'Maïmouna Doucouré', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dpX6JfRuaCWyPC6RWTZr0zSMz8o.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('195', 'Raihan Rafi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mmJAGzMuf4be130W0ZQZY3jxHBe.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('196', 'Himel Ashraf', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zI8gNw7IlSQ18V3zSjUgC9UOqRE.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('210', 'Nathan Greno', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('30', 'Bong Joon Ho', NULL, NULL, 'https://image.tmdb.org/t/p/w500/stwnTvZAoD8gEJEDHpDQyLCyDy5.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('31', 'Alejandro G. Iñárritu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5Mx0RilUcVjXzmeKYAZJJ0WXZMQ.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('32', 'Shawn Levy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rpAvyeds9OztUQUUMmgg7eivfLY.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('33', 'Frank Darabont', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vZ50guP86otYTiBSGfi35GNHWVf.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('34', 'Francis Ford Coppola', NULL, NULL, 'https://image.tmdb.org/t/p/w500/IwGgkmW6IoJ9vuNF0T9CU3FYUX.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('35', 'Robert Zemeckis', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lPYDQ5LYNJ12rJZENtyASmVZ1Ql.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('36', 'Lana Wachowski', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4nE4ttPQBuw1virOz0LYT08c1Vm.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('37', 'Lilly Wachowski', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rCScAjSpeKA19BLNR07MqNNeeTT.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('38', 'Jonathan Demme', NULL, NULL, 'https://image.tmdb.org/t/p/w500/w9Lw3xTEFQUYELkl9AH5i3p5OhJ.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('39', 'Sam Mendes', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5z89X9rB76JDblqMQ52fviwXxAN.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('40', 'Victor Fleming', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kwMaOpQnirmXFEuvP0t7Zc94sqj.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('41', 'Michael Curtiz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/AnxPuEsdjPTJ6uIaHY0KdgBeu7t.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('42', 'Orson Welles', NULL, NULL, 'https://image.tmdb.org/t/p/w500/e9lGmqQq3EsHeUQgQLByo275hcc.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('43', 'George Lucas', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mDLDvsx8PaZoEThkBdyaG1JxPdf.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('44', 'Irvin Kershner', NULL, NULL, 'https://image.tmdb.org/t/p/w500/imtFUtcASoh2e1Emtt62UuFkIWA.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('45', 'Richard Marquand', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eEalDQpLsXJqejPDQ3MWGe95UHT.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('46', 'John McTiernan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yVfDkVbgQHD1A7JSV8Z47EjB1mU.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('47', 'George Miller', NULL, NULL, 'https://image.tmdb.org/t/p/w500/35NQ8HjFXQlGYDz9UkhT08lKl5C.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('48', 'Joss Whedon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tAcIXWQWgGzoSsw2BUBuDbCGgii.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('49', 'Jon Favreau', NULL, NULL, 'https://image.tmdb.org/t/p/w500/tnx7iMVydPQXGOoLsxXl84PXtbA.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('50', 'Bob Persichetti', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jmpNVUvvhJB2X2eOSKpveFnetM8.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('51', 'Peter Ramsey', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eAL9QdCEYyxiMP9cl9lQddg8zEa.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('52', 'Lee Unkrich', NULL, NULL, 'https://image.tmdb.org/t/p/w500/crb297utC6W4HSstOe5djDPTwEN.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('53', 'John Lasseter', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xlrE4VD2VbZCDpaNdWCpH1ZihPS.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('54', 'Andrew Stanton', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fo6ePCWEVB0L1sccrvB99Iaoqcg.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('55', 'Andrew Adamson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qqIAVKAe5LHRbPyZUlptsqlo4Kb.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('56', 'Vicky Jenson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dDSlofPZbJxtYBO2f73XjNwcFVT.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('57', 'Roger Allers', NULL, NULL, 'https://image.tmdb.org/t/p/w500/sdFyM5FNcJuMv7knrz6swaIHXIJ.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('58', 'Rob Minkoff', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fn5QA0bqJn6tk4Wt1QonjojFPjd.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('59', 'Gary Trousdale', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yczbyaRGnhWYGU5OeFtTrzVaR87.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('60', 'Kirk Wise', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7UjxOiWuIXGUrxHNSNZ7eaUCgHm.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('61', 'Ron Clements', NULL, NULL, 'https://image.tmdb.org/t/p/w500/u9k9yg2EGlDsxYo3ehf35yRUfcD.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('62', 'John Musker', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vSn1d9JpEpECu9cQbRGTFWZdLhA.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('63', 'Jennifer Lee', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cRxBIe0sa2JcBtczzysV4aFUaEy.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('64', 'Chris Buck', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ponaYm3Xr1Pki8JVDSIzfA4NkNw.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('65', 'Brad Bird', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zB9Uz0Rs1K9uwHffXRFaBwwSYI.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('66', 'Damien Chazelle', NULL, NULL, 'https://image.tmdb.org/t/p/w500/14kRZ3XxNMyBv717YQSXr3wCucy.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('67', 'Danny Boyle', NULL, NULL, 'https://image.tmdb.org/t/p/w500/b5qQpFHmgNyvV1t81ou17Jt2fRj.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('68', 'Joel Coen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rgVaJNkZCgMarUcZuUAsVfXMWk3.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('69', 'Ethan Coen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/lbL8LEcvuxNrzda37g3mysOS2qS.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('70', 'Paul Thomas Anderson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wKAs2LtLYSUzt3ZZ8pnxMwuEWuR.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('71', 'Adam McKay', NULL, NULL, 'https://image.tmdb.org/t/p/w500/vOyZXNJq7Oo01LPtSD5AZHjctgH.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('72', 'Tom McCarthy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cEA6cxG3AiH0hUzFH9mUQQVy20O.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('73', 'Noah Baumbach', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pNCt2m8jfiX3YOiCdnJT3OPxNvm.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('74', 'Kenneth Lonergan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4eIorZhYSIAnGUCOjRv45nB08FG.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('75', 'Barry Jenkins', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6nld5eQwiJmuLmyesk4EUeCaoo3.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('76', 'Steve McQueen', NULL, NULL, 'https://image.tmdb.org/t/p/w500/if4tLIZJ0EJtyhlJaSzSwMQU5Yz.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('77', 'Peter Farrelly', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3PDYOFfk5NLmNcEz6SFZmdmqVZr.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('78', 'Tom Hooper', NULL, NULL, 'https://image.tmdb.org/t/p/w500/w9Z3dlJDtWBXo4rIxGI0XY896j2.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('79', 'Ben Affleck', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aTcqu8cI4wMohU17xTdqmXKTGrw.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('80', 'Bryan Singer', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ts06thbCv9Ug2mNpcbcrmLGRL4Q.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('81', 'Bradley Cooper', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5Dhy50qOMOHfR1NZifKIfffjV9X.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('82', 'Jordan Peele', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kFUKn5g3ebpyZ3CSZZZo2HFWRNQ.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('83', 'John Krasinski', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pmVGDb6Yl6OyFcHVGbu1EYNfyFK.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('84', 'Ari Aster', NULL, NULL, 'https://image.tmdb.org/t/p/w500/45lOHyHwdMgyKm6u3jwLtyfwOjc.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('85', 'Andy Muschietti', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4ndnP2NNavhfGtJqihD4FVDsYMY.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('86', 'James Wan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bNJccMIKzCtYnndcOKniSKCzo5Y.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('87', 'Todd Phillips', NULL, NULL, 'https://image.tmdb.org/t/p/w500/A6FPht87DiqXzp456WjakLi2AtP.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('88', 'James Mangold', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pk0GDjn99crNwR4qgCCEokDYd71.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('89', 'James Gunn', NULL, NULL, 'https://image.tmdb.org/t/p/w500/pnKqZub3IlKYbyH9RRTMDOoqEn0.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('90', 'Ryan Coogler', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dux4DCDaL6c639DTXGiV7nm1wcN.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('91', 'Scott Derrickson', NULL, NULL, 'https://image.tmdb.org/t/p/w500/caapCMfXLifC7XveUiY653xWBsZ.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('92', 'Jon Watts', NULL, NULL, 'https://image.tmdb.org/t/p/w500/fkXChMX6CUXY1yOxBehAzvaTCl7.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('93', 'Joseph Kosinski', NULL, NULL, 'https://image.tmdb.org/t/p/w500/oWLUXWY0j8TYzwnf2wETYWO181S.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('94', 'Daniel Scheinert', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rb59IHeLhmyBgTeBH5LGXXIt3Y8.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('95', 'Daniel Kwan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rVAZLUZhuKCmdzhCsSiOf8j64IA.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('96', 'Matt Reeves', NULL, NULL, 'https://image.tmdb.org/t/p/w500/5rA459xpMt6IeJG7ZqvhLbSozEH.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('97', 'Chad Stahelski', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eRCryGwKDH4XqUlrdkERmeBWPo8.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('98', 'Edgar Wright', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3BqgbeAkNnDcIVtrDvG6LJnEkZK.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('99', 'Mathieu Kassovitz', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3FRBEdKKlxhvPWPt0jzgmSjeHwn.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('100', 'Jean-Pierre Jeunet', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4DhPaNaxYnkgxVJHVLyL5gKmKpG.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('101', 'Fernando Meirelles', NULL, NULL, 'https://image.tmdb.org/t/p/w500/usc1zwBXEHN4A6rkvJcmgWpc7rS.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('102', 'Park Chan-wook', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jsSFCVB7MhuVbSLwTgESiXEiNjt.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('103', 'Yeon Sang-ho', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dLP1p4AkU1zwJkDboct58Uub9S7.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('104', 'Stanley Kubrick', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yFT0VyIelI9aegZrsAwOG5iVP4v.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('105', 'Alfonso Cuarón', NULL, NULL, 'https://image.tmdb.org/t/p/w500/gaHhrzPfxfc3cbQLkDt54gtP3n1.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('106', 'Florian Henckel von Donnersmarck', NULL, NULL, 'https://image.tmdb.org/t/p/w500/3IuSW8NazUH3VlM8KYwMhTTk5lV.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('107', 'Tom Tykwer', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7Upo7OK9T1jKkpjXnZHA7bhgwlN.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('108', 'Olivier Nakache', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cLfpk5eIT8h7NnZcz6Iti3DPkRu.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('109', 'Éric Toledano', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9axN13gdsRpQLKqmvibsc9jqK2q.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('110', 'Asghar Farhadi', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mCEpFbimAvhiR3P91h5b8UEUhY.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('111', 'Akira Kurosawa', NULL, NULL, 'https://image.tmdb.org/t/p/w500/g2iwSho2vJxVz7cbD1FAKAmPD6A.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('10', 'Quentin Tarantino', TO_DATE('1963-03-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/1gjcpAa99FAOWGnrUvHEXXsRs7o.jpg', 'American film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('11', 'Martin Scorsese', TO_DATE('1942-11-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/g3DjfKsgZQWZiw30I20hZVk1oMX.jpg', 'American film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('12', 'Peter Jackson', TO_DATE('1961-10-31 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'New Zealander', 'https://image.tmdb.org/t/p/w500/bNc908d59Ba8VDNr4eCcm4G1cR.jpg', 'New Zealander film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('13', 'David Fincher', TO_DATE('1962-08-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/tpEczFclQZeKAiCeKZZ0adRvtfz.jpg', 'American film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('14', 'Sofia Coppola', TO_DATE('1971-05-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/dzHC2LxmarkBxWLhjp2DRa5oCev.jpg', 'American film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('15', 'Alejandro Inarritu', TO_DATE('1963-08-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Mexican', 'https://image.tmdb.org/t/p/w500/5Mx0RilUcVjXzmeKYAZJJ0WXZMQ.jpg', 'Mexican film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('16', 'Ridley Scott', TO_DATE('1937-11-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'British', 'https://image.tmdb.org/t/p/w500/zABJmN9opmqD4orWl3KSdCaSo7Q.jpg', 'British film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('17', 'Wes Anderson', TO_DATE('1969-05-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/s03CeUeC5yAXyB1acqP0zGNo2SC.jpg', 'American film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('18', 'Hayao Miyazaki', TO_DATE('1941-01-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Japanese', 'https://image.tmdb.org/t/p/w500/ouhjt9KugzhWtdEyBPipihB3ic8.jpg', 'Japanese film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('19', 'Taika Waititi', TO_DATE('1975-08-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'New Zealander', 'https://image.tmdb.org/t/p/w500/ww6L2ksfJNMbuiIdDuvVKndUHsv.jpg', 'New Zealander film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('20', 'Kathryn Bigelow', TO_DATE('1951-11-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'American', 'https://image.tmdb.org/t/p/w500/ee1zr5G7L54lvtjGCD2JUyyk4UX.jpg', 'American film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('21', 'Guillermo del Toro', TO_DATE('1964-10-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Mexican', 'https://image.tmdb.org/t/p/w500/cWvt8FdPAH0j3QtLzAN1j7ZJJrr.jpg', 'Mexican film director.');
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('112', 'Giuseppe Tornatore', NULL, NULL, 'https://image.tmdb.org/t/p/w500/t5PurTT9QuvV5Xs9Q2JzVui5oqF.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('113', 'Roberto Benigni', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ba1Sg02XxCphu6E1dWDMAH1GzeE.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('114', 'Jean Renoir', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ePLyIIgSud1ZhhaLtj1yFo2diC4.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('115', 'Ingmar Bergman', NULL, NULL, 'https://image.tmdb.org/t/p/w500/nkmOaXNRoioViN9OQf2n9Iu6akA.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('116', 'Federico Fellini', NULL, NULL, 'https://image.tmdb.org/t/p/w500/r0GTpMWUrxgPRbMmv38mNggOBvA.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('117', 'Fritz Lang', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9dz4PmFzlSyexldWrOXBLLpkBqB.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('118', 'F. W. Murnau', NULL, NULL, 'https://image.tmdb.org/t/p/w500/keLp43iiIkkllroUwExIJITeR7a.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('119', 'Ramesh Sippy', NULL, NULL, 'https://image.tmdb.org/t/p/w500/cI0ToZpcju84KjmXSzRuTD8a9V2.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('120', 'Aditya Chopra', NULL, NULL, 'https://image.tmdb.org/t/p/w500/eXYKfA6bg12pn9LPrWeRfxYQwcb.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('121', 'Ashutosh Gowariker', NULL, NULL, 'https://image.tmdb.org/t/p/w500/s48qPtQJVXdwrVfezMIiyowl3eT.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('122', 'Rajkumar Hirani', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wNnmF3mzG7kyaTYuFr5uMpHIJSw.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('123', 'Nitesh Tiwari', NULL, NULL, 'https://image.tmdb.org/t/p/w500/h80yPI8rDKlUk29dWFFl6Is8J0P.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('124', 'Anurag Kashyap', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wS1aF7dFDnKC44ZbFkbDcIpmFq5.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('125', 'Zoya Akhtar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ukj424TfDZCrRwYwQVAWl2nJ3ON.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('126', 'Patrice Chéreau', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hsdqKnOsxeFTaSkveIsgPV4Nida.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('127', 'Sriram Raghavan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/wSm4CkL6LxdDxg7t1kBzy0Gi8Fs.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('128', 'Anubhav Sinha', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rWvTtDwSoKgTy3zSeZoMWGRkNmw.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('129', 'Ritesh Batra', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('130', 'Aamir Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/6uiZSwi2kvd1jZ7X7Xz9W9VGuV4.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('131', 'Rakeysh Omprakash Mehra', NULL, NULL, 'https://image.tmdb.org/t/p/w500/jNh2boPrLcAzxwIdI8FnBsEtfCr.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('132', 'Anurag Basu', NULL, NULL, 'https://image.tmdb.org/t/p/w500/o1hGaRlxLaPrJ0CIhm6fMtmrudb.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('133', 'Sujoy Ghosh', NULL, NULL, 'https://image.tmdb.org/t/p/w500/toJ3ClvzxSQoxJrYwJQ2sslGwNo.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('134', 'Meghna Gulzar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9diynmZ1i5y8g5OhgevWmik5lEe.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('135', 'Aditya Dhar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dIZs80xvNgA7VZClECVXIHdaATb.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('136', 'Aniruddha Roy Chowdhury', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4jeITgrS6cZPrKLKRw7QxCkM4ar.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('137', 'Neeraj Ghaywan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ra3sCwqVrPPRf7vUGojoyEhpH3m.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('138', 'Amit Masurkar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/kmts2Cc3756H6d1ekWKaXiIEPUA.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('139', 'Rahi Anil Barve', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xIkbIU29HEb27rt77mIGP4N8gw7.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('140', 'Amar Kaushik', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mFFFMV4uH36RxcBqAlgIoeF8ZgU.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('141', 'Kabir Khan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hxiBucUGDTsBS4BP9Z1nGGmGWI7.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('142', 'Imtiaz Ali', NULL, NULL, 'https://image.tmdb.org/t/p/w500/FLcxKO8DEjtzXvAz8xLN2gMeO9.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('143', 'Nikkhil Advani', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9A2mlvEixMdttPdymVx5xgArihS.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('144', 'Sanjay Leela Bhansali', NULL, NULL, 'https://image.tmdb.org/t/p/w500/aQ1TFMLCvemgbfH5BkIwfg20mf4.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('145', 'Rohit Shetty', NULL, NULL, 'https://image.tmdb.org/t/p/w500/9ZRyKwijT7OAMjIEEPATeTZ2ZQn.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('146', 'K. Asif', NULL, NULL, 'https://image.tmdb.org/t/p/w500/clsITgyo39Mc57DxndZ4G0hzOVJ.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('147', 'Mani Ratnam', NULL, NULL, 'https://image.tmdb.org/t/p/w500/iXRdku91Hp8nHSL3uWxnInxN6TH.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('148', 'Suresh Krissna', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bXCNqiD39dBcCAmtuf7IZTKzMG2.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('149', 'Lokesh Kanagaraj', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yym15SAcSzIe6xzxOWCgDWiSaZN.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('150', 'Li Dachuan', NULL, NULL, NULL, NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('151', 'Pushkar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/hgYt9jkomW0DOqQi3qOioyaZInI.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('152', 'Gayathri', NULL, NULL, 'https://image.tmdb.org/t/p/w500/A47bGCr8UI3pOrlvsepM0OyrhOR.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('153', 'C. Prem Kumar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/g0FBgpYuF0KFA4IYVtf0slyB3t0.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('154', 'Thiagarajan Kumararaja', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1Q827qAGjW4OL8v1F5XcOZyvKry.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('155', 'T. J. Gnanavel', NULL, NULL, 'https://image.tmdb.org/t/p/w500/sdloJVOR5PYwXQTLl5UihynYh9m.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('156', 'Sudha Kongara Prasad', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ofsmrUzaSqEK5JXmbAdSD21uaYS.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('157', 'Vetrimaaran', NULL, NULL, 'https://image.tmdb.org/t/p/w500/dEb8XJGaIqWf2eLaj4ecUlC3b2Z.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('158', 'Mari Selvaraj', NULL, NULL, 'https://image.tmdb.org/t/p/w500/h7six8EKeZtmlEwwWmCuAi9oNqV.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('159', 'Pa. Ranjith', NULL, NULL, 'https://image.tmdb.org/t/p/w500/4wnvpMpX9ZkSQaLj9PysKPIUQNr.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('160', 'Shankar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/p9fL8NqPX6m5u9cFDo8suAlunaR.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('161', 'S. S. Rajamouli', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qPskSZxvoYflC8Bye4tGNBSroy5.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('162', 'Sandeep Reddy Vanga', NULL, NULL, 'https://image.tmdb.org/t/p/w500/ik1rXY6ci6i7LDm9cV178W3txgb.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('163', 'Sukumar', NULL, NULL, 'https://image.tmdb.org/t/p/w500/7TztELIhekyJrR9jxLyuqBYZ5TF.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('164', 'Trivikram Srinivas', NULL, NULL, 'https://image.tmdb.org/t/p/w500/i8FMmDxo2tXbKyrpAJWxokeClWI.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('165', 'Gowtam Tinnanuri', NULL, NULL, 'https://image.tmdb.org/t/p/w500/yA5HYmJGGwMXqMRAXrzHbkJNAfv.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('166', 'Jeethu Joseph', NULL, NULL, 'https://image.tmdb.org/t/p/w500/47Hqs5fHKFU0uRb0qIJOncAcqNl.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('167', 'Madhu C. Narayanan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bzeQl6cLi0XwnXMynIRBwqeOjNn.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('168', 'Alphonse Puthren', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bizV6LQMKMCEAVzeIh5rEOty7av.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('169', 'Anjali Menon', NULL, NULL, 'https://image.tmdb.org/t/p/w500/bWtffI3hVjbjuTbxqnUD1hF8bgI.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('170', 'Dileesh Pothan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/mXCnvBbRynOYOE3aqGostSvCZ0N.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('171', 'Lijo Jose Pellissery', NULL, NULL, 'https://image.tmdb.org/t/p/w500/o9FdqNyBc7Z2wZJYvm4H7MKwTM0.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('172', 'Jeo Baby', NULL, NULL, 'https://image.tmdb.org/t/p/w500/rjjuaQped2aUcnXtWWT4TgH8erJ.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('173', 'Prithviraj Sukumaran', NULL, NULL, 'https://image.tmdb.org/t/p/w500/1xhG42QU8tMQRTDdP1Ed3y9GRvm.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('174', 'Satyajit Ray', NULL, NULL, 'https://image.tmdb.org/t/p/w500/qP5mjuc3dL8n9c1zeY4W6L2w38L.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('175', 'Nagraj Popatrao Manjule', NULL, NULL, 'https://image.tmdb.org/t/p/w500/zI3EZRn8tHpMzrhCkfk0QX2hDhu.jpg', NULL);
INSERT INTO "CINEHIVE"."DIRECTOR" VALUES ('176', 'Zahir Raihan', NULL, NULL, 'https://image.tmdb.org/t/p/w500/xhlPhxtA7kSlUcndYycmpx6sqqx.jpg', NULL);

-- ----------------------------
-- Table structure for DIRECTS
-- ----------------------------
CREATE TABLE "CINEHIVE"."DIRECTS" (
  "DIRECTOR_ID" NUMBER VISIBLE NOT NULL,
  "MOVIE_ID" NUMBER VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of DIRECTS
-- ----------------------------
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('1', '1');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('1', '2');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('1', '3');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('1', '4');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('2', '66');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('2', '67');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('2', '78');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('3', '9');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('3', '79');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('3', '82');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('4', '5');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('4', '53');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('5', '7');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('7', '8');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('8', '8');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('9', '10');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('9', '92');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('10', '11');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('10', '23');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('10', '35');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('10', '47');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('10', '59');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('11', '12');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('11', '24');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('11', '36');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('11', '48');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('12', '13');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('12', '25');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('12', '37');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('12', '49');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('12', '73');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('12', '74');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('13', '14');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('13', '26');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('13', '38');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('13', '50');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('13', '102');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('14', '15');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('14', '27');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('14', '39');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('14', '51');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('16', '17');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('16', '29');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('16', '41');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('16', '81');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('17', '18');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('17', '30');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('17', '42');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('17', '54');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('18', '19');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('18', '31');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('18', '43');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('18', '55');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('19', '20');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('19', '32');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('19', '56');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('20', '21');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('20', '33');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('20', '45');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('20', '57');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('21', '22');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('21', '34');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('21', '46');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('21', '58');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('30', '6');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('30', '148');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('31', '16');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('31', '28');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('31', '40');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('31', '139');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('32', '44');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('33', '60');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('33', '68');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('34', '61');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('34', '62');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('35', '63');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('35', '80');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('36', '64');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('37', '64');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('38', '65');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('39', '69');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('40', '70');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('41', '71');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('42', '72');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('43', '75');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('44', '76');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('45', '77');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('46', '83');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('47', '84');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('48', '85');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('49', '86');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('50', '87');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('51', '87');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('52', '88');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('52', '90');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('53', '89');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('54', '91');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('54', '93');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('55', '94');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('56', '94');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('57', '95');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('58', '95');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('59', '96');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('60', '96');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('61', '97');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('62', '97');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('63', '98');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('64', '98');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('65', '99');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('66', '100');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('66', '101');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('67', '103');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('68', '104');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('69', '104');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('70', '105');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('71', '106');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('72', '107');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('73', '108');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('74', '109');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('75', '110');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('76', '111');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('77', '112');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('78', '113');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('79', '114');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('80', '115');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('81', '116');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('82', '117');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('82', '118');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('83', '119');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('84', '120');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('85', '121');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('86', '122');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('87', '123');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('88', '124');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('89', '125');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('90', '126');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('91', '127');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('92', '128');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('93', '129');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('94', '130');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('95', '130');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('96', '131');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('97', '132');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('98', '133');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('99', '134');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('100', '135');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('101', '136');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('102', '137');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('102', '147');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('103', '138');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('104', '140');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('105', '141');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('105', '146');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('106', '142');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('107', '143');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('108', '144');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('109', '144');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('110', '145');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('111', '149');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('111', '150');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('111', '151');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('112', '152');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('113', '153');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('114', '154');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('115', '155');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('115', '157');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('116', '156');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('117', '158');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('118', '159');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('119', '160');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('120', '161');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('121', '162');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('121', '185');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('122', '163');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('122', '165');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('123', '164');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('124', '166');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('125', '167');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('125', '172');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('126', '168');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('127', '169');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('128', '170');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('129', '171');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('130', '173');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('131', '174');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('132', '175');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('133', '176');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('134', '177');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('135', '178');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('136', '179');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('137', '180');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('138', '181');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('139', '182');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('140', '183');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('141', '184');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('142', '186');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('143', '187');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('144', '188');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('144', '190');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('145', '189');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('146', '191');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('147', '192');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('148', '193');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('149', '194');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('149', '196');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('150', '195');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('151', '197');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('152', '197');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('153', '198');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('154', '199');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('155', '200');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('156', '201');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('157', '202');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('157', '204');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('158', '203');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('159', '205');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('160', '206');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('161', '207');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('161', '208');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('161', '209');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('161', '214');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('161', '215');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('162', '210');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('163', '211');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('163', '212');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('164', '213');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('165', '216');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('166', '217');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('167', '218');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('168', '219');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('169', '220');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('170', '221');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('170', '224');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('171', '222');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('171', '223');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('172', '225');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('173', '226');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('174', '227');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('174', '228');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('174', '229');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('174', '230');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('174', '231');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('174', '232');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('174', '233');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('175', '234');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('176', '235');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('177', '238');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('178', '240');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('179', '241');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('180', '242');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('181', '243');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('182', '244');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('183', '245');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('184', '246');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('184', '248');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('185', '247');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('186', '247');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('187', '249');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('188', '250');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('189', '251');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('190', '252');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('191', '253');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('192', '254');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('193', '255');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('194', '256');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('195', '257');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('195', '258');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('196', '259');
INSERT INTO "CINEHIVE"."DIRECTS" VALUES ('210', '261');

-- ----------------------------
-- Table structure for GENRE
-- ----------------------------
CREATE TABLE "CINEHIVE"."GENRE" (
  "GENRE_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_GENRE".nextval NOT NULL,
  "GENRE_NAME" VARCHAR2(80 BYTE) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of GENRE
-- ----------------------------
INSERT INTO "CINEHIVE"."GENRE" VALUES ('1', 'Action');
INSERT INTO "CINEHIVE"."GENRE" VALUES ('6', 'Adventure');
INSERT INTO "CINEHIVE"."GENRE" VALUES ('8', 'Animation');
INSERT INTO "CINEHIVE"."GENRE" VALUES ('5', 'Comedy');
INSERT INTO "CINEHIVE"."GENRE" VALUES ('7', 'Crime');
INSERT INTO "CINEHIVE"."GENRE" VALUES ('2', 'Drama');
INSERT INTO "CINEHIVE"."GENRE" VALUES ('3', 'Science Fiction');
INSERT INTO "CINEHIVE"."GENRE" VALUES ('4', 'Thriller');

-- ----------------------------
-- Table structure for MOVIE
-- ----------------------------
CREATE TABLE "CINEHIVE"."MOVIE" (
  "MOVIE_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_MOVIE".nextval NOT NULL,
  "TITLE" VARCHAR2(200 BYTE) VISIBLE NOT NULL,
  "RELEASE_DATE" DATE VISIBLE,
  "DURATION" NUMBER(4,0) VISIBLE,
  "LANGUAGE" VARCHAR2(50 BYTE) VISIBLE,
  "DESCRIPTION" VARCHAR2(2000 BYTE) VISIBLE,
  "TRAILER_URL" VARCHAR2(500 BYTE) VISIBLE,
  "POSTER_URL" VARCHAR2(500 BYTE) VISIBLE,
  "BOX_OFFICE" NUMBER(15,2) VISIBLE,
  "BUDGET" NUMBER(15,2) VISIBLE,
  "BACKDROP_URL" VARCHAR2(500 BYTE) VISIBLE,
  "IS_FEATURED" NUMBER(1,0) VISIBLE DEFAULT 0
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of MOVIE
-- ----------------------------
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('1', 'Inception', TO_DATE('2010-07-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '148', 'English', 'A skilled thief enters the dreams of others to steal secrets and attempts an impossible final mission.', 'https://www.youtube.com/watch?v=JE9z-gy4De4', 'https://image.tmdb.org/t/p/w500/xlaY2zyzMfkhk0HSC5VUwzoZPU1.jpg', '839000000', '160000000', NULL, '1');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('2', 'Interstellar', TO_DATE('2014-11-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '169', 'English', 'A group of astronauts travels through a wormhole in search of a new home for humanity.', 'https://www.youtube.com/watch?v=LY19rHKAaAg', 'https://image.tmdb.org/t/p/w500/yQvGrMoipbRoddT0ZR8tPoR7NfX.jpg', '731000000', '165000000', NULL, '1');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('3', 'The Dark Knight', TO_DATE('2008-07-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '152', 'English', 'Batman faces a criminal mastermind who seeks to plunge Gotham City into chaos.', 'https://www.youtube.com/watch?v=_PZpmTj1Q8Q', 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg', '1006000000', '185000000', NULL, '1');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('4', 'Oppenheimer', TO_DATE('2023-07-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '180', 'English', 'The story of J. Robert Oppenheimer and his role in the development of the atomic bomb.', 'https://www.youtube.com/watch?v=qiuSBWVdgLI', 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', '976000000', '100000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('5', 'Dune: Part Two', TO_DATE('2024-03-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '166', 'English', 'Paul Atreides joins the Fremen and seeks revenge against those responsible for destroying his family.', 'https://www.youtube.com/watch?v=U2Qp5pL3ovA', 'https://image.tmdb.org/t/p/w500/6izwz7rsy95ARzTR3poZ8H6c5pp.jpg', '714000000', '190000000', NULL, '1');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('6', 'Parasite', TO_DATE('2019-05-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '132', 'Korean', 'A struggling family gradually becomes involved with a wealthy household, leading to unexpected consequences.', 'https://www.youtube.com/watch?v=bM9QabAojCg', 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg', '258000000', '11400000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('7', 'Barbie', TO_DATE('2023-07-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '114', 'English', 'Barbie leaves her perfect world and travels to the real world to discover herself.', 'https://www.youtube.com/watch?v=Y1IgAEejvqM', 'https://image.tmdb.org/t/p/w500/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg', '1446000000', '145000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('8', 'Avengers: Endgame', TO_DATE('2019-04-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '181', 'English', 'The Avengers attempt to reverse the devastating consequences of their battle with Thanos.', 'https://www.youtube.com/watch?v=L2NAh3CIdig', 'https://image.tmdb.org/t/p/w500/ulzhLuWrPK07P1YkdWQLZnQh1JL.jpg', '2798000000', '356000000', NULL, '1');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('9', 'Titanic', TO_DATE('1997-12-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '195', 'English', 'A young couple from different social backgrounds fall in love aboard the ill-fated RMS Titanic.', 'https://www.youtube.com/watch?v=wO44qBPBG4c', 'https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg', '2264000000', '200000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('10', 'Inside Out', TO_DATE('2015-06-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '95', 'English', 'Five emotions inside a young girl''s mind try to guide her through a major life change.', 'https://www.youtube.com/watch?v=1HFv47QHWJU', 'https://image.tmdb.org/t/p/w500/2H1TmgdfNtsKlU9jKdeNyYL5y8T.jpg', '858000000', '175000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('45', 'Detroit', TO_DATE('2017-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '143', 'English', 'A drama film released in 2017, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=yv74LqiumXE', 'https://image.tmdb.org/t/p/w500/r0ldqSFASpqSM5xTrpcZGO6Ef2G.jpg', '17000000', '34000000', 'https://image.tmdb.org/t/p/w1280/5C01GuAmEJp951X7fm66SPBlsxU.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('46', 'Crimson Peak', TO_DATE('2015-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '119', 'English', 'A thriller film released in 2015, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=vLWsNDZqXpo', 'https://image.tmdb.org/t/p/w500/f9TOb5anVwZeSbYjU1qNxPk3KUk.jpg', '74000000', '55000000', 'https://image.tmdb.org/t/p/w1280/nQQIUwEEqa6sjPvnqcGbjJxbdit.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('47', 'Reservoir Dogs', TO_DATE('1992-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '99', 'English', 'A crime film released in 1992, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=2KLZ4fSXtgI', 'https://image.tmdb.org/t/p/w500/xi8Iu6qyTfyZVDVy60raIOYJJmk.jpg', '3000000', '1000000', 'https://image.tmdb.org/t/p/w1280/jwt159hXWA9Q5xpBo8hWb3zwLi7.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('48', 'Goodfellas', TO_DATE('1990-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '146', 'English', 'A crime film released in 1990, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=PTBRNXGQR9Q', 'https://image.tmdb.org/t/p/w500/9OkCLM73MIU2CrKZbqiT8Ln1wY2.jpg', '47000000', '25000000', 'https://image.tmdb.org/t/p/w1280/gILte6Zd7m1YneIr6MVhh30S9pr.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('49', 'The Lovely Bones', TO_DATE('2009-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '135', 'English', 'A drama film released in 2009, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=QydPyttFzhs', 'https://image.tmdb.org/t/p/w500/kIa9CyK2yiE4CAy7RJPGe7lztse.jpg', '94000000', '65000000', 'https://image.tmdb.org/t/p/w1280/vmonG9lV1s3CtmOQmmWUO206Xay.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('50', 'The Curious Case of Benjamin Button', TO_DATE('2008-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '166', 'English', 'A drama film released in 2008, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=lqijVXvw7_E', 'https://image.tmdb.org/t/p/w500/26wEWZYt6yJkwRVkjcbwJEFh9IS.jpg', '335000000', '150000000', 'https://image.tmdb.org/t/p/w1280/2fswjyrY3GEzeoVn6mF8pNeNcgf.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('51', 'Somewhere', TO_DATE('2010-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '97', 'English', 'A drama film released in 2010, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=iEga7Hz9a3U', 'https://image.tmdb.org/t/p/w500/zOf1sdfF4eH3CVRCpmRO5ugVGdo.jpg', '12000000', '8000000', 'https://image.tmdb.org/t/p/w1280/bzCuOfoZ9ZC9AGLs8ZVZ5yo1X16.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('154', 'The Grand Illusion', TO_DATE('1937-06-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '114', 'French', 'French prisoners of war repeatedly attempt to escape German captivity during the First World War.', 'https://www.youtube.com/watch?v=placeholder', NULL, '500000', '1000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('53', 'Blade Runner 2049', TO_DATE('2017-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '164', 'Science Fiction', 'A science fiction film released in 2017, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=geFtxCSz8xI', 'https://image.tmdb.org/t/p/w500/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg', '267000000', '150000000', 'https://image.tmdb.org/t/p/w1280/gNdLJU9TxrpGx4dkZidjys3fyy0.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('54', 'Moonrise Kingdom', TO_DATE('2012-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '94', 'English', 'A comedy film released in 2012, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=RBCRe73dZb0', 'https://image.tmdb.org/t/p/w500/y4SXcbNl6CEF2t36icuzuBioj7K.jpg', '68000000', '16000000', 'https://image.tmdb.org/t/p/w1280/bsYv9IFIGfpAV0oUbe7YTiyxhox.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('55', 'Howl''s Moving Castle', TO_DATE('2004-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '119', 'Japanese', 'A animation film released in 2004, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=ARCQf2CEr8k', 'https://image.tmdb.org/t/p/w500/13kOl2v0nD2OLbVSHnHk8GUFEhO.jpg', '236000000', '24000000', 'https://image.tmdb.org/t/p/w1280/nv5wwZou159v5OC61i4ElR7OqyY.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('56', 'Next Goal Wins', TO_DATE('2023-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '104', 'English', 'A comedy film released in 2023, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=jFkaH84fOJo', 'https://image.tmdb.org/t/p/w500/xTQCL1zGugIck8MgvJ2lXSrxENR.jpg', '8000000', '25000000', 'https://image.tmdb.org/t/p/w1280/j4TnCy7lNPrE8mX5n5ydCoLA7xW.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('57', 'Point Break', TO_DATE('1991-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '122', 'English', 'A action film released in 1991, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=KywiWyPjrOg', 'https://image.tmdb.org/t/p/w500/tlbERIghrQ4oofqlbF7H0K0EYnx.jpg', '83000000', '24000000', 'https://image.tmdb.org/t/p/w1280/yGOHbICOQwlJ20UjK8F2ChGJjvl.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('58', 'Nightmare Alley', TO_DATE('2021-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '150', 'English', 'A thriller film released in 2021, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=Q81Yf46Oj3s', 'https://image.tmdb.org/t/p/w500/vfn1feL0V9HNSXuLLpaxAW8O6LO.jpg', '40000000', '60000000', 'https://image.tmdb.org/t/p/w1280/g0YNGpmlXsgHfhGnJz3c5uyzZ1B.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('59', 'Once Upon a Time in Hollywood', TO_DATE('2019-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '161', 'English', 'A comedy film released in 2019, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=vKgITiP1UMg', 'https://image.tmdb.org/t/p/w500/8j58iEBw9pOXFD2L0nt0ZXeHviB.jpg', '377000000', '90000000', 'https://image.tmdb.org/t/p/w1280/xwgBHC2FgoIrQitl8jZwXXdsR9u.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('155', 'The Seventh Seal', TO_DATE('1957-02-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '96', 'Swedish', 'A medieval knight returning from the Crusades challenges Death to a game of chess to delay his fate.', 'https://www.youtube.com/watch?v=vZucwtdSvJ8', 'https://image.tmdb.org/t/p/w500/wcZ21zrOsy0b52AfAF50XpTiv75.jpg', '150000', '150000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('156', '8½', TO_DATE('1963-02-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '138', 'Italian', 'A blocked filmmaker wrestles with memory, fantasy, and creative anxiety while failing to start his next film.', 'https://www.youtube.com/watch?v=zzEDWwhtAHc', 'https://image.tmdb.org/t/p/w500/lLbSXLvZIsn77SeHlMZ428bCxoE.jpg', '200000', '600000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('19', 'Spirited Away', TO_DATE('2001-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '125', 'Japanese', 'A animation film released in 2001, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=GAp2_0JJskk', 'https://image.tmdb.org/t/p/w500/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg', '395000000', '19000000', 'https://image.tmdb.org/t/p/w1280/dyJvKsNs2KP8qQnAXbRwDjblViy.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('23', 'Kill Bill: Volume 1', TO_DATE('2003-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '111', 'English', 'A action film released in 2003, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=sXwXk3jcrfU', 'https://image.tmdb.org/t/p/w500/v7TaX8kXMXs5yFFGR41guUDNcnB.jpg', '180000000', '30000000', 'https://image.tmdb.org/t/p/w1280/iffzIhuLAO38Po6sh1s6ZEVwlNL.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('27', 'Marie Antoinette', TO_DATE('2006-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '123', 'English', 'A drama film released in 2006, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=yBWyKRoh98U', 'https://image.tmdb.org/t/p/w500/cybXGmv8Rjd5Os8Xml6YxMBQ0Zt.jpg', '60000000', '40000000', 'https://image.tmdb.org/t/p/w1280/9hxBNoRjEDZGjyR1JpmmtxJWmVU.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('32', 'Thor: Ragnarok', TO_DATE('2017-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '130', 'English', 'A action film released in 2017, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=ue80QwXMRHg', 'https://image.tmdb.org/t/p/w500/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg', '854000000', '180000000', 'https://image.tmdb.org/t/p/w1280/vLmHH8jAy8Jq8uBsLucd3592WGh.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('36', 'Wolf of Wall Street', TO_DATE('2013-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '180', 'English', 'A comedy film released in 2013, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=Slj4-Sv-YNA', 'https://image.tmdb.org/t/p/w500/kW9LmvYHAaS9iA0tHmZVq8hQYoq.jpg', '407000000', '100000000', 'https://image.tmdb.org/t/p/w1280/7Nwnmyzrtd0FkcRyPqmdzTPppQa.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('40', 'Babel', TO_DATE('2006-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '143', 'English', 'A drama film released in 2006, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=PqPNksLZIAk', 'https://image.tmdb.org/t/p/w500/bZByZbvU7u14WjoUJERqCRW9saN.jpg', '135000000', '25000000', 'https://image.tmdb.org/t/p/w1280/9YoLdWeBSxAdR6BqQ5uS88d3FWO.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('60', 'The Shawshank Redemption', TO_DATE('1994-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '142', 'English', 'A banker convicted of a crime he did not commit forms an unlikely bond with a fellow inmate over decades in prison.', 'https://www.youtube.com/watch?v=PLl99DlL6b4', 'https://image.tmdb.org/t/p/w500/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg', '28000000', '25000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('61', 'The Godfather', TO_DATE('1972-03-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '175', 'English', 'The aging patriarch of an organized crime family transfers control of his empire to his reluctant son.', 'https://www.youtube.com/watch?v=Ew9ngL1GZvs', 'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg', '250000000', '6000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('62', 'The Godfather Part II', TO_DATE('1974-12-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '202', 'English', 'The early life of Vito Corleone is intercut with his son Michael consolidating and expanding the family empire.', 'https://www.youtube.com/watch?v=9O1Iy9od7-A', 'https://image.tmdb.org/t/p/w500/sSuQTCZwqKrNBNIsksO9IAUoWP9.jpg', '93000000', '13000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('63', 'Forrest Gump', TO_DATE('1994-07-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '142', 'English', 'A slow-witted but kind-hearted man recounts the remarkable events of his life as they intersect with American history.', 'https://www.youtube.com/watch?v=Mj9IA9tTfio', 'https://image.tmdb.org/t/p/w500/Cw4hIUIAmSYfK9QfaUW5igp9La.jpg', '678000000', '55000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('64', 'The Matrix', TO_DATE('1999-03-31 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '136', 'English', 'A computer hacker learns the shocking truth about his reality and joins a rebellion against machine overlords.', 'https://www.youtube.com/watch?v=FVI84Dfx2-I', 'https://image.tmdb.org/t/p/w500/aOIuZAjPaRIE6CMzbazvcHuHXDc.jpg', '467000000', '63000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('65', 'The Silence of the Lambs', TO_DATE('1991-02-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '118', 'English', 'A young FBI trainee seeks the help of an imprisoned cannibalistic killer to catch another serial murderer.', 'https://www.youtube.com/watch?v=6iB21hsprAQ', 'https://image.tmdb.org/t/p/w500/uS9m8OBk1A8eM9I042bx8XXpqAq.jpg', '272000000', '19000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('66', 'Saving Private Ryan', TO_DATE('1998-07-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '169', 'English', 'A group of soldiers is sent behind enemy lines to retrieve a paratrooper whose brothers were killed in action.', 'https://www.youtube.com/watch?v=RYExstiQlLc', 'https://image.tmdb.org/t/p/w500/uqx37cS8cpHg8U35f9U5IBlrCV3.jpg', '482000000', '70000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('67', 'Schindler''s List', TO_DATE('1993-12-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '195', 'English', 'A businessman becomes an unlikely hero by saving the lives of over a thousand Jewish refugees during the Holocaust.', 'https://www.youtube.com/watch?v=v0RB-3sWbBA', 'https://image.tmdb.org/t/p/w500/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg', '322000000', '22000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('68', 'The Green Mile', TO_DATE('1999-12-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '189', 'English', 'A death row corrections officer witnesses supernatural events involving an inmate with a mysterious gift.', 'https://www.youtube.com/watch?v=Bg7epsq0OIQ', 'https://image.tmdb.org/t/p/w500/8VG8fDNiy50H4FedGwdSVUPoaJe.jpg', '286000000', '60000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('69', 'American Beauty', TO_DATE('1999-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '122', 'English', 'A suburban father undergoes a midlife crisis after becoming infatuated with his daughter''s best friend.', 'https://www.youtube.com/watch?v=XCxzXblZyfQ', 'https://image.tmdb.org/t/p/w500/wby9315QzVKdW9BonAefg8jGTTb.jpg', '356000000', '15000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('70', 'Gone with the Wind', TO_DATE('1939-12-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '238', 'English', 'A strong-willed Southern belle navigates love and survival during and after the American Civil War.', 'https://www.youtube.com/watch?v=h2oX0zQA67U', 'https://image.tmdb.org/t/p/w500/lNz2Ow0wGCAvzckW7EOjE03KcYv.jpg', '402000000', '3900000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('71', 'Casablanca', TO_DATE('1942-11-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '102', 'English', 'A cynical expatriate must choose between love and virtue as war closes in around a Moroccan city.', 'https://www.youtube.com/watch?v=MF7JH_54d8c', 'https://image.tmdb.org/t/p/w500/lGCEKlJo2CnWydQj7aamY7s1S7Q.jpg', '10500000', '950000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('72', 'Citizen Kane', TO_DATE('1941-05-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '119', 'English', 'A newspaper reporter investigates the mysterious life of a powerful and reclusive media tycoon.', 'https://www.youtube.com/watch?v=fAcLNMkzfTE', 'https://image.tmdb.org/t/p/w500/sav0jxhqiH0bPr2vZFU0Kjt2nZL.jpg', '1600000', '839000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('73', 'The Lord of the Rings: The Fellowship of the Ring', TO_DATE('2001-12-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '178', 'English', 'A young hobbit and his companions set out on a perilous journey to destroy a powerful ring.', 'https://www.youtube.com/watch?v=_nZdmwHrcnw', 'https://image.tmdb.org/t/p/w500/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg', '887000000', '93000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('75', 'Star Wars: Episode IV - A New Hope', TO_DATE('1977-05-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '121', 'English', 'A young farm boy joins a rebellion to rescue a princess and destroy an empire''s ultimate weapon.', 'https://www.youtube.com/watch?v=i-vsILeJ8_8', 'https://image.tmdb.org/t/p/w500/fai0rspsNeJCS69wHNjOdWxcI7P.jpg', '775000000', '11000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('76', 'The Empire Strikes Back', TO_DATE('1980-05-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '124', 'English', 'Rebel forces face a devastating counterattack as a young hero begins his Jedi training.', 'https://www.youtube.com/watch?v=vU6L3jXt2r8', 'https://image.tmdb.org/t/p/w500/nNAeTmF4CtdSgMDplXTDPOpYzsX.jpg', '538000000', '18000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('77', 'Return of the Jedi', TO_DATE('1983-05-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '131', 'English', 'The rebels launch a final assault to defeat the empire and rescue their captured leader.', 'https://www.youtube.com/watch?v=MAW1E3JIQZE', 'https://image.tmdb.org/t/p/w500/jQYlydvHm3kUix1f8prMucrplhm.jpg', '475000000', '32800000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('78', 'Jurassic Park', TO_DATE('1993-06-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '127', 'English', 'A theme park showcasing genetically recreated dinosaurs suffers a catastrophic security breakdown.', 'https://www.youtube.com/watch?v=Rz_FvTXa_qY', 'https://image.tmdb.org/t/p/w500/63viWuPfYQjRYLSZSZNq7dglJP5.jpg', '1046000000', '63000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('80', 'Back to the Future', TO_DATE('1985-07-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '116', 'English', 'A teenager accidentally travels back in time and must ensure his parents fall in love to save his existence.', 'https://www.youtube.com/watch?v=ez6WQ7IX72U', 'https://image.tmdb.org/t/p/w500/vN5B5WgYscRGcQpVhHl6p9DDTP0.jpg', '388000000', '19000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('81', 'Alien', TO_DATE('1979-05-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '117', 'English', 'The crew of a commercial spacecraft encounters a deadly extraterrestrial organism aboard their ship.', 'https://www.youtube.com/watch?v=sVwH0hIvV5k', 'https://image.tmdb.org/t/p/w500/vfrQk5IPloGg1v9Rzbh2Eg3VGyM.jpg', '104900000', '11000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('82', 'Aliens', TO_DATE('1986-07-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '137', 'English', 'A colony marine unit is sent to investigate the disappearance of colonists on a distant planet.', 'https://www.youtube.com/watch?v=8OxirbuHsBA', 'https://image.tmdb.org/t/p/w500/r1x5JGpyqZU8PYhbs4UcrO1Xb6x.jpg', '131000000', '18500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('84', 'Mad Max: Fury Road', TO_DATE('2015-05-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '120', 'English', 'A woman rebels against a tyrannical ruler in postapocalyptic Australia in search for her homeland.', 'https://www.youtube.com/watch?v=MonFNCgK4WE', 'https://image.tmdb.org/t/p/w500/ulcAi4dKpAjHwYGS08vNyx9H6I9.jpg', '380000000', '150000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('42', 'Fantastic Mr. Fox', TO_DATE('2009-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '87', 'English', 'A animation film released in 2009, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=VuIaCvIFWIA', 'https://image.tmdb.org/t/p/w500/bOVr292mwn3jxr1e0NmUPM1rcjo.jpg', '46000000', '40000000', 'https://image.tmdb.org/t/p/w1280/xRxSLhhjPG2D8l0BXi0KdN4IvPt.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('85', 'The Avengers', TO_DATE('2012-05-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '143', 'English', 'Earth''s mightiest heroes must come together to stop a mischievous god from enslaving humanity.', 'https://www.youtube.com/watch?v=hIR8Ar-Z4hw', 'https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg', '1519000000', '220000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('86', 'Iron Man', TO_DATE('2008-05-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '126', 'English', 'A billionaire industrialist builds a powered suit of armor to fight against evil after a life-changing accident.', 'https://www.youtube.com/watch?v=8ugaeA-nMTc', 'https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg', '585000000', '140000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('87', 'Spider-Man: Into the Spider-Verse', TO_DATE('2018-12-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '117', 'English', 'A teenager from Brooklyn becomes the Spider-Man of his universe and must team up with alternate dimension counterparts.', 'https://www.youtube.com/watch?v=tg52up16eq0', 'https://image.tmdb.org/t/p/w500/iiZZdoQBEYBv6id8su7ImL0oCbD.jpg', '384000000', '90000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('88', 'Coco', TO_DATE('2017-11-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '105', 'English', 'A young boy journeys into the Land of the Dead to uncover the truth about his family''s history.', 'https://www.youtube.com/watch?v=Rvr68u6k5sI', 'https://image.tmdb.org/t/p/w500/6Ryitt95xrO8KXuqRGm1fUuNwqF.jpg', '814000000', '175000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('89', 'Toy Story', TO_DATE('1995-11-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '81', 'English', 'A cowboy doll feels threatened when a new spaceman action figure supplants him as top toy in a boy''s room.', 'https://www.youtube.com/watch?v=QftAW9TTmuQ', 'https://image.tmdb.org/t/p/w500/sfQtVlIHljToOwYjhe21KPGzZWK.jpg', '373000000', '30000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('90', 'Toy Story 3', TO_DATE('2010-06-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '103', 'English', 'The toys are mistakenly donated to a daycare and must find a way home before their owner leaves for college.', 'https://www.youtube.com/watch?v=6c3K7LhA9Yc', 'https://image.tmdb.org/t/p/w500/AbbXspMOwdvwWZgVN0nabZq03Ec.jpg', '1067000000', '200000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('91', 'Finding Nemo', TO_DATE('2003-05-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '100', 'English', 'A clownfish father searches the ocean for his missing son with the help of a forgetful blue tang.', 'https://www.youtube.com/watch?v=SPHfeNgogVs', 'https://image.tmdb.org/t/p/w500/eHuGQ10FUzK1mdOY69wF5pGgEf5.jpg', '940000000', '94000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('92', 'Up', TO_DATE('2009-05-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '96', 'English', 'An elderly widower ties thousands of balloons to his house to fly to South America, gaining an accidental stowaway.', 'https://www.youtube.com/watch?v=Ajcdb4FAL7A', 'https://image.tmdb.org/t/p/w500/mFvoEwSfLqbcWwFsDjQebn9bzFe.jpg', '735000000', '175000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('93', 'WALL-E', TO_DATE('2008-06-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '98', 'English', 'A lonely robot on a ruined Earth falls in love with a sleek probe sent to check for habitability.', 'https://www.youtube.com/watch?v=NwGEF8B6Bcw', 'https://image.tmdb.org/t/p/w500/1OsdhvbLNLUJEi9vqQCyhAXsaRX.jpg', '521000000', '180000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('94', 'Shrek', TO_DATE('2001-05-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '90', 'English', 'An ogre teams up with a talkative donkey to rescue a princess and reclaim his swamp from a scheming lord.', 'https://www.youtube.com/watch?v=ppDwfm6e498', 'https://image.tmdb.org/t/p/w500/iB64vpL3dIObOtMZgX3RqdVdQDc.jpg', '487000000', '60000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('95', 'The Lion King', TO_DATE('1994-06-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '88', 'English', 'A young lion prince flees his kingdom after his father''s murder, only to learn the true meaning of responsibility.', 'https://www.youtube.com/watch?v=lFzVJEksoDY', 'https://image.tmdb.org/t/p/w500/sKCr78MXSLixwmZ8DyJLrpMsd15.jpg', '968000000', '45000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('96', 'Beauty and the Beast', TO_DATE('1991-11-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '84', 'English', 'A beautiful young woman falls in love with a cursed prince trapped in the form of a monstrous beast.', 'https://www.youtube.com/watch?v=UUVpyeS_fVw', 'https://image.tmdb.org/t/p/w500/hUJ0UvQ5tgE2Z9WpfuduVSdiCiU.jpg', '424000000', '25000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('97', 'Aladdin', TO_DATE('1992-11-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '90', 'English', 'A street urchin uses a genie''s wishes to become a prince and win the heart of a sultan''s daughter.', 'https://www.youtube.com/watch?v=mq05scD6PUs', 'https://image.tmdb.org/t/p/w500/eLFfl7vS8dkeG1hKp5mwbm37V83.jpg', '504000000', '28000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('99', 'Ratatouille', TO_DATE('2007-06-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '111', 'English', 'A rat with dreams of becoming a chef forms an unlikely partnership with a young kitchen worker in Paris.', 'https://www.youtube.com/watch?v=NgsQ8mVkN8w', 'https://image.tmdb.org/t/p/w500/t3vaWRPSf6WjDSamIkKDs1iQWna.jpg', '623000000', '150000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('100', 'Whiplash', TO_DATE('2014-10-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '106', 'English', 'A young jazz drummer enrolls at a cutthroat music conservatory where his talent is pushed to the brink by a ruthless instructor.', 'https://www.youtube.com/watch?v=Q7kZy3T6vRM', 'https://image.tmdb.org/t/p/w500/7fn624j5lj3xTme2SgiLCeuedmO.jpg', '49000000', '3300000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('101', 'La La Land', TO_DATE('2016-12-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '128', 'English', 'A struggling actress and a dedicated jazz musician pursue their dreams while falling in love in Los Angeles.', 'https://www.youtube.com/watch?v=_oBwwSXdO_E', 'https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg', '471000000', '30000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('103', 'Slumdog Millionaire', TO_DATE('2008-11-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '120', 'English', 'A young man from the slums of Mumbai becomes a contestant on a game show, revisiting his past to answer each question.', 'https://www.youtube.com/watch?v=AIzbwV7on6Q', 'https://image.tmdb.org/t/p/w500/5leCCi7ZF0CawAfM5Qo2ECKPprc.jpg', '378000000', '15000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('104', 'No Country for Old Men', TO_DATE('2007-11-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '122', 'English', 'A cat-and-mouse pursuit unfolds across the Texas plains after a hunter stumbles upon drug money and a ruthless killer.', 'https://www.youtube.com/watch?v=A0oNrgumrlE', 'https://image.tmdb.org/t/p/w500/6d5XOczc226jECq0LIX0siKtgHR.jpg', '171000000', '25000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('105', 'There Will Be Blood', TO_DATE('2007-12-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '158', 'English', 'A ruthless prospector builds an oil empire in early twentieth century California, at great personal cost.', 'https://www.youtube.com/watch?v=-bEwlq_7f4s', 'https://image.tmdb.org/t/p/w500/fa0RDkAlCec0STeMNAhPaF89q6U.jpg', '76000000', '25000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('106', 'The Big Short', TO_DATE('2015-12-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '130', 'English', 'A group of investors bet against the housing market before the 2008 financial crisis and profit from the collapse.', 'https://www.youtube.com/watch?v=1kQc3mmtH-o', 'https://image.tmdb.org/t/p/w500/scVEaJEwP8zUix8vgmMoJJ9Nq0w.jpg', '133000000', '28000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('108', 'Marriage Story', TO_DATE('2019-11-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '137', 'English', 'A couple''s divorce brings out the best and worst in each other as they navigate a painful legal separation.', 'https://www.youtube.com/watch?v=BHi-a1n8t7M', 'https://image.tmdb.org/t/p/w500/2JRyCKaRKyJAVpsIHeLvPw5nHmw.jpg', '20000000', '18000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('109', 'Manchester by the Sea', TO_DATE('2016-11-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '137', 'English', 'A withdrawn handyman is forced to return home to care for his nephew after his brother''s sudden death.', 'https://www.youtube.com/watch?v=NxQmuJnrjxg', 'https://image.tmdb.org/t/p/w500/o9VXYOuaJxCEKOxbA86xqtwmqYn.jpg', '79000000', '8500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('110', 'Moonlight', TO_DATE('2016-10-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '111', 'English', 'A young Black man''s journey to adulthood in Miami unfolds across three defining chapters of his life.', 'https://www.youtube.com/watch?v=9NJj12tJzqc', 'https://image.tmdb.org/t/p/w500/qLnfEmPrDjJfPyyddLJPkXmshkp.jpg', '65000000', '1500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('112', 'Green Book', TO_DATE('2018-11-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '130', 'English', 'An Italian-American bouncer is hired to drive a Black classical pianist on a concert tour through the segregated South.', 'https://www.youtube.com/watch?v=QkZxoko_HC0', 'https://image.tmdb.org/t/p/w500/7BsvSuDQuoqhWmU2fL7W2GOcZHU.jpg', '321000000', '23000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('113', 'The King''s Speech', TO_DATE('2010-11-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '118', 'English', 'Britain''s reluctant new king enlists the help of an unconventional speech therapist to overcome his stammer.', 'https://www.youtube.com/watch?v=HXMqX9s67kY', 'https://image.tmdb.org/t/p/w500/pVNKXVQFukBaCz6ML7GH3kiPlQP.jpg', '427000000', '15000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('114', 'Argo', TO_DATE('2012-10-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '120', 'English', 'A CIA operative devises a risky cover story to extract six Americans hiding during the Iran hostage crisis.', 'https://www.youtube.com/watch?v=3RrtxIci4T0', 'https://image.tmdb.org/t/p/w500/m5gPWFZFIp4UJFABgWyLkbXv8GX.jpg', '232000000', '44500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('116', 'A Star Is Born', TO_DATE('2018-10-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '136', 'English', 'A fading musician discovers and falls in love with a struggling singer, helping launch her into stardom.', 'https://www.youtube.com/watch?v=UywJmJ6ohvc', 'https://image.tmdb.org/t/p/w500/wrFpXMNBRj2PBiN4Z5kix51XaIZ.jpg', '436000000', '36000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('117', 'Get Out', TO_DATE('2017-02-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '104', 'English', 'A young Black man uncovers a disturbing secret after visiting his white girlfriend''s seemingly idyllic family estate.', 'https://www.youtube.com/watch?v=gsB70ZRY-hI', 'https://image.tmdb.org/t/p/w500/tFXcEccSQMf3lfhfXKSU9iRBpa3.jpg', '255000000', '4500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('118', 'Us', TO_DATE('2019-03-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '116', 'English', 'A family''s vacation turns into a nightmare when sinister doppelgangers begin to terrorize them.', 'https://www.youtube.com/watch?v=xaEzoWyeR3Y', 'https://image.tmdb.org/t/p/w500/bT7sMDsvWNeIGgZ6ZsisNdBcHdq.jpg', '255000000', '20000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('119', 'A Quiet Place', TO_DATE('2018-04-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '90', 'English', 'A family struggles to survive in silence while hiding from creatures that hunt anything that makes a sound.', 'https://www.youtube.com/watch?v=rqEnM25BsNQ', 'https://image.tmdb.org/t/p/w500/nAU74GmpUk7t5iklEp3bufwDq4n.jpg', '341000000', '17000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('120', 'Hereditary', TO_DATE('2018-06-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '127', 'English', 'A family unravels dark and disturbing secrets following the death of their secretive grandmother.', 'https://www.youtube.com/watch?v=MJNR58zaStE', 'https://image.tmdb.org/t/p/w500/4GFPuL14eXi66V96xBWY73Y9PfR.jpg', '80000000', '10000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('121', 'It', TO_DATE('2017-09-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '135', 'English', 'A group of children face their fears when a shape-shifting entity begins terrorizing their small town.', 'https://www.youtube.com/watch?v=xKJmEC5ieOk', 'https://image.tmdb.org/t/p/w500/9E2y5Q7WlCVNEhP5GiVTjhEhx1o.jpg', '700000000', '35000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('122', 'The Conjuring', TO_DATE('2013-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '112', 'English', 'Paranormal investigators help a family terrorized by a dark presence in their farmhouse.', 'https://www.youtube.com/watch?v=k10ETZ41q5o', 'https://image.tmdb.org/t/p/w500/wVYREutTvI2tmxr6ujrHT704wGF.jpg', '319000000', '20000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('123', 'Joker', TO_DATE('2019-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '122', 'English', 'A failed comedian descends into madness and becomes an infamous symbol of chaos in Gotham City.', 'https://www.youtube.com/watch?v=-RFFRxcoKfA', 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg', '1074000000', '55000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('124', 'Logan', TO_DATE('2017-03-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '137', 'English', 'An aging mutant with fading powers must protect a young girl with similar abilities from dark forces.', 'https://www.youtube.com/watch?v=XaE_9pfybL4', 'https://image.tmdb.org/t/p/w500/fnbjcRDYn6YviCcePDnGdyAkYsB.jpg', '619000000', '97000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('125', 'Guardians of the Galaxy', TO_DATE('2014-08-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '121', 'English', 'A group of misfit outlaws band together to protect the galaxy from a powerful and ruthless villain.', 'https://www.youtube.com/watch?v=3CqymRQ1uUU', 'https://image.tmdb.org/t/p/w500/r7vmZjiyZw9rpJMQJdXpjgiCOk9.jpg', '773000000', '170000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('126', 'Black Panther', TO_DATE('2018-02-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '134', 'English', 'A newly crowned king must defend his technologically advanced nation from enemies both foreign and domestic.', 'https://www.youtube.com/watch?v=xjDjIWPwcPU', 'https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg', '1347000000', '200000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('127', 'Doctor Strange', TO_DATE('2016-11-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '115', 'English', 'A brilliant but arrogant surgeon discovers the mystic arts after a car accident destroys his career.', 'https://www.youtube.com/watch?v=HSzx-zryEgM', 'https://image.tmdb.org/t/p/w500/uGBVj3bEbCoZbDjjl9wTxcygko1.jpg', '677000000', '165000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('128', 'Spider-Man: No Way Home', TO_DATE('2021-12-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '148', 'English', 'A spell gone wrong causes dangerous foes from other worlds to enter a young hero''s universe.', 'https://www.youtube.com/watch?v=1mTjfMFyPi8', 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg', '1922000000', '200000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('129', 'Top Gun: Maverick', TO_DATE('2022-05-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '130', 'English', 'A veteran fighter pilot confronts his past while training a new generation of elite aviators for a dangerous mission.', 'https://www.youtube.com/watch?v=Klc__shdj88', 'https://image.tmdb.org/t/p/w500/n0YuM4f5lvGAP6MAW2kBIzugXnc.jpg', '1496000000', '170000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('130', 'Everything Everywhere All at Once', TO_DATE('2022-03-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '140', 'English', 'An overwhelmed laundromat owner discovers she must connect with parallel versions of herself to save the multiverse.', 'https://www.youtube.com/watch?v=wxN1T1uxQ2g', 'https://image.tmdb.org/t/p/w500/u68AjlvlutfEIcpmbYpKcdi09ut.jpg', '143000000', '25000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('131', 'The Batman', TO_DATE('2022-03-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '176', 'English', 'A vigilante detective investigates a series of murders tied to corruption within Gotham City''s institutions.', 'https://www.youtube.com/watch?v=vc7_mH2PWHs', 'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg', '772000000', '185000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('132', 'John Wick', TO_DATE('2014-10-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '101', 'English', 'A retired hitman seeks vengeance against the gangsters who took everything from him.', 'https://www.youtube.com/watch?v=6r0s41Ju5XA', 'https://image.tmdb.org/t/p/w500/wXqWR7dHncNRbxoEGybEy7QTe9h.jpg', '86000000', '20000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('133', 'Baby Driver', TO_DATE('2017-06-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '113', 'English', 'A talented getaway driver tries to leave his life of crime behind after falling in love.', 'https://www.youtube.com/watch?v=jGGptGEAo2U', 'https://image.tmdb.org/t/p/w500/tYzFuYXmT8LOYASlFCkaPiAFAl0.jpg', '226000000', '34000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('135', 'Amélie', TO_DATE('2001-04-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '122', 'French', 'A whimsical waitress secretly orchestrates small acts of kindness to improve the lives of those around her.', 'https://www.youtube.com/watch?v=555A7T_kmIc', 'https://image.tmdb.org/t/p/w500/nSxDa3M9aMvGVLoItzWTepQ5h5d.jpg', '174000000', '10000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('136', 'City of God', TO_DATE('2002-08-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '130', 'Portuguese', 'Two boys growing up in a violent Rio de Janeiro slum take very different paths in life.', 'https://www.youtube.com/watch?v=dcUOO4Itgmw', 'https://image.tmdb.org/t/p/w500/k7eYdWvhYQyRQoU2TB2A2Xu2TfD.jpg', '30600000', '3300000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('137', 'Oldboy', TO_DATE('2003-11-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '120', 'Korean', 'A man seeks vengeance after being inexplicably imprisoned for fifteen years and then suddenly released.', 'https://www.youtube.com/watch?v=tAaBkFChaRg', 'https://image.tmdb.org/t/p/w500/pWDtjs568ZfOTMbURQBYuT4Qxka.jpg', '14900000', '3000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('139', 'Amores Perros', TO_DATE('2000-06-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '154', 'Spanish', 'Three separate stories intersect around a devastating car crash in Mexico City.', 'https://www.youtube.com/watch?v=_P29GF_NbDc', 'https://image.tmdb.org/t/p/w500/1lX74fPZsBoOyyE5fWL5xT7k9sV.jpg', '20900000', '2000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('141', 'Y Tu Mamá También', TO_DATE('2001-06-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '106', 'Spanish', 'Two teenage friends embark on a road trip with an older woman, uncovering hidden truths about themselves.', 'https://www.youtube.com/watch?v=inc0vS58ZKg', 'https://image.tmdb.org/t/p/w500/aj3rqjab8jfc2fWmcS3H3c5qbur.jpg', '33700000', '5000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('142', 'The Lives of Others', TO_DATE('2006-03-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '137', 'German', 'A secret police officer surveilling a playwright in East Germany becomes unexpectedly drawn into his life.', 'https://www.youtube.com/watch?v=n3_iLOp6IhM', 'https://image.tmdb.org/t/p/w500/cVUDMnskSc01rdbyH0tLATTJUdP.jpg', '77400000', '2000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('144', 'The Intouchables', TO_DATE('2011-11-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '112', 'French', 'A wealthy quadriplegic man forms an unlikely friendship with the ex-convict hired as his caretaker.', 'https://www.youtube.com/watch?v=dvdJ--DV0Uo', 'https://image.tmdb.org/t/p/w500/1QU7HKgsQbGpzsJbJK4pAVQV9F5.jpg', '426000000', '10000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('145', 'A Separation', TO_DATE('2011-03-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '123', 'Persian', 'A couple''s divorce proceedings become entangled with a criminal case involving their daughter''s caretaker.', 'https://www.youtube.com/watch?v=58Onuy5USTc', 'https://image.tmdb.org/t/p/w500/xQadpnoLokxzN3hRpCPbBGpxsiz.jpg', '23700000', '500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('146', 'Roma', TO_DATE('2018-08-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '135', 'Spanish', 'A domestic worker for a middle-class family in 1970s Mexico City navigates upheaval both personal and political.', 'https://www.youtube.com/watch?v=27gpqR5ADUs', 'https://image.tmdb.org/t/p/w500/w90ItYf9qagQKVEBr1uFxPomAtf.jpg', '200000', '15000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('148', 'Memories of Murder', TO_DATE('2003-05-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '131', 'Korean', 'Detectives in a small town struggle to catch a serial killer terrorizing the local community in the 1980s.', 'https://www.youtube.com/watch?v=0n_HQwQU8ls', 'https://image.tmdb.org/t/p/w500/jcgUjx1QcupGzjntTVlnQ15lHqy.jpg', '6900000', '2800000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('149', 'Rashomon', TO_DATE('1950-08-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '88', 'Japanese', 'A samurai''s death is recounted through four contradictory testimonies, questioning the nature of truth itself.', 'https://www.youtube.com/watch?v=L2E_DfExUmU', 'https://image.tmdb.org/t/p/w500/ijWibsAU1iBcCD8tuIZfTmDzMVE.jpg', '100000', '50000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('150', 'Seven Samurai', TO_DATE('1954-04-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '207', 'Japanese', 'A poor farming village hires seven ronin to defend it against a band of marauding bandits.', 'https://www.youtube.com/watch?v=RsRN65PlaIM', 'https://image.tmdb.org/t/p/w500/lOMGc8bnSwQhS4XyE1S99uH8NXf.jpg', '270000', '500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('152', 'Cinema Paradiso', TO_DATE('1988-11-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '155', 'Italian', 'A famous filmmaker recalls his childhood friendship with the projectionist of his small village''s cinema.', 'https://www.youtube.com/watch?v=JMyVSD6OvO8', 'https://image.tmdb.org/t/p/w500/9JhfVOveaY00o8njQu2Xrp4YWud.jpg', '11990000', '5000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('153', 'Life Is Beautiful', TO_DATE('1997-12-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '116', 'Italian', 'A father uses humor and imagination to shield his son from the horrors of a Nazi concentration camp.', 'https://www.youtube.com/watch?v=pAYEQP8gx3w', 'https://image.tmdb.org/t/p/w500/74hLDKjD5aGYOotO6esUVaeISa2.jpg', '230000000', '10000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('11', 'Pulp Fiction', TO_DATE('1994-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '154', 'English', 'A crime film released in 1994, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=tGpTpVyI_OQ', 'https://image.tmdb.org/t/p/w500/vQWk5YBFWF4bZaofAbv0tShwBvQ.jpg', '214000000', '8000000', 'https://image.tmdb.org/t/p/w1280/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('12', 'The Departed', TO_DATE('2006-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '151', 'English', 'A crime film released in 2006, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=r-MiSNsCdQ4', 'https://image.tmdb.org/t/p/w500/nT97ifVT2J1yMQmeq20Qblg61T.jpg', '291000000', '90000000', 'https://image.tmdb.org/t/p/w1280/6WRrGYalXXveItfpnipYdayFkQB.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('13', 'The Hobbit: An Unexpected Journey', TO_DATE('2012-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '169', 'English', 'A adventure film released in 2012, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=CXqZK-nbZ74', 'https://image.tmdb.org/t/p/w500/yHA9Fc37VmpUA5UncTxxo3rTGVA.jpg', '1021000000', '200000000', 'https://image.tmdb.org/t/p/w1280/xyXmtuvsoM5J3yNad0nvcetpBdY.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('14', 'Gone Girl', TO_DATE('2014-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '149', 'English', 'A thriller film released in 2014, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=2-_-1nJf8Vg', 'https://image.tmdb.org/t/p/w500/ts996lKsxvjkO2yiYG0ht4qAicO.jpg', '369000000', '61000000', 'https://image.tmdb.org/t/p/w1280/iWak7wT0j6ycCc8lKr4NBz9c7n5.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('15', 'Lost in Translation', TO_DATE('2003-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '102', 'English', 'A drama film released in 2003, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=1s4YQqnbnM8', 'https://image.tmdb.org/t/p/w500/3jCLmYDIIiSMPujbwygNpqdpM8N.jpg', '119000000', '4000000', 'https://image.tmdb.org/t/p/w1280/6ITVHoipvxAS8luzKtHTbPaHLtT.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('16', 'Birdman', TO_DATE('2014-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '119', 'English', 'A drama film released in 2014, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=egYzOALlYyU', 'https://image.tmdb.org/t/p/w500/rHUg2AuIuLSIYMYFgavVwqt1jtc.jpg', '103000000', '18000000', 'https://image.tmdb.org/t/p/w1280/s0OrExdg7i3RLR7oqzHRk4q2kL4.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('17', 'The Martian', TO_DATE('2015-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '144', 'English', 'A science fiction film released in 2015, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=ej3ioOneTy8', 'https://image.tmdb.org/t/p/w500/fASz8A0yFE3QB6LgGoOfwvFSseV.jpg', '630000000', '108000000', 'https://image.tmdb.org/t/p/w1280/lzMS0CI3FLQYC5EgJoWeIaEt0lm.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('18', 'The Grand Budapest Hotel', TO_DATE('2014-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '99', 'English', 'A comedy film released in 2014, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=G1jG8HUY4zI', 'https://image.tmdb.org/t/p/w500/eWdyYQreja6JGCzqHWXpWHDrrPo.jpg', '174000000', '25000000', 'https://image.tmdb.org/t/p/w1280/jK65srQczOKTpW62wPxwwKztGgE.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('20', 'Jojo Rabbit', TO_DATE('2019-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '108', 'English', 'A comedy film released in 2019, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=tL4McUzXfFI', 'https://image.tmdb.org/t/p/w500/1mqL7VG4Ix8wmxwypmCA1HTHBky.jpg', '90000000', '14000000', 'https://image.tmdb.org/t/p/w1280/lTyikzfGgRX5ZqIfVeT26APYfRL.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('21', 'Zero Dark Thirty', TO_DATE('2012-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '157', 'English', 'A thriller film released in 2012, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=k7R2uVZYebE', 'https://image.tmdb.org/t/p/w500/wNSdSSxowM3WIqmPJNg3RagYbwP.jpg', '132000000', '40000000', 'https://image.tmdb.org/t/p/w1280/evPzxMacNWsjkUKQO4NXKe5Rl6a.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('22', 'Pan''s Labyrinth', TO_DATE('2006-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '118', 'Spanish', 'A drama film released in 2006, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=OBGKGm3RYos', 'https://image.tmdb.org/t/p/w500/z7xXihu5wHuSMWymq5VAulPVuvg.jpg', '83000000', '19000000', 'https://image.tmdb.org/t/p/w1280/6G6nqSW9S7EHA9HrYl0Z8uo2H7f.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('24', 'Shutter Island', TO_DATE('2010-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '138', 'English', 'A thriller film released in 2010, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=qdPw9x9h5CY', 'https://image.tmdb.org/t/p/w500/nrmXQ0zcZUL8jFLrakWc90IR8z9.jpg', '294000000', '80000000', 'https://image.tmdb.org/t/p/w1280/rbZvGN1A1QyZuoKzhCw8QPmf2q0.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('25', 'The Lord of the Rings: The Two Towers', TO_DATE('2002-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '179', 'English', 'A adventure film released in 2002, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=nuTU5XcZTLA', 'https://image.tmdb.org/t/p/w500/5VTN0pR8gcqV3EPUHHfMGnJYN9L.jpg', '926000000', '94000000', 'https://image.tmdb.org/t/p/w1280/6G73mNyooWAEQTpckPSnFxFoNmc.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('26', 'Se7en', TO_DATE('1995-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '127', 'English', 'A thriller film released in 1995, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=KPOuJGkpblk', 'https://image.tmdb.org/t/p/w500/191nKfP0ehp3uIvWqgPbFmI4lv9.jpg', '327000000', '33000000', 'https://image.tmdb.org/t/p/w1280/i5H7zusQGsysGQ8i6P361Vnr0n2.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('28', 'The Revenant', TO_DATE('2015-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '156', 'English', 'A adventure film released in 2015, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=EhffABvfAW0', 'https://image.tmdb.org/t/p/w500/ji3ecJphATlVgWNY0B0RVXZizdf.jpg', '533000000', '135000000', 'https://image.tmdb.org/t/p/w1280/hEQYZq2CDB2LSJVxxlazdBOKeyW.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('29', 'Napoleon', TO_DATE('2023-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '158', 'English', 'A drama film released in 2023, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=KPr42qEdhnU', 'https://image.tmdb.org/t/p/w500/ytFOXyghxLzAM4KZyazDdEkM66q.jpg', '221000000', '200000000', 'https://image.tmdb.org/t/p/w1280/33pMXav77ICRnceEBLhL8lXTywv.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('30', 'Isle of Dogs', TO_DATE('2018-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '101', 'English', 'A animation film released in 2018, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=dt__kig8PVU', 'https://image.tmdb.org/t/p/w500/c0nUX6Q1ZB0P2t1Jo6EeFSVnOGQ.jpg', '64000000', '25000000', 'https://image.tmdb.org/t/p/w1280/goMGTcitprGu7YD6VZS4lUUwzRA.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('31', 'Princess Mononoke', TO_DATE('1997-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '134', 'Japanese', 'A animation film released in 1997, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=I1dHzoRl0sQ', 'https://image.tmdb.org/t/p/w500/cMYCDADoLKLbB83g4WnJegaZimC.jpg', '170000000', '24000000', 'https://image.tmdb.org/t/p/w1280/gl0jzn4BupSbL2qMVeqrjKkF9Js.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('33', 'The Hurt Locker', TO_DATE('2008-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '131', 'English', 'A thriller film released in 2008, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=4mgWq9wZs2o', 'https://image.tmdb.org/t/p/w500/io2dfBJhasvGbgkCX9cCGVOiA99.jpg', '49000000', '15000000', 'https://image.tmdb.org/t/p/w1280/off0xgvtfHY82l3MC4mDpCk1APY.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('34', 'The Shape of Water', TO_DATE('2017-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '123', 'English', 'A drama film released in 2017, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=oRKnlUanptY', 'https://image.tmdb.org/t/p/w500/9zfwPffUXpBrEP26yp0q1ckXDcj.jpg', '195000000', '19000000', 'https://image.tmdb.org/t/p/w1280/abirSHwWgKajV3hXhaIR5lcCIXe.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('35', 'Django Unchained', TO_DATE('2012-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '165', 'English', 'A action film released in 2012, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=_iH0UBYDI4g', 'https://image.tmdb.org/t/p/w500/7oWY8VDWW7thTzWh3OKYRkWUlD5.jpg', '425000000', '100000000', 'https://image.tmdb.org/t/p/w1280/2oZklIzUbvZXXzIFzv7Hi68d6xf.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('37', 'King Kong', TO_DATE('2005-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '187', 'English', 'A adventure film released in 2005, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=9extfjDZCts', 'https://image.tmdb.org/t/p/w500/6a2HY6UmD7XiDD3NokgaBAXEsD2.jpg', '550000000', '207000000', 'https://image.tmdb.org/t/p/w1280/mRM2NB0i3wv4HqxXvwIjEVi4Qqq.jpg', '1');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('38', 'Fight Club', TO_DATE('1999-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '139', 'English', 'A drama film released in 1999, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=dfeUzm6KF4g', 'https://image.tmdb.org/t/p/w500/jSziioSwPVrOy9Yow3XhWIBDjq1.jpg', '101000000', '63000000', 'https://image.tmdb.org/t/p/w1280/c6OLXfKAk5BKeR6broC8pYiCquX.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('39', 'The Virgin Suicides', TO_DATE('1999-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '97', 'English', 'A drama film released in 1999, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=8kDcCGlaBwY', 'https://image.tmdb.org/t/p/w500/1NCQtXPQnaHRjOZVmktA9BSM35F.jpg', '10000000', '6000000', 'https://image.tmdb.org/t/p/w1280/6b6UpsOXmjO8mJKYsGTG9HW49CN.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('41', 'Gladiator', TO_DATE('2000-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '155', 'English', 'A action film released in 2000, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=P5ieIbInFpg', 'https://image.tmdb.org/t/p/w500/wN2xWp1eIwCKOD0BHTcErTBv1Uq.jpg', '465000000', '103000000', 'https://image.tmdb.org/t/p/w1280/Ar7QuJ7sJEiC0oP3I8fKBKIQD9u.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('43', 'My Neighbor Totoro', TO_DATE('1988-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '86', 'Japanese', 'A animation film released in 1988, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=_nv94fL_IA8', 'https://image.tmdb.org/t/p/w500/rtGDOeG9LzoerkDGZF9dnVeLppL.jpg', '41000000', '5000000', 'https://image.tmdb.org/t/p/w1280/zkThiZAaAie8Lw7RAc5yPTOewBV.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('44', 'Free Guy', TO_DATE('2021-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '115', 'English', 'A comedy film released in 2021, starring an acclaimed ensemble cast.', 'https://www.youtube.com/watch?v=cttnRmcr_ME', 'https://image.tmdb.org/t/p/w500/dxraF0qPr1OEgJk17ltQTO84kQF.jpg', '331000000', '100000000', 'https://image.tmdb.org/t/p/w1280/rOJb0yQOCny0bPjg8bCLw8DyAD7.jpg', '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('157', 'Persona', TO_DATE('1966-10-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '83', 'Swedish', 'A nurse caring for a mute actress finds their identities gradually merging during an isolated seaside stay.', 'https://www.youtube.com/watch?v=8ZO01M8k1mg', 'https://image.tmdb.org/t/p/w500/hloUDKausII3Zf8ROsEZJHSkXza.jpg', '90000', '150000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('158', 'Metropolis', TO_DATE('1927-01-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '153', 'German', 'In a divided futuristic city, a wealthy young man falls for a working-class woman leading a labor uprising.', 'https://www.youtube.com/watch?v=ZAvzaOxDt2c', 'https://image.tmdb.org/t/p/w500/kr9wXRN23zLuWJIelahas1mtnYj.jpg', '1300000', '6000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('159', 'Nosferatu', TO_DATE('1922-03-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '94', 'German', 'A vampire brings terror and plague to a small German town after a young clerk''s fateful visit to his castle.', 'https://www.youtube.com/watch?v=nulvWqYUM8k', 'https://image.tmdb.org/t/p/w500/5qGIxdEO841C0tdY8vOdLoRVrr0.jpg', '180000', '50000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('140', 'The Shining', TO_DATE('1980-05-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '146', 'English', 'A writer descends into psychological horror while serving as an isolated hotel''s winter caretaker with his family.', 'https://www.youtube.com/watch?v=jAE7dNurHR4', 'https://image.tmdb.org/t/p/w500/uAR0AWqhQL1hQa69UDEbb2rE5Wx.jpg', '44000000', '19000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('74', 'The Lord of the Rings: The Return of the King', TO_DATE('2003-12-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '201', 'English', 'The final battle for Middle-earth unfolds as the fellowship''s quest to destroy the ring reaches its climax.', 'https://www.youtube.com/watch?v=zckJCxYxn1g', 'https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg', '1146000000', '94000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('79', 'Terminator 2: Judgment Day', TO_DATE('1991-07-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '137', 'English', 'A cyborg is reprogrammed to protect a young boy from a more advanced killing machine sent from the future.', 'https://www.youtube.com/watch?v=BuBD2s2NmEM', 'https://image.tmdb.org/t/p/w500/jFTVD4XoWQTcg7wdyJKa8PEds5q.jpg', '520000000', '102000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('83', 'Die Hard', TO_DATE('1988-07-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '132', 'English', 'An off-duty police officer battles terrorists who have taken over a Los Angeles skyscraper on Christmas Eve.', 'https://www.youtube.com/watch?v=4Wi28Vsi_ZU', 'https://image.tmdb.org/t/p/w500/7Bjd8kfmDSOzpmhySpEhkUyK2oH.jpg', '140000000', '28000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('98', 'Frozen', TO_DATE('2013-11-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '102', 'English', 'A princess sets out with an iceman and a reindeer to find her estranged sister and end an eternal winter.', 'https://www.youtube.com/watch?v=TbQm5doF_Uc', 'https://image.tmdb.org/t/p/w500/itAKcobTYGpYT8Phwjd8c9hleTo.jpg', '1281000000', '150000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('102', 'The Social Network', TO_DATE('2010-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '120', 'English', 'The founding of a global social networking site sparks legal battles between its creators and former friends.', 'https://www.youtube.com/watch?v=rBCNU0XT9GY', 'https://image.tmdb.org/t/p/w500/n0ybibhJtQ5icDqTp8eRytcIHJx.jpg', '225000000', '40000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('107', 'Spotlight', TO_DATE('2015-11-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '129', 'English', 'A team of investigative journalists uncovers a widespread cover-up of child abuse within a major religious institution.', 'https://www.youtube.com/watch?v=WgnrwwiIDlI', 'https://image.tmdb.org/t/p/w500/8DPGG400FgaFWaqcv11n8mRd2NG.jpg', '98000000', '20000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('111', '12 Years a Slave', TO_DATE('2013-11-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '134', 'English', 'A free Black man is kidnapped and sold into slavery, enduring years of hardship before he can prove his freedom.', 'https://www.youtube.com/watch?v=z02Ie8wKKRg', 'https://image.tmdb.org/t/p/w500/xdANQijuNrJaw1HA61rDccME4Tm.jpg', '187000000', '20000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('115', 'Bohemian Rhapsody', TO_DATE('2018-11-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '134', 'English', 'The story of a rock band''s meteoric rise, chronicled through the singer''s dazzling but troubled personal journey.', 'https://www.youtube.com/watch?v=27zlBpzdOZg', 'https://image.tmdb.org/t/p/w500/lHu1wtNaczFPGFDTrjCSzeLPTKN.jpg', '910000000', '55000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('134', 'La Haine', TO_DATE('1995-05-31 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '98', 'French', 'Three friends in a Paris housing project spend a day grappling with anger and injustice after a police shooting.', 'https://www.youtube.com/watch?v=FKwcXt3JIaU', 'https://image.tmdb.org/t/p/w500/hY4exng4s29RzDbtQInjx9MA3PZ.jpg', '1000000', '2500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('138', 'Train to Busan', TO_DATE('2016-07-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '118', 'Korean', 'Passengers on a train fight for survival as a zombie outbreak spreads across the country.', 'https://www.youtube.com/watch?v=4qm59Rcq1Fw', 'https://image.tmdb.org/t/p/w500/vNVFt6dtcqnI7hqa6LFBUibuFiw.jpg', '98500000', '8500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('143', 'Run Lola Run', TO_DATE('1998-08-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '81', 'German', 'A woman has twenty minutes to find money to save her boyfriend''s life, replayed across three possible outcomes.', 'https://www.youtube.com/watch?v=ZCYnsUdO6H0', 'https://image.tmdb.org/t/p/w500/v0giIi4bTILVhNhJajet3WWY3FA.jpg', '7300000', '1000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('147', 'The Handmaiden', TO_DATE('2016-06-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '145', 'Korean', 'A conman and a pickpocket scheme to defraud a wealthy heiress, but nothing goes as planned.', 'https://www.youtube.com/watch?v=wYsdzNIcJNc', 'https://image.tmdb.org/t/p/w500/dLlH4aNHdnmf62umnInL8xPlPzw.jpg', '18300000', '9000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('151', 'Ikiru', TO_DATE('1952-10-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '143', 'Japanese', 'A terminally ill bureaucrat searches for meaning in his final months after a lifetime of routine.', 'https://www.youtube.com/watch?v=geKhyNerWM8', 'https://image.tmdb.org/t/p/w500/dgNTS4EQDDVfkzJI5msKuHu2Ei3.jpg', '80000', '90000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('160', 'Sholay', TO_DATE('1975-08-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '204', 'Hindi', 'Two small-time criminals are hired by a former police officer to capture a ruthless bandit terrorizing his village.', 'https://www.youtube.com/watch?v=RDY97iu1_q8', 'https://image.tmdb.org/t/p/w500/ya9bwgqA4eNl5bQ9QqS0jcmRoBS.jpg', '30000000', '3000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('161', 'Dilwale Dulhania Le Jayenge', TO_DATE('1995-10-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '190', 'Hindi', 'A young man falls in love with a woman promised to another, and must win over her traditional family.', 'https://www.youtube.com/watch?v=oIZ4U21DRlM', 'https://image.tmdb.org/t/p/w500/lfRkUr7DYdHldAqi3PwdQGBRBPM.jpg', '100000000', '2000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('162', 'Lagaan', TO_DATE('2001-06-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '224', 'Hindi', 'Villagers under British colonial rule wager their future on a high-stakes cricket match to escape crushing taxation.', 'https://www.youtube.com/watch?v=rZPbpymefuE', 'https://image.tmdb.org/t/p/w500/yNX9lFRAFeNLNRIXdqZK9gYrYKa.jpg', '50000000', '6000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('163', '3 Idiots', TO_DATE('2009-12-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '170', 'Hindi', 'Two friends search for their long-lost college companion, recalling his unconventional approach to engineering and life.', 'https://www.youtube.com/watch?v=zIKu9k50SDo', 'https://image.tmdb.org/t/p/w500/66A9MqXOyVFCssoloscw79z8Tew.jpg', '90000000', '10000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('164', 'Dangal', TO_DATE('2016-12-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '161', 'Hindi', 'A former wrestler trains his daughters to become world-class wrestlers, defying entrenched social expectations.', 'https://www.youtube.com/watch?v=x_7YlGv9u1g', 'https://image.tmdb.org/t/p/w500/cJRPOLEexI7qp2DKtFfCh7YaaUG.jpg', '311000000', '10000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('165', 'PK', TO_DATE('2014-12-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '153', 'Hindi', 'An alien stranded on Earth questions human religious customs while searching for a way back home.', 'https://www.youtube.com/watch?v=SOXWc32k4zA', 'https://image.tmdb.org/t/p/w500/z2x2Y4tncefsIU7h82gmUM5vnBJ.jpg', '140000000', '18000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('166', 'Gangs of Wasseypur', TO_DATE('2012-06-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '321', 'Hindi', 'A multi-generational blood feud unfolds between rival coal-mining families in the badlands of Jharkhand.', 'https://www.youtube.com/watch?v=cSfNfckoXPc', 'https://image.tmdb.org/t/p/w500/4nbvLoPDftqXV14w5Mv14iqgVrt.jpg', '4600000', '2900000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('167', 'Zindagi Na Milegi Dobara', TO_DATE('2011-07-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '155', 'Hindi', 'Three friends confront long-buried fears and unresolved feelings during a bachelor road trip across Spain.', 'https://www.youtube.com/watch?v=FJrpcDgC3zU', 'https://image.tmdb.org/t/p/w500/hKO9O715wYxjkQSEv47giCYcyO8.jpg', '45000000', '10000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('168', 'Queen', TO_DATE('2014-03-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '146', 'Hindi', 'A jilted bride embarks solo on her honeymoon and discovers unexpected independence and self-worth.', 'https://www.youtube.com/watch?v=CnWgjtNWKXI', 'https://image.tmdb.org/t/p/w500/dCsCez4aVeXqMiALdWYp4LFsztI.jpg', '27000000', '2700000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('169', 'Andhadhun', TO_DATE('2018-10-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '139', 'Hindi', 'A blind pianist becomes entangled in a murder investigation after witnessing more than he should have.', 'https://www.youtube.com/watch?v=2iVYI99VGaw', 'https://image.tmdb.org/t/p/w500/dy3K6hNvwE05siGgiLJcEiwgpdO.jpg', '38000000', '3300000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('170', 'Article 15', TO_DATE('2019-06-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '130', 'Hindi', 'A newly posted police officer investigates the disappearance of two girls in a caste-divided rural district.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/puyn1J1NOTG7P2dYxpOIl1583yf.jpg', '17000000', '4500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('171', 'The Lunchbox', TO_DATE('2013-09-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '104', 'Hindi', 'A misdelivered lunchbox sparks an unlikely written correspondence between a lonely housewife and a widower.', 'https://www.youtube.com/watch?v=lJxLudSPxsQ', 'https://image.tmdb.org/t/p/w500/jSOiz1h97i3qwjZJXY8SeLvjPsl.jpg', '17000000', '1000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('172', 'Gully Boy', TO_DATE('2019-02-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '153', 'Hindi', 'A young man from Mumbai''s slums pursues his passion for rap music to escape a life mapped out for him.', 'https://www.youtube.com/watch?v=JfbxcD6biOk', 'https://image.tmdb.org/t/p/w500/4RE7TD5TqEXbPKyUHcn7CSeMlrJ.jpg', '32000000', '8500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('173', 'Taare Zameen Par', TO_DATE('2007-12-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '165', 'Hindi', 'An artistic teacher helps a struggling dyslexic child rediscover his confidence and creative gifts.', 'https://www.youtube.com/watch?v=tn_2Ie_jtX8', 'https://image.tmdb.org/t/p/w500/puHRt6Raovm5ujGCdwLWvRv4NHU.jpg', '20500000', '3500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('174', 'Rang De Basanti', TO_DATE('2006-01-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '167', 'Hindi', 'A documentary filmmaker''s college-age actors are radicalized into activism after a friend''s preventable death.', 'https://www.youtube.com/watch?v=l-BTOTtcGmk', 'https://image.tmdb.org/t/p/w500/f1bF8CHzEu621bPSIg6XiUNAabh.jpg', '20000000', '7000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('175', 'Barfi!', TO_DATE('2012-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '151', 'Hindi', 'A deaf and mute young man''s playful romances intertwine with the life of an autistic woman.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/5cJIx2zKjDoUtPSliou23xsReb1.jpg', '32000000', '10500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('176', 'Kahaani', TO_DATE('2012-03-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '122', 'Hindi', 'A pregnant woman searches Kolkata for her missing husband, uncovering a conspiracy far larger than she expected.', 'https://www.youtube.com/watch?v=CUj73MLqZoQ', 'https://image.tmdb.org/t/p/w500/e2eQVOrdQ8k7yYjjHKHP2nlwbTu.jpg', '16000000', '2000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('177', 'Talvar', TO_DATE('2015-10-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '132', 'Hindi', 'Investigators offer conflicting theories in a real double murder case that gripped and divided the nation.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/vye2RxyxXKeTIJBSHo0HkvFuTCR.jpg', '7400000', '2000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('178', 'Uri: The Surgical Strike', TO_DATE('2019-01-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '138', 'Hindi', 'An army officer leads a covert retaliatory strike after a deadly attack on an Indian army base.', 'https://www.youtube.com/watch?v=Cg8sbRFS3zU', 'https://image.tmdb.org/t/p/w500/yNySAgpAnWmPpYinim9E0tUzJWG.jpg', '75000000', '5900000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('179', 'Pink', TO_DATE('2016-09-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '136', 'Hindi', 'Three young women fight a courtroom battle after a harassment complaint spirals into a criminal case.', 'https://www.youtube.com/watch?v=T3BBEX_pyQA', 'https://image.tmdb.org/t/p/w500/aElHyIdF5jmctFGhlhhaPFsbBJC.jpg', '14000000', '2800000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('180', 'Masaan', TO_DATE('2015-07-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '109', 'Hindi', 'Two parallel stories of grief and forbidden love unfold along the sacred banks of the Ganges in Varanasi.', 'https://www.youtube.com/watch?v=SKJfBo3xMW0', 'https://image.tmdb.org/t/p/w500/wgcPR6Weth2yJDo5wBdNqW2TD6J.jpg', '2100000', '600000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('181', 'Newton', TO_DATE('2017-09-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '106', 'Hindi', 'An idealistic government clerk is sent to conduct elections in a conflict-riddled forest region.', 'https://www.youtube.com/watch?v=yU6zMPFd4UU', 'https://image.tmdb.org/t/p/w500/ubzHA1aXUsWvQJHjvqBCHxzTBi5.jpg', '5000000', '1000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('182', 'Tumbbad', TO_DATE('2018-10-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '104', 'Hindi', 'A family guards a cursed ancestral treasure protected by a monstrous deity that demands terrible sacrifice.', 'https://www.youtube.com/watch?v=ZjuhALyNgss', 'https://image.tmdb.org/t/p/w500/vzjZAKozbDplHWcQXbXo0APKxst.jpg', '3400000', '700000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('183', 'Stree', TO_DATE('2018-08-31 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '125', 'Hindi', 'A small town is terrorized by a spirit that abducts men at night, leaving only their clothes behind.', 'https://www.youtube.com/watch?v=gzeaGcLLl_A', 'https://image.tmdb.org/t/p/w500/euhgW6hpDYw7nxFDjqHn0eKvQPX.jpg', '75000000', '4300000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('185', 'Swades', TO_DATE('2004-12-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '210', 'Hindi', 'A NASA scientist returns to his ancestral Indian village and rediscovers his roots while confronting rural hardship.', 'https://www.youtube.com/watch?v=vc7AZNWvs0M', 'https://image.tmdb.org/t/p/w500/yUSL24kpHc9Nls4Pohia4shgcIM.jpg', '9000000', '7500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('186', 'Rockstar', TO_DATE('2011-11-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '159', 'Hindi', 'A college musician chases heartbreak to fuel his art, transforming pain into a meteoric rise to fame.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/cJZC9riwrdATBUonkZJZD6y9g40.jpg', '35000000', '10500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('187', 'Kal Ho Naa Ho', TO_DATE('2003-11-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '186', 'Hindi', 'A terminally ill man secretly orchestrates a romance between his neighbor and her reluctant best friend.', 'https://www.youtube.com/watch?v=tVMAQAsjsOU', 'https://image.tmdb.org/t/p/w500/zhMI6I0kSLnewTMwE0A8Tz3Cj2f.jpg', '44000000', '6000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('188', 'Devdas', TO_DATE('2002-07-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '185', 'Hindi', 'A wealthy man''s forbidden love is shattered by his family''s rejection, sending him into self-destructive despair.', 'https://www.youtube.com/watch?v=8tuHQWGMQwY', 'https://image.tmdb.org/t/p/w500/dUBFi7bnLRfm4WaTh4ZoF2tbBJj.jpg', '36000000', '15000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('190', 'Padmaavat', TO_DATE('2018-01-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '164', 'Hindi', 'A ruthless sultan''s obsession with a legendary queen leads his army to besiege her husband''s kingdom.', 'https://www.youtube.com/watch?v=X_5_BLt76c0', 'https://image.tmdb.org/t/p/w500/5kk71s8Vmvt8XQOojevhTA5QcB0.jpg', '117000000', '25500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('191', 'Mughal-E-Azam', TO_DATE('1960-08-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '197', 'Hindi', 'A Mughal prince''s forbidden love for a court dancer draws him into direct conflict with his emperor father.', 'https://www.youtube.com/watch?v=6PjoLgcrmcQ', 'https://image.tmdb.org/t/p/w500/lKfNZUh9CRp1EHjxgNGtrbvm55.jpg', '11000000', '10500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('192', 'Nayakan', TO_DATE('1987-11-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '145', 'Tamil', 'A young boy who witnesses his father''s murder grows into a powerful, morally complex crime boss in Mumbai''s slums.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/hnCKKPG5VkUiGQV0DTniyMTEZsT.jpg', '1500000', '1000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('194', 'Vikram', TO_DATE('2022-06-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '174', 'Tamil', 'A special task force investigates a series of murders that uncovers a much larger criminal conspiracy.', 'https://www.youtube.com/watch?v=jJf35tEkW9E', 'https://image.tmdb.org/t/p/w500/774UV1aCURb4s4JfEFg3IEMu5Zj.jpg', '150000000', '45000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('195', 'Master', TO_DATE('2021-01-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '179', 'Tamil', 'An alcoholic professor is sent to a juvenile school, where he clashes with a former student turned gangster.', 'https://www.youtube.com/watch?v=CmuEqjuzxWc', 'https://image.tmdb.org/t/p/w500/a77OcLmarwiBJakOPPC36m58t4L.jpg', '63000000', '19000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('196', 'Kaithi', TO_DATE('2019-10-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '145', 'Tamil', 'A newly released convict is forced back into danger to protect a group of police officers under siege.', 'https://www.youtube.com/watch?v=tP_dh_s27iw', 'https://image.tmdb.org/t/p/w500/hOF9CgPsy9aLr5GJEBESC8MEXFy.jpg', '23000000', '8000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('198', '96', TO_DATE('2018-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '158', 'Tamil', 'Former high school sweethearts reconnect at a reunion, reawakening feelings neither fully let go of.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/gWKZ1iLhukvLoh8XY2N4tMvRQ2M.jpg', '17000000', '3500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('199', 'Super Deluxe', TO_DATE('2019-03-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '176', 'Tamil', 'Several interwoven lives collide over one chaotic day, exposing hidden secrets and moral contradictions.', 'https://www.youtube.com/watch?v=DWwvAmVbuEI', 'https://image.tmdb.org/t/p/w500/rTsYDdFWyw87CTk4YgJO6nYmVcJ.jpg', '2700000', '1500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('200', 'Jai Bhim', TO_DATE('2021-11-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '164', 'Tamil', 'A lawyer fights to secure justice for a tribal man wrongfully imprisoned and abused in police custody.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/ehybiOtBUtrMkmtB39zQEtq1Jie.jpg', '1000000', '7000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('202', 'Asuran', TO_DATE('2019-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '141', 'Tamil', 'A farmer''s violent past resurfaces as he fights to protect his family from a powerful, vengeful landlord.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/Elnp3XrAlMM30dil8rbL7D9XeP.jpg', '20000000', '6500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('203', 'Pariyerum Perumal', TO_DATE('2018-09-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '153', 'Tamil', 'A law student''s friendship with a woman from a higher caste exposes him to brutal social discrimination.', 'https://www.youtube.com/watch?v=GMNsUxJe4R4', 'https://image.tmdb.org/t/p/w500/78YoIO3gzkZPC1jotfDmolNDmgT.jpg', '2000000', '900000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('204', 'Visaranai', TO_DATE('2015-11-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '118', 'Tamil', 'Migrant workers are wrongfully arrested and tortured by police desperate to close an unsolved robbery case.', 'https://www.youtube.com/watch?v=4mnzK2KIz9U', 'https://image.tmdb.org/t/p/w500/c1C0x8HDShlhaprftf8vDFqYkNo.jpg', '1500000', '700000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('206', 'Enthiran', TO_DATE('2010-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '159', 'Tamil', 'A brilliant scientist''s humanoid robot creation develops emotions and spirals dangerously out of control.', 'https://www.youtube.com/watch?v=fYKLIjpfuwQ', 'https://image.tmdb.org/t/p/w500/hai6CSCLxULO1RThjDP3lWAqOtQ.jpg', '95000000', '29500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('207', 'Baahubali: The Beginning', TO_DATE('2015-07-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '159', 'Telugu', 'A young man raised in a remote village discovers his royal lineage and a kingdom''s dark, buried history.', 'https://www.youtube.com/watch?v=3NQRhE772b0', 'https://image.tmdb.org/t/p/w500/9BAjt8nSSms62uOVYn1t3C3dVto.jpg', '103000000', '25000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('208', 'Baahubali 2: The Conclusion', TO_DATE('2017-04-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '167', 'Telugu', 'The saga concludes as the truth behind a king''s betrayal and exile is finally revealed.', 'https://www.youtube.com/watch?v=qD-6d8Wo3do', 'https://image.tmdb.org/t/p/w500/21sC2assImQIYCEDA84Qh9d1RsK.jpg', '277000000', '45000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('209', 'RRR', TO_DATE('2022-03-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '187', 'Telugu', 'Two real-life revolutionaries form a fictional bond of friendship before their paths diverge in colonial India.', 'https://www.youtube.com/watch?v=i4pjiLGUTtk', 'https://image.tmdb.org/t/p/w500/u0XUBNQWlOvrh0Gd97ARGpIkL0.jpg', '175000000', '72000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('210', 'Arjun Reddy', TO_DATE('2017-08-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '182', 'Telugu', 'A talented but self-destructive surgeon spirals into alcoholism and rage after losing the woman he loves.', 'https://www.youtube.com/watch?v=aozErj9NqeE', 'https://image.tmdb.org/t/p/w500/kHubDgL59I5hCn7ccBYvU7bKY1r.jpg', '10000000', '2500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('211', 'Rangasthalam', TO_DATE('2018-03-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '171', 'Telugu', 'A hearing-impaired man confronts corrupt village leadership after uncovering a decades-long political conspiracy.', 'https://www.youtube.com/watch?v=sueMmTm-M4Y', 'https://image.tmdb.org/t/p/w500/yiEzDgBBFC25Zd6z0r7sMngn5vr.jpg', '38000000', '7000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('212', 'Pushpa: The Rise', TO_DATE('2021-12-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '179', 'Telugu', 'A laborer rises through the ranks of a red sandalwood smuggling syndicate, clashing with a relentless new officer.', 'https://www.youtube.com/watch?v=ou6h-22tMnA', 'https://image.tmdb.org/t/p/w500/4DpNRjV7ITZ1GzCvrvCk86th0w.jpg', '190000000', '42000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('213', 'Ala Vaikunthapurramuloo', TO_DATE('2020-01-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '166', 'Telugu', 'A man swapped at birth navigates two very different families while chasing his own long-buried destiny.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/2rzORJaegE2bbKNVkQXbZCeV0BP.jpg', '93000000', '11500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('214', 'Eega', TO_DATE('2012-07-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '134', 'Telugu', 'A murdered man is reincarnated as a housefly and seeks revenge against the man who killed him.', 'https://www.youtube.com/watch?v=x-1ZoU1xB4I', 'https://image.tmdb.org/t/p/w500/pX7fn4EZrg2YFlV4GNMIfHDOQZ6.jpg', '36000000', '14000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('215', 'Magadheera', TO_DATE('2009-07-31 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '156', 'Telugu', 'A modern-day stunt performer discovers he is the reincarnation of a warrior separated from his lover by tragedy.', 'https://www.youtube.com/watch?v=_LaejRruLKI', 'https://image.tmdb.org/t/p/w500/xK7MEV56GF291VG0U5XnVJuvNv3.jpg', '45000000', '20000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('216', 'Jersey', TO_DATE('2019-04-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '157', 'Telugu', 'A failed cricketer stages an unlikely comeback in his late thirties to fulfill a promise to his young son.', 'https://www.youtube.com/watch?v=6tC1yOUvvMo', 'https://image.tmdb.org/t/p/w500/kz956Y83YtT6vTyg0Q40mzRe2UM.jpg', '5600000', '2200000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('217', 'Drishyam', TO_DATE('2013-07-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '160', 'Malayalam', 'A family man goes to extraordinary lengths to protect his family after covering up an accidental death.', 'https://www.youtube.com/watch?v=EtXlAVd-uBQ', 'https://image.tmdb.org/t/p/w500/gIClWRv5OSe8rl5Koi0AeUcCZ9Z.jpg', '20000000', '3000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('218', 'Kumbalangi Nights', TO_DATE('2019-05-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '135', 'Malayalam', 'Four brothers with dysfunctional relationships slowly rebuild their bond in a coastal fishing village.', 'https://www.youtube.com/watch?v=3P4BFBSafF0', 'https://image.tmdb.org/t/p/w500/lJ3RvIirE2C7gdBKvPRaoQ3iCo2.jpg', '7300000', '1000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('219', 'Premam', TO_DATE('2015-06-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '156', 'Malayalam', 'A young man''s romantic misadventures unfold across three distinct chapters of his life.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/wfMgsfDrtouYOM6MbrkHtU96Xij.jpg', '14000000', '2000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('221', 'Maheshinte Prathikaram', TO_DATE('2016-02-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '127', 'Malayalam', 'A small-town photographer trains obsessively for a rematch after being publicly humiliated in a fight.', 'https://www.youtube.com/watch?v=_KY8Du4WWew', 'https://image.tmdb.org/t/p/w500/hmK9QUWpOaSs1H7tarzlMNqT60H.jpg', '5000000', '600000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('222', 'Angamaly Diaries', TO_DATE('2017-03-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '129', 'Malayalam', 'A young man''s rise in the local pork business draws him into gang rivalries in a small Kerala town.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/fwxgQakS3vUQIzgJMphQWHxAqr2.jpg', '3800000', '750000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('223', 'Jallikattu', TO_DATE('2019-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '91', 'Malayalam', 'A buffalo''s escape from a slaughterhouse sends an entire village into a chaotic, primal frenzy.', 'https://www.youtube.com/watch?v=xD4GMBTDssU', 'https://image.tmdb.org/t/p/w500/8pEsTp9bS6yjr9P9K43vPP8mw1v.jpg', '1000000', '700000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('224', 'Joji', TO_DATE('2021-04-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '115', 'Malayalam', 'An ambitious younger son plots against his domineering family after his patriarch father falls gravely ill.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/iXAUPTb8XNSf5B4zyUAEajz2vFu.jpg', '1200000', '900000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('226', 'Lucifer', TO_DATE('2019-03-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '175', 'Malayalam', 'A political dynasty descends into crisis after its chief minister''s death, drawing a mysterious outsider into the power struggle.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/qtwN1f39HpFJD6sCN4j8T0HM3dJ.jpg', '37000000', '9500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('227', 'Pather Panchali', TO_DATE('1955-08-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '125', 'Bengali', 'A poor rural family in Bengal endures hardship and loss, seen through the eyes of their young son.', 'https://www.youtube.com/watch?v=mgv68E_o6VM', 'https://image.tmdb.org/t/p/w500/frZj5djlU9hFEjMcL21RJZVuG5O.jpg', '700000', '17000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('228', 'Aparajito', TO_DATE('1956-11-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '113', 'Bengali', 'A young man torn between his widowed mother and his growing ambitions pursues education in the city.', 'https://www.youtube.com/watch?v=mgv68E_o6VM', 'https://image.tmdb.org/t/p/w500/qvR2Qs42WHwCEcuwhQnterU3gVY.jpg', '400000', '120000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('230', 'Charulata', TO_DATE('1964-04-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '117', 'Bengali', 'A neglected wife in 19th-century Calcutta develops a quiet emotional bond with her husband''s visiting cousin.', 'https://www.youtube.com/watch?v=gFCuy_FUsdo', 'https://image.tmdb.org/t/p/w500/ei2YaCcnUBudyc6BQSc6mpCSJTx.jpg', '250000', '100000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('231', 'Nayak', TO_DATE('1966-05-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '122', 'Bengali', 'A famous film star reflects on the hollowness of fame during a long train journey with a young journalist.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/pJmyubDPcMyBtGoYXeahelWWqNb.jpg', '300000', '110000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('232', 'Sonar Kella', TO_DATE('1974-12-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '125', 'Bengali', 'A detective and his companions pursue a mystery surrounding a young boy''s visions of a golden fortress.', 'https://www.youtube.com/watch?v=placeholder', NULL, '500000', '150000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('233', 'Goopy Gyne Bagha Byne', TO_DATE('1969-05-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '132', 'Bengali', 'Two inept musicians granted magical boons by a ghost king use their gifts to stop a senseless war.', 'https://www.youtube.com/watch?v=xVgXiC2hOkg', 'https://image.tmdb.org/t/p/w500/7CtaNb9v7UAkx8eZ1tC1ODKbVse.jpg', '400000', '80000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('235', 'Jibon Theke Neya', TO_DATE('1970-04-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '144', 'Bengali', 'A large joint family''s internal power struggles serve as an allegory for political repression under authoritarian rule.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/pES4eUEWPjySmp6f59I3RzpEP1I.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('236', 'Titas Ekti Nadir Naam', TO_DATE('1973-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '159', 'Bengali', 'Fishing communities along a slowly dying river confront poverty, tradition, and the erosion of their way of life.', 'https://www.youtube.com/watch?v=5a8nYE9Q_Vg', NULL, '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('237', 'Surjo Dighal Bari', TO_DATE('1979-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '121', 'Bengali', 'A destitute rural family struggles for survival and dignity in the harsh aftermath of famine and social neglect.', 'https://www.youtube.com/watch?v=placeholder', NULL, '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('238', 'Ghuddi', TO_DATE('1980-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '110', 'Bengali', 'A young boy infatuated with cinema navigates the gap between his fantasies and the realities of family life.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/8r36eI13Z71xWMGFIgudqWa5EOg.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('239', 'Sareng Bou', TO_DATE('1978-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '130', 'Bengali', 'A riverboat captain''s devoted wife waits through long separations shaped by the rhythms of river trade.', 'https://www.youtube.com/watch?v=placeholder', NULL, '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('240', 'Beder Meye Josna', TO_DATE('1989-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '140', 'Bengali', 'A snake-charmer clan''s daughter falls in love across tribal lines, defying the customs of her nomadic community.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/cG5RywylnNyLUnSlHXkmNwsuQr5.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('242', 'Lalsalu', TO_DATE('2001-05-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '95', 'Bengali', 'A cunning wanderer exploits religious faith to seize control over a superstitious rural village.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/aQsiw5ecLLBH8GF99e7RxCAPuGs.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('243', 'Matir Moina', TO_DATE('2002-05-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '98', 'Bengali', 'A young boy sent to a rigid religious school grapples with faith, family, and a country on the edge of change.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/lpuRN4Gh2jiKhwZeHEsKjgoHZ83.jpg', '120000', '300000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('244', 'Shyamol Chhaya', TO_DATE('2004-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '100', 'Bengali', 'A group of refugees and freedom fighters shelter together in a village during the turmoil of 1971.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/k0KIqsShCTtNEHm2B2crp4eWUI7.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('245', 'Monpura', TO_DATE('2009-10-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '130', 'Bengali', 'A young man exiled to a remote river island falls into a complicated love triangle with local villagers.', 'https://www.youtube.com/watch?v=nFBIJYEiUO4', 'https://image.tmdb.org/t/p/w500/b4brqc4JBjXYy8thlKAoP5jFVH0.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('246', 'Third Person Singular Number', TO_DATE('2009-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '93', 'Bengali', 'A young woman navigates independence and hardship in Dhaka while awaiting her husband''s return from abroad.', 'https://www.youtube.com/watch?v=Q5N2ZuEppf0', 'https://image.tmdb.org/t/p/w500/6COGHlFCf8YwADcS8DYFwtev4Bh.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('247', 'Gerilla', TO_DATE('2011-03-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '115', 'Bengali', 'A woman secretly aids the resistance movement while her husband is held captive during the 1971 war.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/lqbgf7rWpztGyWc1FYwtzmapSjw.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('248', 'Television', TO_DATE('2012-12-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '105', 'Bengali', 'A conservative village leader''s ban on television is quietly defied by residents eager for connection to the outside world.', 'https://www.youtube.com/watch?v=6s1dRyQ8Zbo', 'https://image.tmdb.org/t/p/w500/wmIV5gTjiU9xOg5ZoyQqLmT73JD.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('249', 'Aynabaji', TO_DATE('2016-10-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '143', 'Bengali', 'A professional impersonator who stands in for defendants in court finds his double life spiraling out of control.', 'https://www.youtube.com/watch?v=zfTM48zbi_c', 'https://image.tmdb.org/t/p/w500/1Cz5Q7PH2JklNV7OzMkTenPGrEf.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('250', 'Dhaka Attack', TO_DATE('2017-08-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '140', 'Bengali', 'An elite police officer investigates a covert terror network plotting an attack on the capital.', 'https://www.youtube.com/watch?v=yvUCSoN9Zv8', 'https://image.tmdb.org/t/p/w500/9XSCOyTZ3g0qo0LVCkcxxzT8JwT.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('251', 'Debi', TO_DATE('2018-10-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '107', 'Bengali', 'A woman''s disturbing supernatural visions draw a detective into a mystery rooted in an old psychiatric case.', 'https://www.youtube.com/watch?v=_v9eIPXXBig', 'https://image.tmdb.org/t/p/w500/1lCqsNGxArlCgnOSzfoVX8tOIiE.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('252', 'Fagun Hawa', TO_DATE('2019-03-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '107', 'Bengali', 'Students in a small town are swept up in the 1952 language movement, risking everything for their mother tongue.', 'https://www.youtube.com/watch?v=PtF6gvcF1Hs', 'https://image.tmdb.org/t/p/w500/iMZUAqVOwZITpXCR6ytPFZSXj3k.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('253', 'Made in Bangladesh', TO_DATE('2019-05-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '95', 'Bengali', 'Garment factory workers organize to form a union despite intense pressure from management and their own families.', 'https://www.youtube.com/watch?v=A14bJ2ljHVg', 'https://image.tmdb.org/t/p/w500/o4yDdt3rVnArj1WGB2UItzoU8qR.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('254', 'No Dorai', TO_DATE('2019-12-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '143', 'Bengali', 'A young woman from a coastal village pursues a dream of competitive surfing against her family''s wishes.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/ujAMVYzeJ44nWpBBxXYFfrlz3RD.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('255', 'Rehana Maryam Noor', TO_DATE('2021-07-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '115', 'Bengali', 'A medical college professor risks her career to seek justice after witnessing the harassment of a student.', 'https://www.youtube.com/watch?v=WZNCRsVhvx8', 'https://image.tmdb.org/t/p/w500/1ZTvygaE3yMdYnV44pynFIyKtSF.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('256', 'Hawa', TO_DATE('2022-07-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '130', 'Bengali', 'Tensions and superstition rise among a fishing crew after a mysterious woman is found aboard their boat at sea.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/pwtd4TPJXi26cnEgKf3pczx4kXZ.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('257', 'Poran', TO_DATE('2022-06-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '153', 'Bengali', 'A love triangle in rural Bangladesh escalates into tragedy as old rivalries and new desires collide.', 'https://www.youtube.com/watch?v=YonjB5ZZmKc', 'https://image.tmdb.org/t/p/w500/yaiVJIEoPmwxXz1LZyjNT5fCpgx.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('258', 'Damal', TO_DATE('2022-06-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '150', 'Bengali', 'Bengali footballers form a team to raise funds for the resistance during the 1971 Liberation War.', 'https://www.youtube.com/watch?v=uDXcDGLelXk', 'https://image.tmdb.org/t/p/w500/kf2SYchdh3BJLgwC82BAqAehV0a.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('259', 'Priyotoma', TO_DATE('2023-11-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '150', 'Bengali', 'An expatriate driver''s love for a wealthy woman is tested by class differences and years of separation.', 'https://www.youtube.com/watch?v=oy7FY3k3TJc', 'https://image.tmdb.org/t/p/w500/bbVlVUS5KAO0XLKhSr5oNbbRXbG.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('184', 'Bajrangi Bhaijaan', TO_DATE('2015-07-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '163', 'Hindi', 'A devout man helps a mute Pakistani girl separated from her family find her way home across the border.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/vhlliI7HZZlWfo5d6CiyfBAGLrW.jpg', '195000000', '12000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('189', 'Chennai Express', TO_DATE('2013-08-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '141', 'Hindi', 'A man''s plan for a solo vacation is derailed when he becomes entangled with a runaway bride and her gangster family.', 'https://www.youtube.com/watch?v=rARol7Dk2zo', 'https://image.tmdb.org/t/p/w500/9j7XfhBJKNfidMCa8JsNbqU1waV.jpg', '130000000', '12000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('193', 'Baasha', TO_DATE('1995-01-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '166', 'Tamil', 'A mild-mannered auto-rickshaw driver''s violent past as a Mumbai don resurfaces to threaten his quiet new life.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/xPSw9PLzYFKTVphw9ErZcBPKUsd.jpg', '2000000', '700000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('197', 'Vikram Vedha', TO_DATE('2017-07-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '147', 'Tamil', 'A principled police officer''s moral certainty is shattered by the philosophical riddles of the gangster he hunts.', 'https://www.youtube.com/watch?v=1sVr-uWZPjE', 'https://image.tmdb.org/t/p/w500/ob9YxdzRu5lfKgz0PNrlL45dorf.jpg', '11000000', '3600000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('201', 'Soorarai Pottru', TO_DATE('2020-11-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '153', 'Tamil', 'An ambitious son of a farmer battles entrenched interests to launch India''s first low-cost airline.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/5uimlxPCgAei8JfQUDFEUQLoyyh.jpg', '6000000', '16500000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('205', 'Kabali', TO_DATE('2016-07-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '151', 'Tamil', 'A released gang leader seeks to rebuild his organization and rescue his family from rival crime networks.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/va0M1xhP3sUUERWfHeSKGVhtJHW.jpg', '45000000', '17000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('220', 'Bangalore Days', TO_DATE('2014-07-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '151', 'Malayalam', 'Three cousins navigate love, ambition, and personal crises after relocating together to the city.', 'https://www.youtube.com/watch?v=uVpHL5g4buY', 'https://image.tmdb.org/t/p/w500/iFMyZw1DTGvZ8hPa0eTseSFiRT1.jpg', '17000000', '2600000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('225', 'The Great Indian Kitchen', TO_DATE('2021-01-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '100', 'Malayalam', 'A newlywed woman''s daily domestic servitude gradually exposes the quiet oppression of traditional gender roles.', 'https://www.youtube.com/watch?v=k_E6ctiFn6I', 'https://image.tmdb.org/t/p/w500/4jgiaVOGD8sTjWlwBdx8q5JMJM3.jpg', '500000', '300000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('229', 'Apur Sansar', TO_DATE('1959-05-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '106', 'Bengali', 'A struggling writer''s unexpected marriage and subsequent fatherhood reshape his understanding of loss and love.', 'https://www.youtube.com/watch?v=mgv68E_o6VM', 'https://image.tmdb.org/t/p/w500/6Tz1Q69o2n3Zwb0ZffzPL0nFt2T.jpg', '300000', '150000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('234', 'Sairat', TO_DATE('2016-04-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '174', 'Marathi', 'Young lovers from starkly different castes elope, facing brutal consequences for defying rigid social hierarchies.', 'https://www.youtube.com/watch?v=iShPI_JF524', 'https://image.tmdb.org/t/p/w500/d8K4ZI1RSxMkIIwu5cuvZmzwohq.jpg', '48000000', '2000000', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('241', 'Ora Egaro Jon', TO_DATE('1972-03-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '130', 'Bengali', 'A group of freedmen fighters band together during the 1971 Liberation War to resist occupying forces.', 'https://www.youtube.com/watch?v=placeholder', 'https://image.tmdb.org/t/p/w500/5970NfOMWvGglPeMbRrmWJFYyZa.jpg', '0', '0', NULL, '0');
INSERT INTO "CINEHIVE"."MOVIE" VALUES ('261', 'Swapped', TO_DATE('2026-05-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '102', 'English', 'A small woodland creature and a majestic bird, two natural sworn enemies of the Valley, magically trade places and set off on an adventure of a lifetime to switch back. Their journey soon uncovers a greater threat—one that could endanger not only their species, but the entire valley they call home.', 'https://www.youtube.com/watch?v=glgmAwRDP8s', 'https://www.themoviedb.org/t/p/w600_and_h900_face/tHhxWxge06goXU6ZQH1hj7vK8Hd.jpg', NULL, NULL, NULL, '0');

-- ----------------------------
-- Table structure for MOVIE_GENRE
-- ----------------------------
CREATE TABLE "CINEHIVE"."MOVIE_GENRE" (
  "MOVIE_ID" NUMBER VISIBLE NOT NULL,
  "GENRE_ID" NUMBER VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of MOVIE_GENRE
-- ----------------------------
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('1', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('1', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('2', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('2', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('3', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('3', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('4', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('4', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('5', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('5', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('5', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('6', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('6', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('7', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('7', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('8', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('8', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('9', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('9', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('9', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('10', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('10', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('11', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('11', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('12', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('12', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('13', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('13', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('14', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('14', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('15', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('15', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('16', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('16', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('17', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('17', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('18', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('18', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('19', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('19', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('20', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('20', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('21', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('21', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('22', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('22', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('23', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('23', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('24', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('24', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('25', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('25', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('26', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('26', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('27', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('28', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('28', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('29', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('29', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('30', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('30', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('31', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('31', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('32', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('32', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('33', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('33', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('34', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('34', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('35', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('35', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('36', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('36', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('37', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('37', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('38', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('38', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('39', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('40', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('41', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('41', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('42', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('42', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('43', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('43', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('44', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('44', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('45', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('45', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('46', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('46', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('47', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('47', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('48', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('48', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('49', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('49', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('50', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('50', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('51', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('53', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('53', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('54', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('54', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('55', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('55', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('56', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('56', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('57', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('57', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('58', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('58', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('59', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('59', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('60', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('61', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('61', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('62', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('62', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('63', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('63', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('64', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('64', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('65', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('65', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('66', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('67', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('68', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('69', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('70', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('71', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('72', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('72', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('73', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('73', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('74', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('74', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('75', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('75', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('76', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('76', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('77', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('77', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('78', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('78', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('79', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('79', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('80', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('80', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('81', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('81', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('82', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('82', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('83', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('83', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('84', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('84', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('85', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('85', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('86', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('86', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('87', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('87', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('88', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('88', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('89', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('89', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('90', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('90', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('91', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('91', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('92', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('92', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('93', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('93', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('94', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('94', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('95', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('95', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('96', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('96', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('97', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('97', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('98', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('98', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('99', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('99', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('100', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('101', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('101', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('102', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('103', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('104', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('104', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('105', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('106', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('106', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('107', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('108', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('109', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('110', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('111', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('112', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('112', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('113', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('114', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('114', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('115', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('115', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('116', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('116', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('117', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('118', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('119', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('120', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('121', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('122', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('123', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('123', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('124', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('124', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('125', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('125', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('126', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('126', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('127', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('127', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('128', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('128', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('129', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('129', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('130', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('130', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('131', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('131', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('132', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('132', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('133', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('133', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('134', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('135', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('135', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('136', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('136', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('137', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('137', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('138', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('139', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('139', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('141', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('141', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('142', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('142', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('143', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('144', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('144', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('145', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('146', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('147', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('147', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('148', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('148', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('149', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('149', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('150', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('150', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('151', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('152', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('153', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('153', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('154', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('155', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('156', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('157', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('158', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('159', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('160', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('160', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('161', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('161', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('162', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('162', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('163', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('163', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('164', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('164', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('165', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('165', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('166', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('166', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('167', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('167', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('168', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('168', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('169', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('169', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('170', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('170', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('171', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('171', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('172', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('172', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('173', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('174', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('174', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('175', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('175', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('176', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('177', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('177', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('178', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('178', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('179', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('179', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('180', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('181', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('181', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('182', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('182', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('183', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('183', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('184', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('184', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('185', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('186', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('186', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('187', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('187', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('188', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('189', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('189', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('190', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('190', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('191', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('192', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('192', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('193', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('193', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('194', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('194', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('195', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('195', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('196', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('196', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('197', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('197', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('198', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('199', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('200', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('200', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('201', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('202', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('202', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('203', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('204', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('204', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('205', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('205', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('206', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('206', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('207', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('207', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('208', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('208', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('209', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('209', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('210', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('211', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('211', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('212', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('212', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('213', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('213', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('214', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('214', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('215', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('215', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('216', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('217', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('217', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('218', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('218', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('219', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('219', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('220', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('220', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('221', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('221', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('222', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('222', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('223', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('223', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('224', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('224', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('225', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('226', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('226', '7');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('227', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('228', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('229', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('230', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('231', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('232', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('232', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('233', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('233', '8');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('234', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('234', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('235', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('236', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('237', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('238', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('238', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('239', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('240', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('240', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('241', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('241', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('242', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('243', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('244', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('245', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('245', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('246', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('247', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('247', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('248', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('248', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('249', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('249', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('250', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('250', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('251', '3');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('251', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('252', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('253', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('254', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('254', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('255', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('255', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('256', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('256', '4');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('257', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('257', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('258', '1');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('258', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('259', '2');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('259', '5');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('261', '6');
INSERT INTO "CINEHIVE"."MOVIE_GENRE" VALUES ('261', '8');

-- ----------------------------
-- Table structure for PRODUCES
-- ----------------------------
CREATE TABLE "CINEHIVE"."PRODUCES" (
  "PRODUCTION_ID" NUMBER VISIBLE NOT NULL,
  "MOVIE_ID" NUMBER VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of PRODUCES
-- ----------------------------
INSERT INTO "CINEHIVE"."PRODUCES" VALUES ('1', '1');
INSERT INTO "CINEHIVE"."PRODUCES" VALUES ('1', '2');
INSERT INTO "CINEHIVE"."PRODUCES" VALUES ('1', '3');
INSERT INTO "CINEHIVE"."PRODUCES" VALUES ('1', '4');
INSERT INTO "CINEHIVE"."PRODUCES" VALUES ('1', '5');
INSERT INTO "CINEHIVE"."PRODUCES" VALUES ('3', '7');
INSERT INTO "CINEHIVE"."PRODUCES" VALUES ('3', '9');
INSERT INTO "CINEHIVE"."PRODUCES" VALUES ('4', '8');
INSERT INTO "CINEHIVE"."PRODUCES" VALUES ('5', '6');
INSERT INTO "CINEHIVE"."PRODUCES" VALUES ('5', '10');

-- ----------------------------
-- Table structure for PRODUCTION_COMPANY
-- ----------------------------
CREATE TABLE "CINEHIVE"."PRODUCTION_COMPANY" (
  "PRODUCTION_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_PRODUCTION_COMPANY".nextval NOT NULL,
  "COMPANY_NAME" VARCHAR2(200 BYTE) VISIBLE NOT NULL,
  "COUNTRY" VARCHAR2(100 BYTE) VISIBLE,
  "FOUNDED_YEAR" NUMBER(4,0) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of PRODUCTION_COMPANY
-- ----------------------------
INSERT INTO "CINEHIVE"."PRODUCTION_COMPANY" VALUES ('1', 'Warner Bros. Pictures', 'USA', '1923');
INSERT INTO "CINEHIVE"."PRODUCTION_COMPANY" VALUES ('2', 'Universal Pictures', 'USA', '1912');
INSERT INTO "CINEHIVE"."PRODUCTION_COMPANY" VALUES ('3', 'Paramount Pictures', 'USA', '1912');
INSERT INTO "CINEHIVE"."PRODUCTION_COMPANY" VALUES ('4', 'Marvel Studios', 'USA', '1993');
INSERT INTO "CINEHIVE"."PRODUCTION_COMPANY" VALUES ('5', 'Pixar Animation Studios', 'USA', '1986');

-- ----------------------------
-- Table structure for RATING
-- ----------------------------
CREATE TABLE "CINEHIVE"."RATING" (
  "USER_ID" NUMBER VISIBLE NOT NULL,
  "MOVIE_ID" NUMBER VISIBLE NOT NULL,
  "RATING_VALUE" NUMBER(2,1) VISIBLE NOT NULL,
  "RATING_DATE" TIMESTAMP(6) VISIBLE DEFAULT SYSTIMESTAMP NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of RATING
-- ----------------------------
INSERT INTO "CINEHIVE"."RATING" VALUES ('1', '1', '9', TO_TIMESTAMP('2026-07-20 10:15:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('29', '28', '9', TO_TIMESTAMP('2026-09-12 13:32:54.307000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('1', '3', '9', TO_TIMESTAMP('2026-07-21 14:20:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('55', '261', '8', TO_TIMESTAMP('2026-09-14 23:44:38.246000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('3', '4', '9', TO_TIMESTAMP('2026-07-24 19:10:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('3', '8', '9', TO_TIMESTAMP('2026-07-25 20:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('4', '5', '9', TO_TIMESTAMP('2026-07-26 13:15:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('4', '7', '7', TO_TIMESTAMP('2026-07-27 17:20:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('6', '1', '8', TO_TIMESTAMP('2026-07-30 15:40:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('6', '5', '9', TO_TIMESTAMP('2026-07-31 18:25:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('7', '3', '9', TO_TIMESTAMP('2026-08-01 11:45:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('7', '8', '9', TO_TIMESTAMP('2026-08-02 20:15:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."RATING" VALUES ('10', '45', '6', TO_TIMESTAMP('2026-09-06 20:30:37.444000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));

-- ----------------------------
-- Table structure for REVIEW
-- ----------------------------
CREATE TABLE "CINEHIVE"."REVIEW" (
  "REVIEW_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_REVIEW".nextval NOT NULL,
  "USER_ID" NUMBER VISIBLE NOT NULL,
  "MOVIE_ID" NUMBER VISIBLE NOT NULL,
  "REVIEW_TEXT" VARCHAR2(3000 BYTE) VISIBLE NOT NULL,
  "REVIEW_DATE" TIMESTAMP(6) VISIBLE DEFAULT SYSTIMESTAMP NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of REVIEW
-- ----------------------------
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('22', '29', '194', 'Great!!!', TO_TIMESTAMP('2026-09-10 21:38:33.038000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('44', '54', '194', 'sheiii', TO_TIMESTAMP('2026-09-12 13:03:07.979000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('48', '55', '129', 'hiiii', TO_TIMESTAMP('2026-09-12 19:52:49.144000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('1', '10', '1', 'good movieeee!', TO_TIMESTAMP('2026-08-23 21:52:24.567000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('41', '29', '34', 'niceeeeeeee!', TO_TIMESTAMP('2026-09-12 12:55:11.698000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('43', '54', '34', 'good!', TO_TIMESTAMP('2026-09-12 12:57:00.797000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('3', '3', '3', 'One of the best superhero films ever made. The performances and storytelling are exceptional.', TO_TIMESTAMP('2026-07-24 20:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('4', '4', '5', 'The world building and visual design are impressive. A very entertaining science-fiction movie.', TO_TIMESTAMP('2026-07-26 14:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('6', '6', '6', 'A clever and unpredictable story with strong social commentary.', TO_TIMESTAMP('2026-07-30 16:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('7', '7', '8', 'A fun and emotional superhero experience with a huge cast and memorable moments.', TO_TIMESTAMP('2026-08-02 21:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('46', '29', '194', 'what a movie!', TO_TIMESTAMP('2026-09-12 19:26:57.219000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('47', '29', '194', 'bestttt', TO_TIMESTAMP('2026-09-12 19:27:02.940000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."REVIEW" VALUES ('21', '29', '255', 'it is a great movie!', TO_TIMESTAMP('2026-09-10 21:37:48.478000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));

-- ----------------------------
-- Table structure for SCREEN
-- ----------------------------
CREATE TABLE "CINEHIVE"."SCREEN" (
  "SCREEN_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_SCREEN".nextval NOT NULL,
  "CINEMA_ID" NUMBER VISIBLE NOT NULL,
  "SCREEN_NAME" VARCHAR2(100 BYTE) VISIBLE NOT NULL,
  "CAPACITY" NUMBER(5,0) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of SCREEN
-- ----------------------------
INSERT INTO "CINEHIVE"."SCREEN" VALUES ('1', '1', 'Screen 1', '100');
INSERT INTO "CINEHIVE"."SCREEN" VALUES ('2', '1', 'Screen 2', '100');
INSERT INTO "CINEHIVE"."SCREEN" VALUES ('3', '2', 'Screen 1', '100');
INSERT INTO "CINEHIVE"."SCREEN" VALUES ('4', '2', 'Screen 2', '100');
INSERT INTO "CINEHIVE"."SCREEN" VALUES ('5', '3', 'Screen 1', '100');

-- ----------------------------
-- Table structure for SEAT
-- ----------------------------
CREATE TABLE "CINEHIVE"."SEAT" (
  "SEAT_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_SEAT".nextval NOT NULL,
  "SCREEN_ID" NUMBER VISIBLE NOT NULL,
  "ROW_NUMBER" VARCHAR2(10 BYTE) VISIBLE NOT NULL,
  "SEAT_NUMBER" NUMBER(5,0) VISIBLE NOT NULL,
  "SEAT_TYPE" VARCHAR2(30 BYTE) VISIBLE DEFAULT 'REGULAR' NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of SEAT
-- ----------------------------
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2001', '3', 'A', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2002', '3', 'A', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2003', '3', 'A', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2004', '3', 'A', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2005', '3', 'A', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2006', '3', 'A', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2007', '3', 'A', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2008', '3', 'A', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2009', '3', 'A', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2010', '3', 'A', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2011', '3', 'B', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2012', '3', 'B', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2276', '5', 'H', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2277', '5', 'H', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2278', '5', 'H', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2279', '5', 'H', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2280', '5', 'H', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2281', '5', 'I', '1', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2282', '5', 'I', '2', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2283', '5', 'I', '3', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2284', '5', 'I', '4', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2285', '5', 'I', '5', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2286', '5', 'I', '6', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2287', '5', 'I', '7', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2288', '5', 'I', '8', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2289', '5', 'I', '9', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2290', '5', 'I', '10', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2013', '3', 'B', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2014', '3', 'B', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2015', '3', 'B', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2016', '3', 'B', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2017', '3', 'B', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2018', '3', 'B', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2019', '3', 'B', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2020', '3', 'B', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2021', '3', 'C', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2022', '3', 'C', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2023', '3', 'C', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2024', '3', 'C', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2025', '3', 'C', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2026', '3', 'C', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2027', '3', 'C', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2028', '3', 'C', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2029', '3', 'C', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2030', '3', 'C', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2031', '3', 'D', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2032', '3', 'D', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2033', '3', 'D', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2034', '3', 'D', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2035', '3', 'D', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2036', '3', 'D', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2037', '3', 'D', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2038', '3', 'D', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2039', '3', 'D', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2040', '3', 'D', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2041', '3', 'E', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2042', '3', 'E', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2043', '3', 'E', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2044', '3', 'E', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2045', '3', 'E', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2046', '3', 'E', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2047', '3', 'E', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2048', '3', 'E', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2049', '3', 'E', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2050', '3', 'E', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2051', '3', 'F', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2052', '3', 'F', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2053', '3', 'F', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2054', '3', 'F', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2055', '3', 'F', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2056', '3', 'F', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2057', '3', 'F', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2058', '3', 'F', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2059', '3', 'F', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2060', '3', 'F', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2061', '3', 'G', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2062', '3', 'G', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2063', '3', 'G', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2064', '3', 'G', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2065', '3', 'G', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2066', '3', 'G', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2067', '3', 'G', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2068', '3', 'G', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2069', '3', 'G', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2070', '3', 'G', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2071', '3', 'H', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2072', '3', 'H', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2073', '3', 'H', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2074', '3', 'H', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2075', '3', 'H', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2076', '3', 'H', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2077', '3', 'H', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2078', '3', 'H', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2079', '3', 'H', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2080', '3', 'H', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2081', '3', 'I', '1', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2082', '3', 'I', '2', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2083', '3', 'I', '3', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2084', '3', 'I', '4', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2085', '3', 'I', '5', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2086', '3', 'I', '6', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2087', '3', 'I', '7', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2088', '3', 'I', '8', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2089', '3', 'I', '9', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2090', '3', 'I', '10', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2091', '3', 'J', '1', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2092', '3', 'J', '2', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2093', '3', 'J', '3', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2094', '3', 'J', '4', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2095', '3', 'J', '5', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2096', '3', 'J', '6', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2097', '3', 'J', '7', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2098', '3', 'J', '8', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2099', '3', 'J', '9', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2100', '3', 'J', '10', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2101', '4', 'A', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2102', '4', 'A', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2103', '4', 'A', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2104', '4', 'A', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2105', '4', 'A', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2106', '4', 'A', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2107', '4', 'A', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2108', '4', 'A', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2109', '4', 'A', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2110', '4', 'A', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2111', '4', 'B', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2112', '4', 'B', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2113', '4', 'B', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2114', '4', 'B', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2115', '4', 'B', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2116', '4', 'B', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2117', '4', 'B', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2118', '4', 'B', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2119', '4', 'B', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2120', '4', 'B', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2121', '4', 'C', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2122', '4', 'C', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2123', '4', 'C', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2124', '4', 'C', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2125', '4', 'C', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2126', '4', 'C', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2127', '4', 'C', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2128', '4', 'C', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2129', '4', 'C', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2130', '4', 'C', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2131', '4', 'D', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2132', '4', 'D', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2133', '4', 'D', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2134', '4', 'D', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2135', '4', 'D', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2136', '4', 'D', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2137', '4', 'D', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2138', '4', 'D', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2139', '4', 'D', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2140', '4', 'D', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2141', '4', 'E', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2142', '4', 'E', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2143', '4', 'E', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2144', '4', 'E', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2145', '4', 'E', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2146', '4', 'E', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2147', '4', 'E', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2148', '4', 'E', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2149', '4', 'E', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2150', '4', 'E', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2151', '4', 'F', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2152', '4', 'F', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2153', '4', 'F', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2154', '4', 'F', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2155', '4', 'F', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2156', '4', 'F', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2157', '4', 'F', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2158', '4', 'F', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2159', '4', 'F', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2160', '4', 'F', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2161', '4', 'G', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2162', '4', 'G', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2163', '4', 'G', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2164', '4', 'G', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2165', '4', 'G', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2166', '4', 'G', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2167', '4', 'G', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2168', '4', 'G', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2169', '4', 'G', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2170', '4', 'G', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2171', '4', 'H', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2172', '4', 'H', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2173', '4', 'H', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2174', '4', 'H', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2175', '4', 'H', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2176', '4', 'H', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2177', '4', 'H', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2178', '4', 'H', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2179', '4', 'H', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2180', '4', 'H', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2181', '4', 'I', '1', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2182', '4', 'I', '2', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2183', '4', 'I', '3', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2184', '4', 'I', '4', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2185', '4', 'I', '5', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2186', '4', 'I', '6', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2187', '4', 'I', '7', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2188', '4', 'I', '8', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2189', '4', 'I', '9', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2190', '4', 'I', '10', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2191', '4', 'J', '1', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2192', '4', 'J', '2', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2193', '4', 'J', '3', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2194', '4', 'J', '4', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2195', '4', 'J', '5', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2196', '4', 'J', '6', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2197', '4', 'J', '7', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2198', '4', 'J', '8', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2199', '4', 'J', '9', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2200', '4', 'J', '10', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2201', '5', 'A', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2202', '5', 'A', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2203', '5', 'A', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2204', '5', 'A', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2205', '5', 'A', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2206', '5', 'A', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2207', '5', 'A', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2208', '5', 'A', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2209', '5', 'A', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2210', '5', 'A', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2211', '5', 'B', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2212', '5', 'B', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2213', '5', 'B', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2214', '5', 'B', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2215', '5', 'B', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2216', '5', 'B', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2217', '5', 'B', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2218', '5', 'B', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2219', '5', 'B', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2220', '5', 'B', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2221', '5', 'C', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2222', '5', 'C', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2223', '5', 'C', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2224', '5', 'C', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2225', '5', 'C', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2226', '5', 'C', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2227', '5', 'C', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2228', '5', 'C', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2229', '5', 'C', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2230', '5', 'C', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2231', '5', 'D', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2232', '5', 'D', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2233', '5', 'D', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2234', '5', 'D', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2235', '5', 'D', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2236', '5', 'D', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2237', '5', 'D', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2238', '5', 'D', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2239', '5', 'D', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2240', '5', 'D', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2241', '5', 'E', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2242', '5', 'E', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2243', '5', 'E', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2244', '5', 'E', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2245', '5', 'E', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2246', '5', 'E', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2247', '5', 'E', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2248', '5', 'E', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2249', '5', 'E', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2250', '5', 'E', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2251', '5', 'F', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2252', '5', 'F', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2253', '5', 'F', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2254', '5', 'F', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2255', '5', 'F', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2256', '5', 'F', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2257', '5', 'F', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2258', '5', 'F', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2259', '5', 'F', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2260', '5', 'F', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2261', '5', 'G', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2262', '5', 'G', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2263', '5', 'G', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2264', '5', 'G', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2265', '5', 'G', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2266', '5', 'G', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2267', '5', 'G', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2268', '5', 'G', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2269', '5', 'G', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2270', '5', 'G', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2271', '5', 'H', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2272', '5', 'H', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2273', '5', 'H', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2274', '5', 'H', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2275', '5', 'H', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1001', '1', 'A', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1002', '1', 'A', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1003', '1', 'A', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1004', '1', 'A', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1005', '1', 'A', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1006', '1', 'A', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1007', '1', 'A', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1008', '1', 'A', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1009', '1', 'A', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1010', '1', 'A', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1011', '1', 'B', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1012', '1', 'B', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1013', '1', 'B', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1014', '1', 'B', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1015', '1', 'B', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1016', '1', 'B', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1017', '1', 'B', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1018', '1', 'B', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1019', '1', 'B', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1020', '1', 'B', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1021', '1', 'C', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1022', '1', 'C', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1023', '1', 'C', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1024', '1', 'C', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1025', '1', 'C', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1026', '1', 'C', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1027', '1', 'C', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1028', '1', 'C', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1029', '1', 'C', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1030', '1', 'C', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1031', '1', 'D', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1032', '1', 'D', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1033', '1', 'D', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1034', '1', 'D', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1035', '1', 'D', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1036', '1', 'D', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1037', '1', 'D', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1038', '1', 'D', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1039', '1', 'D', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1040', '1', 'D', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1041', '1', 'E', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1042', '1', 'E', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1043', '1', 'E', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1044', '1', 'E', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1045', '1', 'E', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1046', '1', 'E', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1047', '1', 'E', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1048', '1', 'E', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1049', '1', 'E', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1050', '1', 'E', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1051', '1', 'F', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1052', '1', 'F', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1053', '1', 'F', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1054', '1', 'F', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1055', '1', 'F', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1056', '1', 'F', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1057', '1', 'F', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1058', '1', 'F', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1059', '1', 'F', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1060', '1', 'F', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1061', '1', 'G', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1062', '1', 'G', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1063', '1', 'G', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1064', '1', 'G', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1065', '1', 'G', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1066', '1', 'G', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1067', '1', 'G', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1068', '1', 'G', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1069', '1', 'G', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1070', '1', 'G', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1071', '1', 'H', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1072', '1', 'H', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1073', '1', 'H', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1074', '1', 'H', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1075', '1', 'H', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1076', '1', 'H', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1077', '1', 'H', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1078', '1', 'H', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1079', '1', 'H', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1080', '1', 'H', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1081', '1', 'I', '1', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1082', '1', 'I', '2', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1083', '1', 'I', '3', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1084', '1', 'I', '4', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1085', '1', 'I', '5', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1086', '1', 'I', '6', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1087', '1', 'I', '7', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1088', '1', 'I', '8', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1089', '1', 'I', '9', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1090', '1', 'I', '10', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1091', '1', 'J', '1', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1092', '1', 'J', '2', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1093', '1', 'J', '3', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1094', '1', 'J', '4', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1095', '1', 'J', '5', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1096', '1', 'J', '6', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1097', '1', 'J', '7', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1098', '1', 'J', '8', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1099', '1', 'J', '9', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1100', '1', 'J', '10', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1101', '2', 'A', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1102', '2', 'A', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1103', '2', 'A', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1104', '2', 'A', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1105', '2', 'A', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1106', '2', 'A', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1107', '2', 'A', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1108', '2', 'A', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1109', '2', 'A', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1110', '2', 'A', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1111', '2', 'B', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1112', '2', 'B', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1113', '2', 'B', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1114', '2', 'B', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1115', '2', 'B', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1116', '2', 'B', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1117', '2', 'B', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1118', '2', 'B', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1119', '2', 'B', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1120', '2', 'B', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1121', '2', 'C', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1122', '2', 'C', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1123', '2', 'C', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1124', '2', 'C', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1125', '2', 'C', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1126', '2', 'C', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1127', '2', 'C', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1128', '2', 'C', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1129', '2', 'C', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1130', '2', 'C', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1131', '2', 'D', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1132', '2', 'D', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1133', '2', 'D', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1134', '2', 'D', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1135', '2', 'D', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1136', '2', 'D', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1137', '2', 'D', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1138', '2', 'D', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1139', '2', 'D', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1140', '2', 'D', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1141', '2', 'E', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1142', '2', 'E', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1143', '2', 'E', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1144', '2', 'E', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1145', '2', 'E', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1146', '2', 'E', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1147', '2', 'E', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1148', '2', 'E', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1149', '2', 'E', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1150', '2', 'E', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1151', '2', 'F', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1152', '2', 'F', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1153', '2', 'F', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1154', '2', 'F', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1155', '2', 'F', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1156', '2', 'F', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1157', '2', 'F', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1158', '2', 'F', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1159', '2', 'F', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1160', '2', 'F', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1161', '2', 'G', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1162', '2', 'G', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1163', '2', 'G', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1164', '2', 'G', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1165', '2', 'G', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1166', '2', 'G', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1167', '2', 'G', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1168', '2', 'G', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1169', '2', 'G', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1170', '2', 'G', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1171', '2', 'H', '1', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1172', '2', 'H', '2', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1173', '2', 'H', '3', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1174', '2', 'H', '4', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1175', '2', 'H', '5', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1176', '2', 'H', '6', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1177', '2', 'H', '7', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1178', '2', 'H', '8', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1179', '2', 'H', '9', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1180', '2', 'H', '10', 'REGULAR');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1181', '2', 'I', '1', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1182', '2', 'I', '2', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1183', '2', 'I', '3', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1184', '2', 'I', '4', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1185', '2', 'I', '5', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1186', '2', 'I', '6', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1187', '2', 'I', '7', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1188', '2', 'I', '8', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1189', '2', 'I', '9', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1190', '2', 'I', '10', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1191', '2', 'J', '1', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1192', '2', 'J', '2', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1193', '2', 'J', '3', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1194', '2', 'J', '4', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1195', '2', 'J', '5', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1196', '2', 'J', '6', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1197', '2', 'J', '7', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1198', '2', 'J', '8', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1199', '2', 'J', '9', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('1200', '2', 'J', '10', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2291', '5', 'J', '1', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2292', '5', 'J', '2', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2293', '5', 'J', '3', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2294', '5', 'J', '4', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2295', '5', 'J', '5', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2296', '5', 'J', '6', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2297', '5', 'J', '7', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2298', '5', 'J', '8', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2299', '5', 'J', '9', 'PREMIUM');
INSERT INTO "CINEHIVE"."SEAT" VALUES ('2300', '5', 'J', '10', 'PREMIUM');

-- ----------------------------
-- Table structure for SHOWTIME
-- ----------------------------
CREATE TABLE "CINEHIVE"."SHOWTIME" (
  "SHOWTIME_ID" NUMBER VISIBLE DEFAULT "CINEHIVE"."SEQ_SHOWTIME".nextval NOT NULL,
  "MOVIE_ID" NUMBER VISIBLE NOT NULL,
  "SCREEN_ID" NUMBER VISIBLE NOT NULL,
  "SHOW_DATE" DATE VISIBLE NOT NULL,
  "START_TIME" TIMESTAMP(6) VISIBLE NOT NULL,
  "END_TIME" TIMESTAMP(6) VISIBLE NOT NULL,
  "TICKET_PRICE" NUMBER(10,2) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of SHOWTIME
-- ----------------------------
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('1', '1', '1', TO_DATE('2026-08-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-08-15 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-08-15 12:28:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '300');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('3', '3', '1', TO_DATE('2026-08-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-08-15 18:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-08-15 20:32:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '350');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('514', '7', '5', TO_DATE('2026-09-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-15 21:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-15 22:54:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '200');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('78', '1', '2', TO_DATE('2026-09-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-12 19:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-12 21:28:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '320');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('108', '29', '2', TO_DATE('2026-09-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-12 19:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-12 21:38:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '320');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('119', '62', '5', TO_DATE('2026-09-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-12 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-12 13:42:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('121', '63', '4', TO_DATE('2026-09-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-29 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-29 12:42:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('124', '65', '3', TO_DATE('2026-09-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-29 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-30 00:18:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('132', '69', '3', TO_DATE('2026-09-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-26 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-26 21:52:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('134', '70', '3', TO_DATE('2026-09-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-16 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-16 17:48:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('136', '71', '3', TO_DATE('2026-09-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-21 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-22 00:02:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('137', '71', '4', TO_DATE('2026-09-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-29 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-29 12:02:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('138', '72', '4', TO_DATE('2026-09-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-19 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-19 12:19:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('139', '72', '3', TO_DATE('2026-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-04 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-05 00:19:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('140', '73', '4', TO_DATE('2026-10-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-07 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-07 20:18:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('141', '73', '3', TO_DATE('2026-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-23 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-23 13:18:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('145', '75', '4', TO_DATE('2026-10-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-08 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-08 12:21:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('146', '76', '4', TO_DATE('2026-09-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-25 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-26 00:24:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('147', '76', '4', TO_DATE('2026-09-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-15 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-16 00:24:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('148', '77', '4', TO_DATE('2026-10-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-03 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-03 19:31:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('151', '78', '4', TO_DATE('2026-09-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-11 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-12 00:27:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('152', '79', '3', TO_DATE('2026-09-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-19 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-19 12:37:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('154', '80', '3', TO_DATE('2026-09-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-29 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-29 15:46:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('157', '81', '4', TO_DATE('2026-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-23 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-23 21:47:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('158', '82', '4', TO_DATE('2026-09-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-26 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-26 12:37:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('160', '83', '3', TO_DATE('2026-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-14 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-15 00:32:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('164', '85', '3', TO_DATE('2026-09-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-15 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-15 19:43:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('165', '85', '4', TO_DATE('2026-09-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-22 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-22 12:43:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('166', '86', '4', TO_DATE('2026-10-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-08 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-08 21:56:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('167', '86', '3', TO_DATE('2026-09-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-26 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-26 12:26:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('168', '87', '3', TO_DATE('2026-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-14 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-14 19:17:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('173', '89', '3', TO_DATE('2026-09-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-16 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-16 15:11:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('175', '90', '5', TO_DATE('2026-09-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-18 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-18 15:13:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('176', '91', '4', TO_DATE('2026-10-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-07 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-07 15:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('177', '91', '4', TO_DATE('2026-09-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-27 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-27 19:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('180', '93', '3', TO_DATE('2026-09-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-25 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-25 18:58:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('182', '94', '3', TO_DATE('2026-09-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-17 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-17 15:20:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('184', '95', '3', TO_DATE('2026-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-01 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-01 11:48:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('185', '95', '4', TO_DATE('2026-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-14 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-14 15:18:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('186', '96', '4', TO_DATE('2026-09-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-16 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-16 18:44:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('187', '96', '4', TO_DATE('2026-10-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-06 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-06 21:14:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('191', '98', '3', TO_DATE('2026-10-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-02 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-02 15:32:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('197', '101', '4', TO_DATE('2026-09-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-28 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-28 15:58:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('198', '102', '3', TO_DATE('2026-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-04 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-04 21:50:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('203', '104', '4', TO_DATE('2026-09-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-15 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-16 00:22:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('213', '109', '5', TO_DATE('2026-09-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-18 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-18 19:37:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('214', '110', '4', TO_DATE('2026-09-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-17 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-17 15:41:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('215', '110', '4', TO_DATE('2026-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-14 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-14 21:41:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('217', '111', '3', TO_DATE('2026-09-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-17 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-17 12:34:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('218', '112', '3', TO_DATE('2026-10-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-03 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-03 16:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('219', '112', '4', TO_DATE('2026-09-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-15 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-15 16:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('220', '113', '4', TO_DATE('2026-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-14 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-14 21:48:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('222', '114', '4', TO_DATE('2026-09-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-27 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-27 19:20:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('223', '114', '3', TO_DATE('2026-09-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-17 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-17 19:20:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('224', '115', '3', TO_DATE('2026-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-04 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-04 12:34:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('225', '115', '4', TO_DATE('2026-09-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-28 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-28 22:04:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('226', '116', '4', TO_DATE('2026-09-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-11 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-11 19:36:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('227', '116', '3', TO_DATE('2026-09-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-30 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-01 00:36:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('229', '117', '3', TO_DATE('2026-09-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-19 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-19 12:04:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('232', '119', '3', TO_DATE('2026-10-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-03 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-03 11:50:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('534', '261', '1', TO_DATE('2026-09-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-18 19:45:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-18 21:27:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '150');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('245', '125', '4', TO_DATE('2026-09-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-27 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-27 15:51:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('246', '126', '4', TO_DATE('2026-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-14 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-14 22:04:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('247', '126', '4', TO_DATE('2026-10-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-07 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-08 00:34:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('251', '128', '3', TO_DATE('2026-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-01 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-01 22:18:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('253', '129', '2', TO_DATE('2026-09-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-30 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-30 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '280');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('257', '131', '3', TO_DATE('2026-09-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-12 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-12 16:46:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('259', '132', '4', TO_DATE('2026-09-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-13 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-13 19:01:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('261', '133', '3', TO_DATE('2026-09-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-13 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-13 12:13:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('263', '134', '3', TO_DATE('2026-09-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-11 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-11 18:58:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('266', '136', '4', TO_DATE('2026-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-04 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-04 16:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('273', '139', '4', TO_DATE('2026-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-14 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-14 22:24:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('275', '140', '3', TO_DATE('2026-09-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-26 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-26 12:46:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('278', '142', '4', TO_DATE('2026-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-04 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-04 19:37:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('279', '142', '3', TO_DATE('2026-10-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-08 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-08 16:07:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('281', '143', '4', TO_DATE('2026-09-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-26 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-26 11:41:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('282', '144', '3', TO_DATE('2026-10-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-02 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-02 12:12:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('284', '145', '3', TO_DATE('2026-09-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-21 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-21 19:23:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('286', '146', '4', TO_DATE('2026-09-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-12 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-12 19:35:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('289', '147', '4', TO_DATE('2026-09-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-25 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-25 12:45:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('290', '148', '3', TO_DATE('2026-09-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-17 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-17 12:31:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('291', '148', '3', TO_DATE('2026-09-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-11 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-11 22:01:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('296', '151', '3', TO_DATE('2026-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-14 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-14 16:13:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('297', '151', '4', TO_DATE('2026-09-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-26 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-26 12:43:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('298', '152', '4', TO_DATE('2026-09-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-11 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-11 22:25:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('300', '153', '3', TO_DATE('2026-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-23 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-23 12:16:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('301', '153', '3', TO_DATE('2026-09-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-11 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-11 19:16:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('303', '154', '3', TO_DATE('2026-09-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-19 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-19 12:14:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('305', '155', '3', TO_DATE('2026-09-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-24 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-24 11:56:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('307', '156', '3', TO_DATE('2026-09-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-18 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-18 22:08:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('309', '157', '4', TO_DATE('2026-09-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-11 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-11 23:43:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('312', '159', '3', TO_DATE('2026-10-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-08 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-08 21:24:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('314', '160', '3', TO_DATE('2026-09-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-24 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-24 20:44:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('315', '160', '3', TO_DATE('2026-09-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-19 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-19 23:14:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('316', '161', '3', TO_DATE('2026-09-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-18 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-18 23:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('317', '161', '4', TO_DATE('2026-10-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-02 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-02 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('319', '162', '4', TO_DATE('2026-09-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-27 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-28 02:04:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('320', '163', '3', TO_DATE('2026-09-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-25 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-25 22:40:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('325', '165', '4', TO_DATE('2026-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-04 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-04 22:23:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('327', '166', '3', TO_DATE('2026-09-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-19 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-19 15:41:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('331', '168', '4', TO_DATE('2026-09-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-18 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-18 22:16:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('332', '169', '4', TO_DATE('2026-09-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-25 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-25 19:39:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('334', '170', '4', TO_DATE('2026-09-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-29 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-29 12:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('338', '172', '4', TO_DATE('2026-10-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-03 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-03 12:53:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('341', '173', '3', TO_DATE('2026-10-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-03 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-03 16:35:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('345', '175', '3', TO_DATE('2026-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-23 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-23 16:21:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('347', '176', '3', TO_DATE('2026-09-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-25 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-25 19:22:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('350', '178', '3', TO_DATE('2026-10-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-03 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-03 12:38:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('351', '178', '4', TO_DATE('2026-09-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-17 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-17 22:08:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('353', '179', '4', TO_DATE('2026-09-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-18 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-18 12:36:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('354', '180', '4', TO_DATE('2026-09-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-21 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-21 19:09:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('358', '182', '4', TO_DATE('2026-09-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-18 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-18 15:34:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('359', '182', '3', TO_DATE('2026-10-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-05 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-05 12:04:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('361', '183', '4', TO_DATE('2026-09-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-26 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-26 12:25:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('362', '184', '4', TO_DATE('2026-09-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-15 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-15 13:03:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('365', '185', '3', TO_DATE('2026-09-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-25 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-25 13:50:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('366', '186', '3', TO_DATE('2026-09-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-16 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-16 16:29:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('368', '187', '4', TO_DATE('2026-09-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-20 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-20 20:26:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('370', '188', '3', TO_DATE('2026-09-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-13 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-13 13:25:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('372', '189', '3', TO_DATE('2026-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-23 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-23 19:41:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('375', '190', '3', TO_DATE('2026-09-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-21 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-21 22:34:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('376', '191', '4', TO_DATE('2026-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-01 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-01 17:07:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('377', '191', '4', TO_DATE('2026-10-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-05 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-05 13:37:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('378', '192', '4', TO_DATE('2026-09-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-12 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-12 12:45:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('380', '193', '3', TO_DATE('2026-09-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-22 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-22 20:06:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('381', '193', '3', TO_DATE('2026-09-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-12 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-12 20:06:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('382', '194', '1', TO_DATE('2026-09-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-20 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-21 01:14:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '280');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('384', '195', '4', TO_DATE('2026-10-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-03 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-03 22:49:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('385', '195', '4', TO_DATE('2026-09-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-24 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-24 16:49:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('388', '197', '3', TO_DATE('2026-09-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-25 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-26 00:47:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('390', '198', '4', TO_DATE('2026-09-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-18 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-18 12:58:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('391', '198', '4', TO_DATE('2026-09-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-12 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-13 00:58:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('393', '199', '3', TO_DATE('2026-09-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-13 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-14 01:16:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('395', '200', '4', TO_DATE('2026-10-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-03 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-03 16:34:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('396', '201', '4', TO_DATE('2026-09-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-15 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-15 22:23:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('398', '202', '3', TO_DATE('2026-10-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-05 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-05 19:41:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('399', '202', '3', TO_DATE('2026-09-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-29 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-29 19:41:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('400', '203', '3', TO_DATE('2026-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-04 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-04 16:23:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('402', '204', '3', TO_DATE('2026-09-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-15 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-16 00:18:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('404', '205', '5', TO_DATE('2026-09-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-18 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-19 00:51:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('407', '206', '4', TO_DATE('2026-10-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-07 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-07 19:59:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('410', '208', '3', TO_DATE('2026-09-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-13 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-14 01:07:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('413', '209', '1', TO_DATE('2026-09-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-17 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-17 20:27:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '320');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('416', '211', '3', TO_DATE('2026-10-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-07 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-07 22:41:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('419', '212', '4', TO_DATE('2026-09-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-28 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-28 13:19:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('420', '213', '4', TO_DATE('2026-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-14 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-15 01:06:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('422', '214', '4', TO_DATE('2026-09-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-16 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-16 19:34:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('423', '214', '3', TO_DATE('2026-09-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-20 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-20 22:04:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('426', '216', '4', TO_DATE('2026-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-23 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-23 16:27:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('431', '218', '4', TO_DATE('2026-10-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-06 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-06 12:35:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('432', '219', '3', TO_DATE('2026-09-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-30 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-01 00:56:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('433', '219', '3', TO_DATE('2026-09-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-15 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-15 19:56:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('435', '220', '4', TO_DATE('2026-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-23 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-23 16:21:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('445', '225', '3', TO_DATE('2026-10-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-07 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-07 12:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('446', '226', '4', TO_DATE('2026-09-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-30 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-01 01:15:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('447', '226', '3', TO_DATE('2026-10-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-05 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-05 22:45:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('449', '227', '3', TO_DATE('2026-10-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-02 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-02 21:55:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('451', '228', '4', TO_DATE('2026-09-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-30 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-30 21:43:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('453', '229', '4', TO_DATE('2026-10-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-06 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-06 21:36:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('461', '233', '3', TO_DATE('2026-09-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-26 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-26 16:02:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('463', '234', '3', TO_DATE('2026-09-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-30 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-30 16:44:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('464', '235', '3', TO_DATE('2026-09-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-30 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-30 22:14:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('466', '236', '3', TO_DATE('2026-09-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-29 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-30 00:59:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('467', '236', '3', TO_DATE('2026-09-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-18 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-18 19:59:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('469', '237', '3', TO_DATE('2026-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-01 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-01 19:21:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('470', '238', '3', TO_DATE('2026-09-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-16 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-16 12:10:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('471', '238', '3', TO_DATE('2026-09-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-12 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-12 21:40:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('473', '239', '4', TO_DATE('2026-09-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-28 17:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-28 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('474', '240', '3', TO_DATE('2026-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-23 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-24 00:40:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('475', '240', '3', TO_DATE('2026-09-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-22 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-22 12:40:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '420');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('481', '243', '3', TO_DATE('2026-09-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-27 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-27 11:58:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('487', '246', '4', TO_DATE('2026-09-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-30 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-30 15:23:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('490', '248', '3', TO_DATE('2026-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-23 10:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-23 12:05:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('493', '249', '4', TO_DATE('2026-09-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-27 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-27 16:13:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('497', '251', '4', TO_DATE('2026-09-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-15 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-15 15:37:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('501', '253', '4', TO_DATE('2026-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-23 19:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-23 21:25:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('502', '254', '4', TO_DATE('2026-10-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-10-04 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-10-04 16:13:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('503', '254', '3', TO_DATE('2026-09-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-14 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-14 16:13:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('508', '257', '3', TO_DATE('2026-09-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-16 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-16 16:23:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '450');
INSERT INTO "CINEHIVE"."SHOWTIME" VALUES ('510', '258', '3', TO_DATE('2026-09-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-09-23 22:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2026-09-24 00:50:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '400');

-- ----------------------------
-- Table structure for WATCHLIST
-- ----------------------------
CREATE TABLE "CINEHIVE"."WATCHLIST" (
  "USER_ID" NUMBER VISIBLE NOT NULL,
  "MOVIE_ID" NUMBER VISIBLE NOT NULL,
  "ADDED_DATE" TIMESTAMP(6) VISIBLE DEFAULT SYSTIMESTAMP NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of WATCHLIST
-- ----------------------------
INSERT INTO "CINEHIVE"."WATCHLIST" VALUES ('29', '10', TO_TIMESTAMP('2026-09-12 13:19:03.695000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."WATCHLIST" VALUES ('54', '34', TO_TIMESTAMP('2026-09-12 12:57:51.985000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."WATCHLIST" VALUES ('54', '129', TO_TIMESTAMP('2026-09-12 12:58:09.105000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."WATCHLIST" VALUES ('1', '5', TO_TIMESTAMP('2026-07-20 09:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."WATCHLIST" VALUES ('1', '8', TO_TIMESTAMP('2026-07-21 09:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."WATCHLIST" VALUES ('3', '1', TO_TIMESTAMP('2026-07-24 12:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."WATCHLIST" VALUES ('4', '4', TO_TIMESTAMP('2026-07-25 13:30:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."WATCHLIST" VALUES ('6', '9', TO_TIMESTAMP('2026-07-27 15:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."WATCHLIST" VALUES ('7', '10', TO_TIMESTAMP('2026-07-28 16:00:00.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CINEHIVE"."WATCHLIST" VALUES ('55', '194', TO_TIMESTAMP('2026-09-12 20:01:13.927000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));

-- ----------------------------
-- Primary Key structure for table ACTOR
-- ----------------------------
ALTER TABLE "CINEHIVE"."ACTOR" ADD CONSTRAINT "PK_ACTOR" PRIMARY KEY ("ACTOR_ID");

-- ----------------------------
-- Checks structure for table ACTOR
-- ----------------------------
-- ALTER TABLE "CINEHIVE"."ACTOR" ADD CONSTRAINT "SYS_C007577" CHECK ("ACTOR_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."ACTOR" ADD CONSTRAINT "SYS_C007578" CHECK ("ACTOR_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table ACTS_IN
-- ----------------------------
ALTER TABLE "CINEHIVE"."ACTS_IN" ADD CONSTRAINT "PK_ACTS_IN" PRIMARY KEY ("ACTOR_ID", "MOVIE_ID");

-- ----------------------------
-- Checks structure for table ACTS_IN
-- ----------------------------
-- ALTER TABLE "CINEHIVE"."ACTS_IN" ADD CONSTRAINT "SYS_C007602" CHECK ("ACTOR_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."ACTS_IN" ADD CONSTRAINT "SYS_C007603" CHECK ("MOVIE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table APP_USER
-- ----------------------------
ALTER TABLE "CINEHIVE"."APP_USER" ADD CONSTRAINT "PK_APP_USER" PRIMARY KEY ("USER_ID");

-- ----------------------------
-- Uniques structure for table APP_USER
-- ----------------------------
ALTER TABLE "CINEHIVE"."APP_USER" ADD CONSTRAINT "UQ_APP_USER_EMAIL" UNIQUE ("EMAIL") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."APP_USER" ADD CONSTRAINT "UQ_APP_USER_USERNAME" UNIQUE ("USERNAME") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table APP_USER
-- ----------------------------
ALTER TABLE "CINEHIVE"."APP_USER" ADD CONSTRAINT "CK_USER_ROLE" CHECK (ROLE IN ('CUSTOMER', 'SITE_ADMIN', 'CINEMA_ADMIN')) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."APP_USER" ADD CONSTRAINT "SYS_C007591" CHECK ("USER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."APP_USER" ADD CONSTRAINT "SYS_C007592" CHECK ("USERNAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."APP_USER" ADD CONSTRAINT "SYS_C007593" CHECK ("EMAIL" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."APP_USER" ADD CONSTRAINT "SYS_C007594" CHECK ("PASSWORD_HASH" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."APP_USER" ADD CONSTRAINT "SYS_C007595" CHECK ("DATE_JOINED" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."APP_USER" ADD CONSTRAINT "SYS_C007758" CHECK ("ROLE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BOOKING
-- ----------------------------
ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "PK_BOOKING" PRIMARY KEY ("BOOKING_ID");

-- ----------------------------
-- Uniques structure for table BOOKING
-- ----------------------------
ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "UQ_BOOKING_ID_SHOWTIME" UNIQUE ("BOOKING_ID", "SHOWTIME_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table BOOKING
-- ----------------------------
ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "CK_BOOKING_AMOUNT" CHECK (Total_Amount >= 0) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "CK_BOOKING_PAYMENT" CHECK (Payment_Status IN ('PENDING', 'PAID', 'FAILED', 'REFUNDED')) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "SYS_C007652" CHECK ("BOOKING_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "SYS_C007653" CHECK ("USER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "SYS_C007654" CHECK ("SHOWTIME_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "SYS_C007655" CHECK ("BOOKING_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "SYS_C007656" CHECK ("TOTAL_AMOUNT" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "SYS_C007657" CHECK ("PAYMENT_STATUS" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BOOKING_SEAT
-- ----------------------------
ALTER TABLE "CINEHIVE"."BOOKING_SEAT" ADD CONSTRAINT "PK_BOOKING_SEAT" PRIMARY KEY ("BOOKING_ID", "SEAT_ID");

-- ----------------------------
-- Uniques structure for table BOOKING_SEAT
-- ----------------------------
ALTER TABLE "CINEHIVE"."BOOKING_SEAT" ADD CONSTRAINT "UQ_SHOWTIME_SEAT" UNIQUE ("SHOWTIME_ID", "SEAT_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table BOOKING_SEAT
-- ----------------------------
-- ALTER TABLE "CINEHIVE"."BOOKING_SEAT" ADD CONSTRAINT "SYS_C007664" CHECK ("BOOKING_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."BOOKING_SEAT" ADD CONSTRAINT "SYS_C007665" CHECK ("SHOWTIME_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."BOOKING_SEAT" ADD CONSTRAINT "SYS_C007666" CHECK ("SEAT_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table CINEMA
-- ----------------------------
ALTER TABLE "CINEHIVE"."CINEMA" ADD CONSTRAINT "PK_CINEMA" PRIMARY KEY ("CINEMA_ID");

-- ----------------------------
-- Checks structure for table CINEMA
-- ----------------------------
-- ALTER TABLE "CINEHIVE"."CINEMA" ADD CONSTRAINT "SYS_C007599" CHECK ("CINEMA_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."CINEMA" ADD CONSTRAINT "SYS_C007600" CHECK ("CINEMA_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table DIRECTOR
-- ----------------------------
ALTER TABLE "CINEHIVE"."DIRECTOR" ADD CONSTRAINT "PK_DIRECTOR" PRIMARY KEY ("DIRECTOR_ID");

-- ----------------------------
-- Checks structure for table DIRECTOR
-- ----------------------------
-- ALTER TABLE "CINEHIVE"."DIRECTOR" ADD CONSTRAINT "SYS_C007580" CHECK ("DIRECTOR_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."DIRECTOR" ADD CONSTRAINT "SYS_C007581" CHECK ("DIRECTOR_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table DIRECTS
-- ----------------------------
ALTER TABLE "CINEHIVE"."DIRECTS" ADD CONSTRAINT "PK_DIRECTS" PRIMARY KEY ("DIRECTOR_ID", "MOVIE_ID");

-- ----------------------------
-- Checks structure for table DIRECTS
-- ----------------------------
-- ALTER TABLE "CINEHIVE"."DIRECTS" ADD CONSTRAINT "SYS_C007607" CHECK ("DIRECTOR_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."DIRECTS" ADD CONSTRAINT "SYS_C007608" CHECK ("MOVIE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table GENRE
-- ----------------------------
ALTER TABLE "CINEHIVE"."GENRE" ADD CONSTRAINT "PK_GENRE" PRIMARY KEY ("GENRE_ID");

-- ----------------------------
-- Uniques structure for table GENRE
-- ----------------------------
ALTER TABLE "CINEHIVE"."GENRE" ADD CONSTRAINT "UQ_GENRE_NAME" UNIQUE ("GENRE_NAME") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table GENRE
-- ----------------------------
-- ALTER TABLE "CINEHIVE"."GENRE" ADD CONSTRAINT "SYS_C007583" CHECK ("GENRE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."GENRE" ADD CONSTRAINT "SYS_C007584" CHECK ("GENRE_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table MOVIE
-- ----------------------------
ALTER TABLE "CINEHIVE"."MOVIE" ADD CONSTRAINT "PK_MOVIE" PRIMARY KEY ("MOVIE_ID");

-- ----------------------------
-- Checks structure for table MOVIE
-- ----------------------------
ALTER TABLE "CINEHIVE"."MOVIE" ADD CONSTRAINT "CK_MOVIE_BOXOFFICE" CHECK (Box_Office IS NULL OR Box_Office >= 0) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."MOVIE" ADD CONSTRAINT "CK_MOVIE_BUDGET" CHECK (Budget IS NULL OR Budget >= 0) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."MOVIE" ADD CONSTRAINT "CK_MOVIE_DURATION" CHECK (Duration IS NULL OR Duration > 0) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."MOVIE" ADD CONSTRAINT "SYS_C007571" CHECK ("MOVIE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."MOVIE" ADD CONSTRAINT "SYS_C007572" CHECK ("TITLE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table MOVIE_GENRE
-- ----------------------------
ALTER TABLE "CINEHIVE"."MOVIE_GENRE" ADD CONSTRAINT "PK_MOVIE_GENRE" PRIMARY KEY ("MOVIE_ID", "GENRE_ID");

-- ----------------------------
-- Checks structure for table MOVIE_GENRE
-- ----------------------------
-- ALTER TABLE "CINEHIVE"."MOVIE_GENRE" ADD CONSTRAINT "SYS_C007612" CHECK ("MOVIE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."MOVIE_GENRE" ADD CONSTRAINT "SYS_C007613" CHECK ("GENRE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table PRODUCES
-- ----------------------------
ALTER TABLE "CINEHIVE"."PRODUCES" ADD CONSTRAINT "PK_PRODUCES" PRIMARY KEY ("PRODUCTION_ID", "MOVIE_ID");

-- ----------------------------
-- Checks structure for table PRODUCES
-- ----------------------------
-- ALTER TABLE "CINEHIVE"."PRODUCES" ADD CONSTRAINT "SYS_C007617" CHECK ("PRODUCTION_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."PRODUCES" ADD CONSTRAINT "SYS_C007618" CHECK ("MOVIE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table PRODUCTION_COMPANY
-- ----------------------------
ALTER TABLE "CINEHIVE"."PRODUCTION_COMPANY" ADD CONSTRAINT "PK_PRODUCTION_COMPANY" PRIMARY KEY ("PRODUCTION_ID");

-- ----------------------------
-- Checks structure for table PRODUCTION_COMPANY
-- ----------------------------
ALTER TABLE "CINEHIVE"."PRODUCTION_COMPANY" ADD CONSTRAINT "CK_PRODUCTION_FOUNDED" CHECK (Founded_Year IS NULL OR Founded_Year BETWEEN 1800 AND 2100) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."PRODUCTION_COMPANY" ADD CONSTRAINT "SYS_C007587" CHECK ("PRODUCTION_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."PRODUCTION_COMPANY" ADD CONSTRAINT "SYS_C007588" CHECK ("COMPANY_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table RATING
-- ----------------------------
ALTER TABLE "CINEHIVE"."RATING" ADD CONSTRAINT "PK_RATING" PRIMARY KEY ("USER_ID", "MOVIE_ID");

-- ----------------------------
-- Checks structure for table RATING
-- ----------------------------
ALTER TABLE "CINEHIVE"."RATING" ADD CONSTRAINT "CK_RATING_VALUE" CHECK (Rating_Value BETWEEN 1 AND 10) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."RATING" ADD CONSTRAINT "SYS_C007671" CHECK ("USER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."RATING" ADD CONSTRAINT "SYS_C007672" CHECK ("MOVIE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."RATING" ADD CONSTRAINT "SYS_C007673" CHECK ("RATING_VALUE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."RATING" ADD CONSTRAINT "SYS_C007674" CHECK ("RATING_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table REVIEW
-- ----------------------------
ALTER TABLE "CINEHIVE"."REVIEW" ADD CONSTRAINT "PK_REVIEW" PRIMARY KEY ("REVIEW_ID");

-- ----------------------------
-- Checks structure for table REVIEW
-- ----------------------------
-- ALTER TABLE "CINEHIVE"."REVIEW" ADD CONSTRAINT "SYS_C007679" CHECK ("REVIEW_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."REVIEW" ADD CONSTRAINT "SYS_C007680" CHECK ("USER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."REVIEW" ADD CONSTRAINT "SYS_C007681" CHECK ("MOVIE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."REVIEW" ADD CONSTRAINT "SYS_C007682" CHECK ("REVIEW_TEXT" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."REVIEW" ADD CONSTRAINT "SYS_C007683" CHECK ("REVIEW_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table SCREEN
-- ----------------------------
ALTER TABLE "CINEHIVE"."SCREEN" ADD CONSTRAINT "PK_SCREEN" PRIMARY KEY ("SCREEN_ID");

-- ----------------------------
-- Uniques structure for table SCREEN
-- ----------------------------
ALTER TABLE "CINEHIVE"."SCREEN" ADD CONSTRAINT "UQ_SCREEN_NAME" UNIQUE ("CINEMA_ID", "SCREEN_NAME") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table SCREEN
-- ----------------------------
ALTER TABLE "CINEHIVE"."SCREEN" ADD CONSTRAINT "CK_SCREEN_CAPACITY" CHECK (Capacity > 0) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SCREEN" ADD CONSTRAINT "SYS_C007622" CHECK ("SCREEN_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SCREEN" ADD CONSTRAINT "SYS_C007623" CHECK ("CINEMA_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SCREEN" ADD CONSTRAINT "SYS_C007624" CHECK ("SCREEN_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SCREEN" ADD CONSTRAINT "SYS_C007625" CHECK ("CAPACITY" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table SEAT
-- ----------------------------
ALTER TABLE "CINEHIVE"."SEAT" ADD CONSTRAINT "PK_SEAT" PRIMARY KEY ("SEAT_ID");

-- ----------------------------
-- Uniques structure for table SEAT
-- ----------------------------
ALTER TABLE "CINEHIVE"."SEAT" ADD CONSTRAINT "UQ_SEAT_POSITION" UNIQUE ("SCREEN_ID", "ROW_NUMBER", "SEAT_NUMBER") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table SEAT
-- ----------------------------
ALTER TABLE "CINEHIVE"."SEAT" ADD CONSTRAINT "CK_SEAT_NUMBER" CHECK (Seat_Number > 0) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."SEAT" ADD CONSTRAINT "CK_SEAT_TYPE" CHECK (Seat_Type IN ('REGULAR', 'PREMIUM', 'VIP')) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SEAT" ADD CONSTRAINT "SYS_C007630" CHECK ("SEAT_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SEAT" ADD CONSTRAINT "SYS_C007631" CHECK ("SCREEN_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SEAT" ADD CONSTRAINT "SYS_C007632" CHECK ("ROW_NUMBER" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SEAT" ADD CONSTRAINT "SYS_C007633" CHECK ("SEAT_NUMBER" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SEAT" ADD CONSTRAINT "SYS_C007634" CHECK ("SEAT_TYPE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table SHOWTIME
-- ----------------------------
ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "PK_SHOWTIME" PRIMARY KEY ("SHOWTIME_ID");

-- ----------------------------
-- Checks structure for table SHOWTIME
-- ----------------------------
ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "CK_SHOWTIME_PRICE" CHECK (Ticket_Price >= 0) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "CK_SHOWTIME_TIME" CHECK (End_Time > Start_Time) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "SYS_C007640" CHECK ("SHOWTIME_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "SYS_C007641" CHECK ("MOVIE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "SYS_C007642" CHECK ("SCREEN_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "SYS_C007643" CHECK ("SHOW_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "SYS_C007644" CHECK ("START_TIME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "SYS_C007645" CHECK ("END_TIME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "SYS_C007646" CHECK ("TICKET_PRICE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table WATCHLIST
-- ----------------------------
ALTER TABLE "CINEHIVE"."WATCHLIST" ADD CONSTRAINT "PK_WATCHLIST" PRIMARY KEY ("USER_ID", "MOVIE_ID");

-- ----------------------------
-- Checks structure for table WATCHLIST
-- ----------------------------
-- ALTER TABLE "CINEHIVE"."WATCHLIST" ADD CONSTRAINT "SYS_C007688" CHECK ("USER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."WATCHLIST" ADD CONSTRAINT "SYS_C007689" CHECK ("MOVIE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
-- ALTER TABLE "CINEHIVE"."WATCHLIST" ADD CONSTRAINT "SYS_C007690" CHECK ("ADDED_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table ACTS_IN
-- ----------------------------
ALTER TABLE "CINEHIVE"."ACTS_IN" ADD CONSTRAINT "FK_ACTS_IN_ACTOR" FOREIGN KEY ("ACTOR_ID") REFERENCES "CINEHIVE"."ACTOR" ("ACTOR_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."ACTS_IN" ADD CONSTRAINT "FK_ACTS_IN_MOVIE" FOREIGN KEY ("MOVIE_ID") REFERENCES "CINEHIVE"."MOVIE" ("MOVIE_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table APP_USER
-- ----------------------------
ALTER TABLE "CINEHIVE"."APP_USER" ADD CONSTRAINT "FK_USER_CINEMA" FOREIGN KEY ("CINEMA_ID") REFERENCES "CINEHIVE"."CINEMA" ("CINEMA_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table BOOKING
-- ----------------------------
ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "FK_BOOKING_SHOWTIME" FOREIGN KEY ("SHOWTIME_ID") REFERENCES "CINEHIVE"."SHOWTIME" ("SHOWTIME_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."BOOKING" ADD CONSTRAINT "FK_BOOKING_USER" FOREIGN KEY ("USER_ID") REFERENCES "CINEHIVE"."APP_USER" ("USER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table BOOKING_SEAT
-- ----------------------------
ALTER TABLE "CINEHIVE"."BOOKING_SEAT" ADD CONSTRAINT "FK_BOOKING_SEAT_BOOKING" FOREIGN KEY ("BOOKING_ID", "SHOWTIME_ID") REFERENCES "CINEHIVE"."BOOKING" ("BOOKING_ID", "SHOWTIME_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."BOOKING_SEAT" ADD CONSTRAINT "FK_BOOKING_SEAT_SEAT" FOREIGN KEY ("SEAT_ID") REFERENCES "CINEHIVE"."SEAT" ("SEAT_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table DIRECTS
-- ----------------------------
ALTER TABLE "CINEHIVE"."DIRECTS" ADD CONSTRAINT "FK_DIRECTS_DIRECTOR" FOREIGN KEY ("DIRECTOR_ID") REFERENCES "CINEHIVE"."DIRECTOR" ("DIRECTOR_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."DIRECTS" ADD CONSTRAINT "FK_DIRECTS_MOVIE" FOREIGN KEY ("MOVIE_ID") REFERENCES "CINEHIVE"."MOVIE" ("MOVIE_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MOVIE_GENRE
-- ----------------------------
ALTER TABLE "CINEHIVE"."MOVIE_GENRE" ADD CONSTRAINT "FK_MOVIE_GENRE_GENRE" FOREIGN KEY ("GENRE_ID") REFERENCES "CINEHIVE"."GENRE" ("GENRE_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."MOVIE_GENRE" ADD CONSTRAINT "FK_MOVIE_GENRE_MOVIE" FOREIGN KEY ("MOVIE_ID") REFERENCES "CINEHIVE"."MOVIE" ("MOVIE_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table PRODUCES
-- ----------------------------
ALTER TABLE "CINEHIVE"."PRODUCES" ADD CONSTRAINT "FK_PRODUCES_COMPANY" FOREIGN KEY ("PRODUCTION_ID") REFERENCES "CINEHIVE"."PRODUCTION_COMPANY" ("PRODUCTION_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."PRODUCES" ADD CONSTRAINT "FK_PRODUCES_MOVIE" FOREIGN KEY ("MOVIE_ID") REFERENCES "CINEHIVE"."MOVIE" ("MOVIE_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table RATING
-- ----------------------------
ALTER TABLE "CINEHIVE"."RATING" ADD CONSTRAINT "FK_RATING_MOVIE" FOREIGN KEY ("MOVIE_ID") REFERENCES "CINEHIVE"."MOVIE" ("MOVIE_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."RATING" ADD CONSTRAINT "FK_RATING_USER" FOREIGN KEY ("USER_ID") REFERENCES "CINEHIVE"."APP_USER" ("USER_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table REVIEW
-- ----------------------------
ALTER TABLE "CINEHIVE"."REVIEW" ADD CONSTRAINT "FK_REVIEW_MOVIE" FOREIGN KEY ("MOVIE_ID") REFERENCES "CINEHIVE"."MOVIE" ("MOVIE_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."REVIEW" ADD CONSTRAINT "FK_REVIEW_USER" FOREIGN KEY ("USER_ID") REFERENCES "CINEHIVE"."APP_USER" ("USER_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table SCREEN
-- ----------------------------
ALTER TABLE "CINEHIVE"."SCREEN" ADD CONSTRAINT "FK_SCREEN_CINEMA" FOREIGN KEY ("CINEMA_ID") REFERENCES "CINEHIVE"."CINEMA" ("CINEMA_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table SEAT
-- ----------------------------
ALTER TABLE "CINEHIVE"."SEAT" ADD CONSTRAINT "FK_SEAT_SCREEN" FOREIGN KEY ("SCREEN_ID") REFERENCES "CINEHIVE"."SCREEN" ("SCREEN_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table SHOWTIME
-- ----------------------------
ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "FK_SHOWTIME_MOVIE" FOREIGN KEY ("MOVIE_ID") REFERENCES "CINEHIVE"."MOVIE" ("MOVIE_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."SHOWTIME" ADD CONSTRAINT "FK_SHOWTIME_SCREEN" FOREIGN KEY ("SCREEN_ID") REFERENCES "CINEHIVE"."SCREEN" ("SCREEN_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table WATCHLIST
-- ----------------------------
ALTER TABLE "CINEHIVE"."WATCHLIST" ADD CONSTRAINT "FK_WATCHLIST_MOVIE" FOREIGN KEY ("MOVIE_ID") REFERENCES "CINEHIVE"."MOVIE" ("MOVIE_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CINEHIVE"."WATCHLIST" ADD CONSTRAINT "FK_WATCHLIST_USER" FOREIGN KEY ("USER_ID") REFERENCES "CINEHIVE"."APP_USER" ("USER_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

COMMIT;
