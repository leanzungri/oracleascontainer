FROM container-registry.oracle.com/database/enterprise_ru:19.21.0.0 as base

ENV DATAPUMPDIR=/opt/oracle/datapump

COPY --chown=oracle:oinstall --chmod=644 imp.sh /opt/oracle/scripts/setup

RUN <<EOF
mkdir -p ${DATAPUMPDIR}
chown oracle:dba ${DATAPUMPDIR}
EOF

#Esta línea seria reemplazada por RUN aws s3 cp
COPY --chown=oracle:oinstall --chmod=644 IT.dmp ${DATAPUMPDIR}
