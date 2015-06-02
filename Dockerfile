FROM phusion/baseimage:0.9.16

RUN apt-get update

RUN curl -L https://www.opscode.com/chef/install.sh | bash -s -- -v 11.16.4

ADD node.json /tmp/
ADD cookbooks.tar.gz /tmp

RUN cd /tmp && echo "cookbook_path '/tmp/cookbooks'" > /tmp/solo.rb && chef-solo -j /tmp/node.json  -c /tmp/solo.rb
