FROM debian:8

RUN apt-get update && \
    apt-get install --no-install-recommends --yes libdbi-perl libdbd-mysql-perl spamassassin && \
    apt-get autoclean && apt-get --yes autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY [ "entrypoint.sh", "/" ]

EXPOSE 783

ENTRYPOINT [ "/entrypoint.sh" ]
