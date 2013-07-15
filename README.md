# knife-set-atrribute

A plugin for Chef::Knife which will change attributes values of your nodes or roles.

## Usage 

Supply nested attributes and the values can be strings or array.
```
% knife set_attribute node|role <node_name|role> <attribute.sub_attribute> 'value'

% knife set_attribute node|role <node_name|role> <attribute.sub_attribute> "['\'value1\'','\'value2\'']"

% knife set_attribute node|role <node_name|role> <attribute.sub_attribute> "[\"{\'key1\'=>\'value1\'}\", \"{\'key2\'=>\'value2\'}\"]" 

```

## Installation

#### Script install


Copy the knife-set-attribute script from set_attribute.rb to your ~/.chef/plugins/knife directory.

```
$ git clone git@github.com:amian84/knife-set-attribute.git
$ mkdir -p ~/.chef/plugins/knife/
$ cp knife-set-attribute/set_attribute.rb ~/.chef/plugins/knife/

```
