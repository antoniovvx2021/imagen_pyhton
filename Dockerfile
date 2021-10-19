FROM ubuntu
RUN apt-get update
RUN apt-get install -y python && apt-get install -y net-tools && apt-get install -y iputils-ping && apt-get install -y git && apt-get install -y nano

##WORKDIR##
RUN mkdir /datos1
WORKDIR /datos1
RUN touch f1.txt
RUN mkdir /datos2
WORKDIR /datos2
RUN touch f2.txt

##COPY##
COPY index.html .
COPY app.log /datos1

##ADD##
ADD docs docs
ADD f* /datos1/
ADD f.tar .

##ENV##
ENV dir1=/data1 dir2=/data2
RUN mkdir $dir1 && mkdir $dir2
ENV TZ="Europe/Madrid"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

##ARG##
#ARG dir3
#RUN mkdir $dir3
#ARG user
#ENV user_docker $user
#ADD add_user.sh /datos2
#RUN /datos2/add_user.sh

##EXPOSE##
RUN apt-get install -y apache2
EXPOSE 80
ADD entrypoint.sh /datos2

##VOLUME##
ADD paginas /var/www/html
VOLUME ["/var/www/html"]

##CMD##
CMD /datos2/entrypoint.sh


##ENTRYPOINT##
#ENTRYPOINT ["/bin/bash"]


