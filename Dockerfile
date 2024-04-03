FROM fedora:40
RUN dnf -y install procps-ng nano
RUN dnf -y install httpd; systemctl enable httpd
RUN dnf -y install passwd sudo
RUN mkdir install
WORKDIR install
COPY create_user.sh .
RUN chmod a+x create_user.sh
RUN /bin/bash -c './create_user.sh'
WORKDIR /
RUN dnf -y remove httpd; dnf clean all
RUN rm -r install
CMD [ "/sbin/init" ]
