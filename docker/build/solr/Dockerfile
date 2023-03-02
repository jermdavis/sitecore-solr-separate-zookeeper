# escape=`

ARG PARENT_IMAGE
FROM ${PARENT_IMAGE}

RUN powershell "Invoke-WebRequest https://dlcdn.apache.org/zookeeper/zookeeper-3.7.1/apache-zookeeper-3.7.1-bin.tar.gz -OutFile c:\zk.tar.gz; `
			   New-Item -Type Directory c:\apache-zookeeper-3.7.1-bin | out-null; `
			   tar -xzf c:\zk.tar.gz; `
			   Remove-Item c:\zk.tar.gz; `
			   Rename-Item apache-zookeeper-3.7.1-bin zk; `
			   Remove-Item c:\zk\docs\ -Recurse -Force; `
			   New-Item -Type Directory c:\data\zoo_data | out-null"

COPY zoo.cfg c:\zk\conf\
COPY log4j.properties c:\zk\conf\

COPY Start.ps1 c:\Start.ps1