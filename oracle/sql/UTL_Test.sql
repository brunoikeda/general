DECLARE
  file1 UTL_FILE.FILE_TYPE;
BEGIN
  file1 := UTL_FILE.FOPEN('BSCS_UTL','test.txt','w');
  UTL_FILE.PUT_LINE(file1,'Test of UTL_FILE');
  UTL_FILE.FCLOSE(file1);
END;
/
