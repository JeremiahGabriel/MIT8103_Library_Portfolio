-- MIT8103 Advanced Database Systems
-- Portfolio 1: Verify database constraints
-- Database: university_library

SELECT
    table_name,
    constraint_name,
    constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'public'
  AND table_name IN (
      'student',
      'staff',
      'book',
      'bookcopy',
      'loan',
      'fine'
  )
ORDER BY table_name, constraint_type, constraint_name;