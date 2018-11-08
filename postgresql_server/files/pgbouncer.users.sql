COPY ( SELECT '"' || rolname || '" "' || CASE WHEN rolpassword IS null THEN '' ELSE rolpassword END || '"' FROM pg_authid ) TO '/tmp/pgbouncer.users';

