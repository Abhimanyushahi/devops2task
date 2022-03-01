FROM centos:latest

RUN yum install wget -y
RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN yum install java-11-openjdk.x86_64 -y
RUN yum install git -y
RUN yum install sudo -y
RUN yum install initscripts -y
RUN yum install jenkins -y
RUN echo -e "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo -e "baseurl=http://mirror.centos.org/centos-8/8/App ... x86_64/os/" >> /etc/yum.repos.d/CentOS-AppStream.repo
RUN echo -e "baseurl=http://mirror.centos.org/centos-8/8/BaseOS/x86_64/os/" >> /etc/yum.repos.d/CentOS-Base.repo
RUN echo -e "baseurl=http://mirror.centos.org/centos-8/8/extras/x86_64/os/" >> /etc/yum.repos.d/CentOS-Extras.repo
RUN yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
COPY docker.repo /etc/yum.repos.d/
COPY function /etc/yum.repos.d/
RUN yum install -y docker-ce --nobest
EXPOSE 8080
USER jenkins
ENV USER jenkins
CMD ["java", "-jar", "/usr/lib/jenkins/jenkins.war"]
