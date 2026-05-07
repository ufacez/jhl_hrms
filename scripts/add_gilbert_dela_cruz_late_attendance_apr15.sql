-- Add or update late attendance for Gilbert Dela Cruz on 2026-04-15.
-- This script is idempotent due to ON DUPLICATE KEY UPDATE and relies on
-- the unique key (worker_id, attendance_date) in the attendance table.

INSERT INTO attendance (
    worker_id,
    attendance_date,
    time_in,
    time_out,
    status,
    hours_worked,
    raw_hours_worked,
    break_hours,
    late_minutes,
    calculated_at,
    overtime_hours,
    notes,
    verified_by,
    created_at,
    updated_at,
    is_archived,
    archived_at,
    archived_by
)
SELECT
    w.worker_id,
    DATE('2026-04-15') AS attendance_date,
    '08:30:00' AS time_in,
    '17:00:00' AS time_out,
    'late' AS status,
    8.50 AS hours_worked,
    8.50 AS raw_hours_worked,
    0.00 AS break_hours,
    30 AS late_minutes,
    NOW() AS calculated_at,
    0.00 AS overtime_hours,
    'Manual payroll attendance entry (late on Apr 15)' AS notes,
    1 AS verified_by,
    NOW() AS created_at,
    NOW() AS updated_at,
    0 AS is_archived,
    NULL AS archived_at,
    NULL AS archived_by
FROM workers w
WHERE w.first_name = 'Gilbert'
  AND w.last_name = 'Dela Cruz'
  AND w.is_archived = 0
ON DUPLICATE KEY UPDATE
    time_in = VALUES(time_in),
    time_out = VALUES(time_out),
    status = VALUES(status),
    hours_worked = VALUES(hours_worked),
    raw_hours_worked = VALUES(raw_hours_worked),
    break_hours = VALUES(break_hours),
    late_minutes = VALUES(late_minutes),
    calculated_at = VALUES(calculated_at),
    overtime_hours = VALUES(overtime_hours),
    notes = VALUES(notes),
    verified_by = VALUES(verified_by),
    updated_at = VALUES(updated_at),
    is_archived = 0,
    archived_at = NULL,
    archived_by = NULL;

-- Optional validation query:
-- SELECT a.attendance_date, a.time_in, a.time_out, a.status, a.hours_worked, a.late_minutes, a.notes
-- FROM attendance a
-- JOIN workers w ON w.worker_id = a.worker_id
-- WHERE w.first_name = 'Gilbert'
--   AND w.last_name = 'Dela Cruz'
--   AND a.attendance_date = '2026-04-15';
