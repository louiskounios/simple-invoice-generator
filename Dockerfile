FROM ubuntu:18.04

COPY install-deps.sh /install-deps.sh
RUN chmod a+x /install-deps.sh && /install-deps.sh

COPY install-fonts.sh /install-fonts.sh
RUN chmod a+x /install-fonts.sh && /install-fonts.sh

WORKDIR /simple-invoice
COPY template.tex /simple-invoice/template.tex
COPY data.yml.example /simple-invoice/data.yml.example

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
