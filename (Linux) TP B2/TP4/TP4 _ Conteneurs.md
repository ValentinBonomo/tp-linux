# TP4 : Conteneurs

# I. Docker

## 1. Install

```bash
[ersjyhag@localhost ~]$ sudo yum remove docker docker-client docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine                                                                                                 No match for argument: docker
No match for argument: docker-client
No match for argument: docker-common
No match for argument: docker-latest
No match for argument: docker-latest-logrotate
No match for argument: docker-logrotate
No match for argument: docker-engine
No packages marked for removal.
Dependencies resolved.
Nothing to do.
Complete!
[ersjyhag@localhost ~]$ sudo yum install -yq yum-utils
[sudo] password for ersjyhag:

Installed:
  yum-utils-4.0.24-4.el9_0.noarch
[ersjyhag@localhost ~]$ sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
Adding repo from: https://download.docker.com/linux/centos/docker-ce.repo
[ersjyhag@localhost ~]$ sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin

Installed:
  checkpolicy-3.3-1.el9.x86_64                             container-selinux-3:2.188.0-1.el9_0.noarch
  containerd.io-1.6.10-3.1.el9.x86_64                      docker-ce-3:20.10.21-3.el9.x86_64
  docker-ce-cli-1:20.10.21-3.el9.x86_64                    docker-ce-rootless-extras-20.10.21-3.el9.x86_64
  docker-compose-plugin-2.12.2-3.el9.x86_64                docker-scan-plugin-0.21.0-3.el9.x86_64
  fuse-common-3.10.2-5.el9.0.1.x86_64                      fuse-overlayfs-1.9-1.el9_0.x86_64
  fuse3-3.10.2-5.el9.0.1.x86_64                            fuse3-libs-3.10.2-5.el9.0.1.x86_64
  libslirp-4.4.0-7.el9.x86_64                              policycoreutils-python-utils-3.3-6.el9_0.noarch
  python3-audit-3.0.7-101.el9_0.2.x86_64                   python3-libsemanage-3.3-2.el9.x86_64
  python3-policycoreutils-3.3-6.el9_0.noarch               python3-setools-4.4.0-4.el9.x86_64
  python3-setuptools-53.0.0-10.el9.noarch                  slirp4netns-1.2.0-2.el9_0.x86_64
  tar-2:1.34-3.el9.x86_64

Complete!
[ersjyhag@localhost ~]$ yum list docker-ce --showduplicates | sort -r
Rocky Linux 9 - Extras                           22 kB/s | 6.6 kB     00:00
Rocky Linux 9 - BaseOS                          3.6 MB/s | 1.7 MB     00:00
Rocky Linux 9 - AppStream                       9.0 MB/s | 6.0 MB     00:00
Installed Packages
docker-ce.x86_64               3:20.10.21-3.el9                docker-ce-stable
docker-ce.x86_64               3:20.10.21-3.el9                @docker-ce-stable
docker-ce.x86_64               3:20.10.20-3.el9                docker-ce-stable
docker-ce.x86_64               3:20.10.19-3.el9                docker-ce-stable
docker-ce.x86_64               3:20.10.18-3.el9                docker-ce-stable
docker-ce.x86_64               3:20.10.17-3.el9                docker-ce-stable
docker-ce.x86_64               3:20.10.16-3.el9                docker-ce-stable
docker-ce.x86_64               3:20.10.15-3.el9                docker-ce-stable
Docker CE Stable - x86_64                        42 kB/s |  12 kB     00:00
Available Packages
[ersjyhag@localhost ~]$ sudo yum install -yq docker-ce-20.10.21 docker-ce-cli-20.10.21 containerd.io docker-compose-plugin
Nothing to do.
Complete!
[ersjyhag@localhost ~]$ sudo systemctl start docker
[ersjyhag@localhost ~]$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete
Digest: sha256:faa03e786c97f07ef34423fccceeec2398ec8a5759259f94d99078f264e9d7af
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
[ersjyhag@localhost ~]$ sudo usermod -aG docker $(whoami)
[ersjyhag@localhost ~]$ sudo reboot
```

## 2. Vérifier l'install

```bash
[ersjyhag@localhost ~]$ docker info
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  app: Docker App (Docker Inc., v0.9.1-beta3)
  buildx: Docker Buildx (Docker Inc., v0.9.1-docker)
  compose: Docker Compose (Docker Inc., v2.12.2)
  scan: Docker Scan (Docker Inc., v0.21.0)

Server:
 Containers: 1
  Running: 0
  Paused: 0
  Stopped: 1
 Images: 1
 Server Version: 20.10.21
 Storage Driver: overlay2
  Backing Filesystem: xfs
  Supports d_type: true
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: systemd
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 io.containerd.runtime.v1.linux runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 770bd0108c32f3fb5c73ae1264f7e503fe7b2661
 runc version: v1.1.4-0-g5fd4c4d
 init version: de40ad0
 Security Options:
  seccomp
   Profile: default
  cgroupns
 Kernel Version: 5.14.0-70.26.1.el9_0.x86_64
 Operating System: Rocky Linux 9.0 (Blue Onyx)
 OSType: linux
 Architecture: x86_64
 CPUs: 1
 Total Memory: 960.6MiB
 Name: localhost.localdomain
 ID: KGCU:2XWZ:HJKD:DMN2:MPYW:SXYG:KFFJ:RNMG:QOS7:AUCN:GTWI:REZW
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false

[ersjyhag@localhost ~]$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
[ersjyhag@localhost ~]$ docker ps -a
CONTAINER ID   IMAGE         COMMAND    CREATED         STATUS                     PORTS     NAMES
6ba9fa3cbd5a   hello-world   "/hello"   9 minutes ago   Exited (0) 8 minutes ago             wonderful_wilbur
[ersjyhag@localhost ~]$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
hello-world   latest    feb5d9fea6a5   14 months ago   13.3kB
[ersjyhag@localhost ~]$ docker run debian
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
a8ca11554fce: Pull complete
Digest: sha256:3066ef83131c678999ce82e8473e8d017345a30f5573ad3e44f62e5c9c46442b
Status: Downloaded newer image for debian:latest
[ersjyhag@localhost ~]$ docker run -d debian sleep 99999
330e5ceda77d9ced9e25f43b404a0cf90a2b6ca1fc7e7911ebcdb28c1120330e
[ersjyhag@localhost ~]$ docker run -it debian bash
root@fec8d50e3348:/# ^C
root@fec8d50e3348:/# exit
exit
[ersjyhag@localhost ~]$ docker ps
CONTAINER ID   IMAGE     COMMAND         CREATED          STATUS          PORTS     NAMES
330e5ceda77d   debian    "sleep 99999"   33 seconds ago   Up 33 seconds             quizzical_cerf
[ersjyhag@localhost ~]$ docker logs 330e5ceda77d
[ersjyhag@localhost ~]$ docker logs -f 330e5ceda77d
^C
[ersjyhag@localhost ~]$ docker exec 330e5ceda77d ls
bin
boot
dev
etc
home
lib
lib64
media
mnt
opt
proc
root
run
sbin
srv
sys
tmp
usr
var
[ersjyhag@localhost ~]$ docker exec -it 330e5ceda77d bash
root@330e5ceda77d:/#
```

## 3. Lancement de conteneurs

```bash
[ersjyhag@localhost ~]$ mkdir conf
[ersjyhag@localhost ~]$ sudo nano conf/nginx.conf
[ersjyhag@localhost ~]$ cat conf/nginx.conf | grep listen
    listen       89;
    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
[ersjyhag@localhost ~]$ mkdir jesaispas
[ersjyhag@localhost ~]$ sudo nano jesaispas/index.html
[ersjyhag@localhost ~]$ cat jesaispas/index.html
<!doctype html>
<html>
<body>
<h1>La page web utilise un fichier personalise</h1>
</body>
</html>
[ersjyhag@localhost ~]$ docker run --rm -d -m 16MB --name test -v ~/conf:/etc/nginx/conf.d/ -v ~/jesaispas:/usr/share/ng
inx/html -p 8080:89 nginx
ec9ab766c496d3e1dc9cf1116f60104437f5b1ea8b3d9393cd4bd3a8adb645cd
```

Vérif : 

```bash
[ersjyhag@localhost ~]$ curl localhost:8080
<!doctype html>
<html>
<body>
<h1>La page web utilise un fichier personalise</h1>
</body>
</html>
PS C:\Users\Utilisateur> curl 10.104.1.11:8080
<!doctype html>
<html>
<body>
<h1>La page web utilise un fichier personalise</h1>
</body>
</html>
```

# II. Images

## 2. Construisez votre propre Dockerfile

🌞 **Construire votre propre image**

📁 [**`Dockerfile`**](https://github.com/ValentinBonomo/tp-linux/blob/main/(Linux)%20TP%20B2/TP4/Dockerfile/Dockerfile)

# III. `docker-compose`

## 2. Make your own meow

🌞 **Conteneurisez votre application**