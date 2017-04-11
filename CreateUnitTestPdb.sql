CREATE PLUGGABLE DATABASE PDBORCL ADMIN USER pdbAdmin IDENTIFIED BY hackmenot FILE_NAME_CONVERT=('/u01/app/oracle/oradata/orcl/pdbseed/','/u01/app/oracle/oradata/orcl/pdborcl/');
declare

PDB_STATE varchar2(50);
begin
 
  
	SELECT open_mode into PDB_STATE FROM v$pdbs where NAME = 'PDBORCL';

	if (PDB_STATE != 'READ WRITE') then
		execute immediate 'ALTER PLUGGABLE DATABASE pdborcl OPEN';
		execute immediate 'ALTER PLUGGABLE DATABASE pdborcl SAVE STATE';
	end if;
end;
/
exit;
