# knife-set-atrribute

A plugin for Chef::Knife which will change attributes values of your nodes.

## Usage 

Supply nested attributes and the values can be strings or array.

```
% knife set_attribute node_name attribute.sub_attribute 'value'

% knife set_attribute node_name attribute.sub_attribute "['\'value1\'','\'value2\'']"

% knife set_attribute node_name attribute.sub_attribute "[\"{\'key1\'=>\'value1\'}\", \"{\'key2\'=>\'value2\'}\"]" 

```

## Installation

#### Script install

Copy the knife-set-attribute script from lib/chef/knife/set_attribute.rb to your ~/.chef/plugins/knife directory.


