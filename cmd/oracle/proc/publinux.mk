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

#加上调试日志、内部账户日小计更新(INNSUMUPD)、内部账户余额排序(INNDTLORDER)
DFLAG=-DLINUX -DDEBUG -DMSGDEBUG -DPACKETDEBUG -DMEMORYDEBUG -DINNDTLORDER -DINNSUMUPD
#加上内部账户日小计更新(INNSUMUPD)、内部账户余额排序(INNDTLORDER)
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
#LIBS定义
#SRVLIBS: 为tuxedo  server 编译时引用的变量， 与自定义的USERLIB一起使用； 
#APPLIBS：非tuxedo server的可执行程序编译应用的库文件； 
#TUXLIBS：tuxedo库文件，若在非tuxedo server中需要tuxedoAPI，则需要使用该变量； 
#ORACLELIBS：oracle库文件，若在非tuxedo server中需要使用oracle，需使用该变量。
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
