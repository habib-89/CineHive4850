-- Rebuilds SEAT for screens 1 and 2 as 100 seats each:
-- rows A-H (80 seats) = REGULAR, rows I-J (20 seats) = PREMIUM.
-- This is a rebuild, so any existing bookings on these screens are cancelled first
-- (their headers are kept as CANCELLED for history, not deleted).

-- Step 1: Cancel any bookings that depend on screen 1/2 seats
UPDATE BOOKING SET PAYMENT_STATUS = 'REFUNDED'
WHERE BOOKING_ID IN (
  SELECT DISTINCT bs.BOOKING_ID FROM BOOKING_SEAT bs
  JOIN SEAT s ON s.SEAT_ID = bs.SEAT_ID
  WHERE s.SCREEN_ID IN (1, 2)
);

-- Step 2: Remove the old seat-booking links
DELETE FROM BOOKING_SEAT WHERE SEAT_ID IN (
  SELECT SEAT_ID FROM SEAT WHERE SCREEN_ID IN (1, 2)
);

-- Step 3: Remove the old (small) seat layout
DELETE FROM SEAT WHERE SCREEN_ID IN (1, 2);

-- Step 4: Insert the new 100-seat layout for each screen
-- Explicit SEAT_IDs starting at 1000+ to avoid any auto-generation ambiguity
DECLARE
  v_seat_id NUMBER;
BEGIN
  FOR scr IN 1..2 LOOP
    FOR r IN 0..9 LOOP          -- 10 rows: A..J
      FOR n IN 1..10 LOOP       -- 10 seats per row
        v_seat_id := 1000 + (scr - 1) * 100 + r * 10 + n;
        INSERT INTO SEAT (SEAT_ID, SCREEN_ID, ROW_NUMBER, SEAT_NUMBER, SEAT_TYPE)
        VALUES (
          v_seat_id,
          scr,
          CHR(65 + r),                                   -- 'A' through 'J'
          n,
          CASE WHEN r < 8 THEN 'REGULAR' ELSE 'PREMIUM' END  -- rows A-H regular, I-J premium
        );
      END LOOP;
    END LOOP;
  END LOOP;
  COMMIT;
END;
/

-- Step 5: Update screen capacity to reflect the new seat count
UPDATE SCREEN SET CAPACITY = 100 WHERE SCREEN_ID IN (1, 2);
COMMIT;