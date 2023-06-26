from diagrams import Cluster, Diagram
from diagrams.generic.network import Switch, Router, Firewall
from diagrams.generic.place import Datacenter


def main():
    with Diagram("Home network", show=False, direction="TB"):
        entrypoint = Router("modem")
        with Cluster("Localhost"):
            internals = Router("Linksys00356") >> Switch("24 poe network switch")


if __name__ == "__main__":
    main()
