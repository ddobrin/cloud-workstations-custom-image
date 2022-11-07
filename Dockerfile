
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

# copy the customization file to /etc/profile.d
COPY 011_customize-user.sh /etc/profile.d/
RUN chmod +x /etc/profile.d/011_customize-user.sh

# bypass a bug in setting ebv variables for the user profile
RUN sed -i 's/user -c/user -c -l/g' /etc/workstation-startup.d/110_start-code-oss.sh

# install GraaLVM 22.3.0 with Java 17
RUN cd ~
RUN curl -OL https://get.graalvm.org/jdk
RUN bash jdk graalvm-ce-java17-22.3.0

# install missing libraries for GraalVM
RUN apt-get --assume-yes install build-essential libz-dev zlib1g-dev  

# install Dive container inspection tool
RUN wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb
RUN apt install ./dive_0.9.2_linux_amd64.deb

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