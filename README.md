# Chef

## Chef Components
- chef server
	The Chef server acts as a hub for configuration data. The Chef server stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the chef-client.
	Nodes use the chef-client to ask the Chef server for configuration details, such as recipes, templates, and file distributions.
- chef client

## Terminologys used in chef 
- Node
- Resource
	A resource is a statement of configuration policy that describes the desired state of an piece within your infrastructure, along with the steps needed to bring that item to the desired state.
- chef-apply
	A command-line tool that allows a single recipe to be run from the command line.
- recipe
	A recipe is a collection of resources that tells the chef-client how to configure a node.
- knife
	A command-line tool that provides an interface between a local chef-repo and the Chef server.
- chef-repo
	The repository structure in which cookbooks are authored, tested, and maintained.
- Cookbook
	A cookbook is the fundamental unit of configuration and policy distribution.
- run-list
	A run-list defines all of the configuration settings that are necessary for a node that is under management by Chef to be put into the desired state and the order in which these configuration settings are applied.
- role
	A role is a way to define certain patterns and processes that exist across nodes in an organization as belonging to a single job function.