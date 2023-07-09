from diagrams import Cluster, Diagram
from diagrams.generic.network import Switch, Router, Firewall
from diagrams.generic.place import Datacenter

# test
from diagrams.aws.compute import EC2
from diagrams.aws.database import RDS
from diagrams.aws.network import ELB


def main():
    with Diagram("Home network", show=False, direction="TB"):
        entrypoint = Router("modem")
        # with Cluster("Localhost"):
        #     internals = Router("Linksys00356") >> Switch("24 poe network switch")


def test():
    with Diagram("Web Service", show=False):
        ELB("lb") >> EC2("web") >> RDS("userdb")


if __name__ == "__main__":
    # main()
    print("hello there")
