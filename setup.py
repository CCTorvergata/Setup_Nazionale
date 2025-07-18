#!/usr/bin/env python3

import argparse
import os
from getpass import getpass
from pathlib import Path

import ansible_runner
import paramiko


def parse_args():
    parser = argparse.ArgumentParser(description="")

    parser.add_argument("vulnbox_ip", help="Vulnbox IP address")

    parser.add_argument("vulnbox", action="store_true", help="Setup vulnbox")
    parser.add_argument("tools", action="store_true", help="Setup tools")

    args = parser.parse_args()

    return args


def setup_ssh_key(remote_host):
    ssh_dir = Path.home() / ".ssh"
    private_key_path = ssh_dir / "id_rsa_ctf"
    public_key_path = ssh_dir / "id_rsa_ctf.pub"

    # 1. Genera la coppia di chiavi se non esiste già
    if not private_key_path.exists():
        print("[+] Generate new ssh key: id_rsa_ctf")
        key = paramiko.RSAKey.generate(2048)
        os.makedirs(ssh_dir, exist_ok=True)
        key.write_private_key_file(str(private_key_path))
        with public_key_path.open('w') as pub_file:
            pub_file.write(f"{key.get_name()} {key.get_base64()}\n")
    else:
        print("[!] The key id_rsa_ctf already exists. Skipping...")

    # 2. Chiede la password per login remoto
    password = getpass(f"root@{remote_host} password: ")

    # 3. Connessione SSH con paramiko
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    print(f"[+] Connection to {remote_host}...")

    client.connect(
        hostname=remote_host,
        port=22,
        username="root",
        password=password
    )

    # 4. Assicura che ~/.ssh esista sul remoto
    stdin, stdout, stderr = client.exec_command(
        'mkdir -p ~/.ssh && chmod 700 ~/.ssh')
    stdout.channel.recv_exit_status()

    # 5. Aggiunge la chiave pubblica in ~/.ssh/authorized_keys
    with public_key_path.open('r') as f:
        public_key = f.read().strip()

    print("[+] Adding public_key to authorized_keys on the remote host...")
    command = f'echo "{public_key}" >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
    stdin, stdout, stderr = client.exec_command(command)
    stdout.channel.recv_exit_status()

    client.close()
    print("[✓] Done.")


if __name__ == "__main__":
    args = parse_args()

    if args.vulnbox:
        inventory = {
            "vulnbox": {
                "hosts": args.vulnbox_ip,
                "vars": {
                    "ansible_user": "root",
                    "ansible_connection": "ssh",
                    "ansible_python_interpreter": "python3",
                }
            }
        }

        runner = ansible_runner.run(
            private_data_dir="./ansible",
            playbook="setup_vulnbox.yaml",
            inventory=inventory
        )

        if runner.rc != 0:
            raise RuntimeError(
                f"The playbook setup_vulnbox.yaml failed with error {runner.rc}")

    if args.tools:
        inventory = {
            "localhost": {
                "hosts": "localhost",
            },
            "all": {
                "vars": {
                    "ansible_connection": "local",
                    "ansible_python_interpreter": "python3",
                }
            }
        }

        runner = ansible_runner.run(
            private_data_dir="./ansible",
            playbook="setup_tools.yaml",
            inventory=inventory
        )

        if runner.rc != 0:
            raise RuntimeError(
                f"The playbook setup_tools.yaml failed with error {runner.rc}")
