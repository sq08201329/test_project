#
#             Makefile common block for post. "POSTORAHOME/lib/pub.mk"
#
#
IBSDIR=$(HOME)
WORKDIR=$(HOME)

PROC=proc
OTTFLAGS=$(PCCFLAGS)
CLIBS= $(TTLIBS_QA) $(LDLIBS)
PRODUCT_LIBHOME=
PLSQLHOME=$(ORACLE_HOME)/plsql/
INCLUDE=$(I_SYM)$(PRECOMPHOME)public $(I_SYM)$(RDBMSHOME)public $(I_SYM)$(RDBMSHOME)demo $(I_SYM)$(PLSQLHOME)public $(I_SYM)$(HOME)/def 
STATICPROLDLIBS=$(SCOREPT) $(SSCOREED) $(DEF_ON) $(LLIBCLIENT) $(LLIBSQL) $(TTLIBS)

#���ϵ�����־���ڲ��˻���С�Ƹ���(INNSUMUPD)���ڲ��˻��������(INNDTLORDER)
DFLAG=-DLINUX -DDEBUG -DMSGDEBUG -DPACKETDEBUG -DMEMORYDEBUG -DINNDTLORDER -DINNSUMUPD
#�����ڲ��˻���С�Ƹ���(INNSUMUPD)���ڲ��˻��������(INNDTLORDER)
#DFLAG=-DLINUX -DINNDTLORDER -DINNSUMUPD
#DFLAG=-DLINUX
#PROCDFLAG='define=INNDTLORDER' 'define=INNSUMUPD'
PROCDFLAG='define=INNDTLORDER' 'define=INNSUMUPD' 'define=LINUX'
#PROCDFLAG='define=LINUX'

PROLDLIBS=$(LIBCLNTSH) $(LIBSQL)

PROCFLAGS= -DQLSQLCA 'def_sqlcode=true'  'parse=full' 'lines=true' \
'include=$(ORACLE_HOME)/precomp/public' \
   'include=$(HOME)/def' 'include=$(TUXDIR)/include' $(PROCDFLAG) \
 def_sqlcode=y

LIBDIR=$(WORKDIR)/lib
BINDIR=$(WORKDIR)/bin

CCARG= -g -m64  -fzero-initialized-in-bss -Wall
CC = gcc $(CCARG)

LD = ld

INCLDIR= -I$(WORKDIR)/def -I$(ORACLEDIR)/precomp/public -I$(TUXDIR)/include -I$(WORKDIR)/def/unibus
CFLAG= $(DFLAG) $(INCLDIR)
CFLAGS=$(CFLAG)

AR_BUILD = $(AR) -rv $(@) $(?F)          
LINK_SO = ld  $(PB_LDFLAGS) -bnoentry -bexpall -o $(@) $(?) $(PBLDLIBS)

LIB= -l -L${LIBDIR} \
	-l -lpacket -l -lmsgapi -l -ljson2c\
	-l -lpub -l -lbase -l -lpubmemory -l -lmud \
	-l -ldl -l -lpthread \
	-l -ltibems64 -l -ltibemslookup64 -l -ltibemsadmin64 \
	-l -lldap -l -llber -l -lssl -l -lz -l -lxml2 -l -lcrypto
#LIBS����
#SRVLIBS: Ϊtuxedo  server ����ʱ���õı����� ���Զ����USERLIBһ��ʹ�ã� 
#APPLIBS����tuxedo server�Ŀ�ִ�г������Ӧ�õĿ��ļ��� 
#TUXLIBS��tuxedo���ļ������ڷ�tuxedo server����ҪtuxedoAPI������Ҫʹ�øñ����� 
#ORACLELIBS��oracle���ļ������ڷ�tuxedo server����Ҫʹ��oracle����ʹ�øñ�����
TUXLIBS = -L$(TUXDIR)/lib -lwsc -lbuft -lfml -lfml32 
ORACLELIBS = -L${ORACLE_HOME}/lib -lclntsh

SRVLIBS= -l -L${WORKDIR}/lib \
	-l -lpacket -l -lmsgapi -l -ljson2c\
	-l -lfmlapi -l -lpubmemory -l -lpub -l -lmud -l -lbase\
	-l -ldl -l -lpthread \
	-l -ltibems64 -l -ltibemslookup64 -l -ltibemsadmin64 \
	-l -lldap -l -llber -l -lssl -l -lz -l -lxml2 -l -lcrypto

APPLIBS= -L$(WORKDIR)/lib -lpacket  -lmsgapi  -ljson2c\
	 -lpubmemory -lpub -lmud -lbase\
	 -ldl -lpthread \
	 -ltibems64 -ltibemslookup64  -ltibemsadmin64 \
	 -lldap  -llber  -lssl -lz  -lxml2  -lcrypto
