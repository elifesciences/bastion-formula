# `bastion` formula

This repository contains instructions for installing and configuring the `bastion` project.

This repository should be structured as any Saltstack formula should, but it 
should also conform to the structure required by the [builder](https://github.com/elifesciences/builder) 
project.

[MIT licensed](LICENCE.txt)

## Usage

[Run `ssh-agent`](https://github.com/elifesciences/builder/blob/master/docs/ssh-agent.md) on your machine.

Connect to the `bastion` server:

```
$ ssh -A elife@bastion.elifesciences.org
```

The `-A` flag allows forwarding your private key there to let you authenticate with other servers inside the VPC.

From the `bastion` server, you can use internal DNS to reach single servers even if they are normally hidden behind a load balancer:

```
$ ssh elife@prod--search--1.elife.internal
$ ssh elife@prod--search--2.elife.internal
```

## Available hostnames

Projects that use a single server always have a `{env}--{subdomain}.elife.internal` DNS entry e.g. `prod--alfred.elife.internal`.

Projects that use multiple servers behind a load balancer must opt in to internal DNS using the `ec2.dns-internal` configuration. This will result in them having DNS of the form `{env}--{subdomain}--{node}.elife.internal` e.g. `prod--search--1.elife.internal`.

## Permanent setup

You can SSH into servers in a single command without having to go to the bastion:

```
ssh prod--journal--1
```

To SSH into servers in a single command, add this to your `~/.ssh/config` file:
```
Host bastion
    Hostname bastion.elifesciences.org
    User elife
    ForwardAgent yes
    
Host *--*--*
  IdentityFile ~/.ssh/elife
  User elife
  ProxyCommand ssh bastion nc %h.elife.internal %p
```
