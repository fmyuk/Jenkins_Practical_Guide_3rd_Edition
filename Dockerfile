# Jenkins の公式イメージをベースとする
FROM jenkins/jenkins:lts

# ユーザーを root に切り替える
USER root

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y wget

RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java

# JAVA_HOME 環境変数の設定
ENV JAVA_HOME /opt/jdk8u292-b10
ENV PATH $JAVA_HOME/bin:$PATH

# Maven 3.5.0 のインストール
RUN wget http://archive.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz \
    && tar -xvzf apache-maven-3.5.0-bin.tar.gz -C /opt \
    && rm apache-maven-3.5.0-bin.tar.gz

# MAVEN_HOME 環境変数の設定
ENV MAVEN_HOME /opt/apache-maven-3.5.0
ENV PATH $MAVEN_HOME/bin:$PATH

# ユーザーを jenkins に戻す
USER jenkins