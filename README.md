# knife-set-atrribute

A plugin for Chef::Knife which will change attributes values of your nodes.

## Usage 

Supply nested attributes and the values can be strings or array.

```
% knife set_attribute node_name attribute.sub_attribute 'value'

% knife set_attribute node_name attribute.sub_attribute "['\'value1\'','\'value2\'']"

% knife set_attribute node_name attribute.sub_attribute "[\"{\'key1\'=>\'value1\'}\", \"{\'key2\'=>\'value2\'}\"]" 

```
Use custom separator for keys containing dots.

```
% knife set_attribute node_name attribute/sub_attribute/v1.0 'value' --separator /
```

Use regular expression to match a list of nodes.

```
% knife set_attribute nodePrefix.* attrubute.sub_attribute value
```

## Installation

#### Script install


Copy the knife-set-attribute script from set_attribute.rb to your ~/.chef/plugins/knife directory.

```
$ git clone git@github.com:amian84/knife-set-attribute.git
$ mkdir -p ~/.chef/plugins/knife/
$ cp knife-set-attribute/set_attribute.rb ~/.chef/plugins/knife/

```
