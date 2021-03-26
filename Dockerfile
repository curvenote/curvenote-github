FROM python:3.9

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh
RUN pip install curvenote

ENTRYPOINT [ "/entrypoint.sh" ]
