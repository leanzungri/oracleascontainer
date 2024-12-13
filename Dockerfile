FROM container-registry.oracle.com/database/enterprise_ru:19.21.0.0 as base

ENV DATAPUMPDIR=/opt/oracle/datapump

COPY --chown=oracle:oinstall --chmod=644 imp.sh /opt/oracle/scripts/setup

RUN <<EOF
mkdir -p ${DATAPUMPDIR}
chown oracle:dba ${DATAPUMPDIR}
EOF

USER root
RUN <<EOF
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
EOF

#Esta línea seria reemplazada por RUN aws s3 cp
#COPY --chown=oracle:oinstall --chmod=644 IT.dmp ${DATAPUMPDIR}

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

RUN <<EOF
cd ${DATAPUMPDIR}
aws s3 cp s3://ocidatapump/IT.dmp  .
chown oracle:oinstall IT.dmp
EOF
