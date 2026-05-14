-- Add on-leave flag for daily schedules
ALTER TABLE daily_schedules
    ADD COLUMN is_on_leave TINYINT(1) NOT NULL DEFAULT 0 AFTER is_rest_day;

-- Optional: backfill from notes if you have a standard marker
-- UPDATE daily_schedules SET is_on_leave = 1 WHERE notes LIKE '%On Leave%';
