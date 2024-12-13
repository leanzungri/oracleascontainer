#!/bin/bash

# No se puede crear en el Dockerfile ya que el instalador lo borra
#mkdir -p /opt/oracle/oradata/expdp
#chown oracle:oinstall /opt/oracle/datapump

sqlplus /nolog <<EOF
connect system/${ORACLE_PWD}@${ORACLE_PDB}
create directory DP as '${DATAPUMPDIR}'
/
EOF

impdp system/${ORACLE_PWD}@${ORACLE_PDB} directory=DP dumpfile=IT.dmp
