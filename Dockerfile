FROM kibana:5.5

VOLUME /usr/share/kibana/config/
COPY config/kibana.yml /usr/share/kibana/config/
COPY config/kibana-objects.json /usr/share/kibana/config/
COPY scripts/startup.sh /usr/share/kibana/scripts/
COPY scripts/load-kibana-objects.sh /usr/share/kibana/scripts/
RUN ["chmod", "+x", "/usr/share/kibana/scripts/startup.sh"]
RUN ["chmod", "+x", "/usr/share/kibana/scripts/load-kibana-objects.sh"]

RUN apt-get update && apt-get install -y curl at

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN apt-get install -y nodejs
RUN npm install elasticdump -g 

ENTRYPOINT ["usr/share/kibana/scripts/startup.sh"]
CMD ["kibana"]

