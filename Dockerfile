FROM python:3.9

COPY requirements.txt setup.py entrypoint.sh README.rst /
COPY curvenote /curvenote

RUN chmod +x /entrypoint.sh
RUN pip install -r requirements.txt

ENTRYPOINT [ "/entrypoint.sh" ]
