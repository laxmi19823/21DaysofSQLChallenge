-- 1. Who entered CEO Office near crime time
SELECT k.employee_id, e.name, k.room, k.entry_time, k.exit_time
FROM keycard_logs k JOIN employees e USING(employee_id)
WHERE k.room = 'CEO Office' AND k.entry_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:05';

-- 2. Alibis in window
SELECT a.employee_id, e.name, a.claimed_location, a.claim_time
FROM alibis a JOIN employees e USING(employee_id)
WHERE a.claim_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:05';

-- 3. Compare alibi vs keycard
SELECT a.employee_id, e.name, a.claimed_location, k.room AS actual_room, k.entry_time, k.exit_time
FROM alibis a
JOIN keycard_logs k ON a.employee_id = k.employee_id
JOIN employees e ON a.employee_id = e.employee_id
WHERE a.claim_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:05'
  AND k.entry_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:05';

-- 4. Calls around time
SELECT c.call_id, c.caller_id, ec.name AS caller, c.receiver_id, er.name AS receiver, c.call_time, c.duration_sec
FROM calls c
JOIN employees ec ON c.caller_id = ec.employee_id
JOIN employees er ON c.receiver_id = er.employee_id
WHERE c.call_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:05';

-- 5. Evidence at CEO Office
SELECT * FROM evidence WHERE room = 'CEO Office';

-- Final "Case Solved" single column output
SELECT e.name AS killer
FROM employees e
WHERE e.employee_id = (
  SELECT k.employee_id
  FROM keycard_logs k
  JOIN alibis a ON k.employee_id = a.employee_id
  JOIN calls c ON k.employee_id = c.caller_id
  WHERE k.room = 'CEO Office'
    AND k.entry_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:05'
    AND a.claim_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:05'
    AND c.call_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:05'
  LIMIT 1
);
