FROM jenkins/jenkins:2.303.3-jdk11

# 설치 위자드 비활성화
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
# JCasC가 읽을 설정 파일 위치 지정하는 환경 변수
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

# Jenkins Docker image에 Docker 설치
USER root
RUN curl -sSL https://get.docker.com/ | sh
RUN usermod -a -G docker jenkins
USER jenkins

# plugins.txt에 설치하고자 하는 플러그를 명시하고 install-plugins.sh을 통해 설치
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# 앞에 작성한 설정 파일 casc.yaml 복사
COPY casc.yaml /var/jenkins_home/casc.yaml

# 젠킨스 기본 시드잡 설정 파일 복사
COPY defaultJob.xml /usr/share/jenkins/ref/jobs/default-job/config.xml