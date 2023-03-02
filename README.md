# Sitecore developer Solr image with separate zookeeper

On some computers, I've found that Sitecore's standard developer image for Solr does not start reliably.
I <a href="https://blog.jermdavis.dev/posts/2022/docker-zookeeper-solr-fail">wrote about the behaviour of the
issue and some early attempts to fix it</a> on my blog a while back.

This repository holds an example for how to modify the standard Sitecore image to use a separate instance of
ZooKeeper instead of the internal one that SolrCloud can use. This seems to resolve the startup issues for me.
I've <a href="">written up this work on my blog too</a>.