# JAhir
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![alt text](Images/Network_Diagram_HW13.jpg)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the _____ file may be used to install only certain pieces of it, such as Filebeat.

---
- name: installing and launching filebeat
  hosts: webservers
  become: yes
  tasks:

  - name: download filebeat deb
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.1-amd64.deb

  - name: install filebeat deb
    command: dpkg -i filebeat-7.6.1-amd64.deb

  - name: drop in filebeat.yml
    copy:
      src: /etc/ansible/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml

  - name: enable and configure system module
    command: filebeat modules enable system

  - name: setup filebeat
    command: filebeat setup

  - name: start filebeat service
    command: service filebeat start

---
- name: installing and launching metricbeat
  hosts: webservers
  become: yes
  tasks:

  - name: download metricbeat deb
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.1-amd64.deb

  - name: install metricbeat deb
    command: dpkg -i metricbeat-7.6.1-amd64.deb

  - name: drop in metricbeat.yml
    copy:
      src: /etc/ansible/metricbeat.cfg
      dest: /etc/metricbeat/metricbeat.yml

  - name: enable and configure system module
    command: metricbeat modules enable docker

  - name: setup metricbeat
    command: metricbeat setup

  - name: start metricbeat service
    command: service metricbeat start

---
- name: ELK_Project-1
  hosts: elk
  become: true
  tasks:
  - name: docker.io
    apt:
      force_apt_get: yes
      update_cache: yes
      name: docker.io
      state: present

  - name: Install pip3
    apt:
      force_apt_get: yes
      name: python3-pip
      state: present

  - name: Install Docker python module
    pip:
      name: docker
      state: present

  - name: Use more memory
    sysctl:
      name: vm.max_map_count
      value: '262144'
      state: present
      reload: yes

  - name: sebp/elk:761
    docker_container:
      name: sebp
      image: sebp/elk:761
      state: started
      published_ports:
      - "5601:5601"
      - "9200:9200"
      - "5044:5044"

  - name: Enable docker service
    systemd:
      name: docker
      enabled: yes


This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting load to the network.
What aspect of security do load balancers protect? Availability 
What is the advantage of a jump box? Jump box prevents the VMs to be exposed directly to the internet.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system trafic.
What does Filebeat watch for? log files, collect log events, system log entries
What does Metricbeat record? Records metrics and statistics

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function    | IP Address | Operating System |
|----------|-------------|------------|------------------|
| Jump Box | Gateway     | 10.0.0.1   | Linux            |
| Web-1    | Web Server  | 10.0.0.8   | Linux            |
| Web-2    | Web Server  | 10.0.0.9   | Linux            |
| Web-3    | Web Server  | 10.0.0.11  | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
Add whitelisted IP addresses_24.107.205.229

Machines within the network can only be accessed by SSH.
Which machine did you allow to access your ELK VM? Ansible of the jump box
What was its IP address?_10.1.0.4

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses                    |
|----------|---------------------|-----------------------------------------|
| Jump Box | Yes                 | 10.0.0.8 10.0.0.9 10.0.0.11 10.1.0.4    |
| ELK      | Yes                 | 10.0.0.8 10.0.0.9 10.0.0.11             |
| Web-1    | No                  | 10.0.0.7 10.1.0.4                       |
| Web-2    | No                  | 10.0.0.7 10.1.0.4                       |
| Web-3    | No                  | 10.0.0.7 10.1.0.4                       |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it is automated. 
What is the main advantage of automating configuration with Ansible? To automate daily or routine tasks.

The playbook implements the following tasks:
In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
1) install docker.io
2) install python3-pip
3) install docker module
4) increase virtual memory
5) use more memory
6) download and launch a docker elk container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

Images/sudo_docker_ps.jpg

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
10.0.0.8
10.0.0.9
10.0.0.11

We have installed the following Beats on these machines:
filebeats 
metricbeats

These Beats allow us to collect the following information from each machine:
Filebeat collects log files, collect log events, system log entries
e.g. 
Metricbeat collects Records metrics and statistics. 
e.g. Uptime : The System uptime metricset provides the uptime of the host operating system

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook.yml file to /etc/ansible
- Update the host file to include the privete IP addresses of the webservers and elk
- Run the playbook, and navigate to http://24.107.205.229:5601 to check that the installation worked as expected.

Which file is the playbook? filebeat-playbook.yml, metricbeat-playbook.yml
Where do you copy it? /etc/ansible 
Which file do you update to make Ansible run the playbook on a specific machine? Host
How do I specify which machine to install the ELK server on versus which to install Filebeat on? Elk is installed on the VM that would be used to monitors VMs whereas filebeat is installed in the VM that would be monitored by the ELK server. 
Which URL do you navigate to in order to check that the ELK server is running? http://24.107.205.229:5601

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
ansible-platbook filebeat-playbook.yml
ansible-platbook metricbeat-playbook.yml
