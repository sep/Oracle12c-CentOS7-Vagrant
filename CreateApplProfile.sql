declare
begin
	execute immediate 'alter session set "_ORACLE_SCRIPT"=true';
	execute immediate 'CREATE PROFILE APPL LIMIT FAILED_LOGIN_ATTEMPTS UNLIMITED SESSIONS_PER_USER 268 PASSWORD_LIFE_TIME UNLIMITED PASSWORD_LOCK_TIME 1/86400';
end;
/
exit;