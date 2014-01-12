/****

����: ��ֲ'����2.0ϵͳ��ծ��ͻ�������ϸ'
����:
      iDATA_DATE:  ������, ��������
      iSYS_CODE:  ������, ϵͳ����
      iOPR_TYPE:  ������, ��������( 1-ȫ������������ϸ, 2-����������ϸ )
      oERROR_ID:  �����, �������( 0����ɹ� )
      oERROR_DESC:  �����, �����������
ʹ�ÿ��:
      1.������( t_mgmt_para )
      2.����ϵͳ�����( t_mgmt_sys_code )
      3.���ڿ�Ŀԭ��������ֻ��˻��ܱ�( t_chg_acc_total_XX99001 )
      4.ҵ������������ϸ( t_acc_gnl_dtl ) -- ���˿�
      5.ҵ�����׻���������ϸ( t_acc_inst_dtl ) -- ���˿�

���Է���:
SQL> SET SERVEROUTPUT ON SIZE 100000;
SQL> DECLARE
    iDATA_DATE VARCHAR2( 8 ) := '20130327';
    iSYS_CODE  VARCHAR2( 11 ) := '61990010000';
    iOPR_TYPE  NUMBER( 2 ) := 1;
    oERROR_ID NUMBER( 10 ) := -1;
    oERROR_DESC  VARCHAR2( 250 ) := '';
    BEGIN
       mig_sav_gnl( iDATA_DATE, iSYS_CODE, iOPR_TYPE, oERROR_ID, oERROR_DESC );
       dbms_output.put_line( 'oERROR_ID = ' || oERROR_ID );
       dbms_output.put_line( 'oERROR_DESC = ' || oERROR_DESC );
    END;
    /

****/


CREATE OR REPLACE PROCEDURE mig_sav_gnl( iDATA_DATE IN VARCHAR2, iSYS_CODE IN VARCHAR2, iOPR_TYPE IN NUMBER, oERROR_ID OUT NUMBER, oERROR_DESC OUT VARCHAR2 ) AUTHID CURRENT_USER
IS
        TYPE define_cursor IS REF CURSOR;
        cursor_accgnl  define_cursor;
        cursor_instgnl  define_cursor;

	event_EXCEPTION  EXCEPTION;
	PRAGMA EXCEPTION_INIT( event_EXCEPTION, -1 );

	m_mgmt_para  t_mgmt_para%ROWTYPE;
	m_mgmt_sys_code  t_mgmt_sys_code%ROWTYPE;

	c_task_id  CHAR( 7 ) := 'B'||SUBSTR( iSYS_CODE, 1, 2 ) || SUBSTR( iSYS_CODE, 1, 2 ) || '03'; /* �ֺܷ˶������� */
	c_run_stat CHAR( 1 ) := '0';
	tmp_sql  VARCHAR2( 512 ) := '';
	cursor_sql VARCHAR2( 1024 ) := '';
	insert_sql VARCHAR2( 1024 ) := '';
	update_sql VARCHAR2( 1024 ) := '';
	v_sys_code CHAR( 7 ) := SUBSTR( iSYS_CODE, 1, 7 );
	c_acc_inst CHAR( 8 ) := '';
	c_up_itm_no  CHAR( 15 ) := '';
	c_itm_lv  CHAR( 1 ) := '';
	c_itm_no CHAR( 15 ) := '';
	c_old_itm_no CHAR( 15 ) := 'INITITM';
	d_cr_bal  NUMBER( 22, 2 ) := 0;
	d_cr_crt_bal_dvlp  NUMBER( 22, 2 ) := 0;
	l_acc_num  NUMBER( 10 ) := 0;
BEGIN

	IF ( SUBSTR( iSYS_CODE, 3, 9 ) <> '990010000' ) THEN  /* �Ǵ���2.0ϵͳ */

		oERROR_ID := -701;
		oERROR_DESC := '����Ч�ĺ���ϵͳ����'||iSYS_CODE;

		RETURN;

	END IF;

	IF ( iOPR_TYPE NOT IN ( 1, 2 ) ) THEN

		oERROR_ID := -702;
		oERROR_DESC := '����Ч�Ĳ�������'||iOPR_TYPE;

		RETURN;

	END IF;

	BEGIN

		SELECT para_no, para_name, val_type, para_val_long, para_val_char, para_val_number, para_desc
			INTO m_mgmt_para
			FROM t_mgmt_para 
			WHERE para_no = 'CHGDATE';

	EXCEPTION

		WHEN NO_DATA_FOUND THEN 

			oERROR_ID := -703; 
			oERROR_DESC := '����<�л�����>δ����';

			RETURN;

		WHEN OTHERS THEN 

			oERROR_ID := -704; 
			oERROR_DESC := '��ȡt_mgmt_paraʧ�� ORA=' || SQLCODE;

			RETURN;

	END; 

	BEGIN

		SELECT chg_date, sys_code, sys_name, rela_sys, batch_no, stat, flag
			INTO m_mgmt_sys_code
			FROM t_mgmt_sys_code
			WHERE upper( sys_code ) = upper( iSYS_CODE )
				AND batch_no = m_mgmt_para.para_val_long
				AND flag = '0'; 

	EXCEPTION

		WHEN NO_DATA_FOUND THEN

			oERROR_ID := -705;
			oERROR_DESC := '����ϵͳ'||iSYS_CODE ||'�л��պ���ϵͳ�嵥δ����';

			RETURN;

		WHEN OTHERS THEN

			oERROR_ID := -706;
			oERROR_DESC := '��ȡt_mgmt_sys_codeʧ�� ORA=' || SQLCODE;

			RETURN;

	END;

	IF ( m_mgmt_sys_code.chg_date <> iDATA_DATE ) THEN

		oERROR_ID := -707;
		oERROR_DESC := '����Ч����������'||iDATA_DATE;

		RETURN;

	END IF;

	IF ( ( iOPR_TYPE = 1 AND SUBSTR( m_mgmt_sys_code.stat, 1, 1 ) = 'Y' ) OR
	     ( iOPR_TYPE = 2 AND SUBSTR( m_mgmt_sys_code.stat, 2, 1 ) = 'Y' ) ) THEN

		oERROR_ID := -708;
		oERROR_DESC := '����ϵͳ'||iSYS_CODE||'��������'||iDATA_DATE||'��������['||iOPR_TYPE||']������ϸ�Ѿ��л��ɹ�,��ֹ�ٴβ���?';

		RETURN;

	END IF;

	tmp_sql := 'SELECT run_stat FROM t_chg_task_mgmt_' || v_sys_code || ' WHERE chg_date = :1 AND sys_code = :2 AND task_id = :3 ';

	BEGIN

		EXECUTE IMMEDIATE tmp_sql INTO c_run_stat USING  iDATA_DATE, iSYS_CODE, c_task_id;

	EXCEPTION

		WHEN NO_DATA_FOUND THEN

			oERROR_ID := -709;
			oERROR_DESC := '����ϵͳ'||iSYS_CODE||'�л���'||iDATA_DATE||'δ����ּܷ�鲽��,��ִֹ��������ϸ��ֲ?';

			RETURN;

		WHEN OTHERS THEN

			oERROR_ID := -710;
			oERROR_DESC := '����ʧ��710 tmp_sql=: '||tmp_sql||' ʧ��=['||SQLCODE||']';

			RETURN;

	END;

	IF ( c_run_stat <> '2' ) THEN  /* 0-��ʼ��״̬��1-�������С�2-���н�����OK����3-���н�����ERROR����4-���н���������ʧ�ܣ� */

		oERROR_ID := -711;
		oERROR_DESC := '����ϵͳ'||iSYS_CODE||'�л���'||iDATA_DATE||'�ּܷ��ʧ��,��ֹ����ִ��������ϸ��ֲ?';

		RETURN;

	END IF;

	IF ( iOPR_TYPE = 1 ) THEN /* ȫ������������ϸ */

		cursor_sql := 'SELECT itm_no, sum( cr_bal ), sum( acc_num ) FROM t_chg_acc_total_'||v_sys_code||' WHERE SUBSTR( acc_type, 1, 1 ) IN ( :1, :2 ) GROUP BY itm_no ORDER BY itm_no ';
		insert_sql := 'INSERT INTO t_acc_gnl_dtl@miggnl VALUES( :1, :2, :3, :4, :5, :6, :7, :8, 0, :9, 0, :10, 0, :11, 0, 0, 0, 0, 0, 0, 0, 0, :12 ) ';
		update_sql := 'UPDATE t_acc_gnl_dtl@miggnl SET cr_amt = cr_amt + :1, cr_num = cr_num + :2, cr_crt_bal = cr_crt_bal + :3 WHERE tran_date = :4 AND itm_no = :5 AND acc_set = :6 ';
		OPEN cursor_accgnl FOR cursor_sql USING '3', '5';

		IF cursor_accgnl%ISOPEN THEN

			LOOP

				c_itm_no := '';
				d_cr_bal := 0;
				l_acc_num := 0;

				FETCH cursor_accgnl INTO c_itm_no, d_cr_bal, l_acc_num;
				EXIT WHEN cursor_accgnl%NOTFOUND;

				IF ( c_old_itm_no <> c_itm_no ) THEN  /* ����Ŀ���ʼ����Ŀ */

					c_up_itm_no := '';
					c_itm_lv := '';
					d_cr_crt_bal_dvlp := 0;

					BEGIN

						SELECT ITM_LVL, NVL( SUPITM_NO, ' ' ) INTO c_itm_lv, c_up_itm_no FROM v_mng_pa_itm 
							WHERE itm_no = c_itm_no;

					EXCEPTION

						WHEN NO_DATA_FOUND THEN

							oERROR_ID := -699;
							oERROR_DESC := '����ʧ��699: �¿�Ŀ����['||c_itm_no||']�Ƿ�';
							CLOSE cursor_accgnl;

							RETURN;

						WHEN OTHERS THEN

							oERROR_ID := -698;
							oERROR_DESC := '����ʧ��698: select v_mng_pa_itmʧ��=['||SQLCODE||']';
							CLOSE cursor_accgnl;

							RETURN;

					END;

					c_old_itm_no := c_itm_no;

					BEGIN

						SELECT NVL( cr_crt_bal, 0 ) INTO d_cr_crt_bal_dvlp FROM t_acc_gnl_dvlp@miggnl WHERE itm_no = c_itm_no AND acc_set = '001156';

					EXCEPTION

						WHEN NO_DATA_FOUND THEN

							d_cr_crt_bal_dvlp := 0;

						WHEN OTHERS THEN

							oERROR_ID := -697;
							oERROR_DESC := '����ʧ��697: select t_acc_gnl_dvlp@miggnlʧ��=['||SQLCODE||']';
							CLOSE cursor_accgnl;

							RETURN;

					END;

				END IF;

				BEGIN

					EXECUTE IMMEDIATE insert_sql USING iDATA_DATE, c_itm_no, '001156', '0', '156', c_itm_lv, c_up_itm_no, '1', d_cr_bal, l_acc_num, d_cr_bal + d_cr_crt_bal_dvlp, '00000000';

				EXCEPTION

					WHEN event_EXCEPTION THEN /* �ظ���¼���� */

						BEGIN

							EXECUTE IMMEDIATE update_sql USING d_cr_bal, l_acc_num, d_cr_bal, iDATA_DATE, c_itm_no, '001156';

						EXCEPTION

							WHEN OTHERS THEN

								oERROR_ID := -696;
								oERROR_DESC := '����ʧ��696: update t_acc_gnl_dtlʧ��=['||SQLCODE||']';
								CLOSE cursor_accgnl;

								RETURN;

						END;

					WHEN OTHERS THEN

						oERROR_ID := -695;
						oERROR_DESC := '����ʧ��695: insert t_acc_gnl_dtlʧ��=['||SQLCODE||']';
						CLOSE cursor_accgnl;

						RETURN;

				END;

			END LOOP;

			CLOSE cursor_accgnl;

		ELSE

			oERROR_ID := -694;
			oERROR_DESC := '����ʧ��694: open cursor_accgnlʧ��=['||SQLCODE||']';

			RETURN;

		END IF;

		UPDATE t_mgmt_sys_code
			SET stat = 'Y'||SUBSTR( m_mgmt_sys_code.stat, 2, 7 )
			WHERE upper( sys_code ) = upper( iSYS_CODE )
				AND batch_no = m_mgmt_para.para_val_long
				AND flag = '0'; 

		oERROR_ID := 0;
		oERROR_DESC := '����ϵͳ'||iSYS_CODE||'��������['||iOPR_TYPE||']�л��ɹ�';

		RETURN;

	END IF;

	/* ����������ϸ */

	d_cr_crt_bal_dvlp := 0;
	cursor_sql := 'SELECT itm_no, acc_inst, sum( cr_bal ), sum( acc_num ) FROM t_chg_acc_total_'||v_sys_code||' WHERE SUBSTR( acc_type, 1, 1 ) IN ( :1, :2 ) GROUP BY itm_no, acc_inst  ORDER BY itm_no, acc_inst ';
	insert_sql := 'INSERT INTO t_acc_inst_dtl@miggnl VALUES( :1, :2, :3, :4, :5, :6, :7, :8, :9, 0, :10, 0, :11, 0, :12, 0, 0, 0, 0, 0, 0, 0, 0, :13 ) ';
	update_sql := 'UPDATE t_acc_inst_dtl@miggnl SET cr_amt = cr_amt + :1, cr_num = cr_num + :2, cr_crt_bal = cr_crt_bal + :3 WHERE inst_no = :4 AND tran_date = :5 AND itm_no = :6 AND acc_set = :7 ';
	OPEN cursor_instgnl FOR cursor_sql USING '3', '5';

	IF cursor_instgnl%ISOPEN THEN

		LOOP

			c_acc_inst := '';
			c_itm_no := '';
			d_cr_bal := 0;
			l_acc_num := 0;

			FETCH cursor_instgnl INTO c_itm_no, c_acc_inst, d_cr_bal, l_acc_num;
			EXIT WHEN cursor_instgnl%NOTFOUND;

			IF ( c_old_itm_no <> c_itm_no ) THEN  /* ����Ŀ���ʼ����Ŀ */

				c_up_itm_no := '';
				c_itm_lv := '';
				d_cr_crt_bal_dvlp := 0;

				BEGIN

					SELECT ITM_LVL, NVL( SUPITM_NO, ' ' ) INTO c_itm_lv, c_up_itm_no FROM v_mng_pa_itm 
						WHERE itm_no = c_itm_no;

				EXCEPTION

					WHEN NO_DATA_FOUND THEN

						oERROR_ID := -599;
						oERROR_DESC := '����ʧ��599: �¿�Ŀ����['||c_itm_no||']�Ƿ�';
						CLOSE cursor_instgnl;

						RETURN;

					WHEN OTHERS THEN

						oERROR_ID := -598;
						oERROR_DESC := '����ʧ��598: select v_mng_pa_itmʧ��=['||SQLCODE||']';
						CLOSE cursor_instgnl;

						RETURN;

				END;

				c_old_itm_no := c_itm_no;

				BEGIN

					SELECT NVL( cr_crt_bal, 0 ) INTO d_cr_crt_bal_dvlp FROM t_acc_inst_dvlp@miggnl WHERE inst_no = c_acc_inst AND itm_no = c_itm_no AND acc_set = '001156';

				EXCEPTION

					WHEN NO_DATA_FOUND THEN

						d_cr_crt_bal_dvlp := 0;

					WHEN OTHERS THEN

						oERROR_ID := -597;
						oERROR_DESC := '����ʧ��597: select t_acc_inst_dvlp@miggnlʧ��=['||SQLCODE||']';
						CLOSE cursor_accgnl;

						RETURN;

				END;

			END IF;

			BEGIN

				EXECUTE IMMEDIATE insert_sql USING c_acc_inst, iDATA_DATE, c_itm_no, '001156', '0', '156', c_itm_lv, c_up_itm_no, '1', d_cr_bal, l_acc_num, d_cr_bal + d_cr_crt_bal_dvlp, '00000000';

			EXCEPTION

				WHEN event_EXCEPTION THEN /* �ظ���¼���� */

					BEGIN

						EXECUTE IMMEDIATE update_sql USING d_cr_bal, l_acc_num, d_cr_bal, c_acc_inst, iDATA_DATE, c_itm_no, '001156';

					EXCEPTION

						WHEN OTHERS THEN

							oERROR_ID := -596;
							oERROR_DESC := '����ʧ��596: update t_acc_inst_dtlʧ��=['||SQLCODE||']';
							CLOSE cursor_instgnl;

							RETURN;

					END;

				WHEN OTHERS THEN

					oERROR_ID := -595;
					oERROR_DESC := '����ʧ��595: insert t_acc_inst_dtlʧ��=['||SQLCODE||']';
					CLOSE cursor_instgnl;

					RETURN;

			END;

		END LOOP;

		CLOSE cursor_instgnl;

		UPDATE t_mgmt_sys_code
			SET stat = SUBSTR( m_mgmt_sys_code.stat, 1, 1 ) || 'Y'||SUBSTR( m_mgmt_sys_code.stat, 3, 6 )
			WHERE upper( sys_code ) = upper( iSYS_CODE )
				AND batch_no = m_mgmt_para.para_val_long
				AND flag = '0'; 

	ELSE

		oERROR_ID := -594;
		oERROR_DESC := '����ʧ��594: open cursor_instgnlʧ��=['||SQLCODE||']';

		RETURN;

	END IF;

	oERROR_ID := 0;
	oERROR_DESC := '����ϵͳ'||iSYS_CODE||'��������['||iOPR_TYPE||']�л��ɹ�';

	RETURN;

END;
/


