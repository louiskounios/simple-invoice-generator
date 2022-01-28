FROM ubuntu:20.04

COPY install-deps.sh /install-deps.sh
RUN chmod a+x /install-deps.sh && /install-deps.sh

COPY install-fonts.sh /install-fonts.sh
RUN chmod a+x /install-fonts.sh && /install-fonts.sh

WORKDIR /simple-invoice
COPY template.tex /simple-invoice/template.tex
COPY data.example.yml /simple-invoice/data.example.yml

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
