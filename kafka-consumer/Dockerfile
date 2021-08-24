FROM centos/python-36-centos7:latest
USER 0

ENV INPUT_TOPIC=${INPUT_TOPIC:-'data-input'}
ENV OUTPUT_TOPIC=${OUTPUT_TOPIC:-'data-output'}
ENV FILE_ORIG=${FILE_ORIG:-'file-orig'}
ENV FILE_SORTED=${FILE_SORTED:-'file-sorted'}
ENV BOOTSTRAP_SERVERS=${BOOTSTRAP_SERVERS:-'kafka1:19093,kafka2:29093'}
ENV CONSUMER_GROUP=${CONSUMER_GROUP:-'grp1'}
ENV TIMEOUT_MS=${TIMEOUT_MS:-'6000'}

RUN echo "Download Confluent Platform" && \
    curl "https://packages.confluent.io/archive/6.2/confluent-community-6.2.0.zip?_ga=2.111392396.987750251.1629662619-1020995206.1625671716&_gac=1.17049547.1629662620.CjwKCAjw64eJBhAGEiwABr9o2LUrhcqeZUGFHoLU_9k0VBMhQD4z68fepxRzqTQyud5cPKe4C5MKkxoCEbAQAvD_BwE" -o "/usr/bin/confluent.zip" && \
    unzip /usr/bin/confluent.zip -d /usr/bin/confluent
RUN echo "Install Java-11" && \
    yum install -y java-11
ENV PATH="/usr/bin/confluent/confluent-6.2.0/bin:${PATH}"
ENV KAFKA_HEAP_OPTS="-Xmx1g"

COPY /include /
RUN echo "Setting up necessary permissions" && \
    chmod +x /scripts/*
CMD ["/scripts/kafkaCLI.sh"]