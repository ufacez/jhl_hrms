-- Add or update attendance records for Bernie Oribia from 2026-04-04 to 2026-04-15.
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
    d.attendance_date,
    '08:00:00' AS time_in,
    '17:00:00' AS time_out,
    'present' AS status,
    8.00 AS hours_worked,
    9.00 AS raw_hours_worked,
    1.00 AS break_hours,
    0 AS late_minutes,
    NOW() AS calculated_at,
    0.00 AS overtime_hours,
    'Manual payroll attendance entry (Apr 4 to Apr 15)' AS notes,
    1 AS verified_by,
    NOW() AS created_at,
    NOW() AS updated_at,
    0 AS is_archived,
    NULL AS archived_at,
    NULL AS archived_by
FROM workers w
JOIN (
    SELECT DATE('2026-04-04') AS attendance_date
    UNION ALL SELECT DATE('2026-04-05')
    UNION ALL SELECT DATE('2026-04-06')
    UNION ALL SELECT DATE('2026-04-07')
    UNION ALL SELECT DATE('2026-04-08')
    UNION ALL SELECT DATE('2026-04-09')
    UNION ALL SELECT DATE('2026-04-10')
    UNION ALL SELECT DATE('2026-04-11')
    UNION ALL SELECT DATE('2026-04-12')
    UNION ALL SELECT DATE('2026-04-13')
    UNION ALL SELECT DATE('2026-04-14')
    UNION ALL SELECT DATE('2026-04-15')
) d
WHERE w.first_name = 'Bernie'
  AND w.last_name = 'Oribia'
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
-- SELECT attendance_date, time_in, time_out, status, hours_worked
-- FROM attendance
-- WHERE worker_id = (
--     SELECT worker_id FROM workers WHERE first_name = 'Bernie' AND last_name = 'Oribia' LIMIT 1
-- )
-- AND attendance_date BETWEEN '2026-04-04' AND '2026-04-15'
-- ORDER BY attendance_date;
