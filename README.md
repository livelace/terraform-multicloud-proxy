## Description:

This project is a set of tools that allow to deploy virtual machines with various proxy applications 
([Dante](https://www.inet.no/dante/), [Tinyproxy](https://github.com/tinyproxy/tinyproxy), [Tor](https://www.torproject.org/)) in such clouds as [Amazon](https://aws.amazon.com/), [Google](https://cloud.google.com/), [Yandex](https://cloud.yandex.com/). It can be handy when you have to check your apps from different parts of the world. This set shouldn't be considered as a "production tool", but rather as a "development tool". This set can be easily adapted for any task, when you need something up and running in clouds.

**In-use:**

[alpine linux](https://alpinelinux.org/), [ansible](https://www.ansible.com/), [apache](https://httpd.apache.org/), [awscli](https://github.com/aws/aws-cli), [dante](https://www.inet.no/dante/), [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html), [terraform](https://www.terraform.io/), [tinyproxy](https://github.com/tinyproxy/tinyproxy), [packer](https://packer.io/), [postgres](https://www.postgresql.org/), [powerdns](https://www.powerdns.com/), [poweradmin](https://www.poweradmin.org/), [supervisord](http://supervisord.org/), [qemu-kvm](https://www.qemu.org/), [ubuntu](https://ubuntu.com/).

The project consists of two docker images:

1. *livelace/terraform-multicloud-proxy-bootstrap* - primary tool for creation, deployment and destroying clouds infrastructures.
2. *livelace/terraform-multicloud-proxy-dns* - optional tool for registering deployed virtual machines in DNS. 

Typical workflow:

1. Create configuration.
2. Build virtual machines images.
3. Deploy cloud infrastructure.
4. Destroy cloud infrastructure.

## Requirements:

1. Linux host with Docker (you can use already built images or you could build them yourself). 
2. CPU with AMD-v/VT-x (virtualization is needed for image building, it's too slow to do that without).
3. Cloud credentials with appropriate permissions.

## Usage:


**Get help information:**

```bash
docker run -ti --rm -e UID=$UID \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/data:/data \
    livelace/terraform-multicloud-proxy-bootstrap help
```

Some commands can be run with a specific cloud as an argument.

**Initialize sample configuration:**

```bash
docker run -ti --rm -e UID=$UID \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/data:/data \
    livelace/terraform-multicloud-proxy-bootstrap init
```

This will generate and place into "/conf" directory:

1. Sample configuration (inventory-sample.ini with comments).
2. SSH keys (random generated).
3. Password for root (random generated).

**Generate configurations:**

```bash
docker run -ti --rm -e UID=$UID \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/data:/data \
    livelace/terraform-multicloud-proxy-bootstrap genconf
```

This will produce different configurations for above mentioned apps and place all those stuff into "/data" directory.  
Repeat this command if you change something in the configuration file.

**Build virtual machines images:**

```bash
docker run -ti --rm -e UID=$UID \
    --privileged \
    -v /dev/kvm:/dev/kvm \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/data:/data \
    livelace/terraform-multicloud-proxy-bootstrap build
```

This will produce virtual machines images with individual settings for every cloud provider and place those images into "/data/packer/images".  
Don't forget to rebuild images if you change some settings in the configuration file (SSH keys, port numbers, white lists etc.). 

**Deploy clouds infrastructures:**

```bash
docker run -ti --rm -e UID=$UID \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/data:/data \
    terraform-multicloud-proxy-bootstrap deploy
```

This will take some time for deploying virtual machines inside clouds. If something goes wrong - just "destroy" infrastructure, fix the problems and try again. 

**Destroy clouds infrastructures:**

```bash
docker run -ti --rm -e UID=$UID \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/data:/data \
    terraform-multicloud-proxy-bootstrap destroy
```

This will destroy every object in clouds that were produced during deployment.


## Cloud credentials:

Some additional information about service accounts creation which are needed for performing operations inside clouds (don't use your primary accounts, furthermore, it's much better to use dedicated projects). For more details see the official documentations ([Amazon](https://aws.amazon.com/cli/), [Google](https://cloud.google.com/sdk), [Yandex](https://cloud.yandex.com/docs/cli/)).

**Amazon:**
 
Managing Amazon IAM permissions polices are out of scope of this project, you have to review resources declared in the configuration file and adjust your permissions settings by yourself. And don't forget to review some information about [image importing](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html).

**Google:**

```bash
gcloud iam service-accounts create "terraform-multicloud-proxy-sa"

gcloud iam service-accounts list

gcloud iam service-accounts keys create \
    --iam-account "terraform-multicloud-proxy-sa@<PROJECT>.iam.gserviceaccount.com" \
    ~/terraform-multicloud-proxy-sa-google.json

gcloud projects add-iam-policy-binding "<PROJECT>" \
  --member "serviceAccount:terraform-multicloud-proxy-sa@<PROJECT>.iam.gserviceaccount.com" \
  --role "roles/editor"
```

**Yandex:**

```bash
yc resource-manager cloud list

yc resource-manager folder list

yc iam service-account create \
    --cloud-id "<CLOUD_ID>" \
    --folder-id "<FOLDER_ID>" \
    "terraform-multicloud-proxy-sa" 

yc iam key create \
    --service-account-name "terraform-multicloud-proxy-sa" \
    --output ~/terraform-multicloud-proxy-sa-yandex.json

yc resource-manager folder add-access-binding "<FOLDER_NAME>" \
    --subject "serviceAccount:<SERVICE_ACCOUNT_ID>" \
    --role "editor" 

yc iam access-key create \
    --service-account-name "terraform-multicloud-proxy-sa"
```

