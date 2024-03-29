
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

# copy the customization file to /etc/profile.d
COPY 011_customize-user.sh /etc/profile.d/
RUN chmod +x /etc/profile.d/011_customize-user.sh

# bypass a bug in setting ebv variables for the user profile
RUN sed -i 's/user -c/user -c -l/g' /etc/workstation-startup.d/110_start-code-oss.sh

# install GraaLVM Oracle for Java 17
WORKDIR /opt
RUN pwd

RUN ls -lart .
RUN wget https://download.oracle.com/graalvm/17/latest/graalvm-jdk-17_linux-x64_bin.tar.gz 
RUN tar -xzf graalvm-jdk-17_linux-x64_bin.tar.gz

RUN ls -lart

RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.3/binaries/apache-maven-3.9.3-bin.tar.gz
RUN ls -lart
RUN tar xzf apache-maven-3.9.3-bin.tar.gz
RUN ls -lart

# install missing libraries for GraalVM
RUN apt-get --assume-yes install build-essential libz-dev zlib1g-dev  

# install Dive container inspection tool
RUN wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb
RUN apt install ./dive_0.9.2_linux_amd64.deb

RUN apt install zip
# RUN cd ~
RUN ls -lart .
RUN curl -s "https://get.sdkman.io" | bash
RUN export SDKMAN_DIR=.sdkman/

RUN apt install jq

RUN ls -lart .

# install Java extensions for VS Code (Code OSS)
RUN wget https://open-vsx.org/api/vscjava/vscode-java-debug/0.40.1/file/vscjava.vscode-java-debug-0.40.1.vsix && \
unzip vscjava.vscode-java-debug-0.40.1.vsix "extension/*" &&\
mv extension /opt/code-oss/extensions/java-debug

RUN wget https://open-vsx.org/api/vscjava/vscode-java-dependency/0.19.1/file/vscjava.vscode-java-dependency-0.19.1.vsix && \
unzip vscjava.vscode-java-dependency-0.19.1.vsix "extension/*" &&\
mv extension /opt/code-oss/extensions/java-dependency

RUN wget https://open-vsx.org/api/redhat/java/1.6.0/file/redhat.java-1.6.0.vsix && \
unzip redhat.java-1.6.0.vsix "extension/*" &&\
mv extension /opt/code-oss/extensions/redhat-java

RUN wget https://open-vsx.org/api/vscjava/vscode-maven/0.35.2/file/vscjava.vscode-maven-0.35.2.vsix && \
unzip vscjava.vscode-maven-0.35.2.vsix "extension/*" &&\
mv extension /opt/code-oss/extensions/java-maven

RUN wget https://open-vsx.org/api/vscjava/vscode-java-test/0.35.0/file/vscjava.vscode-java-test-0.35.0.vsix && \
unzip vscjava.vscode-java-test-0.35.0.vsix "extension/*" &&\
mv extension /opt/code-oss/extensions/java-test

RUN pwd
RUN ls -lart .