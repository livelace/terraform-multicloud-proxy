FROM            ubuntu:18.04

ENV             DEBIAN_FRONTEND="noninteractive"

ENV             ANSIBLE_VERSION="2.9.6"
ENV             PACKER_VERSION "1.5.4"
ENV             TERRAFORM_VERSION "0.12.21"

ENV             PACKER_URL "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"
ENV             TERRAFORM_URL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

RUN             apt-get update --fix-missing && \
                apt-get -y upgrade && \
                apt-get install -y \
                apt-transport-https \
                curl \
                git \
                groff \
                libarchive-tools \
                python3-pip \
                pwgen \
                unzip \
                qemu-system \
                vim && \
                apt-get clean all

RUN             pip3 install \
                "ansible==${ANSIBLE_VERSION}" \
                awscli \
                boto3 \
                netaddr


RUN             curl -s "$PACKER_URL" -o "/tmp/packer.zip" && \
                curl -s "$TERRAFORM_URL" -o "/tmp/terraform.zip" && \
                unzip "/tmp/packer.zip" -d "/usr/bin" && \
                unzip "/tmp/terraform.zip" -d "/usr/bin" && \
                rm -f "/tmp/packer.zip" "/tmp/terraform.zip"


COPY            work /work
COPY            entrypoint-pre.sh /entrypoint-pre.sh
COPY            entrypoint.sh /entrypoint.sh

ENTRYPOINT      ["/entrypoint-pre.sh"]

CMD             ["help"]