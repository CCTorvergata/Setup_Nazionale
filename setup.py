import argparse

import ansible_runner


def parse_args():
    parser = argparse.ArgumentParser(description="")

    # Argomento posizionale: IP macchina remota
    parser.add_argument("vulnbox-ip", help="Vulnbox IP address")

    # Opzioni booleane --server e --client
    parser.add_argument("vulnbox", action="store_true", help="Setup vulnbox")
    parser.add_argument("tools", action="store_true", help="Setup tools")

    args = parser.parse_args()

    return args


if __name__ == "__main__":
    args = parse_args()
    print(args.ip)
