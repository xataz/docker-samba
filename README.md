![# Samba](http://wiki.univention.de/images/6/6d/Logo_Samba.png)

> This image is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
> If you don't trust, you can build yourself.

## Tag available
* latest [(Dockerfile)](https://github.com/xataz/dockerfiles/blob/master/samba/Dockerfile)

## Description
What is [Samba](https://www.samba.org/) ?

Samba is the standard Windows interoperability suite of programs for Linux and Unix.  
Samba is Free Software licensed under the GNU General Public License, the Samba project is a member of the Software Freedom Conservancy.  
Since 1992, Samba has provided secure, stable and fast file and print services for all clients using the SMB/CIFS protocol, such as all versions of DOS and Windows, OS/2, Linux and many others.  
Samba is an important component to seamlessly integrate Linux/Unix Servers and Desktops into Active Directory environments. It can function both as a domain controller or as a regular domain member  

## BUILD IMAGE

```shell
docker build -t xataz/samba github.com/xataz/dockerfiles.git#master:samba
```

## Configuration
### Configuration file
#### users.conf
users.conf is a configuration file for list your users and them password :
```shell
#USER:PASSWORD:UID:GID
xataz:xatazpasswd:2000:2000
user1:user1passwd:2001:2001
etc ...
```

You can use environment variable CRYPT, for use users.conf with encrypt password :
```shell
xataz:FAC84832FFCB741F13C5758E1319F46A:2000:2000
user1:F5C8257B666CB899CC34AA3FF3771316:2001:2001
```
for encrypt your password on samba's format, use this command :
```shell
printf '%s' "<passwd>" | iconv -t utf16le | openssl md4 | awk '{print $2}' | tr '[:lower:]' '[:upper:]'
```
exemple with user1passwd :
```shell
$ printf '%s' "user1passwd" | iconv -t utf16le | openssl md4 | awk '{print $2}' | tr '[:lower:]' '[:upper:]'
F5C8257B666CB899CC34AA3FF3771316
```

Mount this files on /config/users.conf, with `-v /path/of/file/users.conf:/config/users.conf`

#### shares.conf
shares.conf is a configuration file for list your shares and them permission :
```shell
SHARE_PATH:SHARE_NAME:USER_WRITE:USER_READ
/storage/share1:Shared:xataz,user2:user1
/storage/share2:Volume:user1:user2,xataz
```

Use "," for separate user, without space.

Mount this files on /config/shares.conf, with `-v /path/of/file/shares.conf:/config/shares.conf`

### Environments
* CRYPT : Use encrypt password in users.conf

### Volumes
* /config/users.conf : users configuration file
* /config/shares.conf : shares configuration file

### Ports
* 137
* 138
* 139
* 445

## Usage
My configuration files (users.conf and shares.conf) are in /docker/config/samba.
```shell
docker run -d -p 137:137 \
              -p 138:138 \
              -p 139:139 \
              -p 445:445 \
	-v /docker/config/samba:/config \ 
    -v /docker/storage:/storage \
	xataz/samba
```

On linux, you can mount share with :
```shell
mount -t cifs -o username=user1,password=user1passwd //172.1.0.2/Shared /mnt
```

On Windows, you can mount share with :
```shell
net use Z: \\computer_name\Shared /PERSISTENT:YES
To disconnect a mapped drive:
net use  Z: /delete
```

## Contributing
Any contributions, are very welcome !
