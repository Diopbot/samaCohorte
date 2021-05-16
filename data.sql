SQL> connect sys as sysdba
Connect .
SQL> --Voir sous quel utilisateur on est connecté
SQL> show user
sqlplus /nolog
USER est "SYS"
SQL> /* 
SQL> SYS l'administrateur de oracle database. c'est le super utilisateur qui pocéde le role le plus élevé.
SQL> */
SQL> --Généralités:
SQL> --------------
SQL> /*
SQL> Serveur de BD Oracle = Mémoire SGA + Background Process + BD
SQL> SGA (System Global Area) est la zone mémoire ou le backgroung process s'execute pour assurer le service.
SQL> SGA + background process = Instance.
SQL> 
SQL> BD = 3 types de fichier (Controle, Journalisation et Donnees)
SQL> Fichier de controle: gère la coherence des données.
SQL> Fichier de journalisation: enregistre les modifications apportées aux données.
SQL> Fichier de données: stocke les données.
SQL> */
SQL> 
SQL> --Recueil d'information de la base:
SQL> -----------------------------------
SQL> /*
SQL> Pour recueillir les informations de la BD, l'administrateur peut recourir au dictionnaire de données.
SQL> Le dictionnaire de données oracle est un ensemble de vue (crée à partir de table) contenant les informations 
SQL> de toutes les définitions (objets existants) de la base.
SQL> */
SQL> --Emplacement des fichiers de controle:
SQL> /*
SQL> La vue v$controlfile donne les infos sur les fichiers de controle.
SQL> */

SQL> desc v$controlfile
 Nom                                       NULL ?   Type
 ----------------------------------------- -------- ----------------------------
 STATUS                                             VARCHAR2(7)
 NAME                                               VARCHAR2(513)
 IS_RECOVERY_DEST_FILE                              VARCHAR2(3)
 BLOCK_SIZE                                         NUMBER
 FILE_SIZE_BLKS                                     NUMBER
 CON_ID                                             NUMBER

SQL> select name from v$controlfile;

NAME                                                                            
--------------------------------------------------------------------------------
C:\APP\DRSOU\ORADATA\ORCL\CONTROL01.CTL                                         
C:\APP\DRSOU\FAST_RECOVERY_AREA\ORCL\CONTROL02.CTL                              

SQL> --Emplacement des fichiers de journalisation:
SQL> /*
SQL> La vue v$logfile donne les infos sur les fichiers de journalisation
SQL> */

SQL> desc v$logfile
 Nom                                       NULL ?   Type
 ----------------------------------------- -------- ----------------------------
 GROUP#                                             NUMBER
 STATUS                                             VARCHAR2(7)
 TYPE                                               VARCHAR2(7)
 MEMBER                                             VARCHAR2(513)
 IS_RECOVERY_DEST_FILE                              VARCHAR2(3)
 CON_ID                                             NUMBER

SQL> select member
  2  from v$logfile;

MEMBER                                                                          
--------------------------------------------------------------------------------
C:\APP\DRSOU\ORADATA\ORCL\REDO03.LOG                                            
C:\APP\DRSOU\ORADATA\ORCL\REDO02.LOG                                            
C:\APP\DRSOU\ORADATA\ORCL\REDO01.LOG                                            

SQL> --Emplacement des fichiers de donnees
SQL> /*
SQL> La vue dba_data_files donne les infos sur les fichiers de donnees.
SQL> */

SQL> desc dba_data_files
 Nom                                       NULL ?   Type
 ----------------------------------------- -------- ----------------------------
 FILE_NAME                                          VARCHAR2(513)
 FILE_ID                                            NUMBER
 TABLESPACE_NAME                                    VARCHAR2(30)
 BYTES                                              NUMBER
 BLOCKS                                             NUMBER
 STATUS                                             VARCHAR2(9)
 RELATIVE_FNO                                       NUMBER
 AUTOEXTENSIBLE                                     VARCHAR2(3)
 MAXBYTES                                           NUMBER
 MAXBLOCKS                                          NUMBER
 INCREMENT_BY                                       NUMBER
 USER_BYTES                                         NUMBER
 USER_BLOCKS                                        NUMBER
 ONLINE_STATUS                                      VARCHAR2(7)

SQL> select file_name from dba_data_files;

FILE_NAME                                                                       
--------------------------------------------------------------------------------
C:\APP\DRSOU\ORADATA\ORCL\SYSTEM01.DBF                                          
C:\APP\DRSOU\ORADATA\ORCL\SYSAUX01.DBF                                          
C:\APP\DRSOU\ORADATA\ORCL\UNDOTBS01.DBF                                         
C:\APP\DRSOU\ORADATA\ORCL\USERS01.DBF                                           
C:\APP\DRSOU\ORADATA\ORCL\EXAMPLE01.DBF                                         

SQL> --Organisation logique:
SQL> /*
SQL> Oracle est organisé logiquement en tablespace.
SQL> Un tablespace est un regroupement de tables qui se partagent les memes fichiers pour le partage de leurs données.
SQL> Ce type de tablespace est appelé: tablespace permanent.
SQL> */
SQL> --lister les tablespaces des données:
SQL> ------------------------------------
SQL> /*
SQL> la vue dba_tablespace contient les fichiers de donnees.
SQL> */

SQL> desc dba_tablespaces
 Nom                                       NULL ?   Type
 ----------------------------------------- -------- ----------------------------
 TABLESPACE_NAME                           NOT NULL VARCHAR2(30)
 BLOCK_SIZE                                NOT NULL NUMBER
 INITIAL_EXTENT                                     NUMBER
 NEXT_EXTENT                                        NUMBER
 MIN_EXTENTS                               NOT NULL NUMBER
 MAX_EXTENTS                                        NUMBER
 MAX_SIZE                                           NUMBER
 PCT_INCREASE                                       NUMBER
 MIN_EXTLEN                                         NUMBER
 STATUS                                             VARCHAR2(9)
 CONTENTS                                           VARCHAR2(9)
 LOGGING                                            VARCHAR2(9)
 FORCE_LOGGING                                      VARCHAR2(3)
 EXTENT_MANAGEMENT                                  VARCHAR2(10)
 ALLOCATION_TYPE                                    VARCHAR2(9)
 PLUGGED_IN                                         VARCHAR2(3)
 SEGMENT_SPACE_MANAGEMENT                           VARCHAR2(6)
 DEF_TAB_COMPRESSION                                VARCHAR2(8)
 RETENTION                                          VARCHAR2(11)
 BIGFILE                                            VARCHAR2(3)
 PREDICATE_EVALUATION                               VARCHAR2(7)
 ENCRYPTED                                          VARCHAR2(3)
 COMPRESS_FOR                                       VARCHAR2(30)

SQL> select tablespace_name from dba_tablespaces;

TABLESPACE_NAME                                                                 
------------------------------                                                  
SYSTEM                                                                          
SYSAUX                                                                          
UNDOTBS1                                                                        
TEMP                                                                            
USERS                                                                           
EXAMPLE                                                                         

6 lignes s lectionn es.

SQL> --diagnostiques de l'instance:
SQL> ------------------------------
SQL> /*
SQL> En cas de défaillance du système, il est recommandé d'inspecter les fichiers d'alerte.
SQL> */
SQL> --Emplacement des fichiers d'alerte:
SQL> ------------------------------------
SQL> /*
SQL> La vue v$diag_info donne l'emplacement du fichier d'alerte.
SQL> */
SQL> select value
  2  from v$diag_info
  3  where name='Diag Trace';

VALUE                                                                           
--------------------------------------------------------------------------------
C:\APP\DRSOU\diag\rdbms\orcl\orcl\trace                                         

SQL> /*
SQL> On va simuler une perte de fichier de données.
SQL> En guise de rappel (explication orale)
SQL> -Les fichiers de données et les fichiers de journalisation sont requis à l'ouverture de la BD.
SQL> -les fichiers de controle sont requis pour monter la base.
SQL> */
SQL> --Arret de la base
SQL> ------------------
SQL> shutdown immediate
Base de donn es ferm e.
Base de donn es d mont e.
Instance ORACLE arr t e.
SQL> 
SQL> --demarrage de la base
SQL> startup
Instance ORACLE lanc e.

Total System Global Area 1870647296 bytes                                       
Fixed Size                  2403928 bytes                                       
Variable Size             553648552 bytes                                       
Database Buffers         1308622848 bytes                                       
Redo Buffers                5971968 bytes                                       
Base de donn es mont e.
Base de donn es ouverte.
SQL> 
SQL> --Vérifier si la BD est ouverte
SQL> /*
SQL> ceci revient à vérifier le statut de l'instance.
SQL> */
SQL> desc v$instance
 Nom                                       NULL ?   Type
 ----------------------------------------- -------- ----------------------------
 INSTANCE_NUMBER                                    NUMBER
 INSTANCE_NAME                                      VARCHAR2(16)
 HOST_NAME                                          VARCHAR2(64)
 VERSION                                            VARCHAR2(17)
 STARTUP_TIME                                       DATE
 STATUS                                             VARCHAR2(12)
 PARALLEL                                           VARCHAR2(3)
 THREAD#                                            NUMBER
 ARCHIVER                                           VARCHAR2(7)
 LOG_SWITCH_WAIT                                    VARCHAR2(15)
 LOGINS                                             VARCHAR2(10)
 SHUTDOWN_PENDING                                   VARCHAR2(3)
 DATABASE_STATUS                                    VARCHAR2(17)
 INSTANCE_ROLE                                      VARCHAR2(18)
 ACTIVE_STATE                                       VARCHAR2(9)
 BLOCKED                                            VARCHAR2(3)
 CON_ID                                             NUMBER
 INSTANCE_MODE                                      VARCHAR2(11)
 EDITION                                            VARCHAR2(7)
 FAMILY                                             VARCHAR2(80)

SQL> select status from v$instance;

STATUS                                                                          
------------                                                                    
OPEN                                                                            

SQL> shutdown immediate
Base de donn es ferm e.
Base de donn es d mont e.
Instance ORACLE arr t e.
SQL> startup
Instance ORACLE lanc e.

Total System Global Area 1870647296 bytes                                       
Fixed Size                  2403928 bytes                                       
Variable Size             553648552 bytes                                       
Database Buffers         1308622848 bytes                                       
Redo Buffers                5971968 bytes                                       
Base de donn es mont e.
ORA-01157: impossible d'identifier ou de verrouiller le fichier de donn es 6 - 
voir le fichier de trace DBWR 
ORA-01110: fichier de donn es 6 : 'C:\APP\DRSOU\ORADATA\ORCL\USERS01.DBF' 


SQL> select status from v$instance;

STATUS                                                                          
------------                                                                    
MOUNTED                                                                         

SQL> /*
SQL> A la lecture du fichier d'alerte nous avons:
SQL> 
SQL> Sat Jan 05 10:51:59 2019
SQL> Errors in file C:\APP\DRSOU\diag\rdbms\orcl\orcl\trace\orcl_dbw0_5968.trc:
SQL> ORA-01157: cannot identify/lock data file 6 - see DBWR trace file
SQL> ORA-01110: data file 6: 'C:\APP\DRSOU\ORADATA\ORCL\USERS01.DBF'
SQL> ORA-27041: unable to open file
SQL> OSD-04002: ouverture impossible du fichier
SQL> O/S-Error: (OS 2) Le fichier sp cifi  est introuvable.
SQL> Sat Jan 05 10:51:59 2019
SQL> Errors in file C:\APP\DRSOU\diag\rdbms\orcl\orcl\trace\orcl_ora_8156.trc:
SQL> ORA-01157: impossible d'identifier ou de verrouiller le fichier de donn es 6 - voir le fichier de trace DBWR
SQL> ORA-01110: fichier de donn es 6 : 'C:\APP\DRSOU\ORADATA\ORCL\USERS01.DBF'
SQL> ORA-1157 signalled during: ALTER DATABASE OPEN...
SQL> Sat Jan 05 10:52:00 2019
SQL> Checker run found 1 new persistent data failures
SQL> */
SQL> 
SQL> 
SQL> 
SQL> shutdown immediate
ORA-01109: base de donn es non ouverte 


Base de donn es d mont e.
Instance ORACLE arr t e.
SQL> 
SQL> startup
Instance ORACLE lanc e.

Total System Global Area 1870647296 bytes                                       
Fixed Size                  2403928 bytes                                       
Variable Size             553648552 bytes                                       
Database Buffers         1308622848 bytes                                       
Redo Buffers                5971968 bytes                                       
Base de donn es mont e.
Base de donn es ouverte.
SQL> show parameter Background_dump_dest

NAME                                 TYPE        VALUE                          
------------------------------------ ----------- ------------------------------ 
background_dump_dest                 string      C:\app\drsou\diag\rdbms\orcl\o 
                                                 rcl\trace                      
SQL> spool off


voici la bonne reponse


SQL> select value
  2  from v$diag_info
  3  where name='Diag Trace';

VALUE
--------------------------------------------------------------------------------
C:\APP\ALEX\diag\rdbms\orcl\orcl\trace
