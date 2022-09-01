SET TIME ON
SET TIMING ON
SET ECHO ON 
SET SERVEROUTPUT ON SIZE 1000000
SPOOL ACC_PROC.log
DECLARE
-- **************************************
-- Variaveis dos PARAMETROS DE ENTRADA
--***************************************
vlimit_proc		    NUMBER          := '&1'; -- Total de registros que serao processados
vLimit		        NUMBER          := '1000'; --Controle de commit. Sera commitado de x em x
------------------------------------------------------------
-- PROCEDURE LOG
------------------------------------------------------------
PROCEDURE LOG ( P_MSG in VARCHAR2 ) IS
  BEGIN

    DBMS_OUTPUT.Put_Line (TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS')||' - '|| P_MSG);

  EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('Erro na procedure log :'||sqlerrm);
    RAISE;
  END;

------------------------------------------------------------------------------
--PROCEDURE HEADER_LOG IS
------------------------------------------------------------------------------
PROCEDURE HEADER_LOG IS
vdbname                       varchar2 (100);
vdbshname                     varchar2 (100);
BEGIN

  SELECT GLOBAL_NAME, SUBSTR (REPLACE (GLOBAL_NAME, '.WORLD'), -3)
  INTO vdbname, vdbshname
  FROM GLOBAL_NAME;

  BEGIN
      LOG('---------------------------------------------------------');
      LOG('- Processo Iniciado');
      LOG('- Base: ' || vdbname);
      LOG('---------------------------------------------------------');
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('LOG UTL_FILE.FOPEN ERROR ROLLBACK: ' || SQLERRM);
    RAISE;
  END;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro na inicializa�ao do processamento: ' || SQLERRM);
    RAISE;
END;
------------------------------------------------------------------------------
--INICIO DA PROCEDURE
------------------------------------------------------------------------------
PROCEDURE ACC_PROC 
IS
   CURSOR update_proc
   IS
      SELECT 	S.ROWID AS row_id, S.*
        FROM ACC_TESTE_PROC S
        WHERE PROCESSADO IS NULL
        AND rownum <= vlimit_proc;
        
   --------------------------------------------------------------------------
   TYPE ttemp IS TABLE OF update_proc%ROWTYPE INDEX BY BINARY_INTEGER;
   TYPE t_campo_1 IS TABLE OF TESTE3.CAMPO_1%TYPE INDEX BY BINARY_INTEGER;
   TYPE t_campo_2 IS TABLE OF TESTE3.CAMPO_2%TYPE INDEX BY BINARY_INTEGER;
   TYPE trowid IS TABLE OF ROWID INDEX BY BINARY_INTEGER;

   vtemp                        ttemp;
   v_campo_1                   t_campo_1;
   v_campo_2                   t_campo_2;
   vrowid                       trowid;
   --------------------------------------------------------------------------
   -- Variaveis de exce��o do FORALL
   --------------------------------------------------------------------------
   bulkerrors EXCEPTION;
   PRAGMA EXCEPTION_INIT (bulkerrors, -24381);
   
BEGIN

  OPEN update_proc;
  LOG ('Iniciando o processo de atualizacao da tabela SUBSCRIBER.');
  LOOP
    --armazena os dados do cursor update_proc
    LOG ('Fetch da tabela de controle.');
    FETCH update_proc
    BULK COLLECT INTO vtemp
    LIMIT vlimit;

    --distribui para os vetores os dados do cursor
    FOR i IN 1 .. vtemp.COUNT  
    LOOP
      BEGIN

        vrowid(i) := vtemp(i).row_id;
        v_campo_1(i) := vtemp(i).CAMPO_1;
        v_campo_2(i) := NULL;

		  END; 
    END LOOP;

    LOG ('Iniciando Update ForalL.');
	  
	  BEGIN
      FORALL m IN 1 .. vrowid.COUNT
      SAVE EXCEPTIONS
					
        UPDATE TESTE3 SET 
          CAMPO_2 = v_campo_2(m)
        WHERE 
          CAMPO_1 = v_campo_1(m);

      EXCEPTION
      WHEN BulkErrors
      THEN
        LOG ('WARNING - Erro ao atualizar a tabela TESTE3');
        FOR z IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
        LOOP
			    LOG ('WARNING - ERRO AO ATUALIZAR A CAMPO_1 ['|| v_campo_1(SQL%BULK_EXCEPTIONS (z).ERROR_INDEX)
          || '] NA TABELA TESTE3 - '
          || SQLERRM (-SQL%BULK_EXCEPTIONS (z).ERROR_CODE));
        END LOOP;
    END;
    COMMIT;
	  
    LOG ('Iniciando Update Forall da tabela de controle ACC_TESTE_PROC.');
    BEGIN
      FORALL a IN 1 .. vrowid.COUNT
      SAVE EXCEPTIONS

      UPDATE ACC_TESTE_PROC 
        SET PROCESSADO = 'X',
            PROC_DATE = SYSDATE
        WHERE ROWID = vrowid(a);
      
      EXCEPTION
        WHEN bulkerrors THEN
          LOG ('WARNING - Erro ao atualizar tabela ACC_TESTE_PROC');
          FOR w IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
          LOOP
              LOG('ROWID: [' ||vrowid(SQL%BULK_EXCEPTIONS (w).ERROR_INDEX)
              || '], ' || SQLERRM (-SQL%BULK_EXCEPTIONS (w).ERROR_CODE));
          END LOOP;
    END;
    COMMIT;
	  
    vtemp.DELETE;
    v_campo_1.DELETE;
    v_campo_2.DELETE;
    vrowid.DELETE;    

  EXIT WHEN update_proc%NOTFOUND;
      
  END LOOP;

  CLOSE update_proc;
   
  EXCEPTION
  WHEN OTHERS THEN
    LOG ('Erro na procedure ACC_PROC :' || SQLERRM);
    RAISE;
      
END ACC_PROC;

--------------------------------------------------------------------------------
-- PROCEDURE MAIN
--------------------------------------------------------------------------------
PROCEDURE MAIN IS
BEGIN

  -- Abre arquivo de Log
  LOG('----------------------------------------------------------------------------------------');
  LOG(' Execucao do ACC_PROC.  ');
  LOG('----------------------------------------------------------------------------------------');
  LOG('Inicio da execucao: ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS'));
  LOG('----------------------------------------------------------------------------------------');

  HEADER_LOG;

  ACC_PROC;

  COMMIT;
  LOG('Commit efetuado com sucesso.');
  LOG('Script finalizado com sucesso.');
  LOG('--------------------------------------------------------------------------------');
  LOG('Termino da execucao: ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS'));
  LOG('--------------------------------------------------------------------------------');

  EXCEPTION 
  WHEN OTHERS THEN
    LOG('Erro na execucao do script.' || CHR(10) || 'Mensagem de Erro: '||SQLERRM );
    LOG('Termino com erro: ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS'));
    ROLLBACK;
    LOG('ROLLBACK efetuado.');
    LOG('--------------------------------------------------------------------------------');
    LOG('Termino da execucao: ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS'));
    LOG('--------------------------------------------------------------------------------');
    
END;
--------------------------------------------------------------------------------
-- Inicio do Script
--------------------------------------------------------------------------------
BEGIN

  MAIN;

END ;
/
EXIT
