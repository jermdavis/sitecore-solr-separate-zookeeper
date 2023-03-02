# Sitecore developer Solr image with separate zookeeper

On some computers, I've found that Sitecore's standard developer image for Solr does not start reliably.
I <a href="https://blog.jermdavis.dev/posts/2022/docker-zookeeper-solr-fail">wrote about the behaviour of the
issue and some early attempts to fix it</a> on my blog a while back.

This repository holds an example for how to modify the standard Sitecore image to use a separate instance of
ZooKeeper instead of the internal one that SolrCloud can use. This seems to resolve the startup issues for me.
I've <a href="https://blog.jermdavis.dev/posts/2023/workaround-solr-docker-issue">written up this work on my blog too</a>
if you want to understand what the assorted changes do.

## Usage

For simplicity, I've added some shortcut scripts. Once you've cloned the repository, you can:

1) Run `build.ps1` to get Docker to build the custom image
2) Run `up.ps1` to start SolrCloud and run Sitecore's `solr-init` job image
3) Run `down.ps1` to stop the containers

This was worked out as an extension to Sitecore's v10.2 docker config, but by changing the base image versions 
for Sitecore, Solr and Solr-Init in the compose and environment files, it should work with most recent versions.
v10.3's OTB docker compose files seem to run fine with it. But I've not tested others (or other customisations
to docker config) myself.

Questions or comments? I'm <a href="https://mastodon.social/@jermdavis">on Mastodon</a> and also @jermdavis on Sitecore Slack.