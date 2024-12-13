FROM container-registry.oracle.com/database/enterprise_ru:19.21.0.0 AS base


COPY --chown=oracle:oinstall --chmod=644 imp.sh /opt/oracle/scripts/setup

ENV DATAPUMPDIR=/opt/oracle/datapump

RUN <<EOF
mkdir -p ${DATAPUMPDIR}
chown oracle:dba ${DATAPUMPDIR}
EOF

COPY --chown=oracle:oinstall --chmod=644 IT.dmp ${DATAPUMPDIR}
