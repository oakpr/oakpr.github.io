---
title: Remote Development
layout: home
---

For club members without a capable computer at home, the club offers a remote development service. Currently, this environment is hosted on Willow's home server, but in the future it will be hosted on a club-controlled cluster.

{: .warning }
> You may only use the remote development service to compile and execute code for club projects or for legitimate educational purposes, such as classwork or language learning. You must obey all school rules when using the service. Any suspicious activities will be reported to the relevant authorities.
>
> Also, please respect the hardware running the service. Do not run unnecessarily demanding tasks or store very large data. Do not attempt to interact with a blockchain or use machine learning algorithms, as those workloads are almost always extremely demanding.

## Using the Remote Development Service

The remote development service is currently reachable at https://dev.wolo.dev, though this location will change once it is moved off of Willow's server.

1. To sign into the service, you must first have an account with [GitHub](https://github.com), and that account must be a member of the [club organization](https://github.com/oakpr). To become a member of the organization, ask one of the administrators on Discord to add you.

2. Visit [the service](https://dev.wolo.dev) using your web browser and choose the "GitHub" option on the login screen, then allow it to identify you via your GitHub account. This step will fail if you are not a member of the club organization.

3. If you wish to modify GitHub repositories from inside the remote development environment, follow these steps. Only do this if you trust the service, as it could theoretically allow an attacker to push to your repositories if they gained access to the server's private key.
   1. Visit https://dev.wolo.dev/settings/ssh-keys and copy the key there.
   2. Visit https://github.com/settings/ssh/new and paste the key into the "Key" field.
   3. Give the key a memorable name, like "OPC Server"
   4. Select "Add SSH Key" to finish.

4. Visit https://dev.wolo.dev/templates and select the template that's relevant to your project.

5. Choose "Create Workspace" and give it a memorable name, then submit the form. Wait for a few moments while the workspace is created.

6. Once the workspace is running, select "code-server" to open a version of Visual Studio Code modified to work for remote development.

## Limitations of the remote development containers

* Running containers inside containers is not possible for security reasons.
* Containers are limited to 2GB of memory each.
* Containers may be deleted if storage is low.
* Containers share CPU time with other processes on the server, so their performance may be degraded during periods of high demand.
* Any modifications to the container's root filesystem (package installations, configuration changes, etc.) will be discarded when the container updates.

## Non-limitations of the remote development containers

* [SSH Access](https://coder.com/docs/coder/v1.20/workspaces/ssh) and [X11 Forwarding](https://www.tomshardware.com/how-to/forward-x-session-ssh) can be combined to run graphical applications.
* You have access to `sudo` and can install packages from the Rocky Linux 9 repositories with `dnf`
* You can use [Kaniko](https://docs.gitlab.com/ee/ci/docker/using_kaniko.html) to build container images without the ability to actually run containers.
* You can ask the administrators to create a new template if you need to persist customizations across updates.
* The container user's home folder will persist across updates, unless it is especially large in which case an administrator may choose to erase it.