FROM container-registry.oracle.com/database/enterprise_ru:19.21.0.0 AS base

#Set Asuncion TZ
USER root
ENV TZ=America/Asuncion
RUN <<EOF
cd /etc
ln -fs /usr/share/zoneinfo/${TZ} localtime
echo ${TZ} > /etc/timezone
EOF

USER oracle
# Set Database import
COPY --chown=oracle:oinstall --chmod=644 imp.sh /opt/oracle/scripts/setup
ENV DATAPUMPDIR=/opt/oracle/datapump
RUN <<EOF
mkdir -p ${DATAPUMPDIR}
chown oracle:dba ${DATAPUMPDIR}
EOF
COPY --chown=oracle:oinstall --chmod=644 IT.dmp ${DATAPUMPDIR}
